function [feature_map] = extract_feature(img)
% extract feature vector for different color space

%% rgb feature
feature_map = one_color_feature(img);

%% no more color space due to limitation of training examples

end

