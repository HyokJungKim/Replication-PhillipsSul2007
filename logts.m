% ========================================================================
% function : [b, re] = logts(hht, p)
% 
% This estimates equation (33) in the original paper
% This function is called from 'sorthat.m' and 'allsort.m'
%
% OUTPUT : 1) b : estimated coefficients (2 by 1 vector)
%          2) re : estimated t-value (2 by 1 vector)
%
% INPUT : 1) hht - Data
%         2) p - How many data to cut. Refer to exm.m
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
function [b, re] = logts(hht, p)

t = size(hht,1);

% Making h_it (Relative Transition Parameter)
hit = zeros(size(hht));
for i = 1:1:size(hht,1)
    hit(i,:) = hht(i,:) ./ mean(hht(i,:),2);
end

% Making variance, Ht, of h_it
Ht = mean((hit - 1).^2, 2);

% lhht : Log of H(1) / H(t)
lhht = log(Ht(1) ./ Ht);

% Dependent Variable
%   - NOTE : This might be assuming L(t) = log t, not log t+1 ???????
rht = lhht(p+1:t) - 2*log(log(p+1:t))';

% Explanatory Variable
xx = [ log(p+1:t)', ones(t-p,1) ];

% OLS Estimate
b = (xx'*xx)^(-1)*xx'*rht;

re = rht - xx*b;
re = re - mean(re);
re = andrs(re);
re = diag((xx'*xx)^(-1)).*re;
b_se = sqrt(re);

re = b ./ b_se;