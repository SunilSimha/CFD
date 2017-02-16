%% Tridiagonal matrix algorithm (TDMA):
% Created by: H.S. Sunil Simha. Version : 1.0
% Updated on Feb 16 2017
% 
% TDMA or the Thomas algorithm is an inversion technique for tridiagonal
% matrices which obtains the inverse in order N operations rather than
% order N^3 like Gaussian elimination. This efficiency comes due to the
% structure of the matrix and the fact that multiplications by 0 as
% performed by Gaussian elimination is uneccessary.
% 
% Given the linear equation A.x = d this function takes A and d as input
% and returns x. Here A is input as a SPARSE matrix to save storage.
% 
% This algorithm was adopted from the Wikipedia page by its name
% (https://en.wikipedia.org/wiki/Tridiagonal_matrix_algorithm). All
% notation used here is the same as that used there (as of 16-02-2017).
%
% see also SPARSE, DIAG

function x = tdma(sparseMatrix, d)
%Checks
if (length(d)~=length(sparseMatrix))
    error('Dimensions of the colun vector are not the same as the number of columns of the matrix');
end
%First to extract the diagonals. This can be done using the DIAG function.
c = diag(sparseMatrix,1); %super diagonal
b = diag(sparseMatrix); %diagonal
a = diag(sparseMatrix,-1); %sub-diagonal

N = length(sparseMatrix); %Dimensionality of the input matrix

cPrime = zeros(1,N-1); %Arrays to store certain intermediate values
dPrime = zeros(1,N);

x = zeros(1,N); %The return array

% Now to write the recursion relation
%--------------------------------------------------------------------------
    cPrime(1) = c(1)/b(1);
    dPrime(1) = d(1)/b(1);

for i = 2:N-1
   cPrime(i) = c(i)/(b(i)-a(i-1)*cPrime(i-1));
   dPrime(i) = (d(i)-a(i-1)*dPrime(i-1))/(b(i)-a(i-1)*cPrime(i-1));
end
   dPrime(N) = (d(N)-a(N-1)*dPrime(N-1))/(b(N)-a(N-1)*cPrime(N-1));
%--------------------------------------------------------------------------
%And finally the solution
x(N) = dPrime(N);
for i = (N-1):-1:1
    x(i) = dPrime(i)-cPrime(i)*x(i+1);
end
end