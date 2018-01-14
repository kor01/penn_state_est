function [new_state] = one_dim_measure(m, state)
% update the current kalman state with observation m
% if the current state is empty, a new state is constructed with m

persistent observe_sigma observe_mat;

if isempty(state)
    
    observe_sigma = 0.01;
    
    observe_mat = [1, 0];
    
    new_state = struct('mean', [m; 0], 'sigma', eye(2));
    
    return;
    
end

% kalman gain

sigma = state.sigma; c = observe_mat;

kt = (sigma * c') / (c * sigma * c' + observe_sigma);

new_mean = state.mean + kt * (m - state.mean(1));
new_sigma = (eye(2) - kt * observe_mat) * state.sigma;

new_state = struct('mean', new_mean, 'sigma', new_sigma);

end

