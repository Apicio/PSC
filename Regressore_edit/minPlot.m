function [times, srt] = minPlot(min)
%     t1 = 0;+1;
%     t2 =t1 +1;
%     t3 =t2 +1;
%     t4 =t3 +1;
%     t5 =t4 +1;
%     t6 =t5 +0.2;
%     t7 =t6 +1;
%     t8 =t7 +1;
%     t9 =t8 +1;
%     t10=t9 +1;
%     t11=t10+1;
%     t12=t11+1;
%     t13=t12+1;
%     t14=t13+1;
%     t15=t14+1;
%     t16=t15+1;
%     t17=t16+1;
%     t18=t17+1;
%     t19=t18+1;
%     t20=t19+1;
%     t21=t20+1;
%     t22=t21+1;
%     t23=t22+1;
%     t24=t23+1;
%     t25=t24+1;
%     t26=t25+1;
%     t27=t26+1;
%     t28=t27+1;
%     t29=t28+1;
%     t30=t29+1;
%     t31=t30+1;
%     t32=t31+1;
%     t33=t32+1;
%     t34=t33+1;
%     t35=t34+1;
%     t36=t35+1;
%     t37=t36+1;
% %     t38=t37+1;
% %     t39=t38+1;
% %     t40=t39+1;
% %     t41=t40+1;
% %     t42=t41+1;
% %     t43=t42+1;

    F = 1000; tend = size(min,2);
%     times =  [t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16,t17,t18,t19,t20,t21,t22,t23,t24,t25,t26,t27,t28,t29,t30,t31,t32,t33,t34,t35,t36,t37];%,t38];%,t39];%,t40,t41,t42,t43];
%     times = times*(tend/times(end));
    times = linspace(0,tend,size(min,2));
    srt = 1:1:size(min,2);
   
    traj = genTraj(min, srt, 6, size(min,2), times, F);
    traj = traj(:,1:end-1);
    % figure
    % plot(T,traj(1,:),'g',T,traj(2,:),'k',T,traj(3,:),'c',T,traj(4,:),T,traj(5,:),'y',T,traj(6,:),'r');
    points = zeros(3,size(traj,2));
    for i=1:size(traj,2)
          [p, ~, ~, ~] = cindir([0,0, traj(1:6,i)'], 'ZYZ');
          points(1:3,i) = p;
    end
    figure
    plot(linspace(times(1),times(end),size(traj,2)),points(3,:));
    
    points_m = zeros(3,size(min,2));
    for j=1:size(min,2)
        [p, ~, ~, ~] = cindir([0,0,min(1:6,j)'], 'ZYZ');
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

