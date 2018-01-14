function g = gauss_expand(I)

    % Input:
    % I: the input image
    % Output:
    % g: the image after the expand operation

    % Please follow the instructions to fill in the missing commands.
    
    % 1) Create the expanded image. 
    % The new image should be twice the size of the original image.
    % So, for an n x n image you will create an empty 2n x 2n image
    % Fill every second row and column with the rows and columns of the original image
    % i.e., 1st row of I -> 1st row of expanded image
    %       2nd row of I -> 3rd row of expanded image
    %       3rd row of I -> 5th row of expanded image, and so on
    
    % 2) Create a Gaussian kernel of size 5x5 and 
    % standard deviation equal to 1 (MATLAB command fspecial)
    
    % 3) Convolve the input image with the filter kernel (MATLAB command imfilter)
    % Tip: Use the default settings of imfilter
    % Remember to multiply the output of the filtering with a factor of 4
    
    sz = size(I);
    target_h = sz(1) * 2;
    target_w = sz(2) * 2;
    ng = zeros(target_h, target_w, sz(3));
    ng(1:2:target_h, 1:2:target_w, :) = I;
    kernel = fspecial('Gaussian', 5, 1);
    ing = imfilter(ng, kernel);
    g = ing * 4;
   
end
