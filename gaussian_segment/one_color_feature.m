function [feature_map] = one_color_feature(img)
% extract pixel wise feature for gaussian discrimintive analysis

[l1, l2] = gaussian_pyramid(img);

feature_map = cat(3, double(img), l1, l2);

end
