% haar1d.m
%
% Function that returns the resultant vector obtained by
% applying Haar 1d wavelet transform method
function [ outputVector ] = haar1d( inputVector,len)
%
% inputVector - Vector for which haar 1d wavelet transform has to be
%               applied
% len - length of the vector
%
% outputVector - the vector obtained after applying haar 1d wavelet
%                transform
%
% Authors - Abhilash & Shreyas


% Temporary vector maintained to store the intermediate results
temp = zeros(1,len);

% Output vector after applying 1d haar wavelet
outputVector = zeros(size(inputVector));

    % Applying mean on pairs of values to get the first half of the
    % resultant vector and difference of pairs divided by square root of 2
    % to get the second half of the resultant matrix
    widthLimit = floor(len/2);
    for k = 0:widthLimit-1
        
        % Filling first half of the resulting vector
        temp(k+1) = (inputVector(2*k+1) + inputVector(2*k+2))/sqrt(2.0);
        
        % Filling second half of the resulting vector
        temp(k+widthLimit+1) = (inputVector(2*k+1) - inputVector(2*k+2))/sqrt(2.0);
        
    end
    
    % Filling the final resutant vector using the temporary vector
    for l=1:len
       
        outputVector(l) = temp(l);
        
    end

end

