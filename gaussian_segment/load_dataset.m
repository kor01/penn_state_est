function [pos_features, neg_features] = load_dataset()
% load images and mask, extract features

pos_features = [];
neg_features = [];

for k=1:15
    img = imread(sprintf('train/%03d.png', k));
    mask = imread(sprintf('masks/%d.png', k));
    
    feature = extract_feature(img);
    pos_mask = mask > 0;
    neg_mask = mask <= 0;
    
    feature = permute(feature, [3 1 2]);
    [depth, width, height] = size(feature);
        
    feature = reshape(feature, [depth, width, height]);
    
    pos_feat = feature(:, pos_mask);
    neg_feat = feature(:, neg_mask);
    
    pos_features = [pos_features, pos_feat];
    neg_features = [neg_features, neg_feat];
    
end

end

