function coord = clip_coord(coord, max_idx)

coord(coord > max_idx) = max_idx;
coord(coord <= 1) = 1;

end
