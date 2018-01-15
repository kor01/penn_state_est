% Robotics: Estimation and Learning 
% WEEK 3
% 
% Complete this function following the instruction. 
function myMap = occGridMapping(ranges, scanAngles, pose, param)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Parameters 
% 
% % the number of grids for 1 meter.
% myResol = param.resol;
% % the initial map size in pixels
% myMap = zeros(param.size);
% % the origin of the map in pixels
% myorigin = param.origin; 
% 
% % 4. Log-odd parameters 
% lo_occ = param.lo_occ;
% lo_free = param.lo_free; 
% lo_max = param.lo_max;
% lo_min = param.lo_min;

myMap = zeros(param.size);
origin = param.origin;

resolution = param.resol;

N = size(pose, 2);

for j = 1:N
    
    x = pose(1, j); y = pose(2, j); theta = pose(3, j);
    
    angles = scanAngles + theta;
    
    directions = [cos(angles) -sin(angles)];
        
    deltas =  directions .* ranges(:, j);
        
    ends = deltas + [x y];
        
    ends = ceil(ends * resolution) + origin';
    
    start = ceil([x; y] * resolution) + origin;
            
    ends = unique(ends, 'rows');
            
    for i=1:length(ends)

        ep = ends(i, :);

        [freex, freey] = bresenham(start(1), start(2), ep(1), ep(2));
        
        idx = sub2ind(param.size, freey, freex);
        
            %% TODO: update log ratio with given conditional probability
        
        myMap(idx) = max(myMap(idx) - param.lo_free, param.lo_min);
        
        ep_idx = sub2ind(param.size, ep(2), ep(1));
          
        myMap(ep_idx) = min(myMap(ep_idx) + param.lo_occ, param.lo_max);

    end    
end

end