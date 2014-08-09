%POGO ODE simulation of a pogo stick
%   Demonstrates a slider joint with optional actuation
%
%   Author: Erik Schuitema <e.schuitema@tudelft.nl>

%% Initialization
sim = odesim('pogo.xml');                         % Load configuration
sim.realtime();                                   % Slow down to realtime

%% Define sensors and actuators
pos = sim.sensor('robot.motorjoint.position');    % Define sensor
vel = sim.sensor('robot.motorjoint.positionrate');% Define sensor
motor = sim.actuator('robot.motorjoint.force');   % Define actuator
actuators = sim.actuate();                        % Get actuation vector

%% Control loop
for t = 0:sim.step():6                            % Simulation loop (6s)
    sensors = sim.sense();                        % Measure sensor values
    % No actuation: set both upper- and lowerjointlimit in XML file to 0.0
    %actuators(motor) = 0.0;                      
    % PD control: remove upper- and lowerjointlimit from XML file
    actuators(motor) = 30*(0 - sensors(pos)) + 2*(0 - sensors(vel));
    sim.actuate(actuators);                       % Run simulation step
end

%% Clean up
sim.close()                                       % Destroy simulation
