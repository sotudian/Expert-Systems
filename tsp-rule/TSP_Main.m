clc;
clear;
%%   Shahab sotudian - 94125091
%%   TSP - Rule based

n=input('Please Enter The Number of Machines:');
Model=Model_Cal(n);
N=Model.Num;
Positions=Model.Position_Machines;
MachineDistances=Model.Distance_Machines;
Depository_Distance=Model.Distance_Depository;
MachineDistances2=MachineDistances;

%% machines positions Figure
figure;
plot(Positions(:,1),Positions(:,2),'*','MarkerSize',11,'MarkerFaceColor','b','linewidth',2);
hold on;
plot(0,0,'s','MarkerSize',11,'MarkerFaceColor','r','linewidth',1);
axis([-12 12 -12 12])
grid on
title(['Position of Machines and Depository']);
%% Shortest path
Total_Distance=0;
Path_min=zeros(N,3);
Path_min(:,2)=inf;
if rem(N,2)==0
        for i=1:N
        if Path_min(i,3)==0
        for j=1:N
        DIST=Depository_Distance(i)+Depository_Distance(j)+MachineDistances2(i,j);
        if DIST<=Path_min(i,2)
            Path_min(i,1)=i;Path_min(i,2)=DIST;Path_min(i,3)=j;
        end
        end
        Path_min(Path_min(i,3),1)=Path_min(i,3);
        Path_min(Path_min(i,3),2)=DIST;
        Path_min(Path_min(i,3),3)=i;
        MachineDistances2(:,Path_min(i,3))=inf;
        MachineDistances2(:,i)=inf;
        end
    end
    for i=1:N
       Total_Distance=Total_Distance+Depository_Distance(i)+(MachineDistances(i,Path_min(i,3))/2);
    end
    
 
else
    [S,F]=min(Depository_Distance);
    Path_min(F,1)=F;
    Path_min(F,2)=S;
    Path_min(F,3)=F;
    MachineDistances2(:,Path_min(F,3))=inf;
    
    for i=1:N
        if Path_min(i,3)==0
        for j=1:N
        DIST=Depository_Distance(i)+Depository_Distance(j)+MachineDistances2(i,j);
        if DIST<=Path_min(i,2)
            Path_min(i,1)=i; Path_min(i,2)=DIST; Path_min(i,3)=j;
        end
        end
        Path_min(Path_min(i,3),1)=Path_min(i,3);
        Path_min(Path_min(i,3),2)=DIST;
        Path_min(Path_min(i,3),3)=i;
        MachineDistances2(:,Path_min(i,3))=inf;
        MachineDistances2(:,i)=inf;
        end
    end
    
    for i=1:N
        if Path_min(i,3)==i
            Total_Distance=Total_Distance+Depository_Distance(i);
        else
            Total_Distance=Total_Distance+Depository_Distance(i)+(MachineDistances(i,Path_min(i,3))/2);
        end
    end
    
    
end

%% Shortest path Figure
figure;
Col=hsv(N);
for(i=1:N)
    F1=[Positions(i,1),0];
    F2=[Positions(i,2),0];
    plot(F1,F2,'LineWidth',2,'color',Col(i,:));
    hold on;
    F3=[Positions(i,1),Positions(Path_min(i,3),1)];
    F4=[Positions(i,2),Positions(Path_min(i,3),2)];
    plot(F3,F4,'LineWidth',2,'color',Col(i,:));
    hold on;
    F1=[0,Positions(Path_min(i,3),1)];
    F2=[0,Positions(Path_min(i,3),2)];
    plot(F1,F2,'LineWidth',2,'color',Col(i,:));
    hold on;
    end
hold on;
plot(Positions(:,1),Positions(:,2),'o','MarkerSize',9,'MarkerFaceColor','r','linewidth',6);
hold on;
plot(0,0,'s','MarkerSize',11,'MarkerFaceColor','k');
axis([-12 12 -12 12])
grid on
title(['Shoetest Path']);
%% Total Distance 
disp('----<< Shortest Path >>---- ')
disp(['Total Distance Is :', num2str(Total_Distance)]);