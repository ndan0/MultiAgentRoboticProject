num_robot = input("Enter number of robots: [5]");
if isempty(num_robot)
    num_robot = 5; % Default value if no input is provided
end

%Make a graph that display the robot randomly on the square grid
side_length = 5;
robot_positions = rand(num_robot, 2) * side_length; % Generate random positions for robots
% Plot the robot positions on the grid
figure;
scatter(robot_positions(:, 1), robot_positions(:, 2), 'filled');
xlim([0 side_length]);
ylim([0 side_length]);
xlabel('X Position');
ylabel('Y Position');
title('Random Robot Positions on Grid');
grid on;

