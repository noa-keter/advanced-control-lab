%%%======================== Question 1 ====================================
% Generate a vector of 1x6 random values with normal distribution
vec1 = randn(1,6);

% Generate a second vector Y which elements are the invers of the first
% vector elements accordingly
Y = 1./vec1;

% Generate a third vector X which consists of natural number 1 to 6
X = 1:6;

% Use a Matlab function to fit vector y to x in three methods of polynomial
% fitting, level 3, level 4 and level 5
p3 = polyfit(X, Y, 3);
p4 = polyfit(X, Y, 4);
p5 = polyfit(X, Y, 5);

% Draw a graph for each fitting in range of [0..7] 
% X asix resulution 0.01
x_res = 0:0.01:7;

% y values for each polynomial fit over the new x_res range
y3 = polyval(p3, x_res);
y4 = polyval(p4, x_res);
y5 = polyval(p5, x_res);

% Plot
figure('Name', 'q1 - figure', 'NumberTitle', 'off');
hold on; 
grid on;
title('Polynomial Fitting');
xlabel('X Axis');
ylabel('Y Axis');

% Adding curves to figure according to the requierments
% The first curve is a regular curve, width 2.
plot(x_res, y3, 'b-', 'LineWidth', 2);
% Second curve is red with dash line, width 2.
plot(x_res, y4, 'r--', 'LineWidth', 2);
% Third curve is magenta and dotted line, width 2.
plot(x_res, y5, 'm:', 'LineWidth', 2);
%Legend
legend('level 3 fit', 'level 4 fit', 'level 5 fit', 'Location', 'best');
% Fit the graph axis range to fit the curves dynamically in code
% Setting X asix to [0,7]
xlim([0 7]);

% Fitting the Y asix based on the curves
y_all = [y3, y4, y5, Y];
ylim([min(y_all), max(y_all)]);

hold off

%%%======================== Question 2 ====================================
vec2 = 2*vec1; % [a b c d e f]

% Coeffifients
a = vec2(1);
b = vec2(2);
c = vec2(3);
d = vec2(4);
e = vec2(5);
f = vec2(6);

% 6000 points in [0, 2*pi]
x_dense = linspace(0, 2*pi, 6000);
y_dense = a*sin(b*x_dense + c) + d*sin(e*x_dense + f);

% 6 equally spaced points
x_sparse = linspace(0, 2*pi, 6);
y_sparse = a*sin(b*x_sparse + c) + d*sin(e*x_sparse + f);

% Plot
figure('Name', 'q2 - figure', 'NumberTitle', 'off');
hold on;
grid on;

title('Sine Function Comparison');
xlabel('X Axis');
ylabel('Y Axis');

plot(x_dense, y_dense, 'b-', 'LineWidth', 2);
% 6-point representation (stem + circle markers)
stem(x_sparse, y_sparse, 'ro', 'LineWidth', 1.5);
legend('6000 points', '6 points (stem)', 'Location', 'best');

hold off

% Q: Is there a difference between the 6000 points vector and the 6 points?
% A: Yes — there is a significant difference between the 6000-point vector
% and the 6-point vector. The 6000-point graph is smooth and accurately
% represents the function, capturing all its variations. In contrast, 
% the 6-point graph contains very little information, so it does not reflect 
% the true shape of the function and misses important details. 
% As a result, fitting based on 6000 points is much more accurate, 
% while fitting based on only 6 points is unreliable.

%%%======================== Question 3 ====================================
% Define theta
theta = 0:0.01:2*pi;

% Example values (replace with YOUR ID digits)
a = 3;
b = 1;
c = 8;
d = 8;

% Define rho
rho = (a + b) + 0.5 * sin((c + d) * theta);

% Convert to Cartesian
x = rho .* cos(theta);
y = rho .* sin(theta);

% Plot the shape
figure('Name','q3 -  shape figure','NumberTitle','off');
plot(x, y, 'LineWidth', 2);
grid on;
axis equal;
title('Polar to Cartesian Shape');
xlabel('x');
ylabel('y');

% Calculate the delta variable vector dx,dy
dx = diff(x);
dy = diff(y);

% Angle using atan
angle_atan = atan(dy ./ dx);

% Angle using atan2
angle_atan2 = atan2(dy, dx);

% Plot angles
figure('Name','q3 - angles figure','NumberTitle','off');
hold on;
grid on;

plot(angle_atan, 'r', 'LineWidth', 1.5);
plot(angle_atan2, 'b', 'LineWidth', 1.5);

title('Angle Change Comparison');
xlabel('Index');
ylabel('Angle');

% Q: Describe the graphs
% A: The plot shows the angle change calculated using both atan and atan2 functions.
% The atan2 (blue) curve is smoother and more consistent, correctly representing
% the angle changes over the full range. However, it still shows sharp jumps
% due to angle wrapping between pi and −pi.
% The atan (red) curve is less accurate and more irregular.
% It produces incorrect values and discontinuities because it does not 
% consider the correct quadrant of the angle. Overall, atan2 provides a
% more reliable representation of the angle, while atan leads to errors and
% instability in the results.

% Continuosy fix
angle_atan2_unwrapped = unwrap(angle_atan2);
plot(angle_atan2_unwrapped, 'k', 'LineWidth', 2);
legend('atan', 'atan2', 'Continuous');

%%%======================== Question 4 ====================================
% Define System Parameters
m = 1; c = 4; k = 3;

% Define State-Space Matrices (Observer Form)
A = [-4 1;-3 0];
B = [-1; 2];
C = [1 0];
D = 0;

% Run Simulink Simulation (Assumes model is named 'control_model')
t_final = 10;
sim_data = sim('control_model', 'ReturnWorkspaceOutputs', 'on', 'StopTime', num2str(t_final));

% Plot Results
figure('Name', 'System Response - Zero Initial Conditions', 'NumberTitle', 'off');

% Plot Column 2 (State-Space) and Column 3 (Direct Diagram)
plot(sim_data.tout, sim_data.yout(:, 2:3), 'LineWidth', 2);
grid on;

title('System Response');
xlabel('Time (s)');
ylabel('Amplitude');
legend('From state-space', 'Block Diagram', 'Location', 'best');

% 2. Plot the results
figure('Name', 'Question 4 - Initial Conditions', 'NumberTitle', 'off');

% Plot only the State-Space and Diagram columns (ignoring the time column)
plot(sim_data.tout, sim_data.yout(:, 2:3), 'LineWidth', 2);
grid on;
title('System Response with Initial Conditions');
xlabel('Time (s)');
ylabel('Amplitude (\alpha)');
legend('State-Space (\alpha_0 = 0.5)', 'Block Diagram (d\alpha_0 = 1)', 'Location', 'best');
% Find the matrixes C,D for the case of y = [alpha; d_alpha/dt]
% We know from our state definitions:
% x1 = alpha
% x2 = d_alpha/dt + 4*alpha + u
% Rearranging for d_alpha/dt gives: d_alpha/dt = -4*x1 + x2 - u

% Therefore, the new C and D matrices to output both variables are:
C_new = [1 0; -4 1];
D_new = [0; -1];

disp('--- Matrices for y = [alpha; d_alpha/dt] ---');
disp('New C matrix:');
disp(C_new);
disp('New D matrix:');
disp(D_new);

% --- Question 5: Non-Linear Behaviors (3 View Modes) ---

% Run the Simulink Simulation (runs for 10 seconds)
t_final = 10;
sim_data = sim('question5_model', 'ReturnWorkspaceOutputs', 'on', 'StopTime', num2str(t_final));

% Extract time and signal data to make plotting cleaner
time = sim_data.tout;
signals = sim_data.yout(:, 2:6); 

% ---------------------------------------------------------
% Mode 1: With y auto range
% ---------------------------------------------------------
figure('Name', 'Q5 - Mode 1: Auto Range', 'NumberTitle', 'off');
plot(time, signals, 'LineWidth', 1.5);
grid on;
title('Response of Non-Linear Blocks (Y Auto Range)');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original Transfer Fcn', 'Saturation', 'Dead Zone', 'Backlash', 'Relay', 'Location', 'best');
axis auto; % This tells MATLAB to automatically fit all data perfectly

% ---------------------------------------------------------
% Mode 2: With y in a range of [-0.3, 0.3]
% ---------------------------------------------------------
figure('Name', 'Q5 - Mode 2: Y-Limits [-0.3, 0.3]', 'NumberTitle', 'off');
plot(time, signals, 'LineWidth', 1.5);
grid on;
title('Response of Non-Linear Blocks (Y Range [-0.3, 0.3])');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original Transfer Fcn', 'Saturation', 'Dead Zone', 'Backlash', 'Relay', 'Location', 'best');
ylim([-0.3, 0.3]); % This strictly limits the Y-axis to the requested range

% ---------------------------------------------------------
% Mode 3: With manual range using magnifying glass
% ---------------------------------------------------------
% To simulate drawing a box with the magnifying glass in Simulink, 
% we will zoom in on both the X and Y axes to focus on a specific section.
figure('Name', 'Q5 - Mode 3: Manual Zoom', 'NumberTitle', 'off');
plot(time, signals, 'LineWidth', 1.5);
grid on;
title('Response of Non-Linear Blocks (Manual Zoom)');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original Transfer Fcn', 'Saturation', 'Dead Zone', 'Backlash', 'Relay', 'Location', 'best');
xlim([0.5, 3]);     % Zooming in on the X-axis (from 0.5s to 3s)
ylim([-0.25, 0.3]); % Zooming in closely on the Y-axis to see the interactions

% --- Question 6: Frequency Response & Sampling ---

% Define the Transfer Function
num = [-1, 2];
den = [1, 4, 3];
sys = tf(num, den);

% Plot the Bode Response
figure('Name', 'Question 6 - Bode Plot', 'NumberTitle', 'off');
bode(sys);
grid on;
title('Bode Response of the System');

% Sample 5 frequencies logarithmically between 0.5 and 100 rad/s
w_samples = logspace(log10(0.5), log10(100), 5);

% Extract the magnitude data
[mag, phase, wout] = bode(sys, w_samples);
gain_samples = squeeze(mag)'; % 'squeeze' flattens it, transpose makes it a row

% Display the values in the Command Window
disp('--- Q6: Sampled Data ---');
fprintf('Frequencies (w):  %.4f,  %.4f,  %.4f,  %.4f,  %.4f\n', w_samples);
fprintf('Absolute Gain (G): %.4f,  %.4f,  %.4f,  %.4f,  %.4f\n', gain_samples);