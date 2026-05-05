% Class for configuration parameters
classdef Config
    properties (Constant)
        % Project structure
        CodeFolderName = 'code';
        DataFolderName = 'data';
        SourceFolderName = 'src';
        SessionFolderName = 'session';
        ModelFolderName = 'models';
        ModelTrainingFolderName = 'modelTraining'

        % Main script sections
        CheckPreprocessedDataValidity = false;
        LoadAlreadyGeneratedFeatures = true;

        % Interpretability Script sections
        RetrainModels = true;

        % Data preprocessing
        SyncFrequency = 350; % Hertz;
        InterpolationMode = 'previous';
        ARModelOrder = 10;
        RemoveLastFrameIfIncomplete = true;
        FlattenDataTable = true; % Due to code additions and updates it may not work if false
        
        % Feature preprocessing
        FeatureRemovalThreshold = 0.01 % Percentage of invalid values (0 to 1)

        % Training parameters
        HoldoutRatio = 0.2;
        SamplingMode = 'Stratify';

        % Field names to load from the original data
        DataFields = [
            "AHR2" "ARM" "ATT" "CTRL" "CTUN" "DSF" "DU32" "ERR" "ESC_0" "ESC_1" "ESC_2" "ESC_3" "ESC_4" "ESC_5" "EV" "FILE" "GPA_0" "GPS_0" "HEAT" "IMU_0" "IMU_1" "IMU_2" "IOMC" "MAG_0" "MAG_1" "MAG_2" "MODE" "MOTB" "MSG" "MSG1" "MULT" "ORGN_0" "ORGN_1" "PARM" "PIDA" "PIDP" "PIDR" "PIDY" "PM" "POS" "RAD" "RATE" "RCO2" "RCOU" "SRTL" "STAK_0" "STAK_1" "STAK_10" "STAK_11" "STAK_12" "STAK_13" "STAK_14" "STAK_15" "STAK_16" "STAK_17" "STAK_18" "STAK_19" "STAK_2" "STAK_20" "STAK_255" "STAK_3" "STAK_4" "STAK_5" "STAK_6" "STAK_7" "STAK_8" "STAK_9" "Seen" "TERR" "UBX1_0" "UBX2_0" "UNIT" "VER" "VIBE_0" "VIBE_1" "VIBE_2" "XKF1_0" "XKF1_1" "XKF2_0" "XKF2_1" "XKF3_0" "XKF3_1" "XKF4_0" "XKF4_1" "XKF5_0" "XKFS_0" "XKFS_1" "XKQ_0" "XKQ_1" "XKT_0" "XKT_1" "XKV1_0" "XKV2_0" "XKY0_0" "XKY0_1" "XKY1_0" "XKY1_1"
            ];
        WhitelistedFields = [
            "ATT", "ESC_0" "ESC_1" "ESC_2" "ESC_3" "ESC_4" "ESC_5" "IMU_0" "IMU_1" "IMU_2" "RCOU", "VIBE_0" "VIBE_1" "VIBE_2" "XKF1_0" "XKF1_1"
            ];

        %% Labels and types of the final data table\timetable
        % Feature labels and type
        FeatureLabels = [ ...
            "GyrX","GyrY","GyrZ","AccX","AccY","AccZ", ...                % IMU_avg
            "VibeX","VibeY","VibeZ", ...                                  % VIBE_avg
            "VelNorth","VelEast","VelDown" ...                            % XKF1_avg
            "DesRoll", "Roll", "DesPitch", "Pitch", "DesYaw", "Yaw", ...  % ATT
            "RPM0", "Curr0", ...                                          % ESC_0
            "RPM1", "Curr1", ...                                          % ESC_1
            "RPM2", "Curr2", ...                                          % ESC_2
            "RPM3", "Curr3", ...                                          % ESC_3
            "RPM4", "Curr4", ...                                          % ESC_4
            "RPM5", "Curr5", ...                                          % ESC_5
            "CTRL0", "CTRL1", "CTRL2", "CTRL3", "CTRL4", "CTRL5" ...      % RCOU           
        ];
        FeatureType = "double";
        
        % Metadata labels and types
        MetadataLabels = ["Filename", "FaultyMotor", "WearPercentage", "FaultCode"];
        MetadataTypes = ["string", "uint8", "uint8", "string"];
        
    end
end

%{
    ATT x6 >> Roll (4), Pitch (6), Yaw (8), DesRoll (3), DesPitch (5), DesYaw (7)
    IMU x6 >> GyrX (4), GyrY (5), GyrZ (6), AccX (7), AccY (8), AccZ (9) (mean of IMU_0, IMU_1, IMU_2)
    ESC x12 >> RPM (4), Curr (7)
    RCOU x6 >> C9 (11), C10 (12), C11 (13), C12 (14), C13 (15), C14 (16)
    VIBE x3 >> VibeX (4), VibeY (5), VibeZ (6) (mean of VIBE_0, VIBE_1, VIBE_2)
    XFK1 x3 >> VN (7), VE (8), VD (9) (mean of XKF1_0, XKF_1)
    Total: 36
%}