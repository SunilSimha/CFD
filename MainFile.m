%% Main
% Created by: H.S. Sunil Simha. Version : 1.0
% Updated on Feb 08 2017
% Main file for running the CFD code

%%
% For now I shall simply call the FDCalc function to compute the derivative
% of sin(x)
grid = linspace(0,2*pi);
[derivative, outgrid] = FDCalc(@sin,grid,'forward',1);

