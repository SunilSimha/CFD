%% convDiffCD.m
% Version 1.0
% Modified on 17th March 2017
% A function to solve the 1-D source-free convection diffusion equation using the
% central difference finite volume approximation. This is a sub-function of
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

%Initialize solution vector.
N = length(x)-2; %Number of control volumes

phi = zeros(1,N+2); %Initialising the solution vector
deltax = diff(x);         %A grid of dx values
D = gamma./deltax;        %A convenient paramterisation as defined in Versteeg/Malalasekara

%Bearing in mind that a tridiagonal matrix inversion is part of the
%solution, the code shall suitably reflect this:
% Defining the main, sub and super diagonals and the RHS vector:

main = zeros(1,N);
sub = zeros(1,N-1);
super = zeros(1,N-1);
RHSvec = zeros(1,N);

% auxilliary diagonals
super = super - (D(2:N) - F/2);
sub = sub - (D(2:N) + F/2);

% main diagonal
main = main + cat(2,0,-sub) + cat(2,-super,0);
main(1) = main(1) + (D(1)+F);
main(N) = main(N) + (D(N+1)-F);

%RHS vector
RHSvec(1) = phiBound(1)*(D(1)+F);
RHSvec(N) = phiBound(2)*(D(N+1)-F);

%Solution
phi(2:N+1) = tdma(main,sub,super,RHSvec);
phi(1) = phiBound(1);
phi(N+2) = phiBound(2);
end