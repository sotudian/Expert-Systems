function [ a,b,c,d ] = Voroudi_MISO( Inference_GKFPCM,cluster_n,Xin )

ppp=size(Xin);

%% Inputs
for i=1:ppp(2)
    for j=1:cluster_n
    
    
MEANin(i,j)=Inference_GKFPCM.input(i).mf(j).params(2);
SIGMAin(i,j)=Inference_GKFPCM.input(i).mf(j).params(1);

    end
end

%% Output       NumberOfoutput=1;

for ii=1:cluster_n
    
    
    
MEANout(1,ii)=Inference_GKFPCM.output.mf(ii).params(2);
SIGMAout(1,ii)=Inference_GKFPCM.output.mf(ii).params(1);

    
end

a=MEANin;
b=SIGMAin;
c=MEANout;
d=SIGMAout;


end

