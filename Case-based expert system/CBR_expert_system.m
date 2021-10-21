% Question 3 
% Shahab SOtudian    94125091
% CBR expert system
clear
clc
load('Inputs.mat');
load('Outputs.mat');
N=size(Inputs);

%% New Case
disp('Please enter the price of the stock at the beginning of the week')
    New_Case(1,1)=input('');
disp('Please enter the highest price of the stock during the week')
    New_Case(1,2)=input('');    
disp('Please enter the lowest price of the stock during the week')
    New_Case(1,3)=input(''); 
disp('Please enter the price of the stock at the end of the week')
    New_Case(1,4)=input(''); 
disp('Please enter the number of shares of stock that traded hands in the week')
    New_Case(1,5)=input('');  
disp('Please enter the percentage change in price throughout the week')
    New_Case(1,6)=input('');
disp('Please enter the percentage change in the number of shares of stock that traded hands for this week compared to the previous week')
    New_Case(1,7)=input('');    

%% CBR
for i=1:N(1)
similarity(i)=Euclidean_Distance(Inputs(i,:),New_Case);
end
Total_sum=sum(similarity);
FinalOutput=zeros(1,4);
for j=1:N(1)
FinalOutput=FinalOutput+((similarity(j)/Total_sum)*Outputs(j,:));
end
%% Final results
disp('===========================================')
disp('============== Final Results ==============')
disp('===========================================')
disp('The opening price of the stock in the following week is :')
disp(FinalOutput(1))
disp('The closing price of the stock in the following week :')
disp(FinalOutput(2))
disp('The percentage change in price of the stock in the following week is :')
disp(FinalOutput(3))
disp('The percentage of return on the next dividend :')
disp(FinalOutput(4))





