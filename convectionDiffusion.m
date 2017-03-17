%% convectionDiffusion.m
% Version 1.0
% Modified on 17th March 2017
% Group: Aswin, Jerik, Remil, Sunil
% This is a solver of the 1-D convection diffusion equation for three different
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

%%
function phi = convectionDiffusion(x, phiBound, u, rho, gamma, method)
%Checks:
if (method ~= 'cd'|| method ~= 'uw' || method ~= 'hy')
    error('Invalid method. Only ''cd'',''uw'' and ''hy'' are accepted')
elseif (len(phiBound) ~= 2)
    error('Invalid boundary conditions')
end

phi = zeros(1,length(x)); %Initialising the solution vector

F = rho*u; %A convenient paramterisation

%@Aswin and Remil: You need to write functions that fit here:

switch method
    case 'cd'
        phi = convDiffCD(x, phiBound, F, gamma);%I'm doing this
    case 'uw'
        phi = convDiffUW(x, phiBound, F, gamma);
    case 'hy'
        phi = convDiffHY(x, phiBound, F, gamma);
end
end