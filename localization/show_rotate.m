mp = zeros(size(M));
i = 1
idx = transform_particles(pose(:, 1), scanAngles, ranges(:, 1),...
    param.resol, param.origin, size(M));

mp(idx) = 255;

figure;

imshow(mp);
