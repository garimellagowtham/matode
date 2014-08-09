%MOUNTAINCAR ODE simulation of the mountain car task
%   This script shows a car trying to get out of a valley.
%
%   Author: Wouter Caarls <w.caarls@tudelft.nl>

%% Initialization
sim = odesim('mountaincar.xml');                  % Load configuration
sim.realtime();                                   % Slow down to realtime

%% Define sensors and actuators
vel = sim.sensor('robot.base.velocity.y');        % Define sensor

x = sim.sensor('robot.base.orientation.x');        % Define sensor
y = sim.sensor('robot.base.orientation.y');        % Define sensor
z = sim.sensor('robot.base.orientation.z');        % Define sensor
w = sim.sensor('robot.base.orientation.w');        % Define sensor

motor = sim.actuator('robot.motorjoint1.torque'); % Define actuator
actuators = sim.actuate();                        % Get actuation vector

%% Control loop
for t = 0:sim.step():6                            % Simulation loop (6s)
    sensors = sim.sense();                       % Measure sensor values
    if sensors(vel) > 0                           % Read sensor
        actuators(motor) = 0.5;                   % Set actuator
    else
        actuators(motor) = -0.5;
    end
    sim.actuate(actuators);                       % Run simulation step
    
    A = quaternion2matrix(sensors([w x y z]));
    A*[0 1 0 1]'
    
end

%% Clean up
sim.close()                                       % Destroy simulation
