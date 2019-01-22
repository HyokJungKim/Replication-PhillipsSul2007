% ========================================================================
% function : [f_signal,conv_index,comp_index] = sorthat(yh,ccc,kq)
% 
% This function returns indices for club membership, and signal of
% convergence
% This function is called from 'allsort.m'
%
% OUTPUT : 1) f_signal : When all of the items diverge, return 0
%                        otherwise, 1
%          2) conv_index : Items forming convergence club
%          3) comp_index : Complement of 2)
%
% INPUT : 1) yh - Data
%         2) ccc - Critical value in STEP3 of clustering algorithm
%                   usually set to zero. For more details refer to paper
%                   cited below
%         3) kq - How many data to cut. Refer to exm.m
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

function [f_signal, conv_index, comp_index] = sorthat(yh, ccc, kq)

[~, t1] = logts(yh,kq);         % Computing t-value for the whole sample

[t,n] = size(yh);               % Size of matrix yh

%%%%%%%%%%%%%%%%%%%% STEP 1 : Last Observation Ordering %%%%%%%%%%%%%%%%%%%
kk = [yh(t,:)', (1:1:n)'];      % Extract last row

kk = sortrows(kk,1);            % Arrange from minimum to maximum value

kk = kk(n:-1:1,:);              % Reverse order

kin = kk(:,2);                  % Extract the orderings

yhh = yh(:,kin');               % Construct re-ordered vector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%% STEP 2 : CORE GROUP FORMATION %%%%%%%%%%%%%%%%%%%%%
% Find the Initial Item (Exclude Diverging Item Above)
if t1(1) > -1.65                   % When all items converge
    ik1 = 1;
else                            % When all items do not converge
    ik1 = 0;
    while t1(1) < -1.65         % When t > -1.65 then stop!
        if ik1+2 > size(yhh,2)   % When all of items diverge (this happens)
            f_signal = 0;                    % Signal of divergence
            conv_index = [];                 % Converging matrix : NULL
            comp_index = (1:1:size(yhh,2))';    % Diverging matrix  : ALL
            return
        else                    % When items do not diverge (normal case)
            ik1 = ik1+1;
            ww = yhh(:,ik1:ik1+1);
            [~,t1] = logts(ww,kq);
        end
    end
end

% Find Core Group from the Initial Item
t1_vec = zeros(size(yhh,2)-ik1,2); % Preallocate vector storing t-values
i = 1;
[~,t1_vec(i,:)] = logts(yhh(:,ik1:ik1+i),kq);
while t1_vec(i,1) > -1.65          % When t < -1.65 then stop!
    i = i+1;
    [~,t1_vec(i,:)] = logts(yhh(:,ik1:ik1+i),kq);
end

t1_vec = t1_vec(t1_vec(:,1) ~= 0);    % Drop zeros that are not computed

[~, core_index] = max(t1_vec);   % Select index that maximizes t-value

yhh_core = yhh(:,ik1:ik1+core_index);  % Core of the group
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%% STEP 3 : SIEVE INDIVIDUALS for CLUB MEMBERSHIP %%%%%%%%%%%%%

% Convergent subgroup candidates
yhh_candidates = yhh(:,ik1+core_index+1:end);

% Preallocate vector
t1_vec = zeros(size(yhh_candidates,2),2);

for i = 1:1:size(yhh_candidates,2)
    % stack candidates one by one at each iteration
    [~,t1_vec(i,:)] = logts([yhh_core, yhh_candidates(:,i)], kq);
end

t1_vec_index = find(t1_vec(:,1) > ccc);   % indices satisfying criterion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

conv_index2 = [ik1:ik1+core_index, t1_vec_index'+core_index+ik1]';
conv_index = kin(conv_index2);

% comp_index : remaining items
comp_index = (1:1:n)';
for i = 1:1:size(conv_index,1)
    comp_index = comp_index(comp_index ~= conv_index(i));
end

comp_index = sortrows(comp_index,1);
conv_index = sortrows(conv_index,1);
f_signal = 1;
