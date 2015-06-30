% CBIR.m 
%
% Function that takes an image as input and retrieves 
% all the images from the current directory which are similar to the
% current image
function CBIR( queryImage )
% queryImage - Query image file name given as input for which similar
%              images in the current directory has to be listed
%
% Authors - Abhilash & Shreyas

% Reading the query image
img = imread(queryImage);

% Getting the histogram for approximate, horizontal and vertical
% coefficients obtained after applying haar wavelet transform on the query
% image
[histApproximateForQueryImage,histHorizontalForQueryImage,histVerticalForQueryImage]=histogram(img);

% Getting all the jpg and png file names from the current directory
fileNames = dir('*.*g');

% Getting the number of image files
numberOfFiles = length(fileNames);

% Displaying the query image in the first cell of a 5 x 5 window 
figure,subplot(5,5,1),imshow(queryImage),title('Query Image');

% Initializing j which is used print the resulting similar images from the
% first cell of second row of the 5 x 5 resulting window
j = 6;

% Iterating through the image files in the directory
for i = 1:numberOfFiles
    
    % Getting each image file name
    fileName = fileNames(i).name;
    
    % Exception handling if the resulting window consists images more than
    % its capacity
    try
        
    % If the current image name from the directory is not same as the query
    % image
    if ~strcmp(fileName,queryImage)
       
        % Reading the image file from the directory
        directoryImage = imread(fileNames(i).name);
        
        % Getting the histogram for approximate, horizontal and vertical
        % coefficients obtained after applying haar wavelet transform on
        % the directory image
        [histApproximateForDirectoryImage,histHorizontalForDirectoryImage,histVerticalForDirectoryImage] = histogram(directoryImage);
        
        % Distance calcuated for the approximate coefficients obtained for
        % the query image and the current directory image using Histogram
        % Intersection Distance method
        approximateDistance = findDistance(histApproximateForQueryImage,histApproximateForDirectoryImage);
        
        
        % Distance calcuated for the horizontal coefficients obtained for
        % the query image and the current directory image using Histogram
        % Intersection Distance method
        horizontalDistance = findDistance(histHorizontalForQueryImage,histHorizontalForDirectoryImage);
        
        
        % Distance calcuated for the vertical coefficients obtained for
        % the query image and the current directory image using Histogram
        % Intersection Distance method
        verticalDistance3 = findDistance(histVerticalForQueryImage,histVerticalForDirectoryImage);
       
        % Mentioning the range of distances to decide if the two images are
        % similar
        if approximateDistance > 0.27  
            if horizontalDistance > 0.675 
                if verticalDistance3 > 0.675
                    
                    % Displaying the current directory image in the 5 x 5
                    % window
                    subplot(5,5,j), imshow(directoryImage),title('Result');
                    j = j + 1;
                end
            end
        end
            
    end
    
    % Control comes to catch block if there is an exception. If the current
    % result displaying window is exceeded with the already read images,
    % then exception is raised. So we just stop the execution displaying
    % enough similar images in the current window.
    catch E
        
    end
    
end

end



