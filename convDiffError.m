%% Error analysis
% We shall compute the RMS two norm of the normalised error for specific
% cases of initial conditions for different schemes and see how the error
% evolves as a function of the number of points on the grid.
% 
% Here we shall use four conditions of flow velocity: u = +-0.1 and +-2.5
% m/s, rho = 1 and gamma = 0.1. Essentially, we are considering different regimes of
% peclet numbers: small and large, positive and negative. Thus the scheme will 
% be tested for convergence and accuracy by varying the number of grid points. 
% The two signs are to compare how each scheme behaves under different flow 
% directions. The boundary values of phi will be 2 and 1. 

% Constants
gamma = 0.1;
rho = 1;
phiBound = [2,1];
u = [-2.5,-0.1,0.1,2.5];

%% Central scheme

method = 'cd'; %Central difference
[numbers,error1,error2,error3,error4]=computeErrors(x,phiBound,u,rho,gamma,method); %Function definition at the end of the script

% Now to plot the errors
h = figure;
hold on
plot(log10(numbers),log10(error1),'--','LineWidth',2)
plot(log10(numbers),log10(error2),':','LineWidth',2)
plot(log10(numbers),log10(error3),'-','LineWidth',2)
plot(log10(numbers),log10(error4),'-.','LineWidth',2)
hold off
xlabel('log(number of grid points)')
ylabel('log(errors)')
title({'Errors in solving the convection diffusion equation';
    '(Central difference scheme)';'over a uniformly spaced 1-D grid'});
legend('u = -2.5','u = -0.1', 'u = 0.1', 'u = 2.5','Location','best');
%print(h,'errorCD','-dpdf','-bestfit');
%% Pure Upwind

method = 'pu';
[numbers,error1,error2,error3,error4]=computeErrors(x,phiBound,u,rho,gamma,method);

% Now to plot the errors
g = figure;
hold on
plot(log10(numbers),log10(error1),'--','LineWidth',2)
plot(log10(numbers),log10(error2),':','LineWidth',2)
plot(log10(numbers),log10(error3),'-','LineWidth',2)
plot(log10(numbers),log10(error4),'-.','LineWidth',2)
hold off
xlabel('log(number of grid points)')
ylabel('log(errors)')
title({'Errors in solving the convection diffusion equation';
    '(Pure upwind scheme)';'over a uniformly spaced 1-D grid'});
legend('u = -2.5','u = -0.1', 'u = 0.1', 'u = 2.5','Location','best');
print(g,'errorPU','-dpdf','-bestfit');

%% Hybrid
method = 'hy';
[numbers,error1,error2,error3,error4]=computeErrors(x,phiBound,u,rho,gamma,method);

% Now to plot the errors
a = figure;
hold on
plot(log10(numbers),log10(error1),'--','LineWidth',2)
plot(log10(numbers),log10(error2),':','LineWidth',2)
plot(log10(numbers),log10(error3),'-','LineWidth',2)
plot(log10(numbers),log10(error4),'-.','LineWidth',2)
hold off
xlabel('log(number of grid points)')
ylabel('log(errors)')
title({'Errors in solving the convection diffusion equation';
    '(Hybrid scheme)';'over a uniformly spaced 1-D grid'});
legend('u = -2.5','u = -0.1', 'u = 0.1', 'u = 2.5','Location','best');
print(a,'errorHY','-dpdf','-bestfit');

%% Power Law

method = 'pl';
[numbers,error1,error2,error3,error4]=computeErrors(x,phiBound,u,rho,gamma,method);

% Now to plot the errors
c = figure;
hold on
plot(log10(numbers),log10(error1),'--','LineWidth',2)
plot(log10(numbers),log10(error2),':','LineWidth',2)
plot(log10(numbers),log10(error3),'-','LineWidth',2)
plot(log10(numbers),log10(error4),'-.','LineWidth',2)
hold off
xlabel('log(number of grid points)')
ylabel('log(errors)')
title({'Errors in solving the convection diffusion equation';
    '(Power Law scheme)';'over a uniformly spaced 1-D grid'});
legend('u = -2.5','u = -0.1', 'u = 0.1', 'u = 2.5','Location','best');
print(c,'errorPL','-dpdf','-bestfit');
%% QUICK scheme
% This is a higher order scheme in the sense that it is similar to central 
% differencing but the interpolation is quadratic. Being similar in nature, it 
% is logical to test the QUICK scheme under the same conditions as the central 
% scheme

method = 'qu';
[numbers,error1,error2,error3,error4]=computeErrors(x,phiBound,u,rho,gamma,method);

% Now to plot the errors
h = figure;
hold on
plot(log10(numbers),log10(error1),'--','LineWidth',2)
plot(log10(numbers),log10(error2),':','LineWidth',2)
plot(log10(numbers),log10(error3),'-','LineWidth',2)
plot(log10(numbers),log10(error4),'-.','LineWidth',2)
hold off
xlabel('log(number of grid points)')
ylabel('log(errors)')
title({'Errors in solving the convection diffusion equation';
    '(QUICK scheme)';'over a uniformly spaced 1-D grid'});
legend('u = -2.5','u = -0.1', 'u = 0.1', 'u = 2.5','Location','best');
print(h,'errorQU','-dpdf','-bestfit');

%% COMPUTEERRORS
function [numbers,error1,error2,error3,error4] = computeErrors(x,phiBound,u,rho,gamma,method)
%Looping over grid points and computing error
error1 = zeros(1,100); %For -2.5
error2 = error1; %-0.1
error3 = error1; %0.1
error4 = error1; %2.5
numbers = floor(10.^linspace(1,7,100));

for i=1:100
    N = numbers(i); %Number of grid points
    
    %Defining the grid
    dx = 1/N;
    x = linspace(dx,1-dx,N);
    x = cat(2,0,x,1);
    
    %Computing the solutions
    [phi1,exact1] = convectionDiffusion(x,phiBound,u(1),rho,gamma,method);
    [phi2,exact2] = convectionDiffusion(x,phiBound,u(2),rho,gamma,method);
    [phi3,exact3] = convectionDiffusion(x,phiBound,u(3),rho,gamma,method);
    [phi4,exact4] = convectionDiffusion(x,phiBound,u(4),rho,gamma,method);
    
    %Normalised residuals
    residuals1 = (exact1 - phi1)./exact1;
    residuals2 = (exact2 - phi2)./exact2;
    residuals3 = (exact3 - phi3)./exact3;
    residuals4 = (exact4 - phi4)./exact4;
    
    %Errors
    error1(i) = sqrt(sum(residuals1.*residuals1));
    error2(i) = sqrt(sum(residuals2.*residuals2));
    error3(i) = sqrt(sum(residuals3.*residuals3));
    error4(i) = sqrt(sum(residuals4.*residuals4));
end
end