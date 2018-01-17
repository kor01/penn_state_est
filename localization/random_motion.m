function motion = random_motion(num_particles)

motion_variance = [0.05 0.05 0.5];

x_motion = normrnd(0, motion_variance(1), [1, num_particles]);
y_motion = normrnd(0, motion_variance(2), [1, num_particles]);
theta_motion = normrnd(0, motion_variance(3), [1, num_particles]);

motion = [x_motion; y_motion; theta_motion];

end
