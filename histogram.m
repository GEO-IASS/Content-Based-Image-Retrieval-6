% histogram.m
%
% Function used to apply haar wavelet transform on the image, get the
% approximate, vertical and horizontal coefficient, and return the
% histogram for all the three coefficients
function [ colorHistogramForApproximate, colorHistogramForHorizontal, colorHistogramForVertical ] = histogram( im )
%
% im - Image for which histograms need to be computed
%
% colorHistogramForApproximate - Histogram for Approximate Coefficient
% colorHistogramForHorizontal - Histogram for Horizontal Coefficient
% colorHistogramForVertical - Histogram for Vertical Coefficient
% 
% 
% Authors - Abhilash & Shreyas



% Extracting the red component
ir = im(:,:,1);

% Extracting the green component
ig = im(:,:,2);

% Extracting the blue component
ib = im(:,:,3);

% Applying the haar 2d wavelet tranform on the red component by calling the
% haar2d function
haarRed = haar2d(ir);

% Applying the haar 2d wavelet tranform on the green component by calling the
% haar2d function
haarGreen = haar2d(ig);

% Applying the haar 2d wavelet tranform on the blue component by calling the
% haar2d function
haarBlue = haar2d(ib);

% Getting the size of the resulting image by applying haard 2d wavelet
% transformation on the image
[r c] = size(haarRed);

% Extracting the approximate coefficient of the red component
rA = haarRed(1:floor(r/2), 1:floor(c/2));

% Extracting the horizontal coefficient of the red component
rH = haarRed(1:floor(r/2), floor(c/2)+1:c);

% Extracting the vertical coefficient of the red component
rV = haarRed(floor(r/2)+1:r, 1:floor(c/2));

% Extracting the approximate coefficient of the green component
gA = haarGreen(1:floor(r/2), 1:floor(c/2));

% Extracting the horizontal coefficient of the green component
gH = haarGreen(1:floor(r/2), floor(c/2)+1:c);

% Extracting the vertical coefficient of the green component
gV = haarGreen(floor(r/2)+1:r, 1:floor(c/2));

% Extracting the approximate coefficient of the blue component
bA = haarBlue(1:floor(r/2), 1:floor(c/2));

% Extracting the horizontal coefficient of the blue component
bH = haarBlue(1:floor(r/2), floor(c/2)+1:c);

% Extracting the blue coefficient of the blue component
bV = haarBlue(floor(r/2)+1:r, 1:floor(c/2));


% Combining red, green, blue component
% of the approximation coefficient
A(:,:,1)=rA;
A(:,:,2)=gA;
A(:,:,3)=bA;

% Combining red, green, blue component
% of th vertical coefficient
V(:,:,1) = rV;
V(:,:,2) = gV;
V(:,:,3) = bV;

% Combining red, green, blue component
% of th horizontal coefficient
H(:,:,1) = rH;
H(:,:,2) = gH;
H(:,:,3) = bH;

% Assiging weights to each coefficient
WA = A * 0.004;
WH = H * 0.003;
WV = V * 0.003;

% Converting each coefficient color model 
% to HSV plane
Ahsv = rgb2hsv(WA);
Hhsv = rgb2hsv(WH);
Vhsv = rgb2hsv(WV);

% Retrieving hue, saturation and calue component separately from the
% approximate coefficient matrix
hApproximate = Ahsv(:,:,1);
sApproximate = Ahsv(:,:,2);
vApproximate = Ahsv(:,:,3);

% Getting the size of the approximate coefficient's HSV Image
[rows, cols] = size(Ahsv);

% Getting the maximum value from hue, saturation and value component matrix
% separately from the approximate coefficient matrix
maxHue = max(hApproximate(:));
maxSat = max(sApproximate(:));
maxVal = max(vApproximate(:));

% Initializing the color histogram 3d matrix with zeros
colorHistogramForApproximate = zeros(8, 8, 8);

% Matrix that maintains seperate column vectors for hue, saturation and
% value which will be later used to fill the color histogram matrix
placeHolder = zeros(rows*cols, 3);

% To iterate through the placeHolder matrix
placeHolderIndex = 1;

% To store the size of the matrix used to iterate through the rows
sizeOfApproximateForRow = size(hApproximate,1);

% To store the size of the matrix used to iterate through the columns
sizeOfApproximateForCol = size(hApproximate,2);

% Iterating through the matrix and filling the place Holder matrix by
% quantizing the pixels such that they are in the range from 0-8
for row = 1:sizeOfApproximateForRow
    for col = 1 : sizeOfApproximateForCol        
        
        % Quantizing the hue approximate matrix pixels to be in the range from 0-8
        placeHolder(placeHolderIndex, 1) = ceil(8 * hApproximate(row, col)/maxHue);
        
        % Quantizing the sat approximate matrix pixels to be in the range from 0-8
        placeHolder(placeHolderIndex, 2) = ceil(8 * sApproximate(row, col)/maxSat);
        
        % Quantizing the val approximate matrix pixels to be in the range from 0-8
        placeHolder(placeHolderIndex, 3) = ceil(8 * vApproximate(row, col)/maxVal);
        placeHolderIndex = placeHolderIndex+1;
    end
end

% Filling the final histogram 3d matrix by iterating through the rows of
% the placeholder matrix such that if any row has all 0s in it, we ignore
% else we use the values in it as an index of the 3d matrix and finally
% increment the value at that index by 1
for row = 1:size(placeHolder, 1)
    
    if (placeHolder(row, 1) == 0 || placeHolder(row, 2) == 0 || placeHolder(row, 3) == 0)
        continue;
    end
    
    % Temporary variable to store the value at that position
    temp =  colorHistogramForApproximate(placeHolder(row, 1), placeHolder(row, 2), placeHolder(row, 3));
    temp = temp + 1;
    
    % Finally updating the incremented value at that position of the
    % histogram matrix
    colorHistogramForApproximate(placeHolder(row, 1), placeHolder(row, 2), placeHolder(row, 3)) = temp;
end

colorHistogramForApproximate = colorHistogramForApproximate(:)';
colorHistogramForApproximate = colorHistogramForApproximate/sum(colorHistogramForApproximate);


% Retrieving hue, saturation and calue component separately from the
% horizontal coefficient matrix
hHorizontal = Hhsv(:,:,1);
sHorizontal = Hhsv(:,:,2);
vHorizontal = Hhsv(:,:,3);

% Getting the size of the horizontal coefficient's HSV Image
[rows, cols] = size(Hhsv);

% Getting the maximum value from hue, saturation and value component matrix
% separately from the approximate coefficient matrix
maxHue = max(hHorizontal(:));
maxSat = max(sHorizontal(:));
maxVal = max(vHorizontal(:));

% Initializing the color histogram 3d matrix with zeros
colorHistogramForHorizontal = zeros(8, 8, 8);

% Matrix that maintains seperate column vectors for hue, saturation and
% value which will be later used to fill the color histogram matrix
placeHolder = zeros(rows*cols, 3);

% To iterate through the placeHolder matrix
placeHolderIndex = 1;

% To store the size of the matrix used to iterate through the rows
sizeOfHorizontalForRow = size(hHorizontal,1);

% To store the size of the matrix used to iterate through the columns
sizeOfHorizontalForCol = size(hHorizontal,2);

% Iterating through the matrix and filling the place Holder matrix by
% quantizing the pixels such that they are in the range from 0-8
for row = 1:sizeOfHorizontalForRow
    for col = 1 : sizeOfHorizontalForCol
        
        % Quantizing the hue horizontal matrix pixels to be in the range from 0-8
        placeHolder(placeHolderIndex, 1) = ceil(8 * hHorizontal(row, col)/maxHue);
        
        % Quantizing the sat horizontal matrix pixels to be in the range from 0-8
        placeHolder(placeHolderIndex, 2) = ceil(8 * sHorizontal(row, col)/maxSat);
        
        % Quantizing the value horizontal matrix pixels to be in the range from 0-8
        placeHolder(placeHolderIndex, 3) = ceil(8 * vHorizontal(row, col)/maxVal);
        placeHolderIndex = placeHolderIndex+1;
    end
end

% Filling the final histogram 3d matrix by iterating through the rows of
% the placeholder matrix such that if any row has all 0s in it, we ignore
% else we use the values in it as an index of the 3d matrix and finally
% increment the value at that index by 1
for row = 1:size(placeHolder, 1)
    if (placeHolder(row, 1) == 0 || placeHolder(row, 2) == 0 || placeHolder(row, 3) == 0)
        continue;
    end
    
     % Temporary variable to store the value at that position
    temp =  colorHistogramForHorizontal(placeHolder(row, 1), placeHolder(row, 2), placeHolder(row, 3));
    temp = temp + 1;
    
    
    % Finally updating the incremented value at that position of the
    % histogram matrix
    colorHistogramForHorizontal(placeHolder(row, 1), placeHolder(row, 2), placeHolder(row, 3)) = temp;
end

colorHistogramForHorizontal = colorHistogramForHorizontal(:)';
colorHistogramForHorizontal = colorHistogramForHorizontal/sum(colorHistogramForHorizontal);


% Retrieving hue, saturation and calue component separately from the
% vertical coefficient matrix
hVertical = Vhsv(:,:,1);
sVertical = Vhsv(:,:,2);
vVertical = Vhsv(:,:,3);

% Getting the size of the vertical coefficient's HSV Image
[rows, cols] = size(Vhsv);

% Getting the maximum value from hue, saturation and value component matrix
% separately from the approximate coefficient matrix
maxHue = max(hVertical(:));
maxSat = max(sVertical(:));
maxVal = max(vVertical(:));

% Initializing the color histogram 3d matrix with zeros
colorHistogramForVertical = zeros(8, 8, 8);

% Matrix that maintains seperate column vectors for hue, saturation and
% value which will be later used to fill the color histogram matrix
placeHolder = zeros(rows*cols, 3);

% To iterate through the placeHolder matrix
placeHolderIndex = 1;

% To store the size of the matrix used to iterate through the rows
sizeOfVerticalForRow = size(hVertical,1);

% To store the size of the matrix used to iterate through the columns
sizeOfVerticalForCol = size(hVertical,2);

% Iterating through the matrix and filling the place Holder matrix by
% quantizing the pixels such that they are in the range from 0-8
for row = 1:sizeOfVerticalForRow
    for col = 1 : sizeOfVerticalForCol
        
        % Quantizing the hue vertical matrix pixels to be in the range from 0-8
        placeHolder(placeHolderIndex, 1) = ceil(8 * hVertical(row, col)/maxHue);
        
        % Quantizing the sat vertical matrix pixels to be in the range from 0-8
        placeHolder(placeHolderIndex, 2) = ceil(8 * sVertical(row, col)/maxSat);
        
        % Quantizing the value vertical matrix pixels to be in the range from 0-8
        placeHolder(placeHolderIndex, 3) = ceil(8 * vVertical(row, col)/maxVal);
        placeHolderIndex = placeHolderIndex+1;
    end
end

% Filling the final histogram 3d matrix by iterating through the rows of
% the placeholder matrix such that if any row has all 0s in it, we ignore
% else we use the values in it as an index of the 3d matrix and finally
% increment the value at that index by 1
for row = 1:size(placeHolder, 1)
    if (placeHolder(row, 1) == 0 || placeHolder(row, 2) == 0 || placeHolder(row, 3) == 0)
        continue;
    end
    
     % Temporary variable to store the value at that position
    temp =  colorHistogramForVertical(placeHolder(row, 1), placeHolder(row, 2), placeHolder(row, 3));
    temp = temp + 1;
    
    
    % Finally updating the incremented value at that position of the
    % histogram matrix
    colorHistogramForVertical(placeHolder(row, 1), placeHolder(row, 2), placeHolder(row, 3)) = temp;
end

colorHistogramForVertical = colorHistogramForVertical(:)';
colorHistogramForVertical = colorHistogramForVertical/sum(colorHistogramForVertical);



end


