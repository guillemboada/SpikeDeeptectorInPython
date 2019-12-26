% This script gets the activations of a specified layer given the trained
% model and an input batch from the evaluation data MAT file.

clear;clc;
%-------------------------GetActivations-----------------------------------

% Load trained model
load trainedModelDeepNetCNN.mat % load trained model of DeepSpikeCNN
% Get a batch from the evaluation data
load data_evaluation.mat
ch = 60; % select a channel
featureMap = BatchesAndPredictions(ch).Ch.BatchesCh(:,:,:,1);

% Get the activations a the specified layer
layer = 'conv_1';
a = activations(trainedNet, featureMap, layer);
a_filter1 = a(:,:,1);
