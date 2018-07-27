% Iterative solution Using Newton method with generation Limits
%% Input parameters
ng = input('Enter number of generators = ');
alpha = input('Enter values of Alpha in matrix form = ');
beta = input('Enter values of Beta in matrix form = ');
gamma= input('Enter values of Gamma in matrix form = ');
Max = input('Enter the maximum generation limits = ');
Min = input('Enter the minimum generation limits = ');
B = input('Enter the Power loss coeffiecents (Bii) = ');
PD= input('Enter the total power demand PD = ');
lambda = input('Enter estimated value of Lambda = ');


%% initialization
DelP = 10;                                                    % Error in DelP is set to a high value
fprintf('\n ')
disp(['Iteration    Lambda      P1       P2        P3     PL       DP     Delambda']) 
check = zeros(1,ng);          
n = 0;  
P = zeros(1,ng);
iter = 0;

%% iterative solution
while abs(DelP)  >= 0.001 && iter<20                                    
    while abs(DelP)  >= 0.001 && iter<20
        iter = iter +1;
        PL = 0;
        for n=1 : ng
            if check(n) == 0
                P(n) = (lambda - beta(n)) / (2 *( gamma(n) + lambda*B(n)));
                PL = PL + B(n) * P(n)^2;
            end
        end
        DelP = PD + PL - sum(P);
        for n=1 : ng
            if check (n) == 0
                Den(n) = (gamma(n) + B(n)*beta(n))/(2 * (gamma(n) + lambda * B(n))^2);
            else Den(n) = 0;
            end
        end
        if sum(Den) ~= 0
        Delambda = DelP / sum(Den);
        else break;
        end
        disp([iter, lambda, P(1), P(2), P(3),PL, DelP, Delambda])
        lambda = lambda + Delambda;        
    end
    for n=1 : ng
        if check(n) == 0
            if P(n)>=Max(n)
                P(n) = Max(n);
                check(n) = 1;
            end
            
            if P(n)<=Min(n)
                P(n) = Min(n);
                check(n) = 2;
            end
        end
    end
   DelP = PD + PL - sum(P);
   if sum(Den) == 0
       if DelP > 0
           for n=1:ng
               if check(n) == 2
                   check(n) = 0;
               end
           end
       else
           for n=1:ng
               if check(n) == 1
                   check(n) = 0;
               end
           end
       end
   end     
end
            

        
                