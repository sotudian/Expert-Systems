% Question 1 Hybrid frame based expert
% Shahab SOtudian
clear
clc
load('Xin.mat');
load('Xout.mat');
cluster_n=5;
%% ££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££
Inference_GKFPCM=Genfis3_FCM(Xin, Xout, 'mamdani',cluster_n);
[ MEANin,SIGMAin,MEANout,SIGMAout ] = Voroudi_MISO( Inference_GKFPCM,cluster_n,Xin );
%% $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  %%%%%%%%%%%%%%
%%%   inputs   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%
  % Gaussian membership function input 1
for i=1:1:cluster_n
 L=0:0.01:300;
 Antecedent1(i,:)= exp(-(L - MEANin(1,i)).^2/(2*SIGMAin(1,i)^2));
end
% Gaussian membership function input 2
for i=1:1:cluster_n
 L=0:0.01:300;
 Antecedent2(i,:)= exp(-(L - MEANin(2,i)).^2/(2*SIGMAin(2,i)^2));
end
% Gaussian membership function input 3
for i=1:1:cluster_n
 L=0:0.01:300;
 Antecedent3(i,:)= exp(-(L - MEANin(3,i)).^2/(2*SIGMAin(3,i)^2));
end
% Gaussian membership function input 4
for i=1:1:cluster_n
 L=0:0.01:300;
 Antecedent4(i,:)= exp(-(L - MEANin(4,i)).^2/(2*SIGMAin(4,i)^2));
end  
% Gaussian membership function input 5
for i=1:1:cluster_n
 L=0:0.01:300;
 Antecedent5(i,:)= exp(-(L - MEANin(5,i)).^2/(2*SIGMAin(5,i)^2));
end
% Gaussian membership function input 6
for i=1:1:cluster_n
 L=0:0.01:300;
 Antecedent6(i,:)= exp(-(L - MEANin(6,i)).^2/(2*SIGMAin(6,i)^2));
end
% Gaussian membership function input 7
for i=1:1:cluster_n
 L=0:0.01:300;
 Antecedent7(i,:)= exp(-(L - MEANin(7,i)).^2/(2*SIGMAin(7,i)^2));
end

  %%%%%%%%%%%%%%
%%%   Output   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%

  % Gaussian membership function output
for i=1:1:cluster_n
 S=0:0.01:600;
 Consequent(i,:)= exp(-(S- MEANout(i)).^2/(2*SIGMAout(i)^2));
end
  

    %%%%%%%%%%%%%%
%%% Initila inputs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%
  disp('Please enter the amount of Age')
  h1=input('');
% h1=41;
  A(1,:)=gaussmf(L,[(min(SIGMAin(1,:))/1111) h1]);
  disp('Please enter the amount of Ascites')
  h2=input('');
% h2=2;
  A(2,:)=gaussmf(L,[(min(SIGMAin(2,:))/1111) h2]);
  disp('Please enter the amount of Varices')
  h3=input('');
% h3=1.75;
  A(3,:)=gaussmf(L,[(min(SIGMAin(3,:))/1111) h3]);
  disp('Please enter the amount of Bilirubin')
  h4=input('');
% h4=2.001;
  A(4,:)=gaussmf(L,[(min(SIGMAin(4,:))/1111) h4]);
  disp('Please enter the amount of Alk phosphate')
  h5=input('');
% h5=105;
  A(5,:)=gaussmf(L,[(min(SIGMAin(5,:))/1111) h5]);
  disp('Please enter the amount of SGOT')
  h6=input('');
% h6=98;
  A(6,:)=gaussmf(L,[(min(SIGMAin(6,:))/1111) h6]);
  disp('Please enter the amount of ALBUMIN')
  h7=input('');
% h7=3.8;
  A_input7(7,:)=gaussmf(L,[(min(SIGMAin(7,:))/1111) h7]);
    
     %%%%%%%%%%%%%%
%%%    STEP 1-1     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %%%%%%%%%%%%%%
   %input 1
    for e=1:cluster_n
    for j=1:30001
       w(j)= min(A(1,j),Antecedent1(e,j));
    end
    DOF(1,e)=max(w);
    end
  %input 2
    for e=1:cluster_n
    for j=1:30001
       w(j)= min(A(2,j),Antecedent2(e,j));
    end
    DOF(2,e)=max(w);
    end
  %input 3
    for e=1:cluster_n
    for j=1:30001
       w(j)= min(A(3,j),Antecedent3(e,j));
    end
    DOF(3,e)=max(w);
    end
      %input 4
    for e=1:cluster_n
    for j=1:30001
       w(j)= min(A(4,j),Antecedent4(e,j));
    end
    DOF(4,e)=max(w);
    end
  %input 5
    for e=1:cluster_n
    for j=1:30001
       w(j)= min(A(5,j),Antecedent5(e,j));
    end
    DOF(5,e)=max(w);
    end    
  %input 6
    for e=1:cluster_n
    for j=1:30001
       w(j)= min(A(6,j),Antecedent6(e,j));
    end
    DOF(6,e)=max(w);
    end    
  %input 7   motafavet L
    for e=1:cluster_n
    for j=1:30001
       w(j)= min(A_input7(7,j),Antecedent7(e,j));
    end
    DOF(7,e)=max(w);
    end    
    
    % final DOF
    for i=1:cluster_n
        Y(1)=DOF(1,i);
        Y(2)=DOF(2,i);
        Y(3)=DOF(3,i);
        Y(4)=DOF(4,i);
        Y(5)=DOF(5,i);
        Y(6)=DOF(6,i);
        Y(7)=DOF(7,i);
       DOFfinal(i)=min(Y) ;
    end 
     
     %%%%%%%%%%%%%%
%%%    STEP 1-2    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %%%%%%%%%%%%%%     
     
  for e=1:cluster_n
    for j=1:60001
       f(e,j)= min(DOFfinal(e),Consequent(e,j));
    end
     end   
     %%%%%%%%%%%%%%
%%%    Aggrigation    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %%%%%%%%%%%%%%       

 for j=1:60001
        for x=1:cluster_n
           M(x)=f(x,j);
        end
     AGGRIGATE(j)= max(M);
 end     
       %%%%%%%%%%%%%%
%%%    Defuzzification    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       %%%%%%%%%%%%%%       
     
Output=defuzz(S,AGGRIGATE,'centroid');     
     
       %%%%%%%%%%%%%%
%%%    Patient Condition    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       %%%%%%%%%%%%%%       
  if Output>1.65
     disp('*******************************************')
     disp('**  patient is diagnosed with hepatitis  **') 
     disp('*******************************************')
  else
           disp('**************************')
           disp('**  Patient is healthy  **')
           disp('**************************')
  end
         %%%%%%%%%%%%%%
%%%    Stage of disease    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         %%%%%%%%%%%%%% 
 if Output>1.65
    disp('please answer the following question in order to find the stage of your disease') 
  
   jaundice=input('Are there signs of yellow skin and eyes and Itchy Skin? (y/n) ','s'); 
  abdominalPain=input('Are there signs of buildup of fluid in the patient abdomen? (y/n) ','s');
  kidneyfailure=input('Are there signs of dark urine? (y/n) ','s');
  temperature=input('what is the temperature of patient? ');
  if temperature>=37
      fever='y';
  else
      fever='n';
  end
  
   if strcmp(fever,'y');
        if strcmp(abdominalPain,'y');
            nausea='y';
        else
           nausea='n'; 
        end
   end
        
   if strcmp(nausea,'n');
       if strcmp(jaundice,'n');
           if strcmp(kidneyfailure,'n');
           disp('*************************************')
           disp('**  Patient has stage-1 Hepatitis  **')
           disp('*************************************')
   
           end
       end
   end
   if strcmp(nausea,'n');
       if strcmp(jaundice,'n');
           if strcmp(kidneyfailure,'y');
           disp('*************************************')
           disp('**  Patient has stage-2 Hepatitis  **')
           disp('*************************************')
           end
       end
   end 
   if strcmp(nausea,'n');
       if strcmp(jaundice,'y');
           if strcmp(kidneyfailure,'y');
           disp('*************************************')
           disp('**  Patient has stage-3 Hepatitis  **')
           disp('*************************************')
           end
       end
   end
   if strcmp(nausea,'y');
       if strcmp(jaundice,'y');
           if strcmp(kidneyfailure,'y');
           disp('*************************************')
           disp('**  Patient has stage-4 Hepatitis  **')
           disp('*************************************')
           end
       end
   end 
         
     
 end
       
       
       
       %%%%%%%%%%%%%%
%%%       Plotting       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       %%%%%%%%%%%%%%
 
j=1;

        for i=1:cluster_n
        subplot(6,8,j)
        plot(L,Antecedent1(i,:),'b','linewidth',1.5)
        if i==1
         title('Age ')
        end
        ylabel(['Rule ',num2str(i)])
        axis([10 80 0  1.1]);
        j=j+8;
        
             hold on
        end
j=2;
        for i=1:cluster_n
        subplot(6,8,j)
        plot(L,Antecedent2(i,:),'r','linewidth',1.5)
        if i==1
         title('Ascites')
        end
        axis([1 2.5 0  1.1]);
        j=j+8;
             hold on
        end
j=3;
        for i=1:cluster_n
        subplot(6,8,j)
        plot(L,Antecedent3(i,:),'g','linewidth',1.5)
        if i==1
         title('Varices')
        end
        axis([1 2.5 0  1.1]);
        j=j+8;
             hold on
        end
j=4;
        for i=1:cluster_n
        subplot(6,8,j)
        plot(L,Antecedent4(i,:),'m','linewidth',1.5)
        if i==1
         title('Bilirubin')
        end
        axis([0 6 0  1.1]);
        j=j+8;
             hold on
        end
j=5;
        for i=1:cluster_n
        subplot(6,8,j)
        plot(L,Antecedent5(i,:),'c','linewidth',1.5)
        if i==1
         title('Alk phosphate')
        end
        axis([0 300 0  1.1]);
        j=j+8;
             hold on
        end                
j=6;
        for i=1:cluster_n
        subplot(6,8,j)
        plot(L,Antecedent6(i,:),'c','linewidth',1.5)
        if i==1
         title('SGOT')
        end
        axis([0 300 0  1.1]);
        j=j+8;
             hold on
        end        
j=7;
        for i=1:cluster_n
        subplot(6,8,j)
        plot(L,Antecedent7(i,:),'c','linewidth',1.5)
        if i==1
         title('ALBUMIN')
        end
        axis([2.5 5.5 0  1.1]);
        j=j+8;
             hold on
        end        
        
j=8;
         for i=1:cluster_n
        subplot(6,8,j)
        plot(S,f(i,:),'k','linewidth',1.5)
        if i==1
         title('Output')
        end
axis([0 3 0  0.5]);
             j=j+8;
             hold on
        end

subplot(6,8,48)
plot(S,AGGRIGATE,'m','linewidth',1.5)
title('AGGRIGATE')     
     axis([0 3 0  0.5]);
     
     
     
     
     


