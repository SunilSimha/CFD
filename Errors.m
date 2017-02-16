%% Errors in computation.
% Created by: H.S. Sunil Simha. Version : 1.0
% Updated on Feb 10 2017
% This file computes the rms 2-norm of the normalized residuals for varying values number of 
% grid points within the same domain. This exercise will be done for sin(x). The error will be defined
% as the 2-norm of the difference between the exact derivatives and the
% computed derivatives divided by the exact derivatives. The exact
% derivatives will be computed over the grid taken from the output of
% FDCALC.

% This is the maximum number of points that we shall consider in a grid 

% Initializing arrays to store errors.
%For first derivatives:
err_fo_1 = zeros(1,6);
err_ba_1 = zeros(1,6);
err_ce_1 = zeros(1,6);

%For second derivatives
err_fo_2 = zeros(1,6);
err_ba_2 = zeros(1,6);
err_ce_2 = zeros(1,6);

% Now to compute the errors.
for index = 1:6
    n = 10^index; %Number of grid points
    grid = linspace(0,2*pi,n);
    
    %First derivatives
    [dfdx_fo, grid_fo1] = FDCalc(@sin,grid,'forward',1);
    [dfdx_ba, grid_ba1] = FDCalc(@sin,grid,'backward',1);
    [dfdx_ce, grid_ce1] = FDCalc(@sin,grid,'central',1);
    
    %Second derivatives
    [d2fdx2_fo, grid_fo2] = FDCalc(@sin,grid,'forward',2);
    [d2fdx2_ba, grid_ba2] = FDCalc(@sin,grid,'backward',2);
    [d2fdx2_ce, grid_ce2] = FDCalc(@sin,grid,'central',2);
    
    %Exact functions
    dfdx_exac_fo = cos(grid_fo1);
    dfdx_exac_ba = cos(grid_ba1);
    dfdx_exac_ce = cos(grid_ce1);
    
    d2fdx2_exac_fo = -sin(grid_fo2);
    d2fdx2_exac_ba = -sin(grid_ba2);
    d2fdx2_exac_ce = -sin(grid_ce2);
    
    %Residuals:
    resid_fo_1 = (dfdx_exac_fo - dfdx_fo);
    resid_ba_1 = (dfdx_exac_ba - dfdx_ba);
    resid_ce_1 = (dfdx_exac_ce - dfdx_ce);
    
    resid_fo_2 = (d2fdx2_exac_fo - d2fdx2_fo);
    resid_ba_2 = (d2fdx2_exac_ba - d2fdx2_ba);
    resid_ce_2 = (d2fdx2_exac_ce - d2fdx2_ce);
    
    %Errors (2-Norms)
    err_fo_1(index) = sqrt(sum(resid_fo_1.*resid_fo_1));
    err_ba_1(index) = sqrt(sum(resid_ba_1.*resid_ba_1));
    err_ce_1(index) = sqrt(sum(resid_ce_1.*resid_ce_1));
    
    err_fo_2(index) = sqrt(sum(resid_fo_2.*resid_fo_2));
    err_ba_2(index) = sqrt(sum(resid_ba_2.*resid_ba_2));
    err_ce_2(index) = sqrt(sum(resid_ce_2.*resid_ce_2));
end

figure
plot(1:6,log10(err_fo_1),'--o',1:6,log10(err_ba_1),':*',1:6,log10(err_ce_1),'-+')
title('Errors in first derivative')
xlabel('Log10(number of grid points between 0 and 2pi)')
ylabel('Log10(Errors)');    
legend('forward','backward','central')

figure
plot(1:6,log10(err_fo_2),'--o',1:6,log10(err_ba_2),':*',1:6,log10(err_ce_2),'-+')
title('Errors in second derivative')
xlabel('Log10(number of grid points between 0 and 2pi)')
ylabel('Log10(Errors)');
legend('forward','backward','central')
clear;