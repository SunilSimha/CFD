% pentsolve.m
%
% Solve a pentadiagonal system Ax=b where A is a strongly nonsingular
% matrix.
% 
% If A is not a pentadiagonal matrix or singular, results will be wrong.
%
% Reference: G. Engeln-Muellges, F. Uhlig, "Numerical Algorithms with C"
%               Chapter 4. Springer-Verlag Berlin (1996)
%
% Written by Greg von Winckel 15th March 2004
% Contact: gregvw@chtm.unm.edu
% 
% Modified to minimise memory usage
% By Sunil Simha;  18th March 2017
% contact: ph13b011@smail.iitm.ac.in
% 
% Inputs: The non zero band diagonals:
%         g: sub-sub-diagonal
%         h: sub-diagonal
%         d: main diagonal
%         e: super diagonal
%         f: super-super-diagonal
%         b: RHS column vector.
% Output: The solution vector x
% All input should be in the form of column vectors. x will also be
% returned as a column vector.

%%
function x = pentsolve(g,h,d,e,f,b)

N = length(d); %Dimension of the matrix.

% Check dimensions
if length(g) ~= N-2 || length(f) ~= N-2
    error('Sub-sub or super-super diagonals aren''t of length 2 less than main diagonal.');
elseif length(h) ~=N-1 || length(e) ~= N-1
    error('Sub or super diagonals aren''t of length 1 less than main diagonal.');
end

% Initializing solution
x=zeros(N,1);
    

% Non-symmetric Matrix Scheme
% Modify bands slightly

h = [0;h];
g = [0;0;g];

alpha = zeros(N,1);
gamma = zeros(N-1,1);
delta = zeros(N-2,1);
beta = zeros(N,1);

c = zeros(N,1);

% Factor A=LR
alpha(1) = d(1);
gamma(1) = e(1)/alpha(1);
delta(1) = f(1)/alpha(1);
beta(2) = h(2);
alpha(2) = d(2)-beta(2)*gamma(1);
gamma(2) = (e(2)-beta(2)*delta(1))/alpha(2);
delta(2) = f(2)/alpha(2);

for k = 3:N-2
    beta(k) = h(k)-g(k)*gamma(k-2);
    alpha(k) = d(k)-g(k)*delta(k-2)-beta(k)*gamma(k-1);
    gamma(k) = (e(k)-beta(k)*delta(k-1))/alpha(k);
    delta(k) = f(k)/alpha(k);
end

beta(N-1) = h(N-1)-g(N-1)*gamma(N-3);
alpha(N-1) = d(N-1)-g(N-1)*delta(N-3)-beta(N-1)*gamma(N-2);
gamma(N-1) = (e(N-1)-beta(N-1)*delta(N-2))/alpha(N-1);
beta(N) = h(N)-g(N)*gamma(N-2);
alpha(N) = d(N)-g(N)*delta(N-2)-beta(N)*gamma(N-1);

% Update b = Lc
c(1) = b(1)/alpha(1);
c(2) = (b(2)-beta(2)*c(1))/alpha(2);

for k = 3:N
    c(k) = (b(k)-g(k)*c(k-2)-beta(k)*c(k-1))/alpha(k);
end


% Back substitution Rx=c
x(N)=c(N);
x(N-1)=c(N-1)-gamma(N-1)*x(N);

for k=N-2:-1:1
    x(k)=c(k)-gamma(k)*x(k+1)-delta(k)*x(k+2);    
end

end


