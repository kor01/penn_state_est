function [param] = train_gda(pos_features, neg_features)
% train a GDA (gaussian discriminative model)

num_examples = [size(neg_features, 2), size(pos_features, 2)];

prior = num_examples / sum(num_examples);

pos_mean = mean(pos_features, 2);
neg_mean = mean(neg_features, 2);

pos_features = pos_features - pos_mean;
neg_features = neg_features - neg_mean;

pos_cov = pos_features * pos_features' / num_examples(2);
neg_cov = neg_features * neg_features' / num_examples(1);

pos_prec = inv(pos_cov);
neg_prec = inv(neg_cov);

neg_const = log(prior(1)) - 0.5 * log(det(neg_prec));
pos_const = log(prior(2)) - 0.5 * log(det(pos_prec));

param = struct('pos_mean', pos_mean, ...
    'pos_prec', pos_prec, ...
    'neg_mean', neg_mean, ...
    'neg_prec', neg_prec, ...
    'pos_const', pos_const, 'neg_const', neg_const);

end
