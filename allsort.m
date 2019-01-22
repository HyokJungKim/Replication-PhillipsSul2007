% ========================================================================
% function : [record_club] = allsort(yh,crit,kq,iname)
% 
% This prints output of sub club convergence tests, and
%                       club memberships.
% This function is called from 'exm.m'
%
% OUTPUT : 1) record_club : record of club memberships
%          2) Results are printed on screen)
%
% INPUT : 1) yh - Data
%         2) crit - Critical value in STEP3 of clustering algorithm
%                   usually set to zero. For more details refer to paper
%                   cited below
%         3) kq - How many data to cut. Refer to exm.m
%         4) iname - Name of the data series. Refer to exm.m
%
%  This version: August 4 2013.
%  Originally Programmed by Donggyu Sul in GAUSS Version
%  MATLAB reimplementation by Hyok Jung Kim
%
%  More Reference:             
%    Economic Transition and Growth: by Phillips and Sul (2007)
%    Some Empirics on Economic Growth under Heterogeneous Technology (2007)
%      by Phillips and Sul (2007), Journal of Macroeconomics 
% ========================================================================

function record_club = allsort(yh, crit, kq, iname)

% REQUEST USER INPUT FOR PLOTTING GRAPHS
fprintf('Wish to plot relative transition parmeters for each group?\n');
PLOT_GRAPH = input('Press N for no, Y for yes : ','s'); fprintf('\n\n');

fprintf('Wish to plot relative transition parameters altogether?\n');
PLOT_GRAPH2 = input('Press N for no, Y for yes : ','s'); fprintf('\n\n');


[~, in2, in3] = sorthat(yh, crit, kq);

max_club = 30;                      % Expected maximum number of clubs
record_club = cell(max_club,1);     % Save the club membership records

%aaa = in3;

[b1, t1] = logts(yh(:,in2),kq);

fprintf('Sub Club Convergence ===============\n');
fprintf('        b-coef     t-stats\n');
fprintf('const   %7.3f      %7.3f\n', b1(2), t1(2));
fprintf(' logt   %7.3f      %7.3f\n\n', b1(1), t1(1));

fprintf('First Convergence Club\n');
for i = 1:1:size(in2,1)
    fprintf('  %-2g ', in2(i));
end
fprintf('\n');
for i = 1:1:size(in2,1)
    fprintf('  %3s', iname{in2(i)});
end
fprintf('\n\n');

if PLOT_GRAPH == 'Y';
    hit = zeros(size(yh(:,in2)));
    for i = 1:1:size(hit,1)
        hit(i,:) = yh(i,in2) ./ mean(yh(i,in2),2);
    end
    figure(1)
        plot(hit)
        legend(iname{in2})
        title(sprintf('Hit of Convercenge Club %g', 1));
end

[b1, t1] = logts(yh(:,in3),kq);

fprintf('Check if the rest group forms the other convergent club\n');
fprintf('        b-coef     t-stats\n');
fprintf('const   %7.3f      %7.3f\n', b1(2), t1(2));
fprintf(' logt   %7.3f      %7.3f\n\n', b1(1), t1(1));

record_club{1,1} = in2;

ic1 = 2;
nine = in3;
while t1(1) <= -1.65
    fprintf('Since t-stat < -1.65, repeat clustering procedures\n');
    
    restg = yh(:,nine);
    yh2 = restg;
    
    [f_value, inn2, inn3] = sorthat(yh2, crit, kq);
    
    if f_value == 1
    [b1, t1] = logts(yh(:,nine(inn2)),kq);
    
    fprintf('=====================================\n');    
    fprintf('%g convergent club test, \n', ic1);
    fprintf('        b-coef     t-stats\n');
    fprintf('const   %7.3f      %7.3f\n', b1(2), t1(2));
    fprintf(' logt   %7.3f      %7.3f\n\n', b1(1), t1(1));
    
    fprintf('Club %g : \n', ic1);
    for i = 1:1:size(inn2,1)
        fprintf('  %-2g ', nine(inn2(i)));
    end
    fprintf('\n');
    for i = 1:1:size(inn2,1)
        fprintf('  %3s', iname{nine(inn2(i))});
    end
    fprintf('\n\n');
     
    record_club{ic1,1} = nine(inn2);

    if PLOT_GRAPH == 'Y';
        hit = zeros(size(yh(:,inn2)));
        for i = 1:1:size(hit,1)
            hit(i,:) = yh(i,nine(inn2)) ./ mean(yh(i,nine(inn2)),2);
        end
        figure(ic1)
            plot(hit)
            legend(iname{nine(inn2)})
            title(sprintf('Hit of Convercenge Club %g', ic1));    
    end

    ic1 = ic1 + 1;
    
    [b1, t1] = logts(yh(:,nine(inn3)),kq);
    
    fprintf('Check if the rest group forms the other convergent club\n');
    fprintf('        b-coef     t-stats\n');
    fprintf('const   %7.3f      %7.3f\n', b1(2), t1(2));
    fprintf(' logt   %7.3f      %7.3f\n\n', b1(1), t1(1));
    
    nine = nine(inn3);
    
    else
        
    fprintf('Remaining items do not form a convergence club!!!\n');
    fprintf('Remaining Items : \n');
    for i = 1:1:size(inn3,1)
        fprintf('  %-2g ', nine(inn3(i)));
    end
    fprintf('\n');
    for i = 1:1:size(inn3,1)
        fprintf('  %3s', iname{nine(inn3(i))});
    end
    fprintf('\n\n');
    
    
    record_club2 = cell(ic1-1,1);
    for i = 1:1:ic1-1
        record_club2{i,1} = record_club{i,1};
    end
    record_club = record_club2;
    
    if PLOT_GRAPH == 'Y'
        hit = zeros(size(yh(:,inn3)));
        for i = 1:1:size(hit,1)
            hit(i,:) = yh(i,nine(inn3)) ./ mean(yh(i,nine(inn3)),2);
        end
        figure(ic1)
            plot(hit)
            legend(iname{nine(inn3)})
            title(sprintf('Hit of Remaining Diverging Club'));
    end
    
    if PLOT_GRAPH2 == 'Y'
        PLOT2_hit(yh, record_club);
    end
    return
    end
end

record_club{ic1,1} = nine;

fprintf('Since t-stat > -1.65, the rest forms a convergent club\n');
for i = 1:1:size(nine,1)
    fprintf('  %-2g ', nine(i));
end
fprintf('\n');
for i = 1:1:size(inn3,1)
    fprintf('  %3s', iname{nine(i)});
end
fprintf('\n');

record_club2 = cell(ic1,1);
for i = 1:1:ic1
    record_club2{i,1} = record_club{i,1};
end
    record_club = record_club2;

if PLOT_GRAPH == 'Y';
    hit = zeros(size(yh(:,nine)));
    for i = 1:1:size(hit,1)
        hit(i,:) = yh(i,nine) ./ mean(yh(i,nine),2);
    end
        figure(ic1)
            plot(hit)
            legend(iname{nine})
            title(sprintf('Hit of Convercenge Club %g', ic1+1));
end

if PLOT_GRAPH2 == 'Y';
   PLOT2_hit(yh, record_club);
end