% ========================================================================
% Example MATLAB Code for Clustering Algorithm
%              in Transition Modelling and Convergence Test
%             by Peter C.B. Phillips and Donggyu Sul (2007)
%
%  This version: August 4 2013.
%  Originally Programmed by Donggyu Sul in GAUSS Version
%                           Reprogrammed by Hyok Jung Kim in MATLAB Version
%
%  More Reference:             
%    Economic Transition and Growth: by Phillips and Sul (2007)
%    Some Empirics on Economic Growth under Heterogeneous Technology (2007)
%      by Phillips and Sul (2007), Journal of Macroeconomics 
% ========================================================================
% Special thanks go to Ekaterini Panopoulou for testing this Gauss code.

clear;
clc;

x = xlsread('citi.xls');

iname = ['NYC'; 'PHI'; 'BOS'; 'CLE'; 'CHI'; 'DET'; 'WDC'; 'BAL'; 'HOU';
          'LAX'; 'SF0'; 'SEA'; 'POR'; 'CIN'; 'ATL'; 'PIT'; 'STL'; 'MIN';
          'KCM'];
iname = cellstr(iname);

[T, N] = size(x);               % Size of the matrix 'x'

x1 = zeros(size(x));

for i = 1:1:size(x,1)
    x1(i,:) = x(i,:) ./ x(1,:); % Normalized by the initial year
end

x1 = x1 .* 100;                 % Change it into percentage

z = log(x1);

% Select Smoothing Parameter for Hodrick Prescott Filter
lambda = 400;
zz = hpfilter(z, lambda);

zz = zz(43:T,:);        % Cut the sample to discard initial year effect
kq = 25;                % r-value: Usualyy set kq = int(rows(zz)/3)

record_club = allsort(zz, 0, kq, iname);