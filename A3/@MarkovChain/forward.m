function [alfaHat, c]=forward(mc,pX)%[alfaHat, c]=forward(mc,pX)%calculates state and observation probabilities for one single data sequence,%using the forward algorithm, for a given single MarkovChain object,%to be used when the MarkovChain is included in a HMM object.%%Input:%mc= single MarkovChain object%pX= matrix with state-conditional likelihood values,%   without considering the Markov depencence between sequence samples.%	pX(j,t)= myScale(t)* P( X(t)= observed x(t) | S(t)= j ); j=1..N; t=1..T%	(must be pre-calculated externally)%NOTE: pX may be arbitrarily scaled, as defined externally,%   i.e., pX may not be a properly normalized probability density or mass.%%NOTE: If the HMM has Finite Duration, it is assumed to have reached the end%after the last data element in the given sequence, i.e. S(T+1)=END=N+1.%%Result:%alfaHat=matrix with normalized state probabilities, given the observations:%	alfaHat(j,t)=P[S(t)=j|x(1)...x(t), HMM]; t=1..T%c=row vector with observation probabilities, given the HMM:%	c(t)=P[x(t) | x(1)...x(t-1),HMM]; t=1..T%	c(1)*c(2)*..c(t)=P[x(1)..x(t)| HMM]%   If the HMM has Finite Duration, the last element includes%   the probability that the HMM ended at exactly the given sequence length, i.e.%   c(T+1)= P( S(T+1)=N+1| x(1)...x(T-1), x(T)  )%Thus, for an infinite-duration HMM:%   length(c)=T%   prod(c)=P( x(1)..x(T) )%and, for a finite-duration HMM:%   length(c)=T+1%   prod(c)= P( x(1)..x(T), S(T+1)=END )%%NOTE: IF pX was scaled externally, the values in c are %   correspondingly scaled versions of the true probabilities.%%--------------------------------------------------------%Code Authors: Gustav Kjellberg%--------------------------------------------------------T=size(pX,2);%Number of observationsA = mc.TransitionProb; % The transition probabilityB = pX; % state conditional liklihood valuesn_states = mc.nStates; % The number of states (from mc: The sequence generation stops at S(T), if S(T+1)=(nStates+1))q = mc.InitialProb;%-------------------- continue code from here, and delete error message% INIT t = 1% eq. (5.42)t = 1;a_temp = q.*B(:,t);% eq (5.43)c = sum(a_temp);% eq. (5.44)alfaHat = a_temp/c;% For   ward pass t = 2.. Tfor t = 2:T    % eq (5.50)    % the sum prod of the matricies can be calculated with the dot-prod        a_temp = B(:,t).*transpose(transpose(alfaHat(:,t-1))*A(:,1:n_states));    % eq (5.51)    c_temp = sum(a_temp);    c = [c, c_temp];    % eq (5.52)    alfaHat = [alfaHat, a_temp/c_temp];end% If finite matrix, check the last state (see MarkovChain.m for more% details on indexing.if finiteDuration(mc)    % eq (5.53)    c_temp = transpose(alfaHat(:,T))*A(:,n_states+1);    c = [c, c_temp];endend