function [idx] = transform_particles(...
    particles, angles, ranges, resolution, origin, map_size)
% transform particles in local coordinate to world coordinate

angles = angles - particles(3, :);
occ_x = cos(angles) .* ranges + particles(1, :);
occ_y = -sin(angles) .* ranges + particles(2, :);
coord_x = ceil(occ_x * resolution) + origin(1);
coord_y = ceil(occ_y * resolution) + origin(2);

coord_x = clip_coord(coord_x, map_size(2));
coord_y = clip_coord(coord_y, map_size(1));

idx = sub2ind(map_size, coord_y, coord_x);

end
