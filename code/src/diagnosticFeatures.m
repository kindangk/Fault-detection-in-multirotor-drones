function [featureTable,outputTable] = diagnosticFeatures(inputData)
%DIAGNOSTICFEATURES recreates results in Diagnostic Feature Designer.
%
% Input:
%  inputData: A table or a cell array of tables/matrices containing the
%  data as those imported into the app.
%
% Output:
%  featureTable: A table containing all features and condition variables.
%  outputTable: A table containing the computation results.
%
% This function computes spectra:
%  GyrX_ps/SpectrumData
%  GyrY_ps/SpectrumData
%  GyrZ_ps/SpectrumData
%  AccX_ps/SpectrumData
%  AccY_ps/SpectrumData
%  AccZ_ps/SpectrumData
%  VibeX_ps/SpectrumData
%  VibeY_ps/SpectrumData
%  VibeZ_ps/SpectrumData
%  VelNorth_ps/SpectrumData
%  VelEast_ps/SpectrumData
%  VelDown_ps/SpectrumData
%  DesRoll_ps/SpectrumData
%  Roll_ps/SpectrumData
%  DesPitch_ps/SpectrumData
%  Pitch_ps/SpectrumData
%  DesYaw_ps/SpectrumData
%  Yaw_ps/SpectrumData
%  RPM0_ps/SpectrumData
%  Curr0_ps/SpectrumData
%  RPM1_ps/SpectrumData
%  Curr1_ps/SpectrumData
%  RPM2_ps/SpectrumData
%  Curr2_ps/SpectrumData
%  RPM3_ps/SpectrumData
%  Curr3_ps/SpectrumData
%  RPM4_ps/SpectrumData
%  Curr4_ps/SpectrumData
%  RPM5_ps/SpectrumData
%  Curr5_ps/SpectrumData
%  CTRL0_ps/SpectrumData
%  CTRL1_ps/SpectrumData
%  CTRL2_ps/SpectrumData
%  CTRL3_ps/SpectrumData
%  CTRL4_ps/SpectrumData
%  CTRL5_ps/SpectrumData
%
% This function computes features:
%  GyrX_sigstats/ClearanceFactor
%  GyrX_sigstats/CrestFactor
%  GyrX_sigstats/ImpulseFactor
%  GyrX_sigstats/Kurtosis
%  GyrX_sigstats/Mean
%  GyrX_sigstats/PeakValue
%  GyrX_sigstats/RMS
%  GyrX_sigstats/SINAD
%  GyrX_sigstats/SNR
%  GyrX_sigstats/ShapeFactor
%  GyrX_sigstats/Skewness
%  GyrX_sigstats/Std
%  GyrX_sigstats/THD
%  GyrY_sigstats/ClearanceFactor
%  GyrY_sigstats/CrestFactor
%  GyrY_sigstats/ImpulseFactor
%  GyrY_sigstats/Kurtosis
%  GyrY_sigstats/Mean
%  GyrY_sigstats/PeakValue
%  GyrY_sigstats/RMS
%  GyrY_sigstats/SINAD
%  GyrY_sigstats/SNR
%  GyrY_sigstats/ShapeFactor
%  GyrY_sigstats/Skewness
%  GyrY_sigstats/Std
%  GyrY_sigstats/THD
%  GyrZ_sigstats/ClearanceFactor
%  GyrZ_sigstats/CrestFactor
%  GyrZ_sigstats/ImpulseFactor
%  GyrZ_sigstats/Kurtosis
%  GyrZ_sigstats/Mean
%  GyrZ_sigstats/PeakValue
%  GyrZ_sigstats/RMS
%  GyrZ_sigstats/SINAD
%  GyrZ_sigstats/SNR
%  GyrZ_sigstats/ShapeFactor
%  GyrZ_sigstats/Skewness
%  GyrZ_sigstats/Std
%  GyrZ_sigstats/THD
%  AccX_sigstats/ClearanceFactor
%  AccX_sigstats/CrestFactor
%  AccX_sigstats/ImpulseFactor
%  AccX_sigstats/Kurtosis
%  AccX_sigstats/Mean
%  AccX_sigstats/PeakValue
%  AccX_sigstats/RMS
%  AccX_sigstats/SINAD
%  AccX_sigstats/SNR
%  AccX_sigstats/ShapeFactor
%  AccX_sigstats/Skewness
%  AccX_sigstats/Std
%  AccX_sigstats/THD
%  AccY_sigstats/ClearanceFactor
%  AccY_sigstats/CrestFactor
%  AccY_sigstats/ImpulseFactor
%  AccY_sigstats/Kurtosis
%  AccY_sigstats/Mean
%  AccY_sigstats/PeakValue
%  AccY_sigstats/RMS
%  AccY_sigstats/SINAD
%  AccY_sigstats/SNR
%  AccY_sigstats/ShapeFactor
%  AccY_sigstats/Skewness
%  AccY_sigstats/Std
%  AccY_sigstats/THD
%  AccZ_sigstats/ClearanceFactor
%  AccZ_sigstats/CrestFactor
%  AccZ_sigstats/ImpulseFactor
%  AccZ_sigstats/Kurtosis
%  AccZ_sigstats/Mean
%  AccZ_sigstats/PeakValue
%  AccZ_sigstats/RMS
%  AccZ_sigstats/SINAD
%  AccZ_sigstats/SNR
%  AccZ_sigstats/ShapeFactor
%  AccZ_sigstats/Skewness
%  AccZ_sigstats/Std
%  AccZ_sigstats/THD
%  VibeX_sigstats/ClearanceFactor
%  VibeX_sigstats/CrestFactor
%  VibeX_sigstats/ImpulseFactor
%  VibeX_sigstats/Kurtosis
%  VibeX_sigstats/Mean
%  VibeX_sigstats/PeakValue
%  VibeX_sigstats/RMS
%  VibeX_sigstats/SINAD
%  VibeX_sigstats/SNR
%  VibeX_sigstats/ShapeFactor
%  VibeX_sigstats/Skewness
%  VibeX_sigstats/Std
%  VibeX_sigstats/THD
%  VibeY_sigstats/ClearanceFactor
%  VibeY_sigstats/CrestFactor
%  VibeY_sigstats/ImpulseFactor
%  VibeY_sigstats/Kurtosis
%  VibeY_sigstats/Mean
%  VibeY_sigstats/PeakValue
%  VibeY_sigstats/RMS
%  VibeY_sigstats/SINAD
%  VibeY_sigstats/SNR
%  VibeY_sigstats/ShapeFactor
%  VibeY_sigstats/Skewness
%  VibeY_sigstats/Std
%  VibeY_sigstats/THD
%  VibeZ_sigstats/ClearanceFactor
%  VibeZ_sigstats/CrestFactor
%  VibeZ_sigstats/ImpulseFactor
%  VibeZ_sigstats/Kurtosis
%  VibeZ_sigstats/Mean
%  VibeZ_sigstats/PeakValue
%  VibeZ_sigstats/RMS
%  VibeZ_sigstats/SINAD
%  VibeZ_sigstats/SNR
%  VibeZ_sigstats/ShapeFactor
%  VibeZ_sigstats/Skewness
%  VibeZ_sigstats/Std
%  VibeZ_sigstats/THD
%  VelNorth_sigstats/ClearanceFactor
%  VelNorth_sigstats/CrestFactor
%  VelNorth_sigstats/ImpulseFactor
%  VelNorth_sigstats/Kurtosis
%  VelNorth_sigstats/Mean
%  VelNorth_sigstats/PeakValue
%  VelNorth_sigstats/RMS
%  VelNorth_sigstats/SINAD
%  VelNorth_sigstats/SNR
%  VelNorth_sigstats/ShapeFactor
%  VelNorth_sigstats/Skewness
%  VelNorth_sigstats/Std
%  VelNorth_sigstats/THD
%  VelEast_sigstats/ClearanceFactor
%  VelEast_sigstats/CrestFactor
%  VelEast_sigstats/ImpulseFactor
%  VelEast_sigstats/Kurtosis
%  VelEast_sigstats/Mean
%  VelEast_sigstats/PeakValue
%  VelEast_sigstats/RMS
%  VelEast_sigstats/SINAD
%  VelEast_sigstats/SNR
%  VelEast_sigstats/ShapeFactor
%  VelEast_sigstats/Skewness
%  VelEast_sigstats/Std
%  VelEast_sigstats/THD
%  VelDown_sigstats/ClearanceFactor
%  VelDown_sigstats/CrestFactor
%  VelDown_sigstats/ImpulseFactor
%  VelDown_sigstats/Kurtosis
%  VelDown_sigstats/Mean
%  VelDown_sigstats/PeakValue
%  VelDown_sigstats/RMS
%  VelDown_sigstats/SINAD
%  VelDown_sigstats/SNR
%  VelDown_sigstats/ShapeFactor
%  VelDown_sigstats/Skewness
%  VelDown_sigstats/Std
%  VelDown_sigstats/THD
%  DesRoll_sigstats/ClearanceFactor
%  DesRoll_sigstats/CrestFactor
%  DesRoll_sigstats/ImpulseFactor
%  DesRoll_sigstats/Kurtosis
%  DesRoll_sigstats/Mean
%  DesRoll_sigstats/PeakValue
%  DesRoll_sigstats/RMS
%  DesRoll_sigstats/SINAD
%  DesRoll_sigstats/SNR
%  DesRoll_sigstats/ShapeFactor
%  DesRoll_sigstats/Skewness
%  DesRoll_sigstats/Std
%  DesRoll_sigstats/THD
%  Roll_sigstats/ClearanceFactor
%  Roll_sigstats/CrestFactor
%  Roll_sigstats/ImpulseFactor
%  Roll_sigstats/Kurtosis
%  Roll_sigstats/Mean
%  Roll_sigstats/PeakValue
%  Roll_sigstats/RMS
%  Roll_sigstats/SINAD
%  Roll_sigstats/SNR
%  Roll_sigstats/ShapeFactor
%  Roll_sigstats/Skewness
%  Roll_sigstats/Std
%  Roll_sigstats/THD
%  DesPitch_sigstats/ClearanceFactor
%  DesPitch_sigstats/CrestFactor
%  DesPitch_sigstats/ImpulseFactor
%  DesPitch_sigstats/Kurtosis
%  DesPitch_sigstats/Mean
%  DesPitch_sigstats/PeakValue
%  DesPitch_sigstats/RMS
%  DesPitch_sigstats/SINAD
%  DesPitch_sigstats/SNR
%  DesPitch_sigstats/ShapeFactor
%  DesPitch_sigstats/Skewness
%  DesPitch_sigstats/Std
%  DesPitch_sigstats/THD
%  Pitch_sigstats/ClearanceFactor
%  Pitch_sigstats/CrestFactor
%  Pitch_sigstats/ImpulseFactor
%  Pitch_sigstats/Kurtosis
%  Pitch_sigstats/Mean
%  Pitch_sigstats/PeakValue
%  Pitch_sigstats/RMS
%  Pitch_sigstats/SINAD
%  Pitch_sigstats/SNR
%  Pitch_sigstats/ShapeFactor
%  Pitch_sigstats/Skewness
%  Pitch_sigstats/Std
%  Pitch_sigstats/THD
%  DesYaw_sigstats/ClearanceFactor
%  DesYaw_sigstats/CrestFactor
%  DesYaw_sigstats/ImpulseFactor
%  DesYaw_sigstats/Kurtosis
%  DesYaw_sigstats/Mean
%  DesYaw_sigstats/PeakValue
%  DesYaw_sigstats/RMS
%  DesYaw_sigstats/SINAD
%  DesYaw_sigstats/SNR
%  DesYaw_sigstats/ShapeFactor
%  DesYaw_sigstats/Skewness
%  DesYaw_sigstats/Std
%  DesYaw_sigstats/THD
%  Yaw_sigstats/ClearanceFactor
%  Yaw_sigstats/CrestFactor
%  Yaw_sigstats/ImpulseFactor
%  Yaw_sigstats/Kurtosis
%  Yaw_sigstats/Mean
%  Yaw_sigstats/PeakValue
%  Yaw_sigstats/RMS
%  Yaw_sigstats/SINAD
%  Yaw_sigstats/SNR
%  Yaw_sigstats/ShapeFactor
%  Yaw_sigstats/Skewness
%  Yaw_sigstats/Std
%  Yaw_sigstats/THD
%  RPM0_sigstats/ClearanceFactor
%  RPM0_sigstats/CrestFactor
%  RPM0_sigstats/ImpulseFactor
%  RPM0_sigstats/Kurtosis
%  RPM0_sigstats/Mean
%  RPM0_sigstats/PeakValue
%  RPM0_sigstats/RMS
%  RPM0_sigstats/SINAD
%  RPM0_sigstats/SNR
%  RPM0_sigstats/ShapeFactor
%  RPM0_sigstats/Skewness
%  RPM0_sigstats/Std
%  RPM0_sigstats/THD
%  Curr0_sigstats/ClearanceFactor
%  Curr0_sigstats/CrestFactor
%  Curr0_sigstats/ImpulseFactor
%  Curr0_sigstats/Kurtosis
%  Curr0_sigstats/Mean
%  Curr0_sigstats/PeakValue
%  Curr0_sigstats/RMS
%  Curr0_sigstats/SINAD
%  Curr0_sigstats/SNR
%  Curr0_sigstats/ShapeFactor
%  Curr0_sigstats/Skewness
%  Curr0_sigstats/Std
%  Curr0_sigstats/THD
%  RPM1_sigstats/ClearanceFactor
%  RPM1_sigstats/CrestFactor
%  RPM1_sigstats/ImpulseFactor
%  RPM1_sigstats/Kurtosis
%  RPM1_sigstats/Mean
%  RPM1_sigstats/PeakValue
%  RPM1_sigstats/RMS
%  RPM1_sigstats/SINAD
%  RPM1_sigstats/SNR
%  RPM1_sigstats/ShapeFactor
%  RPM1_sigstats/Skewness
%  RPM1_sigstats/Std
%  RPM1_sigstats/THD
%  Curr1_sigstats/ClearanceFactor
%  Curr1_sigstats/CrestFactor
%  Curr1_sigstats/ImpulseFactor
%  Curr1_sigstats/Kurtosis
%  Curr1_sigstats/Mean
%  Curr1_sigstats/PeakValue
%  Curr1_sigstats/RMS
%  Curr1_sigstats/SINAD
%  Curr1_sigstats/SNR
%  Curr1_sigstats/ShapeFactor
%  Curr1_sigstats/Skewness
%  Curr1_sigstats/Std
%  Curr1_sigstats/THD
%  RPM2_sigstats/ClearanceFactor
%  RPM2_sigstats/CrestFactor
%  RPM2_sigstats/ImpulseFactor
%  RPM2_sigstats/Kurtosis
%  RPM2_sigstats/Mean
%  RPM2_sigstats/PeakValue
%  RPM2_sigstats/RMS
%  RPM2_sigstats/SINAD
%  RPM2_sigstats/SNR
%  RPM2_sigstats/ShapeFactor
%  RPM2_sigstats/Skewness
%  RPM2_sigstats/Std
%  RPM2_sigstats/THD
%  Curr2_sigstats/ClearanceFactor
%  Curr2_sigstats/CrestFactor
%  Curr2_sigstats/ImpulseFactor
%  Curr2_sigstats/Kurtosis
%  Curr2_sigstats/Mean
%  Curr2_sigstats/PeakValue
%  Curr2_sigstats/RMS
%  Curr2_sigstats/SINAD
%  Curr2_sigstats/SNR
%  Curr2_sigstats/ShapeFactor
%  Curr2_sigstats/Skewness
%  Curr2_sigstats/Std
%  Curr2_sigstats/THD
%  RPM3_sigstats/ClearanceFactor
%  RPM3_sigstats/CrestFactor
%  RPM3_sigstats/ImpulseFactor
%  RPM3_sigstats/Kurtosis
%  RPM3_sigstats/Mean
%  RPM3_sigstats/PeakValue
%  RPM3_sigstats/RMS
%  RPM3_sigstats/SINAD
%  RPM3_sigstats/SNR
%  RPM3_sigstats/ShapeFactor
%  RPM3_sigstats/Skewness
%  RPM3_sigstats/Std
%  RPM3_sigstats/THD
%  Curr3_sigstats/ClearanceFactor
%  Curr3_sigstats/CrestFactor
%  Curr3_sigstats/ImpulseFactor
%  Curr3_sigstats/Kurtosis
%  Curr3_sigstats/Mean
%  Curr3_sigstats/PeakValue
%  Curr3_sigstats/RMS
%  Curr3_sigstats/SINAD
%  Curr3_sigstats/SNR
%  Curr3_sigstats/ShapeFactor
%  Curr3_sigstats/Skewness
%  Curr3_sigstats/Std
%  Curr3_sigstats/THD
%  RPM4_sigstats/ClearanceFactor
%  RPM4_sigstats/CrestFactor
%  RPM4_sigstats/ImpulseFactor
%  RPM4_sigstats/Kurtosis
%  RPM4_sigstats/Mean
%  RPM4_sigstats/PeakValue
%  RPM4_sigstats/RMS
%  RPM4_sigstats/SINAD
%  RPM4_sigstats/SNR
%  RPM4_sigstats/ShapeFactor
%  RPM4_sigstats/Skewness
%  RPM4_sigstats/Std
%  RPM4_sigstats/THD
%  Curr4_sigstats/ClearanceFactor
%  Curr4_sigstats/CrestFactor
%  Curr4_sigstats/ImpulseFactor
%  Curr4_sigstats/Kurtosis
%  Curr4_sigstats/Mean
%  Curr4_sigstats/PeakValue
%  Curr4_sigstats/RMS
%  Curr4_sigstats/SINAD
%  Curr4_sigstats/SNR
%  Curr4_sigstats/ShapeFactor
%  Curr4_sigstats/Skewness
%  Curr4_sigstats/Std
%  Curr4_sigstats/THD
%  RPM5_sigstats/ClearanceFactor
%  RPM5_sigstats/CrestFactor
%  RPM5_sigstats/ImpulseFactor
%  RPM5_sigstats/Kurtosis
%  RPM5_sigstats/Mean
%  RPM5_sigstats/PeakValue
%  RPM5_sigstats/RMS
%  RPM5_sigstats/SINAD
%  RPM5_sigstats/SNR
%  RPM5_sigstats/ShapeFactor
%  RPM5_sigstats/Skewness
%  RPM5_sigstats/Std
%  RPM5_sigstats/THD
%  Curr5_sigstats/ClearanceFactor
%  Curr5_sigstats/CrestFactor
%  Curr5_sigstats/ImpulseFactor
%  Curr5_sigstats/Kurtosis
%  Curr5_sigstats/Mean
%  Curr5_sigstats/PeakValue
%  Curr5_sigstats/RMS
%  Curr5_sigstats/SINAD
%  Curr5_sigstats/SNR
%  Curr5_sigstats/ShapeFactor
%  Curr5_sigstats/Skewness
%  Curr5_sigstats/Std
%  Curr5_sigstats/THD
%  CTRL0_sigstats/ClearanceFactor
%  CTRL0_sigstats/CrestFactor
%  CTRL0_sigstats/ImpulseFactor
%  CTRL0_sigstats/Kurtosis
%  CTRL0_sigstats/Mean
%  CTRL0_sigstats/PeakValue
%  CTRL0_sigstats/RMS
%  CTRL0_sigstats/SINAD
%  CTRL0_sigstats/SNR
%  CTRL0_sigstats/ShapeFactor
%  CTRL0_sigstats/Skewness
%  CTRL0_sigstats/Std
%  CTRL0_sigstats/THD
%  CTRL1_sigstats/ClearanceFactor
%  CTRL1_sigstats/CrestFactor
%  CTRL1_sigstats/ImpulseFactor
%  CTRL1_sigstats/Kurtosis
%  CTRL1_sigstats/Mean
%  CTRL1_sigstats/PeakValue
%  CTRL1_sigstats/RMS
%  CTRL1_sigstats/SINAD
%  CTRL1_sigstats/SNR
%  CTRL1_sigstats/ShapeFactor
%  CTRL1_sigstats/Skewness
%  CTRL1_sigstats/Std
%  CTRL1_sigstats/THD
%  CTRL2_sigstats/ClearanceFactor
%  CTRL2_sigstats/CrestFactor
%  CTRL2_sigstats/ImpulseFactor
%  CTRL2_sigstats/Kurtosis
%  CTRL2_sigstats/Mean
%  CTRL2_sigstats/PeakValue
%  CTRL2_sigstats/RMS
%  CTRL2_sigstats/SINAD
%  CTRL2_sigstats/SNR
%  CTRL2_sigstats/ShapeFactor
%  CTRL2_sigstats/Skewness
%  CTRL2_sigstats/Std
%  CTRL2_sigstats/THD
%  CTRL3_sigstats/ClearanceFactor
%  CTRL3_sigstats/CrestFactor
%  CTRL3_sigstats/ImpulseFactor
%  CTRL3_sigstats/Kurtosis
%  CTRL3_sigstats/Mean
%  CTRL3_sigstats/PeakValue
%  CTRL3_sigstats/RMS
%  CTRL3_sigstats/SINAD
%  CTRL3_sigstats/SNR
%  CTRL3_sigstats/ShapeFactor
%  CTRL3_sigstats/Skewness
%  CTRL3_sigstats/Std
%  CTRL3_sigstats/THD
%  CTRL4_sigstats/ClearanceFactor
%  CTRL4_sigstats/CrestFactor
%  CTRL4_sigstats/ImpulseFactor
%  CTRL4_sigstats/Kurtosis
%  CTRL4_sigstats/Mean
%  CTRL4_sigstats/PeakValue
%  CTRL4_sigstats/RMS
%  CTRL4_sigstats/SINAD
%  CTRL4_sigstats/SNR
%  CTRL4_sigstats/ShapeFactor
%  CTRL4_sigstats/Skewness
%  CTRL4_sigstats/Std
%  CTRL4_sigstats/THD
%  CTRL5_sigstats/ClearanceFactor
%  CTRL5_sigstats/CrestFactor
%  CTRL5_sigstats/ImpulseFactor
%  CTRL5_sigstats/Kurtosis
%  CTRL5_sigstats/Mean
%  CTRL5_sigstats/PeakValue
%  CTRL5_sigstats/RMS
%  CTRL5_sigstats/SINAD
%  CTRL5_sigstats/SNR
%  CTRL5_sigstats/ShapeFactor
%  CTRL5_sigstats/Skewness
%  CTRL5_sigstats/Std
%  CTRL5_sigstats/THD
%  GyrX_ps_spec/PeakAmp1
%  GyrX_ps_spec/PeakAmp2
%  GyrX_ps_spec/PeakFreq1
%  GyrX_ps_spec/PeakFreq2
%  GyrX_ps_spec/BandPower
%  GyrY_ps_spec/PeakAmp1
%  GyrY_ps_spec/PeakAmp2
%  GyrY_ps_spec/PeakFreq1
%  GyrY_ps_spec/PeakFreq2
%  GyrY_ps_spec/BandPower
%  GyrZ_ps_spec/PeakAmp1
%  GyrZ_ps_spec/PeakAmp2
%  GyrZ_ps_spec/PeakFreq1
%  GyrZ_ps_spec/PeakFreq2
%  GyrZ_ps_spec/BandPower
%  AccX_ps_spec/PeakAmp1
%  AccX_ps_spec/PeakAmp2
%  AccX_ps_spec/PeakFreq1
%  AccX_ps_spec/PeakFreq2
%  AccX_ps_spec/BandPower
%  AccY_ps_spec/PeakAmp1
%  AccY_ps_spec/PeakAmp2
%  AccY_ps_spec/PeakFreq1
%  AccY_ps_spec/PeakFreq2
%  AccY_ps_spec/BandPower
%  AccZ_ps_spec/PeakAmp1
%  AccZ_ps_spec/PeakAmp2
%  AccZ_ps_spec/PeakFreq1
%  AccZ_ps_spec/PeakFreq2
%  AccZ_ps_spec/BandPower
%  VibeX_ps_spec/PeakAmp1
%  VibeX_ps_spec/PeakAmp2
%  VibeX_ps_spec/PeakFreq1
%  VibeX_ps_spec/PeakFreq2
%  VibeX_ps_spec/BandPower
%  VibeY_ps_spec/PeakAmp1
%  VibeY_ps_spec/PeakAmp2
%  VibeY_ps_spec/PeakFreq1
%  VibeY_ps_spec/PeakFreq2
%  VibeY_ps_spec/BandPower
%  VibeZ_ps_spec/PeakAmp1
%  VibeZ_ps_spec/PeakAmp2
%  VibeZ_ps_spec/PeakFreq1
%  VibeZ_ps_spec/PeakFreq2
%  VibeZ_ps_spec/BandPower
%  VelNorth_ps_spec/PeakAmp1
%  VelNorth_ps_spec/PeakAmp2
%  VelNorth_ps_spec/PeakFreq1
%  VelNorth_ps_spec/PeakFreq2
%  VelNorth_ps_spec/BandPower
%  VelEast_ps_spec/PeakAmp1
%  VelEast_ps_spec/PeakAmp2
%  VelEast_ps_spec/PeakFreq1
%  VelEast_ps_spec/PeakFreq2
%  VelEast_ps_spec/BandPower
%  VelDown_ps_spec/PeakAmp1
%  VelDown_ps_spec/PeakAmp2
%  VelDown_ps_spec/PeakFreq1
%  VelDown_ps_spec/PeakFreq2
%  VelDown_ps_spec/BandPower
%  DesRoll_ps_spec/PeakAmp1
%  DesRoll_ps_spec/PeakAmp2
%  DesRoll_ps_spec/PeakFreq1
%  DesRoll_ps_spec/PeakFreq2
%  DesRoll_ps_spec/BandPower
%  Roll_ps_spec/PeakAmp1
%  Roll_ps_spec/PeakAmp2
%  Roll_ps_spec/PeakFreq1
%  Roll_ps_spec/PeakFreq2
%  Roll_ps_spec/BandPower
%  DesPitch_ps_spec/PeakAmp1
%  DesPitch_ps_spec/PeakAmp2
%  DesPitch_ps_spec/PeakFreq1
%  DesPitch_ps_spec/PeakFreq2
%  DesPitch_ps_spec/BandPower
%  Pitch_ps_spec/PeakAmp1
%  Pitch_ps_spec/PeakAmp2
%  Pitch_ps_spec/PeakFreq1
%  Pitch_ps_spec/PeakFreq2
%  Pitch_ps_spec/BandPower
%  DesYaw_ps_spec/PeakAmp1
%  DesYaw_ps_spec/PeakAmp2
%  DesYaw_ps_spec/PeakFreq1
%  DesYaw_ps_spec/PeakFreq2
%  DesYaw_ps_spec/BandPower
%  Yaw_ps_spec/PeakAmp1
%  Yaw_ps_spec/PeakAmp2
%  Yaw_ps_spec/PeakFreq1
%  Yaw_ps_spec/PeakFreq2
%  Yaw_ps_spec/BandPower
%  RPM0_ps_spec/PeakAmp1
%  RPM0_ps_spec/PeakAmp2
%  RPM0_ps_spec/PeakFreq1
%  RPM0_ps_spec/PeakFreq2
%  RPM0_ps_spec/BandPower
%  Curr0_ps_spec/PeakAmp1
%  Curr0_ps_spec/PeakAmp2
%  Curr0_ps_spec/PeakFreq1
%  Curr0_ps_spec/PeakFreq2
%  Curr0_ps_spec/BandPower
%  RPM1_ps_spec/PeakAmp1
%  RPM1_ps_spec/PeakAmp2
%  RPM1_ps_spec/PeakFreq1
%  RPM1_ps_spec/PeakFreq2
%  RPM1_ps_spec/BandPower
%  Curr1_ps_spec/PeakAmp1
%  Curr1_ps_spec/PeakAmp2
%  Curr1_ps_spec/PeakFreq1
%  Curr1_ps_spec/PeakFreq2
%  Curr1_ps_spec/BandPower
%  RPM2_ps_spec/PeakAmp1
%  RPM2_ps_spec/PeakAmp2
%  RPM2_ps_spec/PeakFreq1
%  RPM2_ps_spec/PeakFreq2
%  RPM2_ps_spec/BandPower
%  Curr2_ps_spec/PeakAmp1
%  Curr2_ps_spec/PeakAmp2
%  Curr2_ps_spec/PeakFreq1
%  Curr2_ps_spec/PeakFreq2
%  Curr2_ps_spec/BandPower
%  RPM3_ps_spec/PeakAmp1
%  RPM3_ps_spec/PeakAmp2
%  RPM3_ps_spec/PeakFreq1
%  RPM3_ps_spec/PeakFreq2
%  RPM3_ps_spec/BandPower
%  Curr3_ps_spec/PeakAmp1
%  Curr3_ps_spec/PeakAmp2
%  Curr3_ps_spec/PeakFreq1
%  Curr3_ps_spec/PeakFreq2
%  Curr3_ps_spec/BandPower
%  RPM4_ps_spec/PeakAmp1
%  RPM4_ps_spec/PeakAmp2
%  RPM4_ps_spec/PeakFreq1
%  RPM4_ps_spec/PeakFreq2
%  RPM4_ps_spec/BandPower
%  Curr4_ps_spec/PeakAmp1
%  Curr4_ps_spec/PeakAmp2
%  Curr4_ps_spec/PeakFreq1
%  Curr4_ps_spec/PeakFreq2
%  Curr4_ps_spec/BandPower
%  RPM5_ps_spec/PeakAmp1
%  RPM5_ps_spec/PeakAmp2
%  RPM5_ps_spec/PeakFreq1
%  RPM5_ps_spec/PeakFreq2
%  RPM5_ps_spec/BandPower
%  Curr5_ps_spec/PeakAmp1
%  Curr5_ps_spec/PeakAmp2
%  Curr5_ps_spec/PeakFreq1
%  Curr5_ps_spec/PeakFreq2
%  Curr5_ps_spec/BandPower
%  CTRL0_ps_spec/PeakAmp1
%  CTRL0_ps_spec/PeakAmp2
%  CTRL0_ps_spec/PeakFreq1
%  CTRL0_ps_spec/PeakFreq2
%  CTRL0_ps_spec/BandPower
%  CTRL1_ps_spec/PeakAmp1
%  CTRL1_ps_spec/PeakAmp2
%  CTRL1_ps_spec/PeakFreq1
%  CTRL1_ps_spec/PeakFreq2
%  CTRL1_ps_spec/BandPower
%  CTRL2_ps_spec/PeakAmp1
%  CTRL2_ps_spec/PeakAmp2
%  CTRL2_ps_spec/PeakFreq1
%  CTRL2_ps_spec/PeakFreq2
%  CTRL2_ps_spec/BandPower
%  CTRL3_ps_spec/PeakAmp1
%  CTRL3_ps_spec/PeakAmp2
%  CTRL3_ps_spec/PeakFreq1
%  CTRL3_ps_spec/PeakFreq2
%  CTRL3_ps_spec/BandPower
%  CTRL4_ps_spec/PeakAmp1
%  CTRL4_ps_spec/PeakAmp2
%  CTRL4_ps_spec/PeakFreq1
%  CTRL4_ps_spec/PeakFreq2
%  CTRL4_ps_spec/BandPower
%  CTRL5_ps_spec/PeakAmp1
%  CTRL5_ps_spec/PeakAmp2
%  CTRL5_ps_spec/PeakFreq1
%  CTRL5_ps_spec/PeakFreq2
%  CTRL5_ps_spec/BandPower
%
% Frame Policy:
%  Frame name: FRM_1
%  Frame size: 1 seconds
%  Frame rate: 1 seconds
%
% Organization of the function:
% 1. Compute signals/spectra/features
% 2. Extract computed features into a table
%
% Modify the function to add or remove data processing, feature generation
% or ranking operations.

% Auto-generated by MATLAB on 10-Mar-2026 15:16:26

% Create output ensemble.
outputEnsemble = workspaceEnsemble(inputData,'DataVariables',["GyrX";"GyrY";"GyrZ";"AccX";"AccY";"AccZ";"VibeX";"VibeY";"VibeZ";"VelNorth";"VelEast";"VelDown";"DesRoll";"Roll";"DesPitch";"Pitch";"DesYaw";"Yaw";"RPM0";"Curr0";"RPM1";"Curr1";"RPM2";"Curr2";"RPM3";"Curr3";"RPM4";"Curr4";"RPM5";"Curr5";"CTRL0";"CTRL1";"CTRL2";"CTRL3";"CTRL4";"CTRL5"],'ConditionVariables',"WearPercentage");

% Reset the ensemble to read from the beginning of the ensemble.
reset(outputEnsemble);

% Append new frame policy name to DataVariables.
outputEnsemble.DataVariables = [outputEnsemble.DataVariables;"FRM_1"];

% Set SelectedVariables to select variables to read from the ensemble.
outputEnsemble.SelectedVariables = ["GyrX","GyrY","GyrZ","AccX","AccY","AccZ","VibeX","VibeY","VibeZ","VelNorth","VelEast","VelDown","DesRoll","Roll","DesPitch","Pitch","DesYaw","Yaw","RPM0","Curr0","RPM1","Curr1","RPM2","Curr2","RPM3","Curr3","RPM4","Curr4","RPM5","Curr5","CTRL0","CTRL1","CTRL2","CTRL3","CTRL4","CTRL5"];

% Initialize a cell array to store all the results.
allMembersResult = {};

% Loop through all ensemble members to read and write data.
while hasdata(outputEnsemble)
    % Read one member.
    member = read(outputEnsemble);

    % Read signals.
    GyrX_full = readMemberData(member,"GyrX",["Time","GyrX"]);
    GyrY_full = readMemberData(member,"GyrY",["Time","GyrY"]);
    GyrZ_full = readMemberData(member,"GyrZ",["Time","GyrZ"]);
    AccX_full = readMemberData(member,"AccX",["Time","AccX"]);
    AccY_full = readMemberData(member,"AccY",["Time","AccY"]);
    AccZ_full = readMemberData(member,"AccZ",["Time","AccZ"]);
    VibeX_full = readMemberData(member,"VibeX",["Time","VibeX"]);
    VibeY_full = readMemberData(member,"VibeY",["Time","VibeY"]);
    VibeZ_full = readMemberData(member,"VibeZ",["Time","VibeZ"]);
    VelNorth_full = readMemberData(member,"VelNorth",["Time","VelNorth"]);
    VelEast_full = readMemberData(member,"VelEast",["Time","VelEast"]);
    VelDown_full = readMemberData(member,"VelDown",["Time","VelDown"]);
    DesRoll_full = readMemberData(member,"DesRoll",["Time","DesRoll"]);
    Roll_full = readMemberData(member,"Roll",["Time","Roll"]);
    DesPitch_full = readMemberData(member,"DesPitch",["Time","DesPitch"]);
    Pitch_full = readMemberData(member,"Pitch",["Time","Pitch"]);
    DesYaw_full = readMemberData(member,"DesYaw",["Time","DesYaw"]);
    Yaw_full = readMemberData(member,"Yaw",["Time","Yaw"]);
    RPM0_full = readMemberData(member,"RPM0",["Time","RPM0"]);
    Curr0_full = readMemberData(member,"Curr0",["Time","Curr0"]);
    RPM1_full = readMemberData(member,"RPM1",["Time","RPM1"]);
    Curr1_full = readMemberData(member,"Curr1",["Time","Curr1"]);
    RPM2_full = readMemberData(member,"RPM2",["Time","RPM2"]);
    Curr2_full = readMemberData(member,"Curr2",["Time","Curr2"]);
    RPM3_full = readMemberData(member,"RPM3",["Time","RPM3"]);
    Curr3_full = readMemberData(member,"Curr3",["Time","Curr3"]);
    RPM4_full = readMemberData(member,"RPM4",["Time","RPM4"]);
    Curr4_full = readMemberData(member,"Curr4",["Time","Curr4"]);
    RPM5_full = readMemberData(member,"RPM5",["Time","RPM5"]);
    Curr5_full = readMemberData(member,"Curr5",["Time","Curr5"]);
    CTRL0_full = readMemberData(member,"CTRL0",["Time","CTRL0"]);
    CTRL1_full = readMemberData(member,"CTRL1",["Time","CTRL1"]);
    CTRL2_full = readMemberData(member,"CTRL2",["Time","CTRL2"]);
    CTRL3_full = readMemberData(member,"CTRL3",["Time","CTRL3"]);
    CTRL4_full = readMemberData(member,"CTRL4",["Time","CTRL4"]);
    CTRL5_full = readMemberData(member,"CTRL5",["Time","CTRL5"]);

    % Get the frame intervals.
    lowerBound = min([GyrX_full.Time(1),GyrY_full.Time(1),GyrZ_full.Time(1),AccX_full.Time(1),AccY_full.Time(1),AccZ_full.Time(1),VibeX_full.Time(1),VibeY_full.Time(1),VibeZ_full.Time(1),VelNorth_full.Time(1),VelEast_full.Time(1),VelDown_full.Time(1),DesRoll_full.Time(1),Roll_full.Time(1),DesPitch_full.Time(1),Pitch_full.Time(1),DesYaw_full.Time(1),Yaw_full.Time(1),RPM0_full.Time(1),Curr0_full.Time(1),RPM1_full.Time(1),Curr1_full.Time(1),RPM2_full.Time(1),Curr2_full.Time(1),RPM3_full.Time(1),Curr3_full.Time(1),RPM4_full.Time(1),Curr4_full.Time(1),RPM5_full.Time(1),Curr5_full.Time(1),CTRL0_full.Time(1),CTRL1_full.Time(1),CTRL2_full.Time(1),CTRL3_full.Time(1),CTRL4_full.Time(1),CTRL5_full.Time(1)]);
    upperBound = max([GyrX_full.Time(end),GyrY_full.Time(end),GyrZ_full.Time(end),AccX_full.Time(end),AccY_full.Time(end),AccZ_full.Time(end),VibeX_full.Time(end),VibeY_full.Time(end),VibeZ_full.Time(end),VelNorth_full.Time(end),VelEast_full.Time(end),VelDown_full.Time(end),DesRoll_full.Time(end),Roll_full.Time(end),DesPitch_full.Time(end),Pitch_full.Time(end),DesYaw_full.Time(end),Yaw_full.Time(end),RPM0_full.Time(end),Curr0_full.Time(end),RPM1_full.Time(end),Curr1_full.Time(end),RPM2_full.Time(end),Curr2_full.Time(end),RPM3_full.Time(end),Curr3_full.Time(end),RPM4_full.Time(end),Curr4_full.Time(end),RPM5_full.Time(end),Curr5_full.Time(end),CTRL0_full.Time(end),CTRL1_full.Time(end),CTRL2_full.Time(end),CTRL3_full.Time(end),CTRL4_full.Time(end),CTRL5_full.Time(end)]);
    fullIntervals = frameintervals([lowerBound upperBound],1,1,'FrameUnit',"seconds");
    intervals = fullIntervals;

    % Initialize a table to store frame results.
    frames = table;

    % Loop through all frame intervals and compute results.
    for ct = 1:height(intervals)
        % Get all input variables.
        GyrX = GyrX_full(GyrX_full.Time>=intervals{ct,1}&GyrX_full.Time<intervals{ct,2},:);
        GyrY = GyrY_full(GyrY_full.Time>=intervals{ct,1}&GyrY_full.Time<intervals{ct,2},:);
        GyrZ = GyrZ_full(GyrZ_full.Time>=intervals{ct,1}&GyrZ_full.Time<intervals{ct,2},:);
        AccX = AccX_full(AccX_full.Time>=intervals{ct,1}&AccX_full.Time<intervals{ct,2},:);
        AccY = AccY_full(AccY_full.Time>=intervals{ct,1}&AccY_full.Time<intervals{ct,2},:);
        AccZ = AccZ_full(AccZ_full.Time>=intervals{ct,1}&AccZ_full.Time<intervals{ct,2},:);
        VibeX = VibeX_full(VibeX_full.Time>=intervals{ct,1}&VibeX_full.Time<intervals{ct,2},:);
        VibeY = VibeY_full(VibeY_full.Time>=intervals{ct,1}&VibeY_full.Time<intervals{ct,2},:);
        VibeZ = VibeZ_full(VibeZ_full.Time>=intervals{ct,1}&VibeZ_full.Time<intervals{ct,2},:);
        VelNorth = VelNorth_full(VelNorth_full.Time>=intervals{ct,1}&VelNorth_full.Time<intervals{ct,2},:);
        VelEast = VelEast_full(VelEast_full.Time>=intervals{ct,1}&VelEast_full.Time<intervals{ct,2},:);
        VelDown = VelDown_full(VelDown_full.Time>=intervals{ct,1}&VelDown_full.Time<intervals{ct,2},:);
        DesRoll = DesRoll_full(DesRoll_full.Time>=intervals{ct,1}&DesRoll_full.Time<intervals{ct,2},:);
        Roll = Roll_full(Roll_full.Time>=intervals{ct,1}&Roll_full.Time<intervals{ct,2},:);
        DesPitch = DesPitch_full(DesPitch_full.Time>=intervals{ct,1}&DesPitch_full.Time<intervals{ct,2},:);
        Pitch = Pitch_full(Pitch_full.Time>=intervals{ct,1}&Pitch_full.Time<intervals{ct,2},:);
        DesYaw = DesYaw_full(DesYaw_full.Time>=intervals{ct,1}&DesYaw_full.Time<intervals{ct,2},:);
        Yaw = Yaw_full(Yaw_full.Time>=intervals{ct,1}&Yaw_full.Time<intervals{ct,2},:);
        RPM0 = RPM0_full(RPM0_full.Time>=intervals{ct,1}&RPM0_full.Time<intervals{ct,2},:);
        Curr0 = Curr0_full(Curr0_full.Time>=intervals{ct,1}&Curr0_full.Time<intervals{ct,2},:);
        RPM1 = RPM1_full(RPM1_full.Time>=intervals{ct,1}&RPM1_full.Time<intervals{ct,2},:);
        Curr1 = Curr1_full(Curr1_full.Time>=intervals{ct,1}&Curr1_full.Time<intervals{ct,2},:);
        RPM2 = RPM2_full(RPM2_full.Time>=intervals{ct,1}&RPM2_full.Time<intervals{ct,2},:);
        Curr2 = Curr2_full(Curr2_full.Time>=intervals{ct,1}&Curr2_full.Time<intervals{ct,2},:);
        RPM3 = RPM3_full(RPM3_full.Time>=intervals{ct,1}&RPM3_full.Time<intervals{ct,2},:);
        Curr3 = Curr3_full(Curr3_full.Time>=intervals{ct,1}&Curr3_full.Time<intervals{ct,2},:);
        RPM4 = RPM4_full(RPM4_full.Time>=intervals{ct,1}&RPM4_full.Time<intervals{ct,2},:);
        Curr4 = Curr4_full(Curr4_full.Time>=intervals{ct,1}&Curr4_full.Time<intervals{ct,2},:);
        RPM5 = RPM5_full(RPM5_full.Time>=intervals{ct,1}&RPM5_full.Time<intervals{ct,2},:);
        Curr5 = Curr5_full(Curr5_full.Time>=intervals{ct,1}&Curr5_full.Time<intervals{ct,2},:);
        CTRL0 = CTRL0_full(CTRL0_full.Time>=intervals{ct,1}&CTRL0_full.Time<intervals{ct,2},:);
        CTRL1 = CTRL1_full(CTRL1_full.Time>=intervals{ct,1}&CTRL1_full.Time<intervals{ct,2},:);
        CTRL2 = CTRL2_full(CTRL2_full.Time>=intervals{ct,1}&CTRL2_full.Time<intervals{ct,2},:);
        CTRL3 = CTRL3_full(CTRL3_full.Time>=intervals{ct,1}&CTRL3_full.Time<intervals{ct,2},:);
        CTRL4 = CTRL4_full(CTRL4_full.Time>=intervals{ct,1}&CTRL4_full.Time<intervals{ct,2},:);
        CTRL5 = CTRL5_full(CTRL5_full.Time>=intervals{ct,1}&CTRL5_full.Time<intervals{ct,2},:);

        % Initialize a table to store results for one frame interval.
        frame = intervals(ct,:);

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = GyrX.GyrX;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            GyrX_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            GyrX_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({GyrX_sigstats},'VariableNames',{'GyrX_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = GyrY.GyrY;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            GyrY_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            GyrY_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({GyrY_sigstats},'VariableNames',{'GyrY_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = GyrZ.GyrZ;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            GyrZ_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            GyrZ_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({GyrZ_sigstats},'VariableNames',{'GyrZ_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = AccX.AccX;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            AccX_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            AccX_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({AccX_sigstats},'VariableNames',{'AccX_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = AccY.AccY;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            AccY_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            AccY_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({AccY_sigstats},'VariableNames',{'AccY_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = AccZ.AccZ;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            AccZ_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            AccZ_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({AccZ_sigstats},'VariableNames',{'AccZ_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = VibeX.VibeX;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            VibeX_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            VibeX_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({VibeX_sigstats},'VariableNames',{'VibeX_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = VibeY.VibeY;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            VibeY_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            VibeY_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({VibeY_sigstats},'VariableNames',{'VibeY_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = VibeZ.VibeZ;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            VibeZ_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            VibeZ_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({VibeZ_sigstats},'VariableNames',{'VibeZ_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = VelNorth.VelNorth;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            VelNorth_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            VelNorth_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({VelNorth_sigstats},'VariableNames',{'VelNorth_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = VelEast.VelEast;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            VelEast_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            VelEast_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({VelEast_sigstats},'VariableNames',{'VelEast_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = VelDown.VelDown;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            VelDown_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            VelDown_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({VelDown_sigstats},'VariableNames',{'VelDown_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = DesRoll.DesRoll;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            DesRoll_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            DesRoll_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({DesRoll_sigstats},'VariableNames',{'DesRoll_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = Roll.Roll;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            Roll_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            Roll_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Roll_sigstats},'VariableNames',{'Roll_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = DesPitch.DesPitch;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            DesPitch_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            DesPitch_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({DesPitch_sigstats},'VariableNames',{'DesPitch_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = Pitch.Pitch;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            Pitch_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            Pitch_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Pitch_sigstats},'VariableNames',{'Pitch_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = DesYaw.DesYaw;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            DesYaw_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            DesYaw_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({DesYaw_sigstats},'VariableNames',{'DesYaw_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = Yaw.Yaw;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            Yaw_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            Yaw_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Yaw_sigstats},'VariableNames',{'Yaw_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = RPM0.RPM0;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            RPM0_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            RPM0_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({RPM0_sigstats},'VariableNames',{'RPM0_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = Curr0.Curr0;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            Curr0_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            Curr0_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Curr0_sigstats},'VariableNames',{'Curr0_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = RPM1.RPM1;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            RPM1_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            RPM1_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({RPM1_sigstats},'VariableNames',{'RPM1_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = Curr1.Curr1;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            Curr1_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            Curr1_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Curr1_sigstats},'VariableNames',{'Curr1_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = RPM2.RPM2;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            RPM2_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            RPM2_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({RPM2_sigstats},'VariableNames',{'RPM2_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = Curr2.Curr2;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            Curr2_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            Curr2_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Curr2_sigstats},'VariableNames',{'Curr2_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = RPM3.RPM3;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            RPM3_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            RPM3_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({RPM3_sigstats},'VariableNames',{'RPM3_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = Curr3.Curr3;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            Curr3_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            Curr3_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Curr3_sigstats},'VariableNames',{'Curr3_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = RPM4.RPM4;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            RPM4_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            RPM4_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({RPM4_sigstats},'VariableNames',{'RPM4_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = Curr4.Curr4;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            Curr4_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            Curr4_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Curr4_sigstats},'VariableNames',{'Curr4_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = RPM5.RPM5;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            RPM5_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            RPM5_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({RPM5_sigstats},'VariableNames',{'RPM5_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = Curr5.Curr5;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            Curr5_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            Curr5_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Curr5_sigstats},'VariableNames',{'Curr5_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = CTRL0.CTRL0;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            CTRL0_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            CTRL0_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({CTRL0_sigstats},'VariableNames',{'CTRL0_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = CTRL1.CTRL1;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            CTRL1_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            CTRL1_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({CTRL1_sigstats},'VariableNames',{'CTRL1_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = CTRL2.CTRL2;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            CTRL2_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            CTRL2_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({CTRL2_sigstats},'VariableNames',{'CTRL2_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = CTRL3.CTRL3;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            CTRL3_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            CTRL3_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({CTRL3_sigstats},'VariableNames',{'CTRL3_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = CTRL4.CTRL4;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            CTRL4_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            CTRL4_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({CTRL4_sigstats},'VariableNames',{'CTRL4_sigstats'})];

        %% SignalFeatures
        try
            % Compute signal features.
            inputSignal = CTRL5.CTRL5;
            ClearanceFactor = max(abs(inputSignal))/(mean(sqrt(abs(inputSignal)))^2);
            CrestFactor = peak2rms(inputSignal);
            ImpulseFactor = max(abs(inputSignal))/mean(abs(inputSignal));
            Kurtosis = kurtosis(inputSignal);
            Mean = mean(inputSignal,'omitnan');
            PeakValue = max(abs(inputSignal));
            RMS = rms(inputSignal,'omitnan');
            SINAD = sinad(inputSignal);
            SNR = snr(inputSignal);
            ShapeFactor = rms(inputSignal,'omitnan')/mean(abs(inputSignal),'omitnan');
            Skewness = skewness(inputSignal);
            Std = std(inputSignal,'omitnan');
            THD = thd(inputSignal);

            % Concatenate signal features.
            featureValues = [ClearanceFactor,CrestFactor,ImpulseFactor,Kurtosis,Mean,PeakValue,RMS,SINAD,SNR,ShapeFactor,Skewness,Std,THD];

            % Store computed features in a table.
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            CTRL5_sigstats = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,13);
            featureNames = {'ClearanceFactor','CrestFactor','ImpulseFactor','Kurtosis','Mean','PeakValue','RMS','SINAD','SNR','ShapeFactor','Skewness','Std','THD'};
            CTRL5_sigstats = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({CTRL5_sigstats},'VariableNames',{'CTRL5_sigstats'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(GyrX.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = GyrX.GyrX;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            GyrX_ps = ps;
        catch
            GyrX_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({GyrX_ps},'VariableNames',{'GyrX_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(GyrY.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = GyrY.GyrY;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            GyrY_ps = ps;
        catch
            GyrY_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({GyrY_ps},'VariableNames',{'GyrY_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(GyrZ.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = GyrZ.GyrZ;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            GyrZ_ps = ps;
        catch
            GyrZ_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({GyrZ_ps},'VariableNames',{'GyrZ_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(AccX.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = AccX.AccX;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            AccX_ps = ps;
        catch
            AccX_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({AccX_ps},'VariableNames',{'AccX_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(AccY.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = AccY.AccY;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            AccY_ps = ps;
        catch
            AccY_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({AccY_ps},'VariableNames',{'AccY_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(AccZ.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = AccZ.AccZ;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            AccZ_ps = ps;
        catch
            AccZ_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({AccZ_ps},'VariableNames',{'AccZ_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(VibeX.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = VibeX.VibeX;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            VibeX_ps = ps;
        catch
            VibeX_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({VibeX_ps},'VariableNames',{'VibeX_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(VibeY.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = VibeY.VibeY;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            VibeY_ps = ps;
        catch
            VibeY_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({VibeY_ps},'VariableNames',{'VibeY_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(VibeZ.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = VibeZ.VibeZ;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            VibeZ_ps = ps;
        catch
            VibeZ_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({VibeZ_ps},'VariableNames',{'VibeZ_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(VelNorth.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = VelNorth.VelNorth;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            VelNorth_ps = ps;
        catch
            VelNorth_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({VelNorth_ps},'VariableNames',{'VelNorth_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(VelEast.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = VelEast.VelEast;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            VelEast_ps = ps;
        catch
            VelEast_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({VelEast_ps},'VariableNames',{'VelEast_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(VelDown.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = VelDown.VelDown;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            VelDown_ps = ps;
        catch
            VelDown_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({VelDown_ps},'VariableNames',{'VelDown_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(DesRoll.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = DesRoll.DesRoll;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            DesRoll_ps = ps;
        catch
            DesRoll_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({DesRoll_ps},'VariableNames',{'DesRoll_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(Roll.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = Roll.Roll;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            Roll_ps = ps;
        catch
            Roll_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Roll_ps},'VariableNames',{'Roll_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(DesPitch.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = DesPitch.DesPitch;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            DesPitch_ps = ps;
        catch
            DesPitch_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({DesPitch_ps},'VariableNames',{'DesPitch_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(Pitch.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = Pitch.Pitch;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            Pitch_ps = ps;
        catch
            Pitch_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Pitch_ps},'VariableNames',{'Pitch_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(DesYaw.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = DesYaw.DesYaw;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            DesYaw_ps = ps;
        catch
            DesYaw_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({DesYaw_ps},'VariableNames',{'DesYaw_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(Yaw.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = Yaw.Yaw;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            Yaw_ps = ps;
        catch
            Yaw_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Yaw_ps},'VariableNames',{'Yaw_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(RPM0.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = RPM0.RPM0;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            RPM0_ps = ps;
        catch
            RPM0_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({RPM0_ps},'VariableNames',{'RPM0_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(Curr0.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = Curr0.Curr0;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            Curr0_ps = ps;
        catch
            Curr0_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Curr0_ps},'VariableNames',{'Curr0_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(RPM1.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = RPM1.RPM1;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            RPM1_ps = ps;
        catch
            RPM1_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({RPM1_ps},'VariableNames',{'RPM1_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(Curr1.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = Curr1.Curr1;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            Curr1_ps = ps;
        catch
            Curr1_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Curr1_ps},'VariableNames',{'Curr1_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(RPM2.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = RPM2.RPM2;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            RPM2_ps = ps;
        catch
            RPM2_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({RPM2_ps},'VariableNames',{'RPM2_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(Curr2.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = Curr2.Curr2;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            Curr2_ps = ps;
        catch
            Curr2_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Curr2_ps},'VariableNames',{'Curr2_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(RPM3.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = RPM3.RPM3;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            RPM3_ps = ps;
        catch
            RPM3_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({RPM3_ps},'VariableNames',{'RPM3_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(Curr3.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = Curr3.Curr3;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            Curr3_ps = ps;
        catch
            Curr3_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Curr3_ps},'VariableNames',{'Curr3_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(RPM4.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = RPM4.RPM4;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            RPM4_ps = ps;
        catch
            RPM4_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({RPM4_ps},'VariableNames',{'RPM4_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(Curr4.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = Curr4.Curr4;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            Curr4_ps = ps;
        catch
            Curr4_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Curr4_ps},'VariableNames',{'Curr4_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(RPM5.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = RPM5.RPM5;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            RPM5_ps = ps;
        catch
            RPM5_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({RPM5_ps},'VariableNames',{'RPM5_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(Curr5.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = Curr5.Curr5;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            Curr5_ps = ps;
        catch
            Curr5_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Curr5_ps},'VariableNames',{'Curr5_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(CTRL0.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = CTRL0.CTRL0;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            CTRL0_ps = ps;
        catch
            CTRL0_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({CTRL0_ps},'VariableNames',{'CTRL0_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(CTRL1.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = CTRL1.CTRL1;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            CTRL1_ps = ps;
        catch
            CTRL1_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({CTRL1_ps},'VariableNames',{'CTRL1_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(CTRL2.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = CTRL2.CTRL2;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            CTRL2_ps = ps;
        catch
            CTRL2_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({CTRL2_ps},'VariableNames',{'CTRL2_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(CTRL3.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = CTRL3.CTRL3;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            CTRL3_ps = ps;
        catch
            CTRL3_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({CTRL3_ps},'VariableNames',{'CTRL3_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(CTRL4.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = CTRL4.CTRL4;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            CTRL4_ps = ps;
        catch
            CTRL4_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({CTRL4_ps},'VariableNames',{'CTRL4_ps'})];

        %% PowerSpectrum
        try
            % Get units to use in computed spectrum.
            tuReal = "seconds";
            tuTime = tuReal;

            % Compute effective sampling rate.
            tNumeric = time2num(CTRL5.Time,tuReal);
            [Fs,irregular] = effectivefs(tNumeric);
            Ts = 1/Fs;

            % Resample non-uniform signals.
            x_raw = CTRL5.CTRL5;
            if irregular
                x = resample(x_raw,tNumeric,Fs,'linear');
            else
                x = x_raw;
            end

            % Compute the autoregressive model.
            data = iddata(x,[],Ts,'TimeUnit',tuTime,'OutputName','SpectrumData');
            arOpt = arOptions('Approach','fb','Window','now','EstimateCovariance',false);
            model = ar(data,10,arOpt);

            % Compute the power spectrum.
            [ps,w] = spectrum(model);
            ps = reshape(ps, numel(ps), 1);

            % Convert frequency unit.
            factor = funitconv('rad/TimeUnit', 'Hz', 'seconds');
            w = factor*w;
            Fs = 2*pi*factor*Fs;

            % Remove frequencies above Nyquist frequency.
            I = w<=(Fs/2+1e4*eps);
            w = w(I);
            ps = ps(I);

            % Configure the computed spectrum.
            ps = table(w, ps, 'VariableNames', {'Frequency', 'SpectrumData'});
            ps.Properties.VariableUnits = {'Hz', ''};
            ps = addprop(ps, {'SampleFrequency'}, {'table'});
            ps.Properties.CustomProperties.SampleFrequency = Fs;
            CTRL5_ps = ps;
        catch
            CTRL5_ps = table(NaN, NaN, 'VariableNames', {'Frequency', 'SpectrumData'});
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({CTRL5_ps},'VariableNames',{'CTRL5_ps'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = GyrX_ps.SpectrumData;
            w = GyrX_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            GyrX_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            GyrX_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({GyrX_ps_spec},'VariableNames',{'GyrX_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = GyrY_ps.SpectrumData;
            w = GyrY_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            GyrY_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            GyrY_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({GyrY_ps_spec},'VariableNames',{'GyrY_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = GyrZ_ps.SpectrumData;
            w = GyrZ_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            GyrZ_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            GyrZ_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({GyrZ_ps_spec},'VariableNames',{'GyrZ_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = AccX_ps.SpectrumData;
            w = AccX_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            AccX_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            AccX_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({AccX_ps_spec},'VariableNames',{'AccX_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = AccY_ps.SpectrumData;
            w = AccY_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            AccY_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            AccY_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({AccY_ps_spec},'VariableNames',{'AccY_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = AccZ_ps.SpectrumData;
            w = AccZ_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            AccZ_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            AccZ_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({AccZ_ps_spec},'VariableNames',{'AccZ_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = VibeX_ps.SpectrumData;
            w = VibeX_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            VibeX_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            VibeX_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({VibeX_ps_spec},'VariableNames',{'VibeX_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = VibeY_ps.SpectrumData;
            w = VibeY_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            VibeY_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            VibeY_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({VibeY_ps_spec},'VariableNames',{'VibeY_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = VibeZ_ps.SpectrumData;
            w = VibeZ_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            VibeZ_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            VibeZ_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({VibeZ_ps_spec},'VariableNames',{'VibeZ_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = VelNorth_ps.SpectrumData;
            w = VelNorth_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            VelNorth_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            VelNorth_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({VelNorth_ps_spec},'VariableNames',{'VelNorth_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = VelEast_ps.SpectrumData;
            w = VelEast_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            VelEast_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            VelEast_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({VelEast_ps_spec},'VariableNames',{'VelEast_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = VelDown_ps.SpectrumData;
            w = VelDown_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            VelDown_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            VelDown_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({VelDown_ps_spec},'VariableNames',{'VelDown_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = DesRoll_ps.SpectrumData;
            w = DesRoll_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            DesRoll_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            DesRoll_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({DesRoll_ps_spec},'VariableNames',{'DesRoll_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = Roll_ps.SpectrumData;
            w = Roll_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            Roll_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            Roll_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Roll_ps_spec},'VariableNames',{'Roll_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = DesPitch_ps.SpectrumData;
            w = DesPitch_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            DesPitch_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            DesPitch_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({DesPitch_ps_spec},'VariableNames',{'DesPitch_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = Pitch_ps.SpectrumData;
            w = Pitch_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            Pitch_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            Pitch_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Pitch_ps_spec},'VariableNames',{'Pitch_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = DesYaw_ps.SpectrumData;
            w = DesYaw_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            DesYaw_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            DesYaw_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({DesYaw_ps_spec},'VariableNames',{'DesYaw_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = Yaw_ps.SpectrumData;
            w = Yaw_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            Yaw_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            Yaw_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Yaw_ps_spec},'VariableNames',{'Yaw_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = RPM0_ps.SpectrumData;
            w = RPM0_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            RPM0_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            RPM0_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({RPM0_ps_spec},'VariableNames',{'RPM0_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = Curr0_ps.SpectrumData;
            w = Curr0_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            Curr0_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            Curr0_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Curr0_ps_spec},'VariableNames',{'Curr0_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = RPM1_ps.SpectrumData;
            w = RPM1_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            RPM1_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            RPM1_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({RPM1_ps_spec},'VariableNames',{'RPM1_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = Curr1_ps.SpectrumData;
            w = Curr1_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            Curr1_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            Curr1_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Curr1_ps_spec},'VariableNames',{'Curr1_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = RPM2_ps.SpectrumData;
            w = RPM2_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            RPM2_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            RPM2_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({RPM2_ps_spec},'VariableNames',{'RPM2_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = Curr2_ps.SpectrumData;
            w = Curr2_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            Curr2_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            Curr2_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Curr2_ps_spec},'VariableNames',{'Curr2_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = RPM3_ps.SpectrumData;
            w = RPM3_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            RPM3_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            RPM3_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({RPM3_ps_spec},'VariableNames',{'RPM3_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = Curr3_ps.SpectrumData;
            w = Curr3_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            Curr3_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            Curr3_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Curr3_ps_spec},'VariableNames',{'Curr3_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = RPM4_ps.SpectrumData;
            w = RPM4_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            RPM4_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            RPM4_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({RPM4_ps_spec},'VariableNames',{'RPM4_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = Curr4_ps.SpectrumData;
            w = Curr4_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            Curr4_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            Curr4_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Curr4_ps_spec},'VariableNames',{'Curr4_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = RPM5_ps.SpectrumData;
            w = RPM5_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            RPM5_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            RPM5_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({RPM5_ps_spec},'VariableNames',{'RPM5_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = Curr5_ps.SpectrumData;
            w = Curr5_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            Curr5_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            Curr5_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({Curr5_ps_spec},'VariableNames',{'Curr5_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = CTRL0_ps.SpectrumData;
            w = CTRL0_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            CTRL0_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            CTRL0_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({CTRL0_ps_spec},'VariableNames',{'CTRL0_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = CTRL1_ps.SpectrumData;
            w = CTRL1_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            CTRL1_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            CTRL1_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({CTRL1_ps_spec},'VariableNames',{'CTRL1_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = CTRL2_ps.SpectrumData;
            w = CTRL2_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            CTRL2_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            CTRL2_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({CTRL2_ps_spec},'VariableNames',{'CTRL2_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = CTRL3_ps.SpectrumData;
            w = CTRL3_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            CTRL3_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            CTRL3_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({CTRL3_ps_spec},'VariableNames',{'CTRL3_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = CTRL4_ps.SpectrumData;
            w = CTRL4_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            CTRL4_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            CTRL4_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({CTRL4_ps_spec},'VariableNames',{'CTRL4_ps_spec'})];

        %% SpectrumFeatures
        try
            % Compute spectral features.
            % Get frequency unit conversion factor.
            factor = funitconv('Hz', 'rad/TimeUnit', 'seconds');
            ps = CTRL5_ps.SpectrumData;
            w = CTRL5_ps.Frequency;
            w = factor*w;
            mask_1 = (w>=factor*0.00159154943091895) & (w<=factor*175.00000000001);
            ps = ps(mask_1);
            w = w(mask_1);

            % Compute spectral peaks.
            [peakAmp,peakFreq] = findpeaks(ps,w/factor,'MinPeakHeight',-Inf, ...
                'MinPeakProminence',0,'MinPeakDistance',0.001,'SortStr','descend','NPeaks',2);
            peakAmp = [peakAmp(:); NaN(2-numel(peakAmp),1)];
            peakFreq = [peakFreq(:); NaN(2-numel(peakFreq),1)];

            % Extract individual feature values.
            PeakAmp1 = peakAmp(1);
            PeakAmp2 = peakAmp(2);
            PeakFreq1 = peakFreq(1);
            PeakFreq2 = peakFreq(2);
            BandPower = trapz(w/factor,ps);

            % Concatenate signal features.
            featureValues = [PeakAmp1,PeakAmp2,PeakFreq1,PeakFreq2,BandPower];

            % Store computed features in a table.
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            CTRL5_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        catch
            % Store computed features in a table.
            featureValues = NaN(1,5);
            featureNames = {'PeakAmp1','PeakAmp2','PeakFreq1','PeakFreq2','BandPower'};
            CTRL5_ps_spec = array2table(featureValues,'VariableNames',featureNames);
        end

        % Append computed results to the frame table.
        frame = [frame, ...
            table({CTRL5_ps_spec},'VariableNames',{'CTRL5_ps_spec'})];

        %% Concatenate frames.
        frames = [frames;frame]; %#ok<*AGROW>
    end
    % Append all member results to the cell array.
    memberResult = table({frames},'VariableNames',"FRM_1");
    allMembersResult = [allMembersResult; {memberResult}]; %#ok<AGROW>
end

% Write the results for all members to the ensemble.
writeToMembers(outputEnsemble,allMembersResult)

% Gather all features into a table.
selectedFeatureNames = ["FRM_1/GyrX_sigstats/ClearanceFactor","FRM_1/GyrX_sigstats/CrestFactor","FRM_1/GyrX_sigstats/ImpulseFactor","FRM_1/GyrX_sigstats/Kurtosis","FRM_1/GyrX_sigstats/Mean","FRM_1/GyrX_sigstats/PeakValue","FRM_1/GyrX_sigstats/RMS","FRM_1/GyrX_sigstats/SINAD","FRM_1/GyrX_sigstats/SNR","FRM_1/GyrX_sigstats/ShapeFactor","FRM_1/GyrX_sigstats/Skewness","FRM_1/GyrX_sigstats/Std","FRM_1/GyrX_sigstats/THD","FRM_1/GyrY_sigstats/ClearanceFactor","FRM_1/GyrY_sigstats/CrestFactor","FRM_1/GyrY_sigstats/ImpulseFactor","FRM_1/GyrY_sigstats/Kurtosis","FRM_1/GyrY_sigstats/Mean","FRM_1/GyrY_sigstats/PeakValue","FRM_1/GyrY_sigstats/RMS","FRM_1/GyrY_sigstats/SINAD","FRM_1/GyrY_sigstats/SNR","FRM_1/GyrY_sigstats/ShapeFactor","FRM_1/GyrY_sigstats/Skewness","FRM_1/GyrY_sigstats/Std","FRM_1/GyrY_sigstats/THD","FRM_1/GyrZ_sigstats/ClearanceFactor","FRM_1/GyrZ_sigstats/CrestFactor","FRM_1/GyrZ_sigstats/ImpulseFactor","FRM_1/GyrZ_sigstats/Kurtosis","FRM_1/GyrZ_sigstats/Mean","FRM_1/GyrZ_sigstats/PeakValue","FRM_1/GyrZ_sigstats/RMS","FRM_1/GyrZ_sigstats/SINAD","FRM_1/GyrZ_sigstats/SNR","FRM_1/GyrZ_sigstats/ShapeFactor","FRM_1/GyrZ_sigstats/Skewness","FRM_1/GyrZ_sigstats/Std","FRM_1/GyrZ_sigstats/THD","FRM_1/AccX_sigstats/ClearanceFactor","FRM_1/AccX_sigstats/CrestFactor","FRM_1/AccX_sigstats/ImpulseFactor","FRM_1/AccX_sigstats/Kurtosis","FRM_1/AccX_sigstats/Mean","FRM_1/AccX_sigstats/PeakValue","FRM_1/AccX_sigstats/RMS","FRM_1/AccX_sigstats/SINAD","FRM_1/AccX_sigstats/SNR","FRM_1/AccX_sigstats/ShapeFactor","FRM_1/AccX_sigstats/Skewness","FRM_1/AccX_sigstats/Std","FRM_1/AccX_sigstats/THD","FRM_1/AccY_sigstats/ClearanceFactor","FRM_1/AccY_sigstats/CrestFactor","FRM_1/AccY_sigstats/ImpulseFactor","FRM_1/AccY_sigstats/Kurtosis","FRM_1/AccY_sigstats/Mean","FRM_1/AccY_sigstats/PeakValue","FRM_1/AccY_sigstats/RMS","FRM_1/AccY_sigstats/SINAD","FRM_1/AccY_sigstats/SNR","FRM_1/AccY_sigstats/ShapeFactor","FRM_1/AccY_sigstats/Skewness","FRM_1/AccY_sigstats/Std","FRM_1/AccY_sigstats/THD","FRM_1/AccZ_sigstats/ClearanceFactor","FRM_1/AccZ_sigstats/CrestFactor","FRM_1/AccZ_sigstats/ImpulseFactor","FRM_1/AccZ_sigstats/Kurtosis","FRM_1/AccZ_sigstats/Mean","FRM_1/AccZ_sigstats/PeakValue","FRM_1/AccZ_sigstats/RMS","FRM_1/AccZ_sigstats/SINAD","FRM_1/AccZ_sigstats/SNR","FRM_1/AccZ_sigstats/ShapeFactor","FRM_1/AccZ_sigstats/Skewness","FRM_1/AccZ_sigstats/Std","FRM_1/AccZ_sigstats/THD","FRM_1/VibeX_sigstats/ClearanceFactor","FRM_1/VibeX_sigstats/CrestFactor","FRM_1/VibeX_sigstats/ImpulseFactor","FRM_1/VibeX_sigstats/Kurtosis","FRM_1/VibeX_sigstats/Mean","FRM_1/VibeX_sigstats/PeakValue","FRM_1/VibeX_sigstats/RMS","FRM_1/VibeX_sigstats/SINAD","FRM_1/VibeX_sigstats/SNR","FRM_1/VibeX_sigstats/ShapeFactor","FRM_1/VibeX_sigstats/Skewness","FRM_1/VibeX_sigstats/Std","FRM_1/VibeX_sigstats/THD","FRM_1/VibeY_sigstats/ClearanceFactor","FRM_1/VibeY_sigstats/CrestFactor","FRM_1/VibeY_sigstats/ImpulseFactor","FRM_1/VibeY_sigstats/Kurtosis","FRM_1/VibeY_sigstats/Mean","FRM_1/VibeY_sigstats/PeakValue","FRM_1/VibeY_sigstats/RMS","FRM_1/VibeY_sigstats/SINAD","FRM_1/VibeY_sigstats/SNR","FRM_1/VibeY_sigstats/ShapeFactor","FRM_1/VibeY_sigstats/Skewness","FRM_1/VibeY_sigstats/Std","FRM_1/VibeY_sigstats/THD","FRM_1/VibeZ_sigstats/ClearanceFactor","FRM_1/VibeZ_sigstats/CrestFactor","FRM_1/VibeZ_sigstats/ImpulseFactor","FRM_1/VibeZ_sigstats/Kurtosis","FRM_1/VibeZ_sigstats/Mean","FRM_1/VibeZ_sigstats/PeakValue","FRM_1/VibeZ_sigstats/RMS","FRM_1/VibeZ_sigstats/SINAD","FRM_1/VibeZ_sigstats/SNR","FRM_1/VibeZ_sigstats/ShapeFactor","FRM_1/VibeZ_sigstats/Skewness","FRM_1/VibeZ_sigstats/Std","FRM_1/VibeZ_sigstats/THD","FRM_1/VelNorth_sigstats/ClearanceFactor","FRM_1/VelNorth_sigstats/CrestFactor","FRM_1/VelNorth_sigstats/ImpulseFactor","FRM_1/VelNorth_sigstats/Kurtosis","FRM_1/VelNorth_sigstats/Mean","FRM_1/VelNorth_sigstats/PeakValue","FRM_1/VelNorth_sigstats/RMS","FRM_1/VelNorth_sigstats/SINAD","FRM_1/VelNorth_sigstats/SNR","FRM_1/VelNorth_sigstats/ShapeFactor","FRM_1/VelNorth_sigstats/Skewness","FRM_1/VelNorth_sigstats/Std","FRM_1/VelNorth_sigstats/THD","FRM_1/VelEast_sigstats/ClearanceFactor","FRM_1/VelEast_sigstats/CrestFactor","FRM_1/VelEast_sigstats/ImpulseFactor","FRM_1/VelEast_sigstats/Kurtosis","FRM_1/VelEast_sigstats/Mean","FRM_1/VelEast_sigstats/PeakValue","FRM_1/VelEast_sigstats/RMS","FRM_1/VelEast_sigstats/SINAD","FRM_1/VelEast_sigstats/SNR","FRM_1/VelEast_sigstats/ShapeFactor","FRM_1/VelEast_sigstats/Skewness","FRM_1/VelEast_sigstats/Std","FRM_1/VelEast_sigstats/THD","FRM_1/VelDown_sigstats/ClearanceFactor","FRM_1/VelDown_sigstats/CrestFactor","FRM_1/VelDown_sigstats/ImpulseFactor","FRM_1/VelDown_sigstats/Kurtosis","FRM_1/VelDown_sigstats/Mean","FRM_1/VelDown_sigstats/PeakValue","FRM_1/VelDown_sigstats/RMS","FRM_1/VelDown_sigstats/SINAD","FRM_1/VelDown_sigstats/SNR","FRM_1/VelDown_sigstats/ShapeFactor","FRM_1/VelDown_sigstats/Skewness","FRM_1/VelDown_sigstats/Std","FRM_1/VelDown_sigstats/THD","FRM_1/DesRoll_sigstats/ClearanceFactor","FRM_1/DesRoll_sigstats/CrestFactor","FRM_1/DesRoll_sigstats/ImpulseFactor","FRM_1/DesRoll_sigstats/Kurtosis","FRM_1/DesRoll_sigstats/Mean","FRM_1/DesRoll_sigstats/PeakValue","FRM_1/DesRoll_sigstats/RMS","FRM_1/DesRoll_sigstats/SINAD","FRM_1/DesRoll_sigstats/SNR","FRM_1/DesRoll_sigstats/ShapeFactor","FRM_1/DesRoll_sigstats/Skewness","FRM_1/DesRoll_sigstats/Std","FRM_1/DesRoll_sigstats/THD","FRM_1/Roll_sigstats/ClearanceFactor","FRM_1/Roll_sigstats/CrestFactor","FRM_1/Roll_sigstats/ImpulseFactor","FRM_1/Roll_sigstats/Kurtosis","FRM_1/Roll_sigstats/Mean","FRM_1/Roll_sigstats/PeakValue","FRM_1/Roll_sigstats/RMS","FRM_1/Roll_sigstats/SINAD","FRM_1/Roll_sigstats/SNR","FRM_1/Roll_sigstats/ShapeFactor","FRM_1/Roll_sigstats/Skewness","FRM_1/Roll_sigstats/Std","FRM_1/Roll_sigstats/THD","FRM_1/DesPitch_sigstats/ClearanceFactor","FRM_1/DesPitch_sigstats/CrestFactor","FRM_1/DesPitch_sigstats/ImpulseFactor","FRM_1/DesPitch_sigstats/Kurtosis","FRM_1/DesPitch_sigstats/Mean","FRM_1/DesPitch_sigstats/PeakValue","FRM_1/DesPitch_sigstats/RMS","FRM_1/DesPitch_sigstats/SINAD","FRM_1/DesPitch_sigstats/SNR","FRM_1/DesPitch_sigstats/ShapeFactor","FRM_1/DesPitch_sigstats/Skewness","FRM_1/DesPitch_sigstats/Std","FRM_1/DesPitch_sigstats/THD","FRM_1/Pitch_sigstats/ClearanceFactor","FRM_1/Pitch_sigstats/CrestFactor","FRM_1/Pitch_sigstats/ImpulseFactor","FRM_1/Pitch_sigstats/Kurtosis","FRM_1/Pitch_sigstats/Mean","FRM_1/Pitch_sigstats/PeakValue","FRM_1/Pitch_sigstats/RMS","FRM_1/Pitch_sigstats/SINAD","FRM_1/Pitch_sigstats/SNR","FRM_1/Pitch_sigstats/ShapeFactor","FRM_1/Pitch_sigstats/Skewness","FRM_1/Pitch_sigstats/Std","FRM_1/Pitch_sigstats/THD","FRM_1/DesYaw_sigstats/ClearanceFactor","FRM_1/DesYaw_sigstats/CrestFactor","FRM_1/DesYaw_sigstats/ImpulseFactor","FRM_1/DesYaw_sigstats/Kurtosis","FRM_1/DesYaw_sigstats/Mean","FRM_1/DesYaw_sigstats/PeakValue","FRM_1/DesYaw_sigstats/RMS","FRM_1/DesYaw_sigstats/SINAD","FRM_1/DesYaw_sigstats/SNR","FRM_1/DesYaw_sigstats/ShapeFactor","FRM_1/DesYaw_sigstats/Skewness","FRM_1/DesYaw_sigstats/Std","FRM_1/DesYaw_sigstats/THD","FRM_1/Yaw_sigstats/ClearanceFactor","FRM_1/Yaw_sigstats/CrestFactor","FRM_1/Yaw_sigstats/ImpulseFactor","FRM_1/Yaw_sigstats/Kurtosis","FRM_1/Yaw_sigstats/Mean","FRM_1/Yaw_sigstats/PeakValue","FRM_1/Yaw_sigstats/RMS","FRM_1/Yaw_sigstats/SINAD","FRM_1/Yaw_sigstats/SNR","FRM_1/Yaw_sigstats/ShapeFactor","FRM_1/Yaw_sigstats/Skewness","FRM_1/Yaw_sigstats/Std","FRM_1/Yaw_sigstats/THD","FRM_1/RPM0_sigstats/ClearanceFactor","FRM_1/RPM0_sigstats/CrestFactor","FRM_1/RPM0_sigstats/ImpulseFactor","FRM_1/RPM0_sigstats/Kurtosis","FRM_1/RPM0_sigstats/Mean","FRM_1/RPM0_sigstats/PeakValue","FRM_1/RPM0_sigstats/RMS","FRM_1/RPM0_sigstats/SINAD","FRM_1/RPM0_sigstats/SNR","FRM_1/RPM0_sigstats/ShapeFactor","FRM_1/RPM0_sigstats/Skewness","FRM_1/RPM0_sigstats/Std","FRM_1/RPM0_sigstats/THD","FRM_1/Curr0_sigstats/ClearanceFactor","FRM_1/Curr0_sigstats/CrestFactor","FRM_1/Curr0_sigstats/ImpulseFactor","FRM_1/Curr0_sigstats/Kurtosis","FRM_1/Curr0_sigstats/Mean","FRM_1/Curr0_sigstats/PeakValue","FRM_1/Curr0_sigstats/RMS","FRM_1/Curr0_sigstats/SINAD","FRM_1/Curr0_sigstats/SNR","FRM_1/Curr0_sigstats/ShapeFactor","FRM_1/Curr0_sigstats/Skewness","FRM_1/Curr0_sigstats/Std","FRM_1/Curr0_sigstats/THD","FRM_1/RPM1_sigstats/ClearanceFactor","FRM_1/RPM1_sigstats/CrestFactor","FRM_1/RPM1_sigstats/ImpulseFactor","FRM_1/RPM1_sigstats/Kurtosis","FRM_1/RPM1_sigstats/Mean","FRM_1/RPM1_sigstats/PeakValue","FRM_1/RPM1_sigstats/RMS","FRM_1/RPM1_sigstats/SINAD","FRM_1/RPM1_sigstats/SNR","FRM_1/RPM1_sigstats/ShapeFactor","FRM_1/RPM1_sigstats/Skewness","FRM_1/RPM1_sigstats/Std","FRM_1/RPM1_sigstats/THD","FRM_1/Curr1_sigstats/ClearanceFactor","FRM_1/Curr1_sigstats/CrestFactor","FRM_1/Curr1_sigstats/ImpulseFactor","FRM_1/Curr1_sigstats/Kurtosis","FRM_1/Curr1_sigstats/Mean","FRM_1/Curr1_sigstats/PeakValue","FRM_1/Curr1_sigstats/RMS","FRM_1/Curr1_sigstats/SINAD","FRM_1/Curr1_sigstats/SNR","FRM_1/Curr1_sigstats/ShapeFactor","FRM_1/Curr1_sigstats/Skewness","FRM_1/Curr1_sigstats/Std","FRM_1/Curr1_sigstats/THD","FRM_1/RPM2_sigstats/ClearanceFactor","FRM_1/RPM2_sigstats/CrestFactor","FRM_1/RPM2_sigstats/ImpulseFactor","FRM_1/RPM2_sigstats/Kurtosis","FRM_1/RPM2_sigstats/Mean","FRM_1/RPM2_sigstats/PeakValue","FRM_1/RPM2_sigstats/RMS","FRM_1/RPM2_sigstats/SINAD","FRM_1/RPM2_sigstats/SNR","FRM_1/RPM2_sigstats/ShapeFactor","FRM_1/RPM2_sigstats/Skewness","FRM_1/RPM2_sigstats/Std","FRM_1/RPM2_sigstats/THD","FRM_1/Curr2_sigstats/ClearanceFactor","FRM_1/Curr2_sigstats/CrestFactor","FRM_1/Curr2_sigstats/ImpulseFactor","FRM_1/Curr2_sigstats/Kurtosis","FRM_1/Curr2_sigstats/Mean","FRM_1/Curr2_sigstats/PeakValue","FRM_1/Curr2_sigstats/RMS","FRM_1/Curr2_sigstats/SINAD","FRM_1/Curr2_sigstats/SNR","FRM_1/Curr2_sigstats/ShapeFactor","FRM_1/Curr2_sigstats/Skewness","FRM_1/Curr2_sigstats/Std","FRM_1/Curr2_sigstats/THD","FRM_1/RPM3_sigstats/ClearanceFactor","FRM_1/RPM3_sigstats/CrestFactor","FRM_1/RPM3_sigstats/ImpulseFactor","FRM_1/RPM3_sigstats/Kurtosis","FRM_1/RPM3_sigstats/Mean","FRM_1/RPM3_sigstats/PeakValue","FRM_1/RPM3_sigstats/RMS","FRM_1/RPM3_sigstats/SINAD","FRM_1/RPM3_sigstats/SNR","FRM_1/RPM3_sigstats/ShapeFactor","FRM_1/RPM3_sigstats/Skewness","FRM_1/RPM3_sigstats/Std","FRM_1/RPM3_sigstats/THD","FRM_1/Curr3_sigstats/ClearanceFactor","FRM_1/Curr3_sigstats/CrestFactor","FRM_1/Curr3_sigstats/ImpulseFactor","FRM_1/Curr3_sigstats/Kurtosis","FRM_1/Curr3_sigstats/Mean","FRM_1/Curr3_sigstats/PeakValue","FRM_1/Curr3_sigstats/RMS","FRM_1/Curr3_sigstats/SINAD","FRM_1/Curr3_sigstats/SNR","FRM_1/Curr3_sigstats/ShapeFactor","FRM_1/Curr3_sigstats/Skewness","FRM_1/Curr3_sigstats/Std","FRM_1/Curr3_sigstats/THD","FRM_1/RPM4_sigstats/ClearanceFactor","FRM_1/RPM4_sigstats/CrestFactor","FRM_1/RPM4_sigstats/ImpulseFactor","FRM_1/RPM4_sigstats/Kurtosis","FRM_1/RPM4_sigstats/Mean","FRM_1/RPM4_sigstats/PeakValue","FRM_1/RPM4_sigstats/RMS","FRM_1/RPM4_sigstats/SINAD","FRM_1/RPM4_sigstats/SNR","FRM_1/RPM4_sigstats/ShapeFactor","FRM_1/RPM4_sigstats/Skewness","FRM_1/RPM4_sigstats/Std","FRM_1/RPM4_sigstats/THD","FRM_1/Curr4_sigstats/ClearanceFactor","FRM_1/Curr4_sigstats/CrestFactor","FRM_1/Curr4_sigstats/ImpulseFactor","FRM_1/Curr4_sigstats/Kurtosis","FRM_1/Curr4_sigstats/Mean","FRM_1/Curr4_sigstats/PeakValue","FRM_1/Curr4_sigstats/RMS","FRM_1/Curr4_sigstats/SINAD","FRM_1/Curr4_sigstats/SNR","FRM_1/Curr4_sigstats/ShapeFactor","FRM_1/Curr4_sigstats/Skewness","FRM_1/Curr4_sigstats/Std","FRM_1/Curr4_sigstats/THD","FRM_1/RPM5_sigstats/ClearanceFactor","FRM_1/RPM5_sigstats/CrestFactor","FRM_1/RPM5_sigstats/ImpulseFactor","FRM_1/RPM5_sigstats/Kurtosis","FRM_1/RPM5_sigstats/Mean","FRM_1/RPM5_sigstats/PeakValue","FRM_1/RPM5_sigstats/RMS","FRM_1/RPM5_sigstats/SINAD","FRM_1/RPM5_sigstats/SNR","FRM_1/RPM5_sigstats/ShapeFactor","FRM_1/RPM5_sigstats/Skewness","FRM_1/RPM5_sigstats/Std","FRM_1/RPM5_sigstats/THD","FRM_1/Curr5_sigstats/ClearanceFactor","FRM_1/Curr5_sigstats/CrestFactor","FRM_1/Curr5_sigstats/ImpulseFactor","FRM_1/Curr5_sigstats/Kurtosis","FRM_1/Curr5_sigstats/Mean","FRM_1/Curr5_sigstats/PeakValue","FRM_1/Curr5_sigstats/RMS","FRM_1/Curr5_sigstats/SINAD","FRM_1/Curr5_sigstats/SNR","FRM_1/Curr5_sigstats/ShapeFactor","FRM_1/Curr5_sigstats/Skewness","FRM_1/Curr5_sigstats/Std","FRM_1/Curr5_sigstats/THD","FRM_1/CTRL0_sigstats/ClearanceFactor","FRM_1/CTRL0_sigstats/CrestFactor","FRM_1/CTRL0_sigstats/ImpulseFactor","FRM_1/CTRL0_sigstats/Kurtosis","FRM_1/CTRL0_sigstats/Mean","FRM_1/CTRL0_sigstats/PeakValue","FRM_1/CTRL0_sigstats/RMS","FRM_1/CTRL0_sigstats/SINAD","FRM_1/CTRL0_sigstats/SNR","FRM_1/CTRL0_sigstats/ShapeFactor","FRM_1/CTRL0_sigstats/Skewness","FRM_1/CTRL0_sigstats/Std","FRM_1/CTRL0_sigstats/THD","FRM_1/CTRL1_sigstats/ClearanceFactor","FRM_1/CTRL1_sigstats/CrestFactor","FRM_1/CTRL1_sigstats/ImpulseFactor","FRM_1/CTRL1_sigstats/Kurtosis","FRM_1/CTRL1_sigstats/Mean","FRM_1/CTRL1_sigstats/PeakValue","FRM_1/CTRL1_sigstats/RMS","FRM_1/CTRL1_sigstats/SINAD","FRM_1/CTRL1_sigstats/SNR","FRM_1/CTRL1_sigstats/ShapeFactor","FRM_1/CTRL1_sigstats/Skewness","FRM_1/CTRL1_sigstats/Std","FRM_1/CTRL1_sigstats/THD","FRM_1/CTRL2_sigstats/ClearanceFactor","FRM_1/CTRL2_sigstats/CrestFactor","FRM_1/CTRL2_sigstats/ImpulseFactor","FRM_1/CTRL2_sigstats/Kurtosis","FRM_1/CTRL2_sigstats/Mean","FRM_1/CTRL2_sigstats/PeakValue","FRM_1/CTRL2_sigstats/RMS","FRM_1/CTRL2_sigstats/SINAD","FRM_1/CTRL2_sigstats/SNR","FRM_1/CTRL2_sigstats/ShapeFactor","FRM_1/CTRL2_sigstats/Skewness","FRM_1/CTRL2_sigstats/Std","FRM_1/CTRL2_sigstats/THD","FRM_1/CTRL3_sigstats/ClearanceFactor","FRM_1/CTRL3_sigstats/CrestFactor","FRM_1/CTRL3_sigstats/ImpulseFactor","FRM_1/CTRL3_sigstats/Kurtosis","FRM_1/CTRL3_sigstats/Mean","FRM_1/CTRL3_sigstats/PeakValue","FRM_1/CTRL3_sigstats/RMS","FRM_1/CTRL3_sigstats/SINAD","FRM_1/CTRL3_sigstats/SNR","FRM_1/CTRL3_sigstats/ShapeFactor","FRM_1/CTRL3_sigstats/Skewness","FRM_1/CTRL3_sigstats/Std","FRM_1/CTRL3_sigstats/THD","FRM_1/CTRL4_sigstats/ClearanceFactor","FRM_1/CTRL4_sigstats/CrestFactor","FRM_1/CTRL4_sigstats/ImpulseFactor","FRM_1/CTRL4_sigstats/Kurtosis","FRM_1/CTRL4_sigstats/Mean","FRM_1/CTRL4_sigstats/PeakValue","FRM_1/CTRL4_sigstats/RMS","FRM_1/CTRL4_sigstats/SINAD","FRM_1/CTRL4_sigstats/SNR","FRM_1/CTRL4_sigstats/ShapeFactor","FRM_1/CTRL4_sigstats/Skewness","FRM_1/CTRL4_sigstats/Std","FRM_1/CTRL4_sigstats/THD","FRM_1/CTRL5_sigstats/ClearanceFactor","FRM_1/CTRL5_sigstats/CrestFactor","FRM_1/CTRL5_sigstats/ImpulseFactor","FRM_1/CTRL5_sigstats/Kurtosis","FRM_1/CTRL5_sigstats/Mean","FRM_1/CTRL5_sigstats/PeakValue","FRM_1/CTRL5_sigstats/RMS","FRM_1/CTRL5_sigstats/SINAD","FRM_1/CTRL5_sigstats/SNR","FRM_1/CTRL5_sigstats/ShapeFactor","FRM_1/CTRL5_sigstats/Skewness","FRM_1/CTRL5_sigstats/Std","FRM_1/CTRL5_sigstats/THD","FRM_1/GyrX_ps_spec/PeakAmp1","FRM_1/GyrX_ps_spec/PeakAmp2","FRM_1/GyrX_ps_spec/PeakFreq1","FRM_1/GyrX_ps_spec/PeakFreq2","FRM_1/GyrX_ps_spec/BandPower","FRM_1/GyrY_ps_spec/PeakAmp1","FRM_1/GyrY_ps_spec/PeakAmp2","FRM_1/GyrY_ps_spec/PeakFreq1","FRM_1/GyrY_ps_spec/PeakFreq2","FRM_1/GyrY_ps_spec/BandPower","FRM_1/GyrZ_ps_spec/PeakAmp1","FRM_1/GyrZ_ps_spec/PeakAmp2","FRM_1/GyrZ_ps_spec/PeakFreq1","FRM_1/GyrZ_ps_spec/PeakFreq2","FRM_1/GyrZ_ps_spec/BandPower","FRM_1/AccX_ps_spec/PeakAmp1","FRM_1/AccX_ps_spec/PeakAmp2","FRM_1/AccX_ps_spec/PeakFreq1","FRM_1/AccX_ps_spec/PeakFreq2","FRM_1/AccX_ps_spec/BandPower","FRM_1/AccY_ps_spec/PeakAmp1","FRM_1/AccY_ps_spec/PeakAmp2","FRM_1/AccY_ps_spec/PeakFreq1","FRM_1/AccY_ps_spec/PeakFreq2","FRM_1/AccY_ps_spec/BandPower","FRM_1/AccZ_ps_spec/PeakAmp1","FRM_1/AccZ_ps_spec/PeakAmp2","FRM_1/AccZ_ps_spec/PeakFreq1","FRM_1/AccZ_ps_spec/PeakFreq2","FRM_1/AccZ_ps_spec/BandPower","FRM_1/VibeX_ps_spec/PeakAmp1","FRM_1/VibeX_ps_spec/PeakAmp2","FRM_1/VibeX_ps_spec/PeakFreq1","FRM_1/VibeX_ps_spec/PeakFreq2","FRM_1/VibeX_ps_spec/BandPower","FRM_1/VibeY_ps_spec/PeakAmp1","FRM_1/VibeY_ps_spec/PeakAmp2","FRM_1/VibeY_ps_spec/PeakFreq1","FRM_1/VibeY_ps_spec/PeakFreq2","FRM_1/VibeY_ps_spec/BandPower","FRM_1/VibeZ_ps_spec/PeakAmp1","FRM_1/VibeZ_ps_spec/PeakAmp2","FRM_1/VibeZ_ps_spec/PeakFreq1","FRM_1/VibeZ_ps_spec/PeakFreq2","FRM_1/VibeZ_ps_spec/BandPower","FRM_1/VelNorth_ps_spec/PeakAmp1","FRM_1/VelNorth_ps_spec/PeakAmp2","FRM_1/VelNorth_ps_spec/PeakFreq1","FRM_1/VelNorth_ps_spec/PeakFreq2","FRM_1/VelNorth_ps_spec/BandPower","FRM_1/VelEast_ps_spec/PeakAmp1","FRM_1/VelEast_ps_spec/PeakAmp2","FRM_1/VelEast_ps_spec/PeakFreq1","FRM_1/VelEast_ps_spec/PeakFreq2","FRM_1/VelEast_ps_spec/BandPower","FRM_1/VelDown_ps_spec/PeakAmp1","FRM_1/VelDown_ps_spec/PeakAmp2","FRM_1/VelDown_ps_spec/PeakFreq1","FRM_1/VelDown_ps_spec/PeakFreq2","FRM_1/VelDown_ps_spec/BandPower","FRM_1/DesRoll_ps_spec/PeakAmp1","FRM_1/DesRoll_ps_spec/PeakAmp2","FRM_1/DesRoll_ps_spec/PeakFreq1","FRM_1/DesRoll_ps_spec/PeakFreq2","FRM_1/DesRoll_ps_spec/BandPower","FRM_1/Roll_ps_spec/PeakAmp1","FRM_1/Roll_ps_spec/PeakAmp2","FRM_1/Roll_ps_spec/PeakFreq1","FRM_1/Roll_ps_spec/PeakFreq2","FRM_1/Roll_ps_spec/BandPower","FRM_1/DesPitch_ps_spec/PeakAmp1","FRM_1/DesPitch_ps_spec/PeakAmp2","FRM_1/DesPitch_ps_spec/PeakFreq1","FRM_1/DesPitch_ps_spec/PeakFreq2","FRM_1/DesPitch_ps_spec/BandPower","FRM_1/Pitch_ps_spec/PeakAmp1","FRM_1/Pitch_ps_spec/PeakAmp2","FRM_1/Pitch_ps_spec/PeakFreq1","FRM_1/Pitch_ps_spec/PeakFreq2","FRM_1/Pitch_ps_spec/BandPower","FRM_1/DesYaw_ps_spec/PeakAmp1","FRM_1/DesYaw_ps_spec/PeakAmp2","FRM_1/DesYaw_ps_spec/PeakFreq1","FRM_1/DesYaw_ps_spec/PeakFreq2","FRM_1/DesYaw_ps_spec/BandPower","FRM_1/Yaw_ps_spec/PeakAmp1","FRM_1/Yaw_ps_spec/PeakAmp2","FRM_1/Yaw_ps_spec/PeakFreq1","FRM_1/Yaw_ps_spec/PeakFreq2","FRM_1/Yaw_ps_spec/BandPower","FRM_1/RPM0_ps_spec/PeakAmp1","FRM_1/RPM0_ps_spec/PeakAmp2","FRM_1/RPM0_ps_spec/PeakFreq1","FRM_1/RPM0_ps_spec/PeakFreq2","FRM_1/RPM0_ps_spec/BandPower","FRM_1/Curr0_ps_spec/PeakAmp1","FRM_1/Curr0_ps_spec/PeakAmp2","FRM_1/Curr0_ps_spec/PeakFreq1","FRM_1/Curr0_ps_spec/PeakFreq2","FRM_1/Curr0_ps_spec/BandPower","FRM_1/RPM1_ps_spec/PeakAmp1","FRM_1/RPM1_ps_spec/PeakAmp2","FRM_1/RPM1_ps_spec/PeakFreq1","FRM_1/RPM1_ps_spec/PeakFreq2","FRM_1/RPM1_ps_spec/BandPower","FRM_1/Curr1_ps_spec/PeakAmp1","FRM_1/Curr1_ps_spec/PeakAmp2","FRM_1/Curr1_ps_spec/PeakFreq1","FRM_1/Curr1_ps_spec/PeakFreq2","FRM_1/Curr1_ps_spec/BandPower","FRM_1/RPM2_ps_spec/PeakAmp1","FRM_1/RPM2_ps_spec/PeakAmp2","FRM_1/RPM2_ps_spec/PeakFreq1","FRM_1/RPM2_ps_spec/PeakFreq2","FRM_1/RPM2_ps_spec/BandPower","FRM_1/Curr2_ps_spec/PeakAmp1","FRM_1/Curr2_ps_spec/PeakAmp2","FRM_1/Curr2_ps_spec/PeakFreq1","FRM_1/Curr2_ps_spec/PeakFreq2","FRM_1/Curr2_ps_spec/BandPower","FRM_1/RPM3_ps_spec/PeakAmp1","FRM_1/RPM3_ps_spec/PeakAmp2","FRM_1/RPM3_ps_spec/PeakFreq1","FRM_1/RPM3_ps_spec/PeakFreq2","FRM_1/RPM3_ps_spec/BandPower","FRM_1/Curr3_ps_spec/PeakAmp1","FRM_1/Curr3_ps_spec/PeakAmp2","FRM_1/Curr3_ps_spec/PeakFreq1","FRM_1/Curr3_ps_spec/PeakFreq2","FRM_1/Curr3_ps_spec/BandPower","FRM_1/RPM4_ps_spec/PeakAmp1","FRM_1/RPM4_ps_spec/PeakAmp2","FRM_1/RPM4_ps_spec/PeakFreq1","FRM_1/RPM4_ps_spec/PeakFreq2","FRM_1/RPM4_ps_spec/BandPower","FRM_1/Curr4_ps_spec/PeakAmp1","FRM_1/Curr4_ps_spec/PeakAmp2","FRM_1/Curr4_ps_spec/PeakFreq1","FRM_1/Curr4_ps_spec/PeakFreq2","FRM_1/Curr4_ps_spec/BandPower","FRM_1/RPM5_ps_spec/PeakAmp1","FRM_1/RPM5_ps_spec/PeakAmp2","FRM_1/RPM5_ps_spec/PeakFreq1","FRM_1/RPM5_ps_spec/PeakFreq2","FRM_1/RPM5_ps_spec/BandPower","FRM_1/Curr5_ps_spec/PeakAmp1","FRM_1/Curr5_ps_spec/PeakAmp2","FRM_1/Curr5_ps_spec/PeakFreq1","FRM_1/Curr5_ps_spec/PeakFreq2","FRM_1/Curr5_ps_spec/BandPower","FRM_1/CTRL0_ps_spec/PeakAmp1","FRM_1/CTRL0_ps_spec/PeakAmp2","FRM_1/CTRL0_ps_spec/PeakFreq1","FRM_1/CTRL0_ps_spec/PeakFreq2","FRM_1/CTRL0_ps_spec/BandPower","FRM_1/CTRL1_ps_spec/PeakAmp1","FRM_1/CTRL1_ps_spec/PeakAmp2","FRM_1/CTRL1_ps_spec/PeakFreq1","FRM_1/CTRL1_ps_spec/PeakFreq2","FRM_1/CTRL1_ps_spec/BandPower","FRM_1/CTRL2_ps_spec/PeakAmp1","FRM_1/CTRL2_ps_spec/PeakAmp2","FRM_1/CTRL2_ps_spec/PeakFreq1","FRM_1/CTRL2_ps_spec/PeakFreq2","FRM_1/CTRL2_ps_spec/BandPower","FRM_1/CTRL3_ps_spec/PeakAmp1","FRM_1/CTRL3_ps_spec/PeakAmp2","FRM_1/CTRL3_ps_spec/PeakFreq1","FRM_1/CTRL3_ps_spec/PeakFreq2","FRM_1/CTRL3_ps_spec/BandPower","FRM_1/CTRL4_ps_spec/PeakAmp1","FRM_1/CTRL4_ps_spec/PeakAmp2","FRM_1/CTRL4_ps_spec/PeakFreq1","FRM_1/CTRL4_ps_spec/PeakFreq2","FRM_1/CTRL4_ps_spec/BandPower","FRM_1/CTRL5_ps_spec/PeakAmp1","FRM_1/CTRL5_ps_spec/PeakAmp2","FRM_1/CTRL5_ps_spec/PeakFreq1","FRM_1/CTRL5_ps_spec/PeakFreq2","FRM_1/CTRL5_ps_spec/BandPower"];
featureTable = readFeatureTable(outputEnsemble,"FRM_1",'Features',selectedFeatureNames,'ConditionVariables',outputEnsemble.ConditionVariables,'IncludeMemberID',true);

% Set SelectedVariables to select variables to read from the ensemble.
outputEnsemble.SelectedVariables = unique([outputEnsemble.DataVariables;outputEnsemble.ConditionVariables;outputEnsemble.IndependentVariables],'stable');

% Gather results into a table.
if nargout > 1
    outputTable = readall(outputEnsemble);
end
end
