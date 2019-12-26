% This script gets and saves the required learnt parameters to build the
% Python model in a MAT file.

clear;clc;
%-------------------------GetParameters------------------------------------

% Load trained model
load trainedModelDeepNetCNN.mat 
% ImageInputLayer. Mean for "zero-center" normalization
input_mean = trainedNet.Layers(1, 1).Mean;
% Convolution2DLayer
conv1_weights = trainedNet.Layers(2, 1).Weights;
conv1_bias = trainedNet.Layers(2, 1).Bias;
conv2_weights = trainedNet.Layers(6, 1).Weights;
conv2_bias = trainedNet.Layers(6, 1).Bias;
conv3_weights = trainedNet.Layers(10, 1).Weights;
conv3_bias = trainedNet.Layers(10, 1).Bias;
conv4_weights = trainedNet.Layers(15, 1).Weights;
conv4_bias = trainedNet.Layers(15, 1).Bias;
conv5_weights = trainedNet.Layers(19, 1).Weights;
conv5_bias = trainedNet.Layers(19, 1).Bias;
conv6_weights = trainedNet.Layers(24, 1).Weights;
conv6_bias = trainedNet.Layers(24, 1).Bias;
% BatchNormalizationLayers
norm1_runningMean = trainedNet.Layers(3, 1).TrainedMean;
norm1_runningVariance = trainedNet.Layers(3, 1).TrainedVariance;
norm1_beta = trainedNet.Layers(3, 1).Offset;
norm1_gamma = trainedNet.Layers(3, 1).Scale;
norm2_runningMean = trainedNet.Layers(7, 1).TrainedMean;
norm2_runningVariance = trainedNet.Layers(7, 1).TrainedVariance;
norm2_beta = trainedNet.Layers(7, 1).Offset;
norm2_gamma = trainedNet.Layers(7, 1).Scale;
norm3_runningMean = trainedNet.Layers(11, 1).TrainedMean;
norm3_runningVariance = trainedNet.Layers(11, 1).TrainedVariance;
norm3_beta = trainedNet.Layers(11, 1).Offset;
norm3_gamma = trainedNet.Layers(11, 1).Scale;
norm4_runningMean = trainedNet.Layers(16, 1).TrainedMean;
norm4_runningVariance = trainedNet.Layers(16, 1).TrainedVariance;
norm4_beta = trainedNet.Layers(16, 1).Offset;
norm4_gamma = trainedNet.Layers(16, 1).Scale;
norm5_runningMean = trainedNet.Layers(20, 1).TrainedMean;
norm5_runningVariance = trainedNet.Layers(20, 1).TrainedVariance;
norm5_beta = trainedNet.Layers(20, 1).Offset;
norm5_gamma = trainedNet.Layers(20, 1).Scale;
norm6_runningMean = trainedNet.Layers(25, 1).TrainedMean;
norm6_runningVariance = trainedNet.Layers(25, 1).TrainedVariance;
norm6_beta = trainedNet.Layers(25, 1).Offset;
norm6_gamma = trainedNet.Layers(25, 1).Scale;
% FullyConnectedLayers
fc1_weights = trainedNet.Layers(29, 1).Weights;
fc1_bias = trainedNet.Layers(29, 1).Bias;
fc2_weights = trainedNet.Layers(31, 1).Weights;
fc2_bias = trainedNet.Layers(31, 1).Bias;

% Clear trainedNet from workspace
clear trainedNet
% Save workspace variables as a MAT file
save('parameters.mat')
