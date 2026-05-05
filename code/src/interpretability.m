clc;
clear;

%% Load saved features
fprintf('Loading saved features...\n');
load('processedFeatureData.mat');   % contains featureTable
fprintf('Features loaded\n');

%% Prepare features and labels
% Identify labels and remove unused columns
Y = featureTable.WearPercentage;
X = removevars(featureTable, ["WearPercentage", "EnsembleID_"]);

% Parameters
%rng(1);  % reproducibility

% Create stratified holdout partition
cv = cvpartition(Y, ...
    'HoldOut', Config.HoldoutRatio, ...
    Config.SamplingMode, true);

XTrain = X(training(cv), :);
YTrain = Y(training(cv), :);

XTest  = X(test(cv), :);
YTest  = Y(test(cv), :);

XTrainRenamed = renameFeatures(XTrain);
XTestRenamed = renameFeatures(XTest);

fprintf('Train/Test split created: %d train / %d test samples\n', ...
    height(XTrain), height(XTest));

% Results container
results = struct();

%% Obtain model files and iterate over them
% Get model files
modelFolderPath = fullfile('..', '..', Config.ModelFolderName);
modelFiles = dir(fullfile(modelFolderPath, "*.mat"));

% Get model training folder path
modelTrainingFolder = fullfile(Config.ModelTrainingFolderName);

% Add to path to be able to use the functions in its files
addpath(modelTrainingFolder);

% Iterate over model files
for k = 1:length(modelFiles)

    % Load model
    fileName = modelFiles(k).name;
    modelFilePath = fullfile(modelFolderPath, fileName);

    % Extract base model name (remove .mat)
    [~, modelBaseName, ~] = fileparts(fileName);
    
    if Config.RetrainModels
        % Build training factory function name
        trainingFactoryName = modelBaseName + "_training";

        % Rebuild training table
        trainingData = XTrain;
        trainingData.WearPercentage = YTrain;
    
        % Retrain model
        modelTrainingFile = str2func(trainingFactoryName);
        modelTrainingfunctions = modelTrainingFile();
    
        fprintf('\nRetraining model: %s\n', modelBaseName);
        
        [trainedClassifier, validationAccuracy] = ...
            modelTrainingfunctions.trainClassifier(trainingData);
    
        % Extract model
        model = trainedClassifier.ClassificationSVM;
    
        fprintf('Retrained model: %s\n', modelBaseName);
        fprintf('Original model Validation Accuracy: %.4f\n', validationAccuracy);
    else
        % Else load saved model (different train\test split - original F-1 is artificially high)
        model = loadLearnerForCoder(modelFilePath);
        fprintf('\nLoaded model: %s\n', modelBaseName);
    end

    % Original model test predictions
    YPredTrainOriginal = predict(model, XTrain);
    YPredTestOriginal = predict(model, XTest);

    % Macro F1 original model
    macroF1_original = computeMacroF1(YTest, YPredTestOriginal);

    %% Surrogate models
    % 1. Single Tree Surrogate

    % Train a tree
    surrogateTree = fitctree(XTrainRenamed, YPredTrainOriginal, ...
        'MaxNumSplits', size(XTrain,1), ...
        'MinLeafSize', 1, ...
        'Prune', 'on');
    
    % Execute cross-validation for each pruning level (all subtrees) and
    % find best pruning level
    % If two pruning levels have the same loss, the higher level is chosen
    [err, ~, ~, bestPruningLevel] = cvloss(surrogateTree, 'Subtrees', 'all', 'KFold', 5);
    
    % Log optimal level
    fprintf('Optimal pruning level: %d\n', bestPruningLevel);

    % Prune tree at optimal level
    surrogateTree = prune(surrogateTree, 'Level', bestPruningLevel);
    
    YPredTrainTree = predict(surrogateTree, XTrainRenamed);
    YPredTestTree  = predict(surrogateTree, XTestRenamed);
    
    % Fidelity (tree)
    macroF1_fidelity_tree_train = computeMacroF1(YPredTrainOriginal, YPredTrainTree);
    
    YPredTestOriginal = predict(model, XTest);
    macroF1_fidelity_tree_test = computeMacroF1(YPredTestOriginal, YPredTestTree);
    
    % Real performance (tree)
    macroF1_tree_real = computeMacroF1(YTest, YPredTestTree);
    
    % 2. Ensemble Surrogate
    surrogateEns = fitcensemble(XTrainRenamed, YPredTrainOriginal, ...
        'Method', 'Bag', ...
        'NumLearningCycles', 50);
    
    YPredTrainEns = predict(surrogateEns, XTrainRenamed);
    YPredTestEns  = predict(surrogateEns, XTestRenamed);
    
    % Fidelity (ensemble)
    macroF1_fidelity_ens_train = computeMacroF1(YPredTrainOriginal, YPredTrainEns);
    macroF1_fidelity_ens_test  = computeMacroF1(YPredTestOriginal, YPredTestEns);
    
    % Real performance (ensemble)
    macroF1_ens_real = computeMacroF1(YTest, YPredTestEns);

    %% Predictor importance
    importanceTree = predictorImportance(surrogateTree);
    importanceEns = predictorImportance(surrogateEns);

    %% Store results
    results(k).modelName = fileName;
    results(k).surrogateTree = surrogateTree;
    results(k).treePredictorImportance = importanceTree;
    results(k).ensPredictorImportance = importanceEns;

    results(k).surrogateTree = surrogateTree;
    results(k).surrogateEns = surrogateEns;

    results(k).macroF1_original = macroF1_original;
    results(k).macroF1_fidelity_tree_train = macroF1_fidelity_tree_train;
    results(k).macroF1_fidelity_tree_test  = macroF1_fidelity_tree_test;
    results(k).macroF1_tree_real           = macroF1_tree_real;
    
    results(k).macroF1_fidelity_ens_train  = macroF1_fidelity_ens_train;
    results(k).macroF1_fidelity_ens_test   = macroF1_fidelity_ens_test;
    results(k).macroF1_ens_real            = macroF1_ens_real;

    %% Display summary
    fprintf('Original model Test Macro F1: %.4f\n', macroF1_original);

    fprintf('\n--- SURROGATE TREE ---\n');
    fprintf('Train Fidelity Macro F1:  %.4f\n', macroF1_fidelity_tree_train);
    fprintf('Test Fidelity Macro F1:   %.4f\n', macroF1_fidelity_tree_test);
    fprintf('Test Macro F1:            %.4f\n', macroF1_tree_real);
    
    fprintf('\n--- SURROGATE ENSEMBLE ---\n');
    fprintf('Train Fidelity Macro F1:  %.4f\n', macroF1_fidelity_ens_train);
    fprintf('Test Fidelity Macro F1:   %.4f\n', macroF1_fidelity_ens_test);
    fprintf('Test Macro F1:            %.4f\n', macroF1_ens_real);

    %% Plot predictor importance
    % Get feature names
    featureNames = XTrainRenamed.Properties.VariableNames;
    
    % Tree importance
    nonZeroTree = importanceTree > 0;
    treeImpNZ = importanceTree(nonZeroTree);
    treeNamesNZ = featureNames(nonZeroTree);
    
    [treeSorted, idxTree] = sort(treeImpNZ, 'descend');
    treeNamesSorted = treeNamesNZ(idxTree);
    treeNamesSorted = strrep(treeNamesSorted, '_', '\_');
    
    % Ensemble importance
    nonZeroEns = importanceEns > 0;
    ensImpNZ = importanceEns(nonZeroEns);
    ensNamesNZ = featureNames(nonZeroEns);
    
    [ensSorted, idxEns] = sort(ensImpNZ, 'descend');
    ensNamesSorted = ensNamesNZ(idxEns);
    ensNamesSorted = strrep(ensNamesSorted, '_', '\_');
    
    % Limit features
    N = 15;
    
    Ntree = min(N, length(treeSorted));
    Nens  = min(N, length(ensSorted));
    
    treeSorted = treeSorted(1:Ntree);
    treeNamesSorted = treeNamesSorted(1:Ntree);
    
    ensSorted = ensSorted(1:Nens);
    ensNamesSorted = ensNamesSorted(1:Nens);
    
    % Plot comparison graph
    fig = figure('Name', ['Importance Comparison - ', fileName]);
    
    subplot(1,2,1);
    bar(treeSorted);
    xticks(1:Ntree);
    xticklabels(treeNamesSorted);
    xtickangle(45);
    title('Tree Importance');
    
    subplot(1,2,2);
    bar(ensSorted);
    xticks(1:Nens);
    xticklabels(ensNamesSorted);
    xtickangle(45);
    title('Ensemble Importance');

    % Plot tree graph
    view(surrogateTree,'Mode','graph');
end

%% Save results
save('surrogateInterpretabilityResults.mat', 'results');

fprintf('\nAll surrogate models created and evaluated.\n');

%% ==========================================================
% Macro F1 Score
function macroF1 = computeMacroF1(yTrue, yPred)

    classes = unique(yTrue);
    f1Scores = zeros(length(classes),1);

    for i = 1:length(classes)
        c = classes(i);

        TP = sum(yPred == c & yTrue == c);
        FP = sum(yPred == c & yTrue ~= c);
        FN = sum(yPred ~= c & yTrue == c);

        precision = TP / (TP + FP + eps);
        recall    = TP / (TP + FN + eps);

        f1Scores(i) = 2 * (precision * recall) / (precision + recall + eps);
    end

    macroF1 = mean(f1Scores);
end

% Rename features to make them shorter
function renamedFeatureTable = renameFeatures(featureTable)
    featureNames = featureTable.Properties.VariableNames;
    
    featureNames = strrep(featureNames, 'FRM_1/', '');
    featureNames = strrep(featureNames, '_sigstats', '');
    featureNames = strrep(featureNames, '_ps_spec', '');
    featureNames = strrep(featureNames, '/', '_');

    renamedFeatureTable = featureTable;
    renamedFeatureTable.Properties.VariableNames = featureNames;
end