% Robotics: Estimation and Learning 
% WEEK 4
% 
% Complete this function following the instruction. 
function myPose = particleLocalization(ranges, scanAngles, map, param)

[K, N] = size(ranges);
myPose = zeros(3, N);

myPose(:,1) = param.init_pose;


origin = param.origin; 
resolution = param.resol;

M = 200;

% Create M number of particles
P = repmat(myPose(:,1), [1, M]);

motion_var = 0.5;

pos_free = 1; neg_free = -5;
pos_occ = 10; neg_occ = -5;

[size_y, size_x] = size(map);


for j = 2:N
        
    %% motion with random walk
    P = motion_update(P, motion_var);
    
    %% compute correlation weight of each particle
    
    % broadcast to compute sum angles, should be K x M dimension
    angles = scanAngles + P(3, :);
    
    occ_x = cos(angles) .* ranges(:, j) + P(1, :);
    occ_y = -sin(angles) .* ranges(:, j) + P(2, :);
        
    coord_x = ceil(occ_x * resolution) + origin(1);
    coord_y = ceil(occ_y * resolution) + origin(2);
    
    first = coord_x(1:10, 1)
    second = coord_x(1:10, 2)
    
    coord_x = clip_coord(coord_x, size_x);
    coord_y = clip_coord(coord_y, size_y);
    
    indices = sub2ind(coord_y, coord_x);
    
    particle_occ = map(indices);
    particle_occ
    
    num_hits = sum(particle_occ, 1);
    num_miss = K - num_hits;
    
   
    weights = num_hits * pos_occ + num_miss * neg_occ;
    
    % normalize sample weights
    weights(weights < 0) = 0;
    weights = weights .^ 2;
    weights = weights / sum(weights);
    
        
    %% max weight particle is considered as current pose
    
    [~, pose_idx] = max(weights);
        
    myPose(:, j) = P(:, pose_idx);
    
    %% resample new particles by weights
    samples = mnrnd(M, weights);
    
    new_p = zeros(size(P));
    counter = 0;
    
    for i=1:M
       num_samples = samples(i);
       
       if num_samples == 0
           continue
       end
       new_p(:, (counter + 1): (counter + num_samples)) ...
           = repmat(P(:, i), [1 num_samples]);
       counter = counter + num_samples;
    end
    
end

end

function particles = motion_update(particles, motion_var)
    
motion = normrnd(0, motion_var, size(particles));

particles = particles + motion;

end

function coord = clip_coord(coord, max_idx)

coord(coord > max_idx) = max_idx;
coord(coord <= 1) = 1;

end
