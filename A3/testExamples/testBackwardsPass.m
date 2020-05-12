function [hNew,hGen] = testForwardPass
%TESTFORWARDPASS Summary of this function goes here
%   Detailed explanation goes here

q    = [1;0];
A    = [0.9, 0.1, 0.0; 0.0, 0.9, 0.1];
A_inf = [0.9, 0.1; 0.1, 0.9];

pD(1)=GaussD('Mean',0,'StDev',1);
pD(2)=GaussD('Mean',3,'StDev',2);


x    = [-0.2, 2.6, 1.3];

[pX,lp]=prob(pD,x);
mc   = MarkovChain(q, A);

h=HMM(mc,pD);
logP = logprob(h, x)
[alfaHat, c] = forward(mc, pX);

betaHat = backward(mc, pX, c);

disp("$\hat{\Beta}$ for the finite sequence is")
betaHat

end

