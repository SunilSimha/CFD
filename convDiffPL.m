function phi = convDiffPL(x, phiBound, F, gamma)
          
N = length(x) - 2;
phiA = phiBound(1);
phiB = phiBound(2);
dx = diff(x);
ndx = length(dx);
D = gamma./dx;
Pe = F./D;

mainD = zeros(1,N);
subD = zeros(1,N-1);
superD = zeros(1,N-1);
RHSmat = zeros(1,N);
aW = zeros(1,N);
aE = zeros(1,N);
aP = zeros(1,N);

%For intermediate nodes aPtP = aWtW + aEtE
for i=2:1:(N-1)
    Pew = abs(Pe(i));
    Pee = abs(Pe(i+1));
aW(i) = D(i)*max(0,((1-(0.1*Pew))^5))+max(F,0);
aE(i) = D(i+1)*max(0,((1-(0.1*Pee))^5))+max(-F,0);
aP(i) = aE(i) + aW(i);
end

%For node 1 the descretised equation is a1t1 = aWWtWW + aELtE + Su
Pe1 = abs(Pe(1));
Pe2 = abs(Pe(2));
aW(1) = 0;
aE(1) = D(2)*max(0,((1-(0.1*Pe2))^5))+max(-F,0);
SuA = (D(1)*max(0,((1-(0.1*Pe1))^5))+max(F,0))*phiA;
Sp = -(D(1)*max(0,((1-(0.1*Pe1))^5))+max(F,0));
aP(1) = aW(1) + aE(1) - Sp;

%For node N the descretised equation is aNtN = aWRtW + aEEtEE + Su
PeN = abs(Pe(N));
PeN1 = abs(Pe(N+1));
aW(N) = D(ndx-1)*max(0,((1-(0.1*PeN))^5))+max(F,0);
aE(N) = 0;
SuB = (D(ndx)*max(0,((1-(0.1*PeN1))^5))+max(-F,0))*phiB;
Sp = -(D(ndx)*max(0,((1-(0.1*PeN1))^5))+max(-F,0));
aP(N) = aW(N) + aE(N) - Sp;

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
phi = [phiBound(1), phi, phiBound(2)];
    
end

