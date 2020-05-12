% % Author: Gustav Kjellberg
% Brief summary of this function.
% This function takes the input from GetMusicFeatures and post processes the data so that it may better work with our HMM.
% Detailed explanation of this function.
% Input:
% Array-like (3xT) shape, i.e the data yielded from GetMusicFeatures.
% Returns:
% Array-like (1xT) shape, i.e the features.
function features = Postprocess(musicFeatures)
%----------########## For documenation of this file, I refer to the
%interactive file postProcess.mlx
%   Detailed explanation goes here

frequency = log(musicFeatures(1,:));
relation = musicFeatures(2,:);
intensity = log(musicFeatures(3,:));

frequencyMean = mean(frequency);
frequencyStd = std(frequency);

frequencyUpperBound = frequencyMean+frequencyStd;
frequencyLowerBound = frequencyMean-frequencyStd;
frequencyNormalDist = makedist('Normal', "mu",frequencyMean, "sigma",frequencyStd);
frequencyTargetDist = fitdist(transpose(frequency), "Normal");

relationMean = mean(relation);
relationStd = std(relation);

relationUpperBound = relationMean+relationStd;
relationLowerBound = relationMean-relationStd;
relationNormalDist = makedist('Normal', "mu",relationMean, "sigma",relationStd);
relationTargetDist = fitdist(transpose(relation), 'Normal');


intensityMean = mean(intensity);
intensityStd = std(intensity);

intensityUpperBound = intensityMean+intensityStd;
intensityLowerBound = intensityMean-intensityStd;
intensityNormalDist = makedist('Normal', "mu",intensityMean, "sigma",intensityStd);
intensityTargetDist = fitdist(transpose(intensity), 'Normal');



noiseOrQuite = (frequency<frequencyLowerBound)|(frequency>frequencyUpperBound)|(relation < relationMean)|(intensity<intensityLowerBound);

nonNoiseIndecies = find(frequency == 0);




f_0 = min(frequency(find(noiseOrQuite == 0)));


features = 12*log2(frequency/f_0);



features(find(noiseOrQuite==1)) = 0;

features = nonzeros(features);
features = round(features);




end

