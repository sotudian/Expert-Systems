%%   Shahab sotudian - 94125091
%%   TSP - Rule based
function Model=Model_Cal(Num)
Position_Machines=randi([-30 300],Num,2);
Position_Machines=Position_Machines/4;
Distance_Machines=zeros(Num,Num);
Distance_Depository=zeros(Num,1);
for i=1:Num
 Distance_Depository(i)=norm(Position_Machines(i,:));
   for j=1:Num
       if j==i
       Distance_Machines(i,j)=inf; 
       else
       Distance_Machines(i,j)=norm(Position_Machines(i,:)-Position_Machines(j,:)) ;
       end
   end
end
 Model.Num=Num; 
 Model.Position_Machines=Position_Machines;
 Model.Distance_Machines=Distance_Machines;
 Model.Distance_Depository=Distance_Depository;
end