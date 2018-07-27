% Iterative solution Using Newton method
%% Input parameters
alpha = input('Enter values of Alpha in matrix form = [alpha1 ; alpha2 ; ... ; alpha n] = ');
beta = input('Enter values of Beta in matrix form = [beta1 ; beta2 ; ... ; beta n] = ');
gama= input('Enter values of Gamma in matrix form = [gamma1 ; gamma2 ; ... ; gamma n] = ');
PD= input('Enter the total power demand PD = ');
lambda = input('Enter estimated value of Lambda = ');
%% initialization
DelP = 10;                                                    % Error in DelP is set to a high value
iter = 0;                                                     % Iteration counter is set to zero
fprintf('\n ')
disp(['Iteration    Lambda      P1       P2        P3       P4       DP     Delambda']) 
           
               

%% iterative solution
while abs(DelP)  >= 0.001                                     % Test for convergence
iter = iter + 1;                                              % No. of iterations
P = (lambda - beta)./(2*gama);
DelP = PD - sum(P);                                           % Residual
Delambda = DelP/sum( 1./(2*gama));                            % Change in variable
disp([iter, lambda, P(1), P(2), P(3), P(4), DelP, Delambda])
lambda = lambda + Delambda;                                   % Successive solution
end
totalcost = sum(alpha + beta.*P + gama.*P.^2)