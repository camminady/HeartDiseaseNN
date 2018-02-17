function trainHeartDisease
clc
clearvars
close all

trainpercentage = 0.7;
[inputtrain, targettrain, inputtest, targettest] = splitDataset(trainpercentage);

layers = [13,1];
net = fitnet(layers);
%     net.layers{1}.transferFcn = 'tansig';
[net, ~] = train(net, inputtrain, targettrain);

% predictiontrain = net(inputtrain);
% errtrain = norm(predictiontrain-targettrain)/norm(targettrain)

predictiontest = net(inputtest);
predictiontrain = net(inputtrain);

% let us say our net is certain someone has the disease if the certainty is
% above certain treshold
% and let us  take a low treshold (bc we rather want a false positive.
treshold = 0.5;
predictiontestbinary = predictiontest>treshold;
predictiontrainbinary = predictiontrain>treshold;


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
fprintf('Test\n');
print4FelderTafel(targettest,predictiontestbinary)
fprintf('Train\n');
print4FelderTafel(targettrain,predictiontrainbinary)





end


function print4FelderTafel(target,perdiction)
% 4 felder tafel wohooo
a = sum(target & perdiction);
b = sum(not(target) & perdiction);
c = sum(target & not(perdiction));
d = sum(not(target) & not(perdiction));
n = length(target);
s = sum(target)/n;
h = 1-s;
fprintf('prediction of net:\n');
fprintf(' N=%i\t\t\thas disease\thas no disease\nclassified disease\t%f\t%f\nclassified healthy\t%f\t%f\n\n',n,a,b,c,d)
fprintf('if guessing:\n');
fprintf(' N=%i\t\t\thas disease\thas no disease\nclassified disease\t%f\t%f\nclassified healthy\t%f\t%f\n\n',n,s*s*n,s*h*n,h*s*n,h*h*n)
fprintf('\n##########################################################\n');




end




