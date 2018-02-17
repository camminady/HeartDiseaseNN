function trainHeartDisease
clc
clearvars
close all

trainpercentage = 0.8;
[inputtrain, targettrain, inputtest, targettest] = splitDataset(trainpercentage);


layers = [13,1];
net = fitnet(layers);
%     net.layers{1}.transferFcn = 'tansig';
[net, ~] = train(net, inputtrain, targettrain);

% predictiontrain = net(inputtrain);
% errtrain = norm(predictiontrain-targettrain)/norm(targettrain)

predictiontest = net(inputtest);

% let us say our net is certain someone has the disease if the certainty is
% above certain treshold
% and let us  take a low treshold (bc we rather want a false positive.
treshold = 0.4;
predictiontestbinary = predictiontest>treshold;


figure;markersize = 10;
plot(targettest,'go','MarkerSize',markersize);
hold on
plot(predictiontest,'ro','MarkerSize',markersize);
plot(predictiontestbinary,'rx','MarkerSize',markersize);
legend('correct label','prediction','binary prediction');
title('heart disease in patients');
xlabel('patient id');
ylabel('has disease, yes/no');


% 4 felder tafel wohooo
a = sum(targettest & predictiontestbinary);
b = sum(not(targettest) & predictiontestbinary);
c = sum(targettest & not(predictiontestbinary));
d = sum(not(targettest) & not(predictiontestbinary));

fprintf('\t\t\thas disease\thas no disease\nclassified disease\t%f\t%f\nclassified healthy\t%f\t%f\n',a,b,c,d)

