%% convDiffCD.m
% Version 1.0
% Modified on 17th March 2017
% A function to solve the 1-D convection diffusion equation using the
% central difference finite volume approximation. This is a sub-function of
% the convectionDiffusion code and dies the actual computation.
%
% Inputs:
% x            : (vector) grid of node locations along with the boundary points
% phiBound     : (vector) property of interest at the boundary points.
% F            : (scalar) a product of rho and u. 
% gamma        : (scalar) diffusion coefficient
% method       : (string) method used to solve the scheme
%                         1) 'cd': central differencing
%                         2) 'uw': upwind
%                         3) 'hy': hybrid
%
% Outputs:
% phi          : (vector) value of the quantity of interest at the nodes.

%%
function phi = convDiffCD(x, phiBound, F, gamma)

%Initialize solution vector.
phi = zeros(1,length(x)); %Initialising the solution vector

end