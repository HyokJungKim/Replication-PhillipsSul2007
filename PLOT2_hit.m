function PLOT2_hit(yh, record_club)

hit = zeros(size(yh));

for i = 1:1:size(hit,1)
    hit(i,:) = yh(i,:) ./ mean(yh(i,:),2);
end

N = size(record_club,1);

for i = 1:1:N
    figure(N+i)
        plot(hit, 'Color',[0.4, 0.4, 0.4]);
    hold on
        plot(hit(:,record_club{i}),'Color','red', 'LineWidth', 1.15);
        title(sprintf('Hit of Convercenge Club %g', i));
    hold off
end