%% convDiffHY.m
% Version 1.0
% Modified on 18th March 2017
% A function to solve the 1-D source-free convection diffusion equation using the
% Hybrid (CD and PU) finite volume approximation. This is a sub-function of
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

function phi = convDiffHY(x, phiBound, F, gamma)
          
N = length(x) - 2; %Matrix dimension
phiA = phiBound(1);
phiB = phiBound(2);
dx = diff(x);
ndx = length(dx);
D = gamma./dx;
Pe = F./D;

%For using tdma to solve:
mainD = zeros(1,N);
subD = zeros(1,N-1);
superD = zeros(1,N-1);
RHSmat = zeros(1,N);
aW = zeros(1,N);
aE = zeros(1,N);
aP = zeros(1,N);

if(F>=0)
    %For non-negative u
    %For intermediate nodes aPtP = aWtW + aEtE
for i=2:1:(N-1)
        if (Pe(i)>2) && (Pe(i+1)>2)
aW(i) = D(i)+F;
aE(i) = D(i+1);
aP(i) = aE(i) + aW(i);
        elseif (Pe(i)<2) && (Pe(i+1)>2)
aW(i) = D(i)+F/2;
aE(i) = D(i+1);
aP(i) = aE(i) + aW(i);
        elseif (Pe(i)>2) && (Pe(i+1)<2)
aW(i) = D(i)+F;
aE(i) = D(i+1)-F/2;
aP(i) = aE(i) + aW(i);
        elseif (Pe(i)<2) && (Pe(i+1)<2)
aW(i) = D(i)+F/2;
aE(i) = D(i+1)-F/2;
aP(i) = aE(i) + aW(i);
        end        
end

%For node 1 the descretised equation is a1t1 = aWWtWW + aELtE + Su
        if (Pe(1)>2) && (Pe(2)>2)
aW(1) = 0;
aE(1) = D(2);
SuA = (D(1) + F)*phiA;
Sp = -(D(1) + F);
aP(1) = aW(1) + aE(1) - Sp;
        elseif (Pe(1)<2) && (Pe(2)>2)
aW(1) = 0;
aE(1) = D(2);
SuA = (D(1) + F/2)*phiA;
Sp = -(D(1) + F/2);
aP(1) = aW(1) + aE(1) - Sp;
        elseif (Pe(1)>2) && (Pe(2)<2)
aW(1) = 0;
aE(1) = D(2)-F/2;
SuA = (D(1) + F)*phiA;
Sp = -(D(1) + F);
aP(1) = aW(1) + aE(1) - Sp;
        elseif (Pe(1)<2) && (Pe(2)<2)
aW(1) = 0;
aE(1) = D(2)-F/2;
SuA = (D(1) + F/2)*phiA;
Sp = -(D(1) + F/2);
aP(1) = aW(1) + aE(1) - Sp;
        end

%For node N the descretised equation is aNtN = aWRtW + aEEtEE + Su

        if (Pe(N)>2) && (Pe(N+1)>2)
aW(N) = D(ndx-1) + F;
aE(N) = 0;
SuB = D(ndx)*phiB;
Sp = -D(ndx);
aP(N) = aW(N) + aE(N) - Sp;
        elseif (Pe(N)<2) && (Pe(N+1)>2)
aW(N) = D(ndx-1) + F/2;
aE(N) = 0;
SuB = D(ndx)*phiB;
Sp = -D(ndx);
aP(N) = aW(N) + aE(N) - Sp;
        elseif (Pe(N)>2) && (Pe(N+1)<2)
aW(N) = D(ndx-1) + F;
aE(N) = 0;
SuB = (D(ndx)-F/2)*phiB;
Sp = -(D(ndx)-F/2);
aP(N) = aW(N) + aE(N) - Sp;
        elseif (Pe(N)<2) && (Pe(N+1)<2)
aW(N) = D(ndx-1) + F/2;
aE(N) = 0;
SuB = (D(ndx)-F/2)*phiB;
Sp = -(D(ndx)-F/2);
aP(N) = aW(N) + aE(N) - Sp;
        end

else
    %For negative u
    %For intermediate nodes aPtP = aWtW + aEtE
    
for i=2:1:(N-1)
        if (Pe(i)>2) && (Pe(i+1)>2)
aW(i) = D(i);
aE(i) = D(i+1)-F;
aP(i) = aE(i) + aW(i);
        elseif (Pe(i)<2) && (Pe(i+1)>2)
aW(i) = D(i)+F/2;
aE(i) = D(i+1)-F;
aP(i) = aE(i) + aW(i);
        elseif (Pe(i)>2) && (Pe(i+1)<2)
aW(i) = D(i);
aE(i) = D(i+1)-F/2;
aP(i) = aE(i) + aW(i);
        elseif (Pe(i)<2) && (Pe(i+1)<2)
aW(i) = D(i)+F/2;
aE(i) = D(i+1)-F/2;
aP(i) = aE(i) + aW(i);
        end        
end

%For node 1 the descretised equation is a1t1 = aWWtWW + aELtE + Su

        if (Pe(1)>2) && (Pe(2)>2)
aW(1) = 0;
aE(1) = D(2)-F;
SuA = D(1)*phiA;
Sp = -D(1);
aP(1) = aW(1) + aE(1) - Sp;
        elseif (Pe(1)<2) && (Pe(2)>2)
aW(1) = 0;
aE(1) = D(2)-F;
SuA = (D(1) + F/2)*phiA;
Sp = -(D(1) + F/2);
aP(1) = aW(1) + aE(1) - Sp;
        elseif (Pe(1)>2) && (Pe(2)<2)
aW(1) = 0;
aE(1) = D(2)-F/2;
SuA = D(1)*phiA;
Sp = -D(1);
aP(1) = aW(1) + aE(1) - Sp;
        elseif (Pe(1)<2) && (Pe(2)<2)
aW(1) = 0;
aE(1) = D(2)-F/2;
SuA = (D(1) + F/2)*phiA;
Sp = -(D(1) + F/2);
aP(1) = aW(1) + aE(1) - Sp;
        end

%For node N the descretised equation is aNtN = aWRtW + aEEtEE + Su

        if (Pe(N)>2) && (Pe(N+1)>2)
aW(N) = D(ndx-1);
aE(N) = 0;
SuB = (D(ndx)-F)*phiB;
Sp = -(D(ndx)-F);
aP(N) = aW(N) + aE(N) - Sp;
        elseif (Pe(N)<2) && (Pe(N+1)>2)
aW(N) = D(ndx-1) + F/2;
aE(N) = 0;
SuB = (D(ndx)-F)*phiB;
Sp = -(D(ndx)-F);
aP(N) = aW(N) + aE(N) - Sp;
        elseif (Pe(N)>2) && (Pe(N+1)<2)
aW(N) = D(ndx-1);
aE(N) = 0;
SuB = (D(ndx)-F/2)*phiB;
Sp = -(D(ndx)-F/2);
aP(N) = aW(N) + aE(N) - Sp;
        elseif (Pe(N)<2) && (Pe(N+1)<2)
aW(N) = D(ndx-1) + F/2;
aE(N) = 0;
SuB = (D(ndx)-F/2)*phiB;
Sp = -(D(ndx)-F/2);
aP(N) = aW(N) + aE(N) - Sp;
        end

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
phi = [phiBound(1),phi,phiBound(2)];

end

