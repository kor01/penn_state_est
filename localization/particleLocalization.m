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

[size_y, size_x] = size(map);

num_particles = 500;
particles = repmat(param.init_pose, [1, num_particles]);

for j = 2:num_motions
        
    %% motion with random walk
    
    current_step = j
    
    delta = random_motion(num_particles);
    new_particles = particles + delta;
    
    angles = scanAngles + new_particles(3, :);
    occ_x = cos(angles) .* ranges(:, j) + new_particles(1, :);
    occ_y = -sin(angles) .* ranges(:, j) + new_particles(2, :);
    coord_x = ceil(occ_x * resolution) + origin(1);
    coord_y = ceil(occ_y * resolution) + origin(2);

    coord_x = clip_coord(coord_x, size_x);
    coord_y = clip_coord(coord_y, size_y);
    
    indices = sub2ind(size(map), coord_y, coord_x);
    range_map = map(indices);
        
    hits = sum(range_map >= 0.5) * 10;
    misses = sum(range_map < -0.2) * 5;
    
    weights = hits - misses;
    
    % normalize sample weights
    weights(weights < 0) = 0;
    weights = weights / sum(weights);
        
    %% max weight particle is considered as current pose
    
    [~, pose_idx] = max(weights);
        
    new_particles(:, pose_idx)
    
    myPose(:, j) = new_particles(:, pose_idx);
    
    if abs(sum(weights) - 1) > 1e-7
        return
    end
            
    assert(abs(sum(weights) - 1) < 1e-7);
    
    %% resample new particles by weights
    samples = mnrnd(num_particles, weights);
    new_p = zeros(size(new_particles));
        
    counter = 0;
    
    for i=1:num_particles
        
       num_samples = samples(i);
       
       if num_samples == 0
           continue
       end
       
       new_p(:, (counter + 1): (counter + num_samples)) ...
           = repmat(new_particles(:, i), [1 num_samples]);
       counter = counter + num_samples;
    end
    
    particles = new_p;
   
end

end

