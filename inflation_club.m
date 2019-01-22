% ========================================================================
% Example MATLAB Code for Clustering Algorithm
%              in Transition Modelling and Convergence Test
%             by Peter C.B. Phillips and Donggyu Sul (2007)
%
%  This version: August 4 2013.
%  Originally Programmed by Donggyu Sul in GAUSS Version
%                           Reprogrammed by Hyok Jung Kim in MATLAB Version
%
% Difference from Original GAUSS Version:
%     allsort.m  1) Plots relative transition path for each clubs
%                2) Return club membership indices
%
%     sorthat.m  1) Consider the case when all the items diverge
%
%     logts.m    1) nothing changed
%
%     andrs.m    1) nothing changed
%
%  More Reference:             
%    Economic Transition and Growth: by Phillips and Sul (2007)
%    Some Empirics on Economic Growth under Heterogeneous Technology (2007)
%      by Phillips and Sul (2007), Journal of Macroeconomics 
% ========================================================================
% Special thanks go to Ekaterini Panopoulou for testing this Gauss code.

clear;
clc;

x = xlsread('lv4_base1975.xls');

iname = ['s001';'s002';'s003';'s004';'s005';'s006';'s007';'s008';'s009';
         's010';'s011';'s012';'s013';'s014';'s015';'s016';'s017';'s018';
         's019';'s020';'s021';'s022';'s023';'s024';'s025';'s026';'s027';
         's028';'s029';'s030';'s031';'s032';'s033';'s034';'s035';'s036';
         's037';'s038';'s039';'s040';'s041';'s042';'s043';'s044';'s045';
         's046';'s047';'s048';'s049';'s050';'s051';'s052';'s053';'s054';
         's055';'s056';'s057';'s058';'s059';'s061';'s062';'s063';'s064';
         's065';'s066';'s067';'s068';'s069';'s070';'s071';'s072';'s073';
         's074';'s075';'s076';'s077';'s078';'s079';'s080';'s081';'s082';
         's083';'s084';'s085';'s086';'s087';'s088';'s089';'s090';'s091';
         's092';'s093';'s094';'s095';'s096';'s097';'s098';'s099';'s100';
         's101';'s102';'s103';'s104';'s105';'s106';'s107';'s108';'s109';
         's110';'s111';'s112';'s113';'s114';'s115';'s116';'s117';'s118';
         's119';'s120';'s121';'s122';'s123';'s124';'s125';'s126';'s127';
         's128';'s129';'s130';'s131';'s132';'s133';'s134';'s135';'s136';
         's137';'s138';'s139';'s140';'s141';'s142';'s143';'s144';'s145';
         's146';'s147';'s148';'s149';'s150';'s151';'s152';'s153';'s154';
         's155';'s156';'s157';'s158';'s159';'s160';'s161';'s162';'s163';
         's164';'s165';'s166';'s167';'s168';'s169';'s170';'s171';'s172';
         's173';'s174'];
iname = cellstr(iname);

[T, N] = size(x);               % Size of the matrix 'x'

x1 = x;

%for i = 1:1:size(x,1)
%    x1(i,:) = x(i,:) ./ x(1,:); % Normalized by the initial year
%end

%x1 = x1 .* 100;                 % Change it into percentage

z = log(x1);

% Select Smoothing Parameter for Hodrick Prescott Filter
%lambda = 400;
%zz = hpfilter(z, lambda);

%zz = zz(43:T,:);        % Cut the sample to discard initial year effect
zz = z;
kq = 1;                % r-value: Usualyy set kq = int(rows(zz)/3)

record_club = allsort(zz, 0, kq, iname);