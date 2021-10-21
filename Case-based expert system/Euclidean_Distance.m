
% Shahab Sotudian 94125091

%%  Euclidean_Distance 
function DIST = Distance(DATA1, DATA2)
DIST = zeros(size(DATA1, 1), size(DATA2, 1));
if size(DATA1, 2) > 1,
    for k = 1:size(DATA1, 1),
	DIST(k, :) = sqrt(sum(((DATA2-ones(size(DATA2, 1), 1)*DATA1(k, :)).^2)'));
    end
else	
    for k = 1:size(DATA1, 1),
	DIST(k, :) = abs(DATA1(k)-DATA2)';
    end
end