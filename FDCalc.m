%% Finite difference function:
% Created by: H.S. Sunil Simha. Version : 1.0
% Created on Feb 01 2017
% This function evaluates the derivative of a given function using Taylor
% approximation.

function (derivative, outGrid) = FDCalc(givenFunc,grid, method)
% First, lets compute the function over the grid:
func_over_grid = givenFunc(grid);
n = length(grid);
% Now, depending on the method chosen, the derivative is computed using
% finite difference scheme
switch method
    case 'forward'
        derivative = diff(func_over_grid)/diff(grid);
        outGrid = grid(1:(n-1));
    case 'backward'
        outGrid = grid(2:n);
        derivative = (func_over_grid(2:n)-func_over_grid(1:(n-1)))/(grid(2:n)-grid(1:(n-1)));
    case 'central'
        outgrid = grid(2:(n-1));
        derivative = (func_over_grid(3:n)-func_over_grid(1:(n-2)))/(grid(3:n)-grid(1:(n-2)));
    otherwise
        error('method can only take values: "forward", "backward", "central"');
end