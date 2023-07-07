clear;close all;
format longE
%Declaration of global variables 
global History Evals Iter 
%starting initial guess values 
nvars=4;
%Young's Modulus, Poisson's ratio, Yield Stress and WH Exponent 
%Initialise counters 
Iter=0;Evals=0;History=[];
%setting the upper and the lower bounds of optimisation
%only xh0,xa and gsat have been considered for optimization
lb=[2190.0 1.0 150.0 85.0];
ub=[2210.0 1.3 160.0 90.0];
options = optimset('ga');
options.TolFun=1e-50;
%invoke optimizer 
[x,resnorm,exitflag]=ga(@objfunction,nvars,[],[],[],[],lb,ub,[],[],options)
%Extract values of the optimized parameters
x1=x(1);x2=x(2);x3=x(3);x4=x(4);
%Set a variable OptParam just to print the optimization parameters
OptParam=[x1 x2 x3 x4];
%Save the optimised parameters in "parameter.txt"
parameter=fopen('parameters.txt','w');
fprintf(parameter,'%12.8f%12.8f%12.8f%12.8f',OptParam);
fclose(parameter);
%optional arguement of setting the 'parameter.txt' in the -ascii form
%save('parameter.txt','OptParam','-ascii')
%Save the parameter evolution history in "Parameter_history.txt"
History=[History;[Iter Evals x1 x2 x3 x4 resnorm]];
Parameter_history=fopen('Parameter_history.txt','w');
fprintf(parameter,'%6.1f%6.2f%12.8f%12.8f%12.8f%12.8f',History);
fclose(Parameter_history);
%End of Optimization Interface
