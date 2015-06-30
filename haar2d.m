% haar2d.m
% 
% Function that takes the 2d image matrix as input and applies 
% single level haar wavelet transform on the matrix and returns the 
% resultant matrix
function [ out_mat ] = haar2d( mat )
%
% 
% mat - Input matrix for which haar wavelet transform has to be applied
%
% out_mat - Output matrix ibtained after applying haar wavelet transform
%
% Authors - Abhilash & Shreyas


% Converting the types of values to doublle
mat = double(mat);

% Getting the size of the input matrix
[rows, columns] = size(mat);

% Creating a temporary vector to store the each column of the matrix
cur_row = zeros(1,columns);

% Creating a temporary vector to store the each row of the matrix
cur_col = zeros(1,rows);

% Output matrix
out_mat = zeros(rows,columns);

% Sending each row to haar1d function to apply the haar wavelet transform
% method    
for i = 1:rows
           
    for j = 1:columns
               
        cur_row(j) = mat(i,j);
                
    end
            
    cur_row = haar1d(cur_row,columns);
            
    for j = 1:columns
               
        mat(i,j) = cur_row(j);
                
    end
            
end

% Sending each column to haar1d function to apply the haar wavelet transform
% method
for i = 1:columns
           
    for j = 1:rows
               
        cur_col(j) = mat(j,i);
                
    end
            
    cur_col = haar1d(cur_col,rows);
            
    for j = 1:rows
               
        out_mat(j,i) = cur_col(j);
                
    end
            
end

end

