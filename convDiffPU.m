%% convDiffPU.m
% Version 1.0
% Modified on 17th March 2017
% A function to solve the 1-D source-free convection diffusion equation using the
% pure upwind finite volume approximation. This is a sub-function of
% the convectionDiffusion code and does the actual computation.
%
% Inputs:
% x            : (vector) grid of node locations along with the boundary points
% phiBound     : (vector) property of interest at the boundary points.
% F            : (scalar) a product of rho and u. 
% gamma        : (scalar) diffusion coefficient
%
% Outputs:
% phi          : (vector) value of the quantity of interest at the nodes

%%
function phi = convDiffPU(x, phiBound, F, gamma)
          
N = length(x) - 2;
phiA = phiBound(1);
phiB = phiBound(2);
dx = diff(x);
ndx = length(dx);
D = gamma./dx;

mainD = zeros(1,N);
subD = zeros(1,N-1);
superD = zeros(1,N-1);
RHSmat = zeros(1,N);

aW = zeros(1,N);
aE = zeros(1,N);
aP = zeros(1,N);

if(F>=0)

    %For intermediate nodes aPtP = aWtW + aEtE
for i=2:1:(N-1)
aW(i) = D(i)+F;
aE(i) = D(i+1);
aP(i) = aE(i) + aW(i);
end

%For node 1 the descretised equation is a1t1 = aWWtWW + aELtE + Su

aW(1) = 0;
aE(1) = D(2);
SuA = (D(1) + F)*phiA;
Sp = -(D(1) + F);
aP(1) = aW(1) + aE(1) - Sp;

%For node N the descretised equation is aNtN = aWRtW + aEEtEE + Su

aW(N) = D(ndx-1) + F;
aE(N) = 0;
SuB = D(ndx)*phiB;
Sp = -D(ndx);
aP(N) = aW(N) + aE(N) - Sp;

else
    
    %For intermediate nodes aPtP = aWtW + aEtE
for i=2:1:(N-1)
aW(i) = D(i);
aE(i) = D(i+1)-F;
aP(i) = aE(i) + aW(i);
end

%For node 1 the descretised equation is a1t1 = aWWtWW + aELtE + Su

aW(1) = 0;
aE(1) = D(2)-F;
SuA = D(1)*phiA;
Sp = -D(1);
aP(1) = aW(1) + aE(1) - Sp;

%For node N the descretised equation is aNtN = aWRtW + aEEtEE + Su

aW(N) = D(ndx-1);
aE(N) = 0;
SuB = (D(ndx)-F)*phiB;
Sp = -(D(ndx)-F);
aP(N) = aW(N) + aE(N) - Sp;

end
%For the NXN Matrix the leading diagonal terms

mainD(1) = aP(1);
mainD(N) = aP(N);

for i = 2:1:N-1
    mainD(i) = aP(i);
end

%For the NXN Matrix the sub diagonal terms


for i = 1:1:N-1
    subD(i) = -aW(i+1);
end

%For the NXN Matrix the Super diagonal terms


for i = 1:1:N-1
    superD(i) = -aE(i);
end


RHSmat(1) = SuA;
RHSmat(N) = SuB;

for i = 2:1:N-1
    RHSmat(i) = 0;
end

phi = tdma(mainD, subD, superD, RHSmat);
phi = cat(2,phiBound(1),phi,phiBound(2));

    
end

