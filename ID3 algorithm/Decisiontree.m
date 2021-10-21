%% Shahab Sotudian    94125091
% create classification tree
load fisheriris 
ctree = fitctree(meas,species); 
view(ctree) 
view(ctree,'mode','graph')
