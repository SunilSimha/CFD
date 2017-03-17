%%RodTemperature
% Group: Ashwin, Jerik, Remil, Sunil
% Modified for the GUI
% Version 2.0. Date: 10-03-17
% This solves the diffusion equation for the case of a uniformly heated 1-D rod of
% uniform area and uniform conductivity coefficient. Uses finite volume method
% to compute the temperatures at the grid points. Takes as input:
% length: of the rod (m)
% area  : of cross section of the rod (m^2)
% tA, tB: Temperatures at the two ends area and B (K)
% k     : conductivity coefficient (W/m/K)
% N     : Number of grid points
% q     : Uniform heat generation (W/m^3)
% 
% Returns:
% x     : array of grid points at which the solution is computed (m)
% temp  : array of temperature values computed using finite difference (K)
% exact : array of temperature values computed analytically (K)
%--------------------------------------------------------------------------

%%
function [x, temp, exact] = rodTemperature(length, area, tA, tB, k, N, q)

dx = length/N;

%For intermediate nodes aPtP = aWtW + aEtE + Su

aW = k*area/dx;
aE = k*area/dx;
Sp = 0;
aP = aE + aW -Sp;
Su = q*area*dx;

%For node 1 the descretised equation is a1t1 = aWWtWW + aELtE + Su

aWW = 0;
aEL = k*area/dx;
Sp = -2*k*area/dx;
a1 = aWW + aEL - Sp;
SuA = q*area*dx + 2*k*area*tA/dx;

%For node N the descretised equation is aNtN = aWRtW + aEEtEE + Su

aWR = k*area/dx;
aEE = 0;
Sp = -2*k*area/dx;
aN = aWR + aEE - Sp;
SuB = q*area*dx + 2*k*area*tB/dx;

%For the NxN Matrix the leading diagonal terms

mainD = zeros(1,N) +aP;
mainD(1) = a1;
mainD(N) = aN;

%For the NXN Matrix the sub diagonal terms

subD = zeros(1,N-1)-aW;
subD(N-1) = -aWR;

%For the NxN Matrix the Super diagonal terms

superD = zeros(1,N-1)-aE;
superD(1) = -aEL;

RHSmat = zeros(1,N)+q*area*dx;
RHSmat(1) = SuA;
RHSmat(N) = SuB;

%Now to use TDMA to get the solution at the nodes.
NodeTemp = tdma(mainD,subD,superD,RHSmat);

%Finally to return the solution

x = linspace(dx/2,(2*N-1)*dx/2,N);
x = cat(2,0,x);
x = cat(2,x,length);

temp = cat(2,tA,NodeTemp);
temp = cat(2,temp,tB);

%Analytical solutions to  the source free diffusion equation at steady
%state:
exact = ((tB-tA)/length+(q*(length-x)/(2*k))).*x+tA;
end