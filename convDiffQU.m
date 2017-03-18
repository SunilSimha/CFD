%% convDiffQU.m
% Version 1.0
% Modified on 17th March 2017
% A function to solve the 1-D source-free convection diffusion equation using the
% QUICK finite volume approximation. This is a sub-function of
% the convectionDiffusion code and does the actual computation.
%
% Inputs:
% x            : (vector) grid of node locations along with the boundary points
% phiBound     : (vector) property of interest at the boundary points.
% F            : (scalar) a product of rho and u. 
% gamma        : (scalar) diffusion coefficient
%
% Outputs:
% phi          : (vector) value of the quantity of interest at the nodes.

%%
function phi = convDiffCD(x, phiBound, F, gamma)

end