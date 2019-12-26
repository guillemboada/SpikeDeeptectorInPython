% This script gets and saves the required data to evaluate the model in the
% Python implementation. Given a recording in a NEV file and the model, it
% gets the input batches and output predictions in a MAT file.

clear;clc;
%-------------------------GetEvaluationData--------------------------------
nameNEV = 'Recording2.nev';

% Load trained model and NEV file
load trainedModelDeepNetCNN.mat 
dataNEV = openNEV(nameNEV);
% Select number of waveforms in each feature map
batchSize = 20;

% Initialize structure to save evaluation data (batches and predictions)
BatchesAndPredictions(96) = struct('Ch', struct());

for i=1:96 %Utah array contains 96 channels
    
    % Initialize a substructure for channel i
    electrodeId=i;  
    BatchesAndPredictions(electrodeId).Ch = struct('BatchesCh', struct(), 'yPredCh', struct());
    
    % Get waveforms from channel i
    electrodeStamps=dataNEV.Data.Spikes.Electrode;
    dataElectrodeStamps=dataNEV.Data.Spikes.Waveform;
    extractElectrodIdStamps=find(dataNEV.Data.Spikes.Electrode==electrodeId);
    dataElectrodeidStamp=double(dataNEV.Data.Spikes.Waveform(:,extractElectrodIdStamps));
    % Arrange the waveforms in feature maps
    numberWaveformsAtElectrode=numel(extractElectrodIdStamps);
    numberFeatureVectorsAtElectrode=floor(numberWaveformsAtElectrode/batchSize);
    startingIndex=1;
    for i=1:numberFeatureVectorsAtElectrode
        featuresVectorExtracted_i=dataElectrodeidStamp(:,startingIndex:i*batchSize);
        featuresVectorExtracted_i=featuresVectorExtracted_i';
        compFeaturesVectorsCNNs(:,:,1,i)=featuresVectorExtracted_i;
        %featuresVectorsConstructed{i}=dataElectrodeidStamp(:,startingIndex:i*batchSize);
        startingIndex=startingIndex+batchSize;
    end
    % Save batches in the substructure of channel i
    BatchesAndPredictions(electrodeId).Ch.BatchesCh = compFeaturesVectorsCNNs;

    % Get predictions for the feature maps from channel i 
    if numberFeatureVectorsAtElectrode >=1
        yPredicted = classify(trainedNet,compFeaturesVectorsCNNs); % predicted output
        yPredChannels=double(yPredicted);
    else
        yPredChannels=0;
    end

    % Save predictions in the substructure of channel i
    BatchesAndPredictions(electrodeId).Ch.yPredCh = yPredChannels;
    
end

% Clear residual variables from workspace
clearvars -except BatchesAndPredictions
% Save workspace variable as a MAT file
save('data_evaluation.mat')
