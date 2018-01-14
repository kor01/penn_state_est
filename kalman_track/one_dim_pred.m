function [new_state] = one_dim_pred(delta_t, state)
% predict next time step pos and velocity with current

persistent motion_noise;

if isempty(motion_noise)
    motion_noise = eye(2) * 0.01;
end

motion = [1 delta_t; 0, 1];

new_mean = motion * state.mean;
new_var = motion * state.sigma * motion' + motion_noise;

new_state = struct('mean', new_mean, 'sigma', new_var);

end

