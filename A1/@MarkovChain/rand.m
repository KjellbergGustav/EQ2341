function S=rand(mc,T)
%S=rand(mc,T) returns a random state sequence from given MarkovChain object.
%
%Input:
%mc=    a single MarkovChain object
%T= scalar defining maximum length of desired state sequence.
%   An infinite-duration MarkovChain always generates sequence of length=T
%   A finite-duration MarkovChain may return shorter sequence,
%   if END state was reached before T samples.
%
%Result:
%S= integer row vector with random state sequence,
%   NOT INCLUDING the END state,
%   even if encountered within T samples
%If mc has INFINITE duration,
%   length(S) == T
%If mc has FINITE duration,
%   length(S) <= T
%
%---------------------------------------------
%Code Authors: Gustav Kjellberg
%---------------------------------------------

% Stop at S(T) if finite!!!

S=zeros(1,T);%space for resulting row vector
nS=mc.nStates;

endState = nS+1;
stateProbVec = mc.InitialProb;
A = transpose(mc.TransitionProb);

for t = 1:T
    stateProbVec = A*stateProbVec;
    [row, col] = size(stateProbVec);
    randomState = randsample(row,1,true,stateProbVec);
    if randomState == endState
        S(t:end) = [];
        return 
    end
    if size(stateProbVec) ~= nS
        stateProbVec(end) = [];
    end
    S(t) = randomState;

end


%error('Method not yet implemented');
%continue code from here, and erase the error message........


