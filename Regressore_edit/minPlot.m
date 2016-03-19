function [times, srt] = minPlot(min, F)
	% Utilizzata per la visualizzazione dei punti da interpolare con relativa interpolazione, restituisce un sorting e gli istanti temporali.
	% Interpolazione effettuata nello spazio operativo, quindi abbiamo utilizzato la cindir.
	
    tstart = 0; tend = size(min,2)*2;
    times = linspace(tstart,tend,size(min,2));
    srt = 1:1:size(min,2);
   
    traj = genTraj(min, srt, 6, size(min,2), times, F);
    points = zeros(3,size(traj,2));
    for i=1:size(traj,2)
          [p, ~, ~] = cindir([0,0, traj(1:6,i)'], 'ZYZ');
          points(1:3,i) = p;
    end
    figure
    plot(linspace(times(1),times(end),size(traj,2)),points(3,:));
    
    points_m = zeros(3,size(min,2));
    for j=1:size(min,2)
        [p, ~, ~] = cindir([0,0,min(1:6,j)'], 'ZYZ');
        points_m(:,j) = p;
        hold on
        stem(times(j),points_m(3,srt(j)),'r-o');
        text(times(j),points_m(3,srt(j)),num2str(j-1));
    end 
    title('Z');
    figure
    plot(linspace(times(1),times(end),size(traj,2)),points(1,:));
    for j=1:size(min,2)
        hold on
        stem(times(j),points_m(1,srt(j)),'r-o');
        text(times(j),points_m(1,srt(j)),num2str(j-1));
    end    
    title('X');
end

