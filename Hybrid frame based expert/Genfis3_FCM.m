function fismat = Genfis3_FCM(Xin, Xout, fistype, cluster_n, fcmoptions)


if nargin < 2
    error('FuzzyLogic:missingparams', ...
        'genfis3 requires input and output data to build a FIS.');
end

if nargin < 5
    fcmoptions = [];    
    if nargin < 4
        cluster_n = 'auto';
        if nargin < 3
            fistype = 'sugeno';
        end
    end
end

mftype = 'gaussmf'; % hardcoded for now

%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter Checking
%%%%%%%%%%%%%%%%%%%%%%%%%

% Check Xin, Xout
[numData,numInp] = size(Xin);
[numData2,numOutp] = size(Xout);

if numData ~= numData2
    % There's a mismatch in the input and output data matrix dimensions
    if numData == numOutp
        % The output data matrix should have been transposed, we'll fix it
        Xout = Xout';
        numOutp = numData2;
    else
        error('FuzzyLogic:dimensionmismatch', ...
            'Mismatched input and output data matrices');
    end
end


% Check cluster_n
if ~isscalar(cluster_n)
    if ~isequal(cluster_n, 'auto')
        error('FuzzyLogic:cluster_nerror1', ...
            'Set number of clusters to ''auto'' or a value greater than 0');
    end
else
    if cluster_n < 1
        error('FuzzyLogic:cluster_nerror2', ...
            'Number of clusters must have a value greater than 0');
    end
end

% Check fcmoptions


% Check fistype
fistype = lower(fistype);
if ~isequal(fistype, 'mamdani') && ~isequal(fistype, 'sugeno')
        error('FuzzyLogic:fistypeerror', ...
            'Unknown fistype specified. fistype can take only two values. ''mamdani'' or ''sugeno''');
end


if isequal(cluster_n, 'auto')
    xBounds = [min(Xin) min(Xout); max(Xin) max(Xout)];
    [centers,sigmas] = subclust([Xin Xout],0.5,xBounds);
    [cluster_n, dummy] = size(centers);
end


%%%%%%%%%%%%%%%%%%%%
% FCM Clustering
%%%%%%%%%%%%%%%%%%%%

[center, U] = fcm([Xin Xout],cluster_n);



%%%%%%%%%%%%%%%%%%%%%%
% Building FIS
%%%%%%%%%%%%%%%%%%%%%

% Initialize a FIS
theStr = sprintf('%s%g%g',fistype,numInp,numOutp);
fismat = newfis(theStr, fistype);

% Loop through and add inputs
for i = 1:1:numInp
    
    fismat = addvar(fismat,'input',['in' num2str(i)],minmax(Xin(:,i)'));

    % Loop through and add mf's
    for j = 1:1:cluster_n

        params = computemfparams (mftype, Xin(:,i), U(j,:)', center(j,i));
        fismat = addmf(fismat,'input', i, ['in' num2str(i) 'cluster' num2str(j)], mftype, params);

    end   
    
end


switch lower(fistype)
    
    case 'sugeno'

        % Loop through and add outputs
        for i=1:1:numOutp
            
            fismat = addvar(fismat,'output',['out' num2str(i)],minmax(Xout(:,i)'));

            % Loop through and add mf's
            for j = 1:1:cluster_n

                params = computemfparams ('linear', [Xin Xout(:,i)]);
                fismat = addmf(fismat,'output', i, ['out' num2str(i) 'cluster' num2str(j)], 'linear', params);

            end            
        end
        

    case 'mamdani'
        
        % Loop through and add outputs
        for i = 1:1:numOutp

            fismat = addvar(fismat,'output',['out' num2str(i)],minmax(Xout(:,i)'));

            % Loop through and add mf's
            for j = 1:1:cluster_n

                params = computemfparams (mftype, Xout(:,i), U(j,:)', center(j,numInp+i));
                fismat = addmf(fismat,'output', i, ['out' num2str(i) 'cluster' num2str(j)], mftype, params);

            end
        end
        
    otherwise
        error('FuzzyLogic:unknownfistype', ...
            'Unknown fistype specified');                
    
end


% Create rules
ruleList = ones(cluster_n, numInp+numOutp+2);
for i = 2:1:cluster_n
    ruleList(i,1:numInp+numOutp) = i;    
end
fismat = addrule(fismat, ruleList);

% Set the input variable ranges
minX = min(Xin);
maxX = max(Xin);
ranges = [minX ; maxX]';
%Protect against zero range
idx = diff(ranges,1,2)==0;
if any(idx)
    v  = ranges(idx,1);
    dv = 0.1*abs(v)+0.1;
    ranges(idx,:) = [v-dv, v+dv];
end
for i=1:numInp
   fismat.input(i).range = ranges(i,:);
end

% Set the output variable ranges
minX = min(Xout);
maxX = max(Xout);
ranges = [minX ; maxX]';
%Protect against zero range
idx = diff(ranges,1,2)==0;
if any(idx)
    v  = ranges(idx,1);
    dv = 0.1*abs(v)+0.1;
    ranges(idx,:) = [v-dv, v+dv];
end
for i=1:numOutp
   fismat.output(i).range = ranges(i,:);
end



function mfparams = computemfparams(mf,x,m,c)

switch lower(mf)
    
    case 'gaussmf'
        sigma = invgaussmf4sigma (x, m, c);
        mfparams = [sigma, c];
        
    case 'linear'
        [N, dims] = size(x);
        xin = [x(:,1:dims-1) ones(N,1)];
        xout = x(:, dims);
        b = xin \ xout;
        mfparams = b';
        
    otherwise
        error('FuzzyLogic:invalidmftype', ...
            'Unknown type of membership function specified');        
end


function pr=minmax(p)
%MINMAX Ranges of matrix rows.
%
%  Syntax
%
%    pr = minmax(p)
%
%  Description
%
%    MINMAX(P) takes one argument,
%      P - RxQ matrix.
%    and returns the Rx2 matrix PR of minimum and maximum values
%    for each row of P.
%
%    Alternately, P can be an MxN cell array of matrices.  Each matrix
%    P{i,j} should Ri rows and Q columns.  In this case, MINMAX returns
%    an Mx1 cell array where the mth matrix is an Rix2 matrix of the
%    minimum and maximum values of elements for the matrics on the
%    ith row of P.
%
%  Examples
%
%    p = [0 1 2; -1 -2 -0.5]
%    pr = minmax(p)
%
%    p = {[0 1; -1 -2] [2 3 -2; 8 0 2]; [1 -2] [9 7 3]};
%    pr = minmax(p)
if iscell(p)
  [m,n] = size(p);
  pr = cell(m,1);
  for i=1:m
    pr{i} = minmax([p{i,:}]);
  end
elseif isa(p,'double')
  pr = [min(p,[],2) max(p,[],2)];
else
  error('Argument has illegal type.')
end