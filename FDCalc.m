%% Finite difference function:
% Created by: H.S. Sunil Simha. Version : 1.4
% Updated on Mar 08 2017
% 
% FDCALC is a finite difference calculator that computes the derivative of
% a given function on the given grid using a finite differencing scheme. It
% takes as arguments:
%   
%   Arguments:
%   givenFunc: A function handle. For example @sin.
%   grid: The grid over which the derivative is to be computed
%   
%   Optional Arguments:
%   method: 'forward, 'backward' or 'central' differencing schemes can be used.
%   differencing_order: The order of the derivative to be computed.
%   scheme_order: The order of accuracy of finite difference scheme.
%   see also DIFF

%%
function [derivative, outGrid] = FDCalc(givenFunc, grid, method, differencing_order)
% Checks
if ~isa(givenFunc,'function_handle')
    error('The first argument must be a function handle. For example @sin.');
elseif floor(differencing_order)~=differencing_order
    error('The differencing order must be an integer');
elseif ~isreal(grid)
    error('The grid must be a float array');
end

% First, let's compute the function over the grid:
func_over_grid = givenFunc(grid);
n = length(grid);
% Now, depending on the method chosen, the derivative is computed using
% finite difference scheme
    switch differencing_order
        case 0
%           Simply return the function computed over the grid
            derivative = func_over_grid;
            outGrid = grid;
        case 1
%           Compute first derivative
            switch method
                case 'forward'
                    derivative = diff(func_over_grid)./diff(grid);
                    outGrid = grid(1:(n-1));
                case 'backward'
                    outGrid = grid(2:n);
                    derivative = (func_over_grid(2:n)-func_over_grid(1:(n-1)))./(grid(2:n)-grid(1:(n-1)));
                case 'central'
                    outGrid = grid(2:(n-1));
                    derivative = (func_over_grid(3:n)-func_over_grid(1:(n-2)))./(grid(3:n)-grid(1:(n-2)));
                otherwise
                    error('method can only take values: ''forward'', ''backward'', ''central''');
            end
        case 2
%           Compute second derivative.
            switch method
                case 'forward'
                    [dfdx, x] = FDCalc(givenFunc,grid,'forward',1);
                    derivative = diff(dfdx)./diff(x);
                    m = length(x);
                    outGrid = x(1:(m-1));
                case 'backward'
                    [dfdx, x] = FDCalc(givenFunc,grid,'backward',1);
                    m = length(x);
                    derivative = (dfdx(2:m)-dfdx(1:(m-1)))./(x(2:m)-x(1:(m-1)));
                    outGrid = x(2:m);
                case 'central'
%                   It must be noted that the second order derivative
%                   calculated through the central difference scheme is
%                   equivalent to consecutive application of backward and
%                   forward differencing.
                    [dfdx, x] = FDCalc(givenFunc,grid,'backward',1);
%                   Computing forward difference of the derivative obtained
%                   from backward differencing.
                    m = length(x);
                    derivative = diff(dfdx)./diff(x);
                    outGrid = x(1:(m-1));
                otherwise
                    error('method can only take values: ''forward'', ''backward'', ''central''');
            end
        otherwise
            error('Sorry. This function can currently only compute upto second derivative.');
    end
end