%% Convergence analysis
% This script computes the error in the computed values of the temparature
% with respect to the actual values. The metric that shall be used is RMS
% norm of the normalised residuals. We shall see how the errors converge as
% a function of the number of points on the grid. We shall use the
% functions: RODTEMPERATURE, TDMA.

%% Initializing parameters
% Taking representative values for the paramters:
length = 1; % m
area = 1;   % m^2
tA = 100;   % K
tB = 500;   % K
k = 0.5;    % W/m^2/K
q = 1e6;    % W/m^3

% Now to loop over number of grid points and compute error.
error = zeros(1,100);
numbers = floor(10.^linspace(1,7,100));
for i=1:100
    N = numbers(i); %Number of grid points
    [~,temp,exact] = rodTemperature(length,area,tA,tB,k,N,q);
    residuals = (exact - temp)./exact;
    error(i) = sqrt(sum(residuals.*residuals));
end

% Now to plot the errors
h = figure;
plot(log10(numbers),log10(error),'--o','LineWidth',2, 'MarkerSize',2)
xlabel('log(number of grid points)')
ylabel('log(errors)')
title({'Errors in solving the diffusion equation';'over a uniformly spaced 1-D grid'});
%print(h,'convergence','-dpdf','-bestfit');

%%
% We shall also solve the problems from Malalasekara's textbook to serve as
% a benchmark.

%For the source free case:
[x1,temp, exact] = rodTemperature(0.5,1e-3,100,500,1e3,5,0);

g = figure;
hold on
plot(x1,temp,'--o','LineWidth',2, 'MarkerSize',2)
plot(x1,exact,':*','LineWidth',2, 'MarkerSize',2)
xlabel('Position along rod (m)')
ylabel('Temperature (K)')
title({'Malalasekara''s problem:';'Example 4.1: Source free'});
legend('Numerical Solution','Analytical Solution','Location','southeast');
%print(g,'malala1','-dpdf','-bestfit');
hold off
%For the case with constant heating

[x1,temp, exact] = rodTemperature(0.02,1,100,200,0.5,5,1e6);

j = figure;
hold on
plot(x1,temp,'--o','LineWidth',2, 'MarkerSize',2)
plot(x1,exact,':*','LineWidth',2, 'MarkerSize',2)
xlabel('Position along rod (m)')
ylabel('Temperature (K)')
title({'Malalasekara''s problem:';'Example 4.2: Uniform heating'});
legend('Numerical Solution','Analytical Solution','Location','southeast');
%print(j,'malala2','-dpdf','-bestfit');
hold off