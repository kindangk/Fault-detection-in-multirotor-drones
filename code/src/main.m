clc;
clear;

% Start timer
startTime = tic;

% Load once the config parameters that are used several times
featureLabels = Config.FeatureLabels;
metadataLabels = Config.MetadataLabels;
metadataTypes = Config.MetadataTypes;
syncFrequency = Config.SyncFrequency;
flattenDataTable = Config.FlattenDataTable;
featureRemovalThreshold = Config.FeatureRemovalThreshold;

% Imports
fileLoader = fileLoader();
preprocessingUtils = preprocessingUtils();

% Generate or load features
if Config.LoadAlreadyGeneratedFeatures
     fprintf('Loading saved features...\n');
     load('featureData.mat');
     fprintf('Features loaded\n');
else
    % Path to the "data" folder
    dataFolderPath = fullfile('..', Config.DataFolderName);
    
    % Get list of .mat files in the specified folder
    filesList = dir(fullfile(dataFolderPath, '*.mat'));
    
    % Get number of files
    numFiles = length(filesList);
    
    % Get length of feature labels and metadata labels
    numFeatureLabels = length(featureLabels);
    numMetadataLabels = length(metadataLabels);
    numLabels = numFeatureLabels + numMetadataLabels;
    
    % Define masterTable types and variable names
    masterTableTypes = [metadataTypes, repmat(Config.FeatureType, 1, numFeatureLabels)];
    masterTableLabels = [metadataLabels, featureLabels];
    
    if flattenDataTable
        % Initialize table to store the data of all the files
        masterTable = table('Size', [numFiles numLabels], ...
            'VariableTypes', masterTableTypes, ...
            'VariableNames', masterTableLabels);
        
        % Preallocate cells
        for f = 1:numFeatureLabels
            masterTable.(featureLabels{f}) = cell(height(masterTable),1);
        end
    else
        % Initialize table to store the data of all the files
        masterTable = table('Size', [numFiles numMetadataLabels + 1], ...
            'VariableTypes', [metadataTypes, "cell"], ...
            'VariableNames', [metadataLabels, "DataTimetable"]);
    end
    
    fprintf('Initialization completed\n');
    
    % Start file processing time
    startFileProcessingTime = tic;
    
    % Iterate over the file paths
    for k = 1:numFiles
        %% Loading
        % Obtain the file name
        fileName = filesList(k).name;
    
        % Display loading progress
        fprintf('\nLoading file %d of %d: %s\n', k, numFiles, fileName);
     
        % Obtain file path (path to "data" folder + file name)
        filePath = fullfile(dataFolderPath, fileName);
    
        % Load only safe fields
        %fileData = fileLoader.loadSafe(filePath, fileName);
    
        % Load only provided fields
        fileData = fileLoader.loadOnly(filePath, fileName, Config.WhitelistedFields);
    
        %% Alignment and averaging
        % Display preprocessing progress
        fprintf('Preprocessing file data...\n');
    
        % Initialize empty data structure
        preprocessedData = struct();
    
        % IMU averaging (3 datasets, columns 4:9)
        preprocessedData.IMU_avg = preprocessingUtils.computeAvgAlignedByTimestamp( ...
            {fileData.IMU_0, fileData.IMU_1, fileData.IMU_2}, 4:9);
    
        % VIBE averaging (3 datasets, columns 4:6)
        preprocessedData.VIBE_avg = preprocessingUtils.computeAvgAlignedByTimestamp( ...
            {fileData.VIBE_0, fileData.VIBE_1, fileData.VIBE_2}, 4:6);
    
        % XKF1 averaging (2 datasets, columns 7:9)
        preprocessedData.XKF1_avg = preprocessingUtils.computeAvgAlignedByTimestamp( ...
            {fileData.XKF1_0, fileData.XKF1_1}, 7:9);
    
        %% Other preprocessing
        % Extract only relevant columns, move timestamp to first position
        preprocessedData.ATT = [fileData.ATT(:,2), fileData.ATT(:,3:8)];
        escFields = "ESC_" + (0:5);
        for i = 1:numel(escFields)
            esc = fileData.(escFields(i));
            preprocessedData.(escFields(i)) = [esc(:,2), esc(:,4), esc(:,7)];
        end
        preprocessedData.RCOU = [fileData.RCOU(:,2), fileData.RCOU(:,11:16)];
    
        fprintf('Data preprocessed and aligned by timestamp\n');
    
        %% Synchronizing
        % Display synchronization progress
        fprintf('Synchronizing preprocessed data...\n');
    
        % Synchronize datasets and save them in timetable format
        dataTimetable = preprocessingUtils.synchronizeDatasetsIntoTimetable( ...
            preprocessedData, featureLabels);
    
        % Display syncronization result
        fprintf('Data syncronized at %d Hz\n', syncFrequency);
       
        %% Trimming
        %{
            We assume that the drone has yet to take off or has landed when the
            RPM of its engines is zero (or the engine sensors have not started 
            yet), so we trim some initial and final data.
            An alternative is to check the controls.
        %}
    
        % Display trimming progress
        fprintf('Trimming synchronized data...\n');
    
        % Find first valid row
        firstRow = preprocessingUtils.getRowForTrimmingByDesFields(dataTimetable, @all, 'first');
    
        % Find last valid row
        lastRow = preprocessingUtils.getRowForTrimmingByDesFields(dataTimetable, @all, 'last');
    
        % Compute how many rows will be trimmed
        rowsTrimmed = (firstRow-1) + (height(dataTimetable)-lastRow);
        percentageTrimmed = 100 * rowsTrimmed / height(dataTimetable);
        
        % Display numer of trimmed lines
        fprintf('Trimmed %d rows (%.2f%% of total)\n', rowsTrimmed, percentageTrimmed)
    
        % Trim table to include only rows from first row with signal to last
        % row with RMP
        dataTimetable = dataTimetable(firstRow:lastRow, :);

        %% Shift time to zero
        dataTimetable.Time = dataTimetable.Time - dataTimetable.Time(1);
        
        %% Check data length and some other statistics
        % Total number of samples
        numSamples = height(dataTimetable);
        
        % Flight duration in seconds
        flightDuration = seconds(dataTimetable.Time(end));
        
        % Number of complete frames
        numFullFrames = floor(flightDuration);
        
        % Samples in last partial frame
        samplesLastFrame = mod(numSamples, syncFrequency);
        
        % Display results
        fprintf('Flight duration: %.3f seconds\n', flightDuration);
        fprintf('Complete frames (%d samples): %d\n', syncFrequency, numFullFrames);
        fprintf('Samples in last partial frame: %d\n', samplesLastFrame);
    
        %% Remove last frame if not enough samples
        % Remove last frame if it is incomplete
        if Config.RemoveLastFrameIfIncomplete && samplesLastFrame < syncFrequency
            fprintf('Last frame removed\n');
            dataTimetable((numFullFrames*syncFrequency + 1):numSamples, :) = [];
        
        % We want enough values to estimate the parameters of the AR model
        elseif samplesLastFrame < Config.ARModelOrder + 1
            fprintf('Last frame removed because it has less than %d values\n', Config.ARModelOrder + 1);
            dataTimetable((numFullFrames*syncFrequency + 1):numSamples, :) = [];
    
        % Don't remove last frame
        else
            fprintf('Last frame kept because it has more than %d values\n', Config.ARModelOrder + 1);
        end
    
        %% Detect lowest variability column in frames
        % Initialize tracking variables for the global minimum variability
        minUnique = inf;
        worstVar = "";
        worstFrame = -1;
        
        % Extract raw numeric data from the timetable for faster indexing
        data = dataTimetable.Variables;
        
        % Iterate through each complete frame
        for frame = 1:numFullFrames
            % Compute row indices corresponding to the current frame
            idx = (frame-1)*syncFrequency+1 : frame*syncFrequency;
            
            % Extract the data of the current frame
            frameData = data(idx,:);
        
            % Compute the number of unique values for each signal in the frame
            uniqueCounts = arrayfun(@(c) numel(unique(frameData(:,c))), 1:numFeatureLabels);
        
            % Find the signal with the lowest number of unique values
            [minVal,col] = min(uniqueCounts);
        
            % Update the global minimum if a lower variability is found
            if minVal < minUnique
                minUnique = minVal;
                worstVar = featureLabels{col};
                worstFrame = frame;
            end
        end
        
        % Display results
        fprintf('\nLowest variability signal:\n');
        fprintf('  Column: %s\n', worstVar);
        fprintf('  Frame index: %d\n', worstFrame);
        fprintf('  Unique values in frame: %d (out of %d samples)\n', minUnique, syncFrequency);
        
        %% Saving in masterTable and adding FaultCode (target)
        % Extract a valid name from the file name
        [~, fileNameNoExtension, ~] = fileparts(fileName);
        validFileName = matlab.lang.makeValidName(fileNameNoExtension);
    
        % Determine faultCode from fileName
        if contains(fileNameNoExtension, 'NO_FAULT') % No fault
            faultCode = 'NO_FAULT';
            faultyMotorNumber = NaN;
            wearPercentage = NaN;
        else % Fault
            temp = strsplit(fileNameNoExtension, '_');
            faultyMotorCode = temp(2);
            faultyMotorNumber = faultyMotorCode{1}(end); % faultyMotorCode is a 1x1 cell array
            wearPercentage = temp(3);
            faultCode = strcat(faultyMotorCode, '_W', wearPercentage);
        end
      
        % Insert FaultCode and some metadata in the master structure
        masterTable.Filename(k) = validFileName;
        masterTable.FaultyMotor(k) = str2double(faultyMotorNumber);
        masterTable.WearPercentage(k) = str2double(wearPercentage);
        masterTable.FaultCode(k) = faultCode;
    
        % Decide mode in which data is added to masterTable
        if Config.FlattenDataTable
            for f = 1:length(featureLabels)
                % Create single-signal timetable
                singleTT = timetable( ...
                    dataTimetable.Time, ...
                    dataTimetable.(featureLabels{f}), ...
                    'VariableNames', featureLabels(f) ...
                );
            
                % Store timetable in masterTable
                masterTable.(featureLabels{f}){k} = singleTT; % Enables Dot notation access
                %masterTable{k, featureLabels{f}} = {singleTT};
            end
    
        else
            % Single data column
            masterTable.DataTimetable{k} = dataTimetable;   % {} because it's a cell
        end
    end
    
    % Compute file processing time
    elapsedTime = toc(startFileProcessingTime);
    fprintf("\nFile processing time: %.2f seconds\n", elapsedTime);
    
    %% Check for NaN or missing data (if any, something went wrong)
    if Config.CheckPreprocessedDataValidity
        % Iterate over each row and feature column
        for k = 1:numFiles
            if flattenDataTable
                for f = featureLabels
                    % Extract the timetable stored in the corresponding cell
                    TT = masterTable{k,f}{1};
            
                    % Check if the timetable is empty or contains missing values
                    % (NaN, missing, or undefined entries)
                    if isempty(TT) || any(ismissing(TT.Variables))
                        fprintf('File %s, feature %s has NaN\n',masterTable.Filename(k),f)
                    end
                end
            else
                % Extract the timetable stored in the corresponding cell
                TT = masterTable.DataTimetable{k};
        
                % Check if the timetable is empty or contains missing values
                % (NaN, missing, or undefined entries)
                if isempty(TT) || any(ismissing(TT.Variables), 'all')
                    fprintf('File %s has NaN\n',masterTable.Filename(k))
                end
            end
        end
    end
    
    %% Feature generation
    % Start file processing time
    startFeatureGenerationTime = tic;
    
    % Generate features
    fprintf('\nGenerating features, please wait...\n');
    [featureTable, masterFeatureTable] = diagnosticFeatures(masterTable);
    fprintf('Features generated\n');
    
    % Save feature data
    fprintf('\nSaving features...\n');
    save featureData.mat featureTable masterFeatureTable
    fprintf('Features saved at "code/src/featureData.mat" \n');
    
    % Compute feature generation time
    elapsedTime = toc(startFeatureGenerationTime);
    fprintf("\nFeature generation time: %.2f seconds\n", elapsedTime);
end

%% Feature trimming
% Clean feature table from NaN/Inf values
fprintf('\nCleaning feature table with threshold %.2f for invalid values...\n', featureRemovalThreshold);

numRowsOriginal = height(featureTable);

% Identify numeric columns (ignore first four columns: ID, Target, TimeStart, TimeEnd)
numericCols = 5:width(featureTable);
numFeaturesOriginal = length(numericCols);

% Count NaN and Inf values per numeric column
nanCounts = sum(isnan(featureTable{:,numericCols}));
infCounts = sum(isinf(featureTable{:,numericCols}));
totalInvalid = nanCounts + infCounts;

% Compute proportion of invalid per column
propInvalid = totalInvalid / numRowsOriginal;

% Find columns to remove
colsToRemoveIdx = numericCols(propInvalid > featureRemovalThreshold);
colsToKeepIdx   = setdiff(numericCols, colsToRemoveIdx);

% Print column removal stats
fprintf('\nColumns removed due to exceeding threshold:\n');
if isempty(colsToRemoveIdx)
    fprintf('  None\n');
else
    for c = colsToRemoveIdx
        colName = featureTable.Properties.VariableNames{c};
        fprintf('  %s: NaN=%d, Inf=%d, %.2f%% invalid\n', ...
            colName, nanCounts(c-4), infCounts(c-4), propInvalid(c-4)*100);
    end
end

% Keep only valid columns (plus first two)
featureTable = featureTable(:, [1,2, colsToKeepIdx]);

% Remove rows with any remaining NaN or Inf
numericColsAfter = 3:width(featureTable);
rowsToDelete = any(isnan(featureTable{:,numericColsAfter}) | isinf(featureTable{:,numericColsAfter}), 2);
numRowsDeleted = sum(rowsToDelete);

featureTable(rowsToDelete,:) = [];
numRowsRemaining = height(featureTable);

% Print feature stats
fprintf('\nFeature statistics:\n');
fprintf('  Total numeric features: %d\n', numFeaturesOriginal);
fprintf('  Features removed: %d (%.2f%%) \n', length(colsToRemoveIdx), 100*length(colsToRemoveIdx)/numFeaturesOriginal);
fprintf('  Features remaining: %d\n', length(colsToKeepIdx));

% Display row cleaning stats
fprintf('\nRows statistics:\n');
fprintf('  Original rows: %d\n', numRowsOriginal);
fprintf('  Deleted rows with NaN/Inf: %d (%.2f%%)\n', numRowsDeleted, 100*numRowsDeleted/numRowsOriginal);
fprintf('  Remaining rows: %d\n', numRowsRemaining);

% Get class labels (column 2 is the target)
labels = featureTable{:,2};

% Get unique classes and counts
[classes, ~, idx] = unique(labels);
counts = accumarray(idx, 1);

% Print results
fprintf('    of which\n');
for i = 1:numel(classes)
    if iscell(classes)
        className = classes{i};
    else
        className = classes(i);
    end
    fprintf('      Class %s: %d\n', string(className), counts(i));
end

%% Compute Costs Matrix
% Extract features and labels
X = featureTable{:, 3:end};
Y = featureTable.WearPercentage;

% Convert to categorical
Y = categorical(Y);

% Compute class weights
classes = categories(Y);
numClasses = numel(classes);

classCounts = countcats(Y);
totalSamples = sum(classCounts);

classWeights = totalSamples ./ classCounts;

% Build cost matrix
costMatrix = zeros(numClasses);

for i = 1:numClasses
    for j = 1:numClasses
        if i ~= j
            % Cost of predicting class j when the true class is i
            costMatrix(i,j) = classWeights(i);
        end
    end
end

% Normalize
costMatrix = costMatrix / mean(costMatrix(:));

%% Save preprocessed feature table
% Save processed feature data
fprintf('\nSaving processed features...\n');
save processedFeatureData.mat featureTable costMatrix
fprintf('Processed features saved at "code/src/processedFeatureData.mat" \n');

%% Compute execution time
elapsedTime = toc(startTime);
fprintf("\nTotal runtime: %.2f seconds\n", elapsedTime);

%% Best models for classification
% N.B.
% 1) Ad ogni addestramento, Classification Learner può fornire risultati
% diversi a parità di modello, tecnica di split del dataset e tecnica di
% feature selection scelta poiché le partizioni della k-fold validation
% sono generate casualmente.
% 2) Caricando lo stesso dataset in Classification Learner più volte ed
% eseguendo holdout e stratified sampling, si ottengono ogni volta split
% diversi.

% Tree: Fine Tree, Medium Tree
% Linear Discriminant
% SVM: Linear SVM, Quadratic SVM, Cubic SVM, Medium Gaussian SVM
% Ensemble: Boosted Trees, Bagged Trees, Subspace Discriminant, RUSBoosted
%   Trees

% Train-test split: stratified sampling 80-20
% Cross-validation: 5-fold
% Cost matrix: None
% Optimizer: Bayesian (when applicable)
% Total features: 522

%% Results
% NoFeatureSelection
% - Feature Selection: None
% - Best model: Subspace Discriminant
% - Best Macro F1-Score: 94.0%

% ANOVA_25
% - Feature Selection: ANOVA Top 25 features
% - Best model: Boosted Trees
% - Best Macro F1-Score: 92.4%

% ANOVA_50
% - Feature Selection: ANOVA Top 50 features
% - Best model: Cubic SVM
% - Best Marco F1-Score: 94.7%

% ANOVA_100
% - Feature Selection: ANOVA Top 100 features
% - Best model: Quadratic SVM
% - Best Macro F1-Score: 95.4%

% ANOVA_200
% - Feature Selection: ANOVA Top 200 features
% - Best model: Cubic SVM
% - Best Macro F1-Score: 95.1%

% MRMR_25
% - Feature Selection: MRMR Top 25 features
% - Best model: Cubic SVM
% - Best Macro F1-Score: 91.6%

% MRMR_50
% - Feature Selection: MRMR Top 50 features
% - Best model: Boosted Trees
% - Best Macro F1-Score: 92.9%

% MRMR_100
% - Feature Selection: MRMR Top 100 features
% - Best model: Boosted Trees
% - Best Macro F1-Score: 94.2%

% MRMR_200
% - Feature Selection: MRMR Top 200 features
% - Best model: Quadratic SVM
% - Best Macro F1-Score: 93.1%

% KruskalWallis_25
% - Feature Selection: Kruskal Wallis Top 25 features
% - Best model: Quadratic SVM
% - Best Macro F1-Score: 92.3%

% KruskalWallis_50
% - Feature Selection: Kruskal Wallis Top 50 features
% - Best model: Boosted Trees
% - Best Macro F1-Score: 93.6%

% KruskalWallis_100
% - Feature Selection: Kruskal Wallis Top 100 features
% - Best model: Cubic SVM
% - Best Macro F1-Score: 94.9%

% KruskalWallis_200
% - Feature Selection: Kruskal Wallis Top 200 features
% - Best model: Quadratic SVM
% - Best Macro F1-Score: 95.5%

%% Top 10 Models by Macro F1-Score on Test Set
% Quadratic SVM - Kruskal Wallis 200 - 95.5%
% Quadratic SVM - ANOVA 100 - 95.4%
% Cubic SVM - ANOVA 200 - 95.1%
% Cubic SVM - Ksruskal Wallis 100 - 94.9%
% Cubic SVM - Kruskal Wallis 200 - 94.7%
% Quadratic SVM - ANOVA 50 - 94.7%
% Quadratic SVM - ANOVA 200 - 94.4%
% Quadratic SVM - Ksruskal Wallis 100 - 94.2%
% Boosted Trees - MRMR_100 - 94.2%
% Subspace Discriminant - No Feature Selection - 94.0%