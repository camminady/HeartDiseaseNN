function [train, targettrain, test, targettest] = splitDataset(trainpercentage)


load cleveland.mat


% the commented part can be skipped as it is already worked into the data
% set
%
% See the original paper:
% Only 14 attributes used:
% 1. #3 (age)
% 2. #4 (sex)
% 3. #9 (cp)
% 4. #10 (trestbps)
% 5. #12 (chol)
% 6. #16 (fbs)
% 7. #19 (restecg)
% 8. #32 (thalach)
% 9. #38 (exang)
% 10. #40 (oldpeak)
% 11. #41 (slope)
% 12. #44 (ca)
% 13. #51 (thal)
% 14. #58 (num) (the predicted attribute)
% attributes = [3 4 9 10 12 16 19 32 38 40 41 44 51 58];
%  cleveland = cleveland(:,attributes); % filter attributes

cleveland = cleveland(randperm(size(cleveland, 1)), :); % shuffle rows


ntrain = floor(length(cleveland)*trainpercentage);

% note: we transpose everything because the NN wants it that way...
train = cleveland(1:ntrain, 1:end-1)';
targettrain = cleveland(1:ntrain, end)';

test = cleveland(ntrain+1:end, 1:end-1)';
targettest = cleveland(ntrain+1:end, end)';


% target is now 0 for no disease and 1-4 for the type of disease
% we only want to distinguish disease from no disease
targettrain = double(targettrain > 0);
targettest = double(targettest > 0);


end
