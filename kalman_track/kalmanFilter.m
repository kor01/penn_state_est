function [ predictx, predicty, state, param ] = kalmanFilter( t, x, y, state, param, previous_t )
%UNTITLED Summary of this function goes here
%   Four dimensional state: position_x, position_y, velocity_x, velocity_y

    %% Place parameters like covarainces, etc. here:
    % P = eye(4)
    % R = eye(2)

    % Check if the first time running this function
    if previous_t<0
        
        x_state = one_dim_measure(x, {});
        y_state = one_dim_measure(y, {});
        state = [x, y, 0, 0];
        param = struct('x', x_state, 'y', y_state);
        
        predictx = x;
        predicty = y;
        return;
    end
    
    delta_t = t - previous_t;
    
    x_pred_state = one_dim_pred(delta_t, param.x);
    x_measure_state = one_dim_measure(x, x_pred_state);
    
    y_pred_state = one_dim_pred(delta_t, param.y);
    y_measure_state = one_dim_measure(y, y_pred_state);
    
    param = struct('x', x_measure_state, 'y', y_measure_state);
    
    state = [param.x.mean(1), param.y.mean(1), ...
        param.x.mean(2), param.y.mean(2)];
    
    future_x = one_dim_pred(0.33, param.x);
    future_y = one_dim_pred(0.33, param.y);
    
    predictx = future_x.mean(1);
    predicty = future_y.mean(1);
    
end
