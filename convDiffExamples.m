%% Comparing against Malalasekara's solved examples
% This script computes the solutions of the convection diffusion equation
% for the same conditions as that in Malalasekara's textbook's solved
% examples in chapter 5. The solutions are stored in variables by the name
% "ex_<Problem number>". Note that these solutions also report the value of
% the quntity at the boundaries. So this will contain two points more than
% the ones reported in the textbook.
% 
% Please us the "PUBLISH" button in the publish tab to display this.

% Boundary values:
phiBound = [1,0];

%% Example 5.1: Central difference method
% a) Solution for u = 0.1 m/s
u = 0.1; % F = rho*u
gamma = 0.1;
x = [0,0.1,0.3,0.5,0.7,0.9,1]; %Nodes including boundary
[ex5_1a, exact5_1a] = convectionDiffusion(x,phiBound, u, 1, gamma, 'cd'); %Solution

plot(x,ex5_1a,'--','LineWidth',2);
hold on
plot(x,exact5_1a,':','LineWidth',2);
hold off
xlabel('x');
ylabel('Phi');
title('Example 5.1-a');
legend('Central difference solution','Analytical  solution','Location','best');
%%
% b) For u = 2.5 m/s
u = 2.5;
[ex5_1b, exact5_1b] = convectionDiffusion(x,phiBound, u, 1, gamma, 'cd');
plot(x,ex5_1b,'--','LineWidth',2);
hold on
plot(x,exact5_1b,':','LineWidth',2);
hold off
xlabel('x');
ylabel('Phi');
title('Example 5.1-b');
legend('Central difference solution','Analytical  solution','Location','best');
%%
% c) Solution for u = 2.5 m/s but with 20 nodes
N = 20; %Number of nodes
dx = 1/N;
x = linspace(dx,1-dx,N); %Grid
x = cat(2,0,x,1);
[ex5_1c, exact5_1c] = convectionDiffusion(x,phiBound, u, 1, gamma, 'cd');
plot(x,ex5_1c,'--','LineWidth',2);
hold on
plot(x,exact5_1c,':','LineWidth',2);
hold off
xlabel('x');
ylabel('Phi');
title('Example 5.1-c');
legend('Central difference solution','Analytical  solution','Location','best');
%% Example 5.2: Pure Upwind
% a) u = 0.1 m/s
u = 0.1;
[ex5_2a, exact5_2a] = convectionDiffusion(x,phiBound, u, 1, gamma, 'pu');
plot(x,ex5_2a,'--','LineWidth',2);
hold on
plot(x,exact5_2a,':','LineWidth',2);
hold off
xlabel('x');
ylabel('Phi');
title('Example 5.2-a');
legend('Pure upwind solution','Analytical  solution','Location','best');
%%
% b) u = 2.5 m/s
u = 2.5;
[ex5_2b, exact5_2b] = convectionDiffusion(x,phiBound, u, 1, gamma, 'pu');

plot(x,ex5_2b,'--','LineWidth',2);
hold on
plot(x,exact5_2b,':','LineWidth',2);
hold off
xlabel('x');
ylabel('Phi');
title('Example 5.2-b');
legend('Pure upwind solution','Analytical  solution','Location','best');
%% Example 5.3: Hybrid scheme
% Comparing the solution for u = 2.5 for five and twenty five nodes
u = 2.5;
x1 = [0,0.1,0.3,0.5,0.7,0.9,1];
N = 20; %Number of nodes
dx = 1/N;
x2 = linspace(dx,1-dx,N); %Grid
x2 = cat(2,0,x2,1);
[ex5_3a, ~] = convectionDiffusion(x1,phiBound, u, 1, gamma, 'hy');
[ex5_3b, exact5_3b] = convectionDiffusion(x2,phiBound, u, 1, gamma, 'hy');
plot(x1,ex5_3a,'--','LineWidth',2);
hold on
plot(x2,ex5_3b,':','LineWidth',2);
plot(x2,exact5_3b,':','LineWidth',2);
hold off
xlabel('x');
ylabel('Phi');
title('Example 5.3');
legend('5 Nodes','Analytical  solution','25 nodes','Location','best');
%% Example 5.4: QUICK scheme
% u = 0.2 m/s
x = [0,0.1,0.3,0.5,0.7,0.9,1];
u = 0.2;
[ex5_4, exact5_4] = convectionDiffusion(x,phiBound, u, 1, gamma, 'qu');
plot(x,ex5_4,'--','LineWidth',2);
hold on
plot(x,exact5_4,':','LineWidth',2);
hold off
xlabel('x');
ylabel('Phi');
title('Example 5.4');
legend('QUICK solution','Analytical  solution','Location','best');
