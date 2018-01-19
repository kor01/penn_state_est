function [weights] = map_correlation(map, idx)
% compute correlation weight between map and idx  

range_map = map(idx);
hits = sum(range_map >= 0.5) * 10;
misses = sum(range_map < -0.2) * 5;

weights = hits - misses;

end

