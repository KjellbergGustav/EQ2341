function R=rand(pD,nData)
%R=rand(pD,nData) returns random scalars drawn from given Discrete Distribution.
%
%Input:
%pD=    DiscreteD object
%nData= scalar defining number of wanted random data elements
%
%Result:
%R= row vector with integer random data drawn from the DiscreteD object pD
%   (size(R)= [1, nData]
%
%----------------------------------------------------
%Code Authors: Gustav Kjellberg
%----------------------------------------------------

if numel(pD)>1
    error('Method works only for a single DiscreteD object');
end;



%*** Insert your own code here and remove the following error message 
% y = pD.ProbMass(:).'/sum(pD.ProbMass(:))
% x = cumsum([0 y]);
% x(end) = 1e3*eps + x(end);
% 
% c = histc(rand(1,nData), x);
% ce = c(end);
% c = c(1:end-1);
% c(end) = c(end) + ce;
% % extract samples
% xv = find(c);
% if numel(xv) == nData  % each value is sampled at most once
%     R = xv;
% else                % some values are sampled more than once
%     xc = c(xv);
%     d = zeros(1, nData);
%     dv = [xv(1), diff(xv)];
%     dp = [1, 1 + cumsum(xc(1:end-1))];
%     d(dp) = dv;
%     R = cumsum(d);
% end

[states, ~] = (size(pD.ProbMass));
v = linspace(1,states, states);
R = randsample(v, nData, true, pD.ProbMass);

%test = find(a)
%R = pD.pMass(a);

%%error('Not yet implemented');
