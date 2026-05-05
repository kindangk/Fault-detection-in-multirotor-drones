function functions = preprocessingUtils()
    functions.alignDataByTimestamp2 = @alignDataByTimestamp2;
    functions.alignDataByTimestamp3 = @alignDataByTimestamp3;
    functions.computeAverage = @computeAverage;
    functions.computeAvgAlignedByTimestamp = @computeAvgAlignedByTimestamp;
    functions.synchronizeDatasets = @synchronizeDatasets;
    functions.synchronizeDatasetsIntoTable = @synchronizeDatasetsIntoTable;
    functions.synchronizeDatasetsIntoTimetable = @synchronizeDatasetsIntoTimetable;
    functions.getRowForTrimmingByCTRL = @getRowForTrimmingByCTRL;
    functions.getRowForTrimmingByRPM = @getRowForTrimmingByRPM;
    functions.getRowForTrimmingByDesFields = @getRowForTrimmingByDesFields;

end

%  Keeps only rows with timestamps present in both datasets
function [data1_sync, data2_sync] = alignDataByTimestamp2(data1, data2)
    % Use intersect to find the indexes of common timestamps
    [~, i1, i2] = intersect(data1(:,2), data2(:,2), 'stable');
    
    % Extract only rows with common timestamps
    data1_sync = data1(i1,:);
    data2_sync = data2(i2,:);
    
    % Sort by timestamp to ensure alignment
    [~, idx] = sort(data1_sync(:,2));
    data1_sync = data1_sync(idx,:);
    data2_sync = data2_sync(idx,:);
end

%  Keeps only rows with timestamps present in all three datasets
function [data1_sync, data2_sync, data3_sync] = alignDataByTimestamp3(data1, data2, data3)
    % Find common timestamps iteratively
    commonTimestamps = intersect(data1(:,2), data2(:,2), 'stable');
    commonTimestamps = intersect(commonTimestamps, data3(:,2), 'stable');
    
    % Get indices of common timestamps in each dataset
    [~, i1] = ismember(commonTimestamps, data1(:,2));
    [~, i2] = ismember(commonTimestamps, data2(:,2));
    [~, i3] = ismember(commonTimestamps, data3(:,2));
    
    % Extract only the synchronized rows
    data1_sync = data1(i1,:);
    data2_sync = data2(i2,:);
    data3_sync = data3(i3,:);
    
    % Sort by timestamp to ensure alignment
    [~, idx] = sort(data1_sync(:,2));
    data1_sync = data1_sync(idx,:);
    data2_sync = data2_sync(idx,:);
    data3_sync = data3_sync(idx,:);
end

% Compute the average values of the "cols" in the respective "datasets"
function averagedMatrix = computeAverage(datasets, cols)
    numDatasets = numel(datasets);

    % Preallocate averaged matrix
    nRows = size(datasets{1},1);
    averagedMatrix = zeros(nRows, 1 + numel(cols));
    
    % Copy timestamp
    averagedMatrix(:,1) = datasets{1}(:,2);
    
    % Average selected columns
    sumCols = zeros(nRows, numel(cols));
    for k = 1:numDatasets
        sumCols = sumCols + datasets{k}(:,cols);
    end
    averagedMatrix(:,2:end) = sumCols / numDatasets;
end

% Alignes data by timestamp and then averages the values
function averagedMatrix = computeAvgAlignedByTimestamp(datasets, cols)
    numDatasets = numel(datasets);

    % Align datasets by timestamp
    switch numDatasets
        case 2
            [datasets{1}, datasets{2}] = alignDataByTimestamp2(datasets{:});
        case 3
            [datasets{1}, datasets{2}, datasets{3}] = alignDataByTimestamp3(datasets{:});
        otherwise
            error('Only 2 or 3 datasets are supported.');
    end
    
    % Compute the average
    averagedMatrix = computeAverage(datasets, cols);
end

%{
    Synchronizes datasets with a shared and regular timestamp
    Assumes that the time is in the first column of each dataset
    Input time is in microseconds, output time is in seconds
%} 
function [matrixData, uniformTimeArray] = synchronizeDatasets(dataStruct, tableLabels)
    % Convert preprocessedData to array to be able to iterate over it
    datasets = struct2cell(dataStruct);

    % Iterate over datasets
    for l = 1:length(datasets)
        % Convert microseconds to seconds
        datasets{l}(:,1) = datasets{l}(:,1) * 1e-6;
    end

    % Find global start time (in seconds)
    allStartTimes = cellfun(@(x) x(1,1), datasets);
    startTime = max(allStartTimes);
    %{
        With min(allStartTimes) there are 36082 records
        With max(allStartTimes) there are 35900 records
        In the first case, many NaN values because of unavailable data
        The second case is better because it trims rows with partial data
        The engines are the last ones that start recording data
    %}

    % Find common end time (in seconds)
    allEndTimes = cellfun(@(x) x(end,1), datasets);
    endTime = min(allEndTimes);
    
    % Create uniform time vector (start is 0 because of shift)
    uniformTimeArray = (startTime:(1/Config.SyncFrequency):endTime)';

    % Initialize table data and start column counter
    matrixData = zeros(length(uniformTimeArray), length(tableLabels));
    colStart = 1;
    
    % Resample all datasets with Zero-Order Hold Resampling
    for l = 1:length(datasets)
        % Obtain the time column and the rest of the columns
        originalTimeArray = datasets{l}(:,1);
        values = datasets{l}(:,2:end);
        
        % Zero-Order Hold Resampling
        resampled = interp1( ...
            originalTimeArray, values, uniformTimeArray, Config.InterpolationMode);
        
        % Get number of columns
        nCols = size(resampled,2);

        % Update table data
        matrixData(:, colStart:colStart+nCols-1) = resampled;

        % Update start column counter
        colStart = colStart + nCols;
    end
end

%{
    Synchronizes datasets into a table with a shared and regular timestamp
    Assumes that the time is in the first column of each dataset
    Input time is in microseconds, output time is in seconds
%} 
function dataTable = synchronizeDatasetsIntoTable(dataStruct, tableLabels)
    [matrixData, uniformTimeArray] = synchronizeDatasets(dataStruct, tableLabels);
    dataTable = array2table([uniformTimeArray, matrixData], 'VariableNames', ['Time', tableLabels]);
end

%{
    Synchronizes datasets into a timetable with a shared and regular timestamp
    Assumes that the time is in the first column of each dataset
    Input time is in microseconds, output time is in seconds
%} 
function dataTimetable = synchronizeDatasetsIntoTimetable(dataStruct, tableLabels)
    [matrixData, uniformTimeArray] = synchronizeDatasets(dataStruct, tableLabels);
    dataTimetable = array2timetable(matrixData, 'RowTimes', seconds(uniformTimeArray), 'VariableNames', tableLabels);
end

% Supports trimming before first or after last CTRL signal
function row = getRowForTrimmingByCTRL(data, method, position)
    % Controls columns
    ctrlCols = {'CTRL0','CTRL1','CTRL2','CTRL3','CTRL4','CTRL5'};

    ctrlData = data{:, ctrlCols};
    row = find(method(ctrlData ~= 0 & ctrlData ~= 1000, 2), 1, position);
end

% Supports trimming before or after motor activity
function row = getRowForTrimmingByRPM(data, method, position)
    % Motors columns
    rpmCols  = {'RPM0','RPM1','RPM2','RPM3','RPM4','RPM5'};

    rpmData = data{:, rpmCols};
    row = find(method(rpmData ~= 0, 2), 1, position);
end

% Supports trimming before or after desired values
function row = getRowForTrimmingByDesFields(data, method, position)
    % Desired values columns
    desCols  = {'DesRoll','DesPitch','DesYaw'};

    desData = data{:, desCols};
    row = find(method(desData ~= 0, 2), 1, position);
end