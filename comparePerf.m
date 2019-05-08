%compare
close all
%clear all
%POIdata={};
N=5;
% for k0=1:N
%     jointPos=-5-3+k0;
%     GenerateInputfile
%     MAIN
%     POIdata{k0}={left,right,groundLeg,perf};
%     
% end

lgnd1={};
lgnd2={};
colors=get(gca,'colororder');
for k0=1:N
    jointPos=-5-3+k0;
    [left,right,groundLeg,perf]=deal(POIdata{k0}{:});
    figure(1)
    color=colors(k0,:);
    plot(left(:,1),left(:,2),'Color',color);hold on
    %plot(right(:,1),right(:,2),'Color',color);
    lgnd1={lgnd1{:}, ['Jpos ',num2str(jointPos),', h_o_b_s ',num2str(perf.maxlegDiff)]};%,['k=',num2str(k0),' right']};
    
    figure(2)
    plot(t,mean(groundLeg)-groundLeg); hold on
    lgnd2={lgnd2{:}, ['Jpos ',num2str(jointPos),', dh_c_a_r_g_o ',num2str(perf.ghDiffRel),'%']};
    crossFoot=-left(:,1)+right(:,1);
%     figure(3)
%     plot(t,crossFoot); hold on;
end
figure(1)
legend(lgnd1);
title('trajectory of a foot for different joint positions')
xlabel('x [cm]');
ylabel('y [cm]');
figure(2)
legend(lgnd2);
title('y-position of cargo');
xlabel('time [s]')
ylabel('height [cm]');

