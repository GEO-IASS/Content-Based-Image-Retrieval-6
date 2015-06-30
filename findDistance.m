% findDistance.m
% 
% Function that finds the distance between two histograms provided by the
% input using Histogram Intersection method proposed by Smith and Chang
function distance = findDistance( queryHistogram,directoryHistogram )
%
% queryHistogram - Histogram of the query image
% direcoryHistogram - Histogram of the image picked from the directory
%
% distance - Distance obtained by applying histogram intersection
%            distance method on the two histograms
%
%
% Authors - Abhilash & Shreyas


% Initializing minimum
minimumsum=0;

% Calculating minimum sum by iterating through the two hsitograms
for a = 1:length(queryHistogram)
    minimumsum = minimumsum + min(queryHistogram(a),directoryHistogram(a));
end

% Finding the sum of bins of the first histogram
sum_hist1 = sum(queryHistogram);

% Finding the sum of bins of the first histogram
sum_hist2 = sum(directoryHistogram);

% Finally substituting all the values calculated above in the histogram intersection
% distance equation
distance = minimumsum/min(sum_hist1,sum_hist2);

end

