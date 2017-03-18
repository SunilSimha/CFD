%% convectionDiffusion.m
% Version 1.0
% Modified on 17th March 2017
% Group: Aswin, Jerik, Remil, Sunil
% This is a solver of the 1-D source-free convection diffusion equation for three different
% schemes of finite volume: central differencing, upwind and hybrid. This 
% is the core code for the GUI. This solution assumes that the fluid is
% incompressible and, because of continuity, has a constant velocity. It
% computes the value of the property "phi" over the given grid. This solver
% takes a dirichlet type boundary condition.
% 
% Inputs:
% x            : (vector) grid of node locations along with the boundary points
% phiBound     : (vector) property of interest at the boundary points.
% u            : (scalar) velocity of flow.
% rho          : (scalar) density
% gamma        : (scalar) diffusion coefficient
% method       : (string) method used to solve the scheme
%                         1) 'cd': central differencing
%                         2) 'uw': upwind
%                         3) 'hy': hybrid
%
% Outputs:
% phi          : (vector) value of the quantity of interest at the nodes.
% exact        : (vector) exact solution on the grid.

%%
function [phi, exact] = convectionDiffusion(x, phiBound, u, rho, gamma, method)
%Checks:
if (~strcmp(method,'cd') && ~strcmp(method,'pu') && ~strcmp(method,'hy'))
    error('Invalid method. Only ''cd'',''pu'' and ''hy'' are accepted')
elseif (length(phiBound) ~= 2)
    error('Invalid boundary conditions')
end

exact = phiBound(1)+(phiBound(2)-phiBound(1))*(exp(rho*u.*x/gamma)-1)/(exp(rho*u/gamma)-1);

F = rho*u; %A convenient paramterisation

% Now to choose the solver depending on user input:

switch method
    case 'cd' %Central difference
        phi = convDiffCD(x, phiBound, F, gamma);
    case 'pu' %Pure upwind
        phi = convDiffPU(x, phiBound, F, gamma);
    case 'hy'
        phi = convDiffHY(x, phiBound, F, gamma);
end
end