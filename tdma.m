%% Tridiagonal matrix algorithm (TDMA):
% Created by: H.S. Sunil Simha. Version : 2.1
% Updated on March 17 2017
% 
% TDMA or the Thomas algorithm is an inversion technique for tridiagonal
% matrices which obtains the inverse in order N operations rather than
% order N^3 like Gaussian elimination. This efficiency comes due to the
% structure of the matrix and the fact that multiplications by 0 as
% performed by Gaussian elimination is uneccessary.
% 
% Given the linear equation A.x = d this function takes A and d as input
% and returns x. Here the diagonals of A are input instead of A itself.
% 
% This algorithm was adopted from the Wikipedia page by its name
% (https://en.wikipedia.org/wiki/Tridiagonal_matrix_algorithm). All
% notation used here is the same as that used there (as of 16-02-2017).
%
% see also SPARSE, DIAG

%%
function x = tdma(main,sub,super, d)
N = length(main); %Dimensionality of the input matrix
%Checks
if (N~=length(sub)+1 || N~=length(super)+1 || N~=length(d))
    error('Dimensions of the column vector are not the same as the number of columns of the matrix');
end
%%


cPrime = zeros(1,N-1); %Arrays to store certain intermediate values
dPrime = zeros(1,N);

x = zeros(1,N); %The return array

%%
% Now to write the recursion relation

    cPrime(1) = super(1)/main(1);
    dPrime(1) = d(1)/main(1);

for i = 2:N-1
   cPrime(i) = super(i)/(main(i)-sub(i-1)*cPrime(i-1));
   dPrime(i) = (d(i)-sub(i-1)*dPrime(i-1))/(main(i)-sub(i-1)*cPrime(i-1));
end
   dPrime(N) = (d(N)-sub(N-1)*dPrime(N-1))/(main(N)-sub(N-1)*cPrime(N-1));

%%
%And finally the solution
x(N) = dPrime(N);
for i = (N-1):-1:1
    x(i) = dPrime(i)-cPrime(i)*x(i+1);
end
end