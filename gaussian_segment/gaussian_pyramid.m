function [l1, l2] = gaussian_pyramid(image)
% compute a 3 level gaussian pyramid for input image

l1 = gauss_reduce(image);
l2 = gauss_reduce(l1);

l2 = gauss_expand(l2);
l2 = gauss_expand(l2);

l1 = gauss_expand(l1);

end
