% Height difference of the cargo

left=PosPOI(:,1:2);
right=PosPOI(:,3:4);
groundLeg=min([left(:,2),right(:,2)],[],2);
airLeg=max([left(:,2),right(:,2)],[],2);
legDiff=airLeg-groundLeg;
perf.maxGroundheightDiff=max(groundLeg)-min(groundLeg);
perf.ghDiffRel=-perf.maxGroundheightDiff/mean(groundLeg)*100;
perf.maxlegDiff=max(legDiff);
%plot(t,legDiff);


