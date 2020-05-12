function [hNew,hGen]=testGMM3%test training a single GaussMixD object%Arne Leijon 2009-07-21 testedc='rbgk';%state color coding, max 4 statesc='rrrr';%state color coding, max 4 states%make a fairly tricky Gaussmix distribution%Here the VQ initialization finds the wrong clusters!pDgen(1)=GaussD('Mean',[+3 0],'StDev',[1 3]);pDgen(2)=GaussD('Mean',[0 -3],'StDev',[3 1]);pDgen(3)=GaussD('Mean',[0 +3],'StDev',[3 1]);%make a well separated Gaussmix distribution% pDgen(1)=GaussD('Mean',[-7 0],'StDev',[1 3]);% pDgen(2)=GaussD('Mean',[+7 0],'StDev',[1 3]);% pDgen(3)=GaussD('Mean',[0 -7],'StDev',[3 1]);% pDgen(4)=GaussD('Mean',[0 +7],'StDev',[3 1]);%hGen=GaussMixD(pDgen,[1 1 1 ]);%generating GMM, NOT USED%Make 3 separate training data sequences:xTraining1=rand(pDgen(1),3000);%training dataxTraining2=rand(pDgen(2),3000);%training dataxTraining3=rand(pDgen(3),3000);%training datafigure;plotTraining(xTraining1,ones(1,size(xTraining1,2)),c);%only scatter plothold on;plotTraining(xTraining2,ones(1,size(xTraining2,2)),c);%only scatter plotplotTraining(xTraining3,ones(1,size(xTraining3,2)),c);%only scatter plotaxis([-10 10 -10 10]);hold off;%hNew=GaussMixD([GaussD([-0.3 0],[1 1]),GaussD([0.3 0],[1 1]),GaussD([0 -0.3],[1 1]),GaussD([0 0.3],[1 1])]);% g=repmat(GaussD,4,1);% g=init(g,xTraining);% hNew=GaussMixD(g);hNew=init(GaussMixD(3),xTraining1);%init with only first data setfor nTraining=1:10%iterations    figure;    plotTraining(xTraining1,ones(1,size(xTraining1,2)),c);%only scatter plot    hold on;    plotTraining(xTraining2,ones(1,size(xTraining2,2)),c);%only scatter plot    plotTraining(xTraining3,ones(1,size(xTraining3,2)),c);%only scatter plot    plotCross(hNew.Gaussians,[1 2],'k'); 	axis([-10 10 -10 10]);	hold off;    %one training step:    aS=adaptStart(hNew);        aS=adaptAccum(hNew,aS,xTraining1);%separate training data sets        aS=adaptAccum(hNew,aS,xTraining2);%separate training data sets        aS=adaptAccum(hNew,aS,xTraining3);%separate training data sets    hNew=adaptSet(hNew,aS);end;function plotTraining(xT,sT,c)nStates=max(sT);for s=1:nStates    plot(xT(1,sT==s),xT(2,sT==s),['o',c(s)],'MarkerSize',1.5);    hold on;end;