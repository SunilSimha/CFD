%% convDiffQU.m
% Version 1.0
% Modified on 17th March 2017
% A function to solve the 1-D source-free convection diffusion equation using the
% QUICK finite volume approximation. This is a sub-function of
% the convectionDiffusion code and does the actual computation. This
% solution is valid only for a uniform grid.
%
% Inputs:
% x            : (vector) uniform grid of node locations along with the boundary points
% phiBound     : (vector) property of interest at the boundary points.
% F            : (scalar) a product of rho and u. 
% gamma        : (scalar) diffusion coefficient
%
% Outputs:
% phi          : (vector) value of the quantity of interest at the nodes.

%%
function phi = convDiffQU(x, phiBound, F, gamma)


%Initialise soution:
N = length(x)-2; %Number of control volumes

phi = zeros(1,N+2); %Initialising the solution vector
phi(1) = phiBound(1);
phi(N+2) = phiBound(2);

deltax = x(3)-x(2);      %dx value
D = gamma/deltax;        %A convenient paramterisation as defined in Versteeg/Malalasekara

% This scheme being a higher order one, as compared to the central difference
% scheme, requires a penta diagonal matrix solution. The code shall
% suitably reflect this.

%Initialise
main = zeros(N,1);
aww = main;
aw = main;
ae = main;
aee = main;
Su = main;
Sp = main;

% Considering the direction of flow:
if F>0
    alpha_w = 1;
    alpha_e = 1;
    
    aw(3:N-1) = aw(3:N-1) + (D + 6.0*alpha_w*F/8 + alpha_e*F/8+ 3.0/8*(1-alpha_w)*F);
    ae(3:N-1) = ae(3:N-1) + (D - 3.0/8*alpha_e*F - 6/8*(1-alpha_e)*F-1/8*(1-alpha_w)*F);
    aee(3:N-1) = aww(3:N-1) + 1/8*(1-alpha_e)*F;
    aww(3:N-1) = aww(3:N-1) - 1/8*alpha_w*F;
    
    aww(N) = -1/8*F;
    aw(2) = D + F;
    aw(N) = 4/3*D + 6/8*F;
    ae(1) = 4/3*D - 3/8*F;
    ae(2) = D - 3/8*F;
    Sp(1) = -(8/3*D + 5/4*F);
    Sp(2) = 1/4*F;
    Sp(N) = -(8/3*D-F);
    Su(1) = (8/3*D + 5/4*F)*phiBound(1);
    Su(2) = -1/4*F*phiBound(1);
    Su(N) = (8/3*D - F)*phiBound(2);
    
    ap = aww + aw +ae - Sp;
    
    phi = pentsolve(-aww(3:N),-aw(2:N),ap,-ae(1:N-1),-aee(1:N-2),Su);
    phi = [phiBound(1); phi; phiBound(2)];
    
else
    % One can exploit the symmetry of the situation very profitably here. A
    % flow in the opposite direction for a uniform grid can be solved by
    % flipping the sign of the flow and exchanging the boundary values.
    % After solving it in this condition using the above algorithm, one simply 
    % needs to flip the solution again and voila, it should be the same as
    % the actual solution.
    phiBoundPrime = fliplr(phiBound);
    phi = convDiffQU(x,phiBoundPrime,-F,gamma);
    phi = flipud(phi);
end 
end
