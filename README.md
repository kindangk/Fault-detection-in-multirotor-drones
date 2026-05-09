# Context
This project focuses on developing a Fault Detection procedure to identify worn propeller blades in a hexarotor drone using flight log data. Based on the [UAV-FD: a dataset for actuator fault detection in multirotor drones](https://ieeexplore.ieee.org/document/10156060) dataset, the work involves extracting features from onboard sensor signals and training classifiers to distinguish between normal and faulty operating conditions. The project also investigates the interpretability of the models to understand which variables most influence the fault detection process.

# Project Structure
- `model/`  
  Contains the trained Machine Learning models saved in `.mat` format.

- `explainability_graphs/`  
  Stores graphs and figures related to the interpretability and explainability analysis of the trained models, saved in `.fig` format.

- `code/data/`  
  This directory is not included in the project repository.  
  ___The dataset must be placed here before running the scripts.___

- `code/modelTraining/`  
  Contains the automatically generated and exported MATLAB code from the Classification Learner app, used for model training and validation.

- `code/src/`  
  Contains the main MATLAB `.m` scripts used for data processing, feature extraction, training, and evaluation.

  - `main.m`  
    Main execution script of the project.  
    It performs dataset loading, preprocessing, feature extraction, feature selection, and preparation of the data for classification.
  
  - `interpretability.m`  
    Script dedicated to the post-training interpretability analysis.  
    It trains surrogate models and generates explainability results and figures for the trained classifiers.
  
  - `Config.m`  
    Configuration file containing the main project settings and customizable parameters, such as dataset paths, output folders, preprocessing options, and training settings.
  
  - `fileLoader.m`  
    Utility functions used by `main.m` to load the dataset files and organize the acquired flight data.
  
  - `preprocessingUtils.m`  
    Collection of preprocessing utility functions used by `main.m` during the signal preprocessing phase.
  
  - `diagnosticFeatures.m`  
    Feature extraction script used by `main.m` to compute diagnostic features from the sensor signals.  
    This file was automatically generated using the MATLAB Diagnostic Feature Designer tool.
  
  - `saveTrainedModels.m`  
    Utility script used to save the trained Machine Learning models from the MATLAB workspace into `.mat` files.

# How to Run
1. **Download the dataset**  
   Obtain the UAV-FD dataset and place it inside the `code/data/` directory.  
   This folder is not included in the repository and must be created/populated manually before running the scripts.

2. **Configure project settings**  
   Open the `Config.m` file and update the required parameters if needed.  
   The configuration file includes several customizable settings, such as the dataset path and preprocessing parameters.

3. **Run preprocessing and feature extraction**  
   Execute the `main.m` script located in `code/src/`.  
   This script handles dataset loading, data preprocessing, feature extraction and feature selection.

4. **Run the interpretability analysis**  
   Execute the `interpretability.m` script to perform the post-training interpretability study.  
   This script trains surrogate models and generates explainability results and related figures.
