function [mask] = eval_gda(img, param)
% segment mask given image and GDA parameter

feature = extract_feature(img);
[height, width, depth] = size(feature);

feature = permute(feature, [3, 1, 2]);
feature = reshape(feature, [depth, height * width]);

pos_log_prob = eval_gauss(param.pos_mean, ...
    param.pos_prec, param.pos_const, feature);

neg_log_prob = eval_gauss(param.neg_mean, ...
    param.neg_prec, param.neg_const, feature);

prob_diff = pos_log_prob - neg_log_prob;

exp_prob_diff = exp(prob_diff);

pos_prob = exp_prob_diff ./ (exp_prob_diff + 1);

mask = reshape(pos_prob, [height, width]);

end

function [log_prob] = eval_gauss(mean, prec, const, features)

shift = features - mean;

log_prob = -0.5 * sum(shift .* (prec * shift), 1);

log_prob = log_prob + const;

end