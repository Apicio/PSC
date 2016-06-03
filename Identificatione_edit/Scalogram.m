%%%%%%%%%  Corso di Elaborazione Numerica dei Segnali      %%%%%%%%
%%%%%%%%%                 FWT - Plot dei coefficienti                 %%%%%%%%

%Plot dei coefficienti
WT=[];
progressivo=cumsum(l);
for i1=2:length(l)-1,
    %%%%Per il plot
    %Estraggo i coefficienti
    c_m=c(progressivo(i1-1)+1:progressivo(i1));
    passo=round(N/l(i1));
    for ic=1:l(i1),
        WT(i1-1,(ic-1)*passo+1:ic*passo)=c_m(ic);
    end
end


f=fh./2.^(i1-1:-1:1);

figure,surf(1:N,1:length(f),abs(WT),'EdgeColor','none');
tplot=linspace(t(1),tend,11);
set(gca,'XTick',linspace(1,2048,11))
set(gca,'XTicklabel',tplot)

set(gca,'YTick',1:length(f))
set(gca,'YTicklabel',f)
axis xy; axis tight; colormap(jet); view(0,90);
xlabel('Time');
ylabel('Frequency');
zlabel('|WT|')


figure,surf(1:N,2.^(0:L-1),abs(WT),'EdgeColor','none');

axis xy; axis tight; colormap(jet); view(0,90);
tplot=linspace(t(1),tend,11);
set(gca,'XTick',linspace(1,2048,11))
set(gca,'XTicklabel',tplot)
set(gca,'YTick',2.^(0:L-1))
set(gca,'YTicklabel',f)
xlabel('Time');
ylabel('Frequency');
zlabel('|WT|')
