% Generate a vector of 1x6 random values with normal distribution
vec = randn(1,6);

% Generate a second vector Y which elements are the invers of the first vector elements accordingly
Y = 1./vec;

% Generate a third vector X which consists of natural number 1 to 6
X = 1:6;

% Use a Matlab function to fit vector y to x in three methods of polynomial fitting, level 3, level 4 and level 5
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

% figure
figure('Name', 'q1 - figure', 'NumberTitle', 'off');
hold on; 
grid on;

title('Polynomial Fitting');
xlabel('X Axis');
ylabel('Y Axis');
legend('level 3 fit', 'level 4 fit', 'level 5 fit', 'Location', 'northwest');

% Adding curves to figure according to the requierments
% The first curve is a regular curve, width 2.
plot(x_res, y3, 'b-', 'LineWidth', 2);
% Second curve is red with dash line, width 2.
plot(x_res, y4, 'r--', 'LineWidth', 2);
% Third curve is magenta and dotted line, width 2.
plot(x_res, y5, 'm:', 'LineWidth', 2);

% Fit the graph axis range to fit the curves dynamically in code
% Setting X asix to [0,7]
xlim([0 7]);

% Fitting the Y asix based on the curves
y_min = min([min(y3), min(y4), min(y5), min(Y)]);
y_max = max([max(y3), max(y4), max(y5), max(Y)]);
% Setting the Y asix with the calculated values: 
ylim([y_min, y_max]);

hold off

