mp = zeros(size(M));
idx = transform_particles(init_pose, scanAngles, ranges(:, 1),...
    param.resol, param.origin, size(M));

mp(idx) = 255;

figure;

imshow(mp);
