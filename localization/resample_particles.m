function [new_particles] = resample_particles(weights, particles)
% resample paticles by correlation weight
weights(weights < 0) = 0;
weights = weights / sum(weights);
samples = mnrnd(length(weights), weights);

new_particles = zeros(size(particles));

counter = 0;

for i=1:length(samples)
        
       num_samples = samples(i);
       
       if num_samples == 0
           continue
       end
       new_particles(:, (counter + 1): (counter + num_samples)) ...
           = repmat(particles(:, i), [1, num_samples]);
       counter = counter + num_samples;
end

end

