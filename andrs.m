% ========================================================================
% function : [lam] = andrs(x)
% 
% This function returns HAC correction parameter to estimated HAC standard
% error
% This function is called from 'logts.m'
%
% OUTPUT : 1) lam : Correction parameter
%
% INPUT : 1) x : demeaned residual from estimated equation in 'logts.m'
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

function lam = andrs(x)

[t, n] = size(x);

x1 = x(1:t-1,:);
y1 = x(2:t,:);

b1 = sum(x1.*y1) ./ sum(x1.*x1);
ee = y1 - x1.*b1;

a1 = 4.*(b1.^2)./(((1-b1).^2).*((1+b1).^2));
a2 = 4.*(b1.^2)./((1-b1).^4);

band1 = 1.1447.*((a1.*t).^(1/3));
band2 = 1.3221.*((a2.*t).^(1/5));

jb2 = (1:1:t-1) ./ band2';

jband2 = jb2.*(1.2*pi);
kern1 = ((sin(jband2)./jband2 - cos(jband2))./((jb2.*pi).^2.*12)).*25;
kern1 = kern1';
lam = zeros(n,n);
jam = zeros(n,n);
tt = size(ee,1);

for j=1:1:tt-1
    ttp1 = (x(1:tt-j,:)'*x(1+j:tt,:)).*kern1(j,:)./tt;
    ttp  = (x(1:tt-j,:)'*x(1+j:tt,:))'.*kern1(j,:)./tt;
    lam = lam + ttp + ttp1;
end

sigm = (x'*x)./tt;
lam = sigm + lam;