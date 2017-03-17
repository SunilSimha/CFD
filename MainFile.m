%% Main: Interactive input
% Created by: H.S. Sunil Simha. Version : 1.1
% Updated on Feb 08 2017
% Interactive command line input to compute the derivatives using FDCalc.

%%
% This calls for user input. The user has to give the function handle, the
% 1-D grid over which the function is to be computed, the method of calculation
% and the order upto which the function is to be differenced.
functionHandle = input('Please give the function handle of the function to which the derivative is to be computed. e.g. @sin for sin(x): ');
xmin = input('Please input the minimum value of grid coordinate: ');
xmax = input('Now, the max value: ');
while xmax<xmin
    xmax = input('No, the max value can''t be less than the min value. Try again: ');
end
n = input('Input the number of points the grid must have: ');
grid = linspace(xmin,xmax,n);
method = input('Choose the method of differencing: ''forward'',''backward'' or ''central'': ');
differencing_order = input('Choose the order of the derivative. Can currently only take 0,1 or 2: ');

%% Compute the function and the derivative

funcValue = functionHandle(grid);
[derivative, outGrid] = FDCalc(functionHandle,grid,method,differencing_order);

%%
% Now to just plot the function and it's derivative:
figure('Name','Finite difference scheme of computing derivative');
plot(grid, funcValue);
hold on
plot(outGrid, derivative,'--');
title('Plot of function and the requested derivative');
xlabel('x');
ylabel('f(x)');
hold off
if differencing_order == 1
    legend('f(x)','f''(x)')
elseif differencing_order == 2
    legend('f(x)','f''''(x)')
end