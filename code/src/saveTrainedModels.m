clc;

% Saves a trained model to a MAT file
function fullFilePath = saveModelToMAT(modelName, modelFolderPath)
    fullFilePath = fullfile(modelFolderPath, modelName + ".mat");
    saveLearnerForCoder(evalin('base', modelName), fullFilePath);
end

% List of model names expected to be found in workspace
modelNames = ["CubicSVM_ANOVA_200", "CubicSVM_KruskalWallis_200", "CubicSVM_KruskalWallis_100", "QuadraticSVM_KruskalWallis_200", "QuadraticSVM_ANOVA_100"];

% Path to the "models" folder
modelFolderPath = fullfile('..', '..', Config.ModelFolderName);

% Iterate over list and save models
for k = 1:length(modelNames)
    modelName = modelNames(k);
    saveModelToMAT(modelName, modelFolderPath);
end
