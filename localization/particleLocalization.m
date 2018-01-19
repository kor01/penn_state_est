% Robotics: Estimation and Learning 
% WEEK 4
% 
% Complete this function following the instruction. 
function myPose = particleLocalization(ranges, scanAngles, map, param)

[~, num_motions] = size(ranges);
myPose = zeros(3, num_motions);

myPose(:,1) = param.init_pose;


origin = param.origin; 
resolution = param.resol;

num_particles = 500;
particles = repmat(param.init_pose, [1, num_particles]);

prev_weights = ones(1, num_particles);

for j = 2:num_motions
        
    %% motion with random walk
    
    delta = random_motion(num_particles);
    new_particles = particles + delta;
    
    %widx = transform_particles(pose(:, j), scanAngles, ...
    %    ranges(:, j), resolution, origin, size(map));
    
    %ideal_weight = map_correlation(map, widx);
    
    idx = transform_particles(new_particles, ...
        scanAngles, ranges(:, j), resolution, origin, size(map));
    
    weights = map_correlation(map, idx);
    
    % average with prev weight
    weights = weights .* prev_weights;
    
    [max_weight, pose_idx] = max(weights);
    
    %sprintf('current_step=%f max_weight=%f, ideal_weight=%f', ...
    %    j, max_weight, ideal_weight)
    
    myPose(:, j) = new_particles(:, pose_idx);
    
    %particles = resample_particles(weights, new_particles);
    
    particles = repmat(new_particles(:, pose_idx), [1, num_particles]);
    
end

end

