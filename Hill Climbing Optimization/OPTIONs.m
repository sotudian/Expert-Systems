% Shahab SOtudian
% Options definition for hill climbing.

function options=OPTIONs(varargin)

options.space = [0 1];
options.MaxIter = 200;
options.prec = 4;
options.line = 99;
options.Display = 'Final';
options.TimeLimit = 30;
options.Goal = -inf;

if (nargin == 0) && (nargout == 0)
    fprintf('          space: [ real matrix  | {[0 1]} ]\n');
    fprintf('        MaxIter: [ integer positive scalar | {200} ]\n');
    fprintf('           prec: [ integer positive scalar | {4} ]\n');
    fprintf('           line: [ integer positive scalar | {99} ]\n');
    fprintf('        Display: [ integer non-negative scalar | {"Final"} ]\n');
    fprintf('      TimeLimit: [ real positive scalar | {30} ]\n');
    fprintf('           Goal: [ real scalar | {-inf} ]\n');
end

if nargin > 1
    if rem(nargin,2)==0
        for i=1:nargin/2
            switch varargin{i*2-1}
                case 'space'
                                        if ndims(varargin{i*2})>3
                        error(['"' varargin{i*2-1} '" must be a 2 dimensinal matrix.']);
                    end
                                        if size(varargin{i*2},2)~=2
                        error(['"' varargin{i*2-1} '" must contain exactly 2 columns.']);
                    end
                case {'MaxIter','prec','TimeLimit'}
                                        if sum(size(varargin{i*2}))>2
                        error([varargin{i*2-1} ' must be a scalar.']);
                    end
                                        if varargin{i*2}<=0
                        error([varargin{i*2-1} ' must be positive.']);
                    end
                case {'line'}
                                        if sum(size(varargin{i*2}))>2
                        error([varargin{i*2-1} ' must be a scalar.']);
                    end
                                       if varargin{i*2}<0
                        error([varargin{i*2-1} ' must be non-negative.']);
                    end
                case {'Display'}
                    if isa(varargin{i*2},'numeric')==1
                                                if sum(size(varargin{i*2}))>2
                            error([varargin{i*2-1} ' must be a scalar.']);
                        end
                                                if varargin{i*2}<=0
                            error([varargin{i*2-1} ' must be positive.']);
                        end
                                                if varargin{i*2}~=round(varargin{i*2})
                            error([varargin{i*2-1} ' must be an integer.']);
                        end
                    elseif strcmp(varargin{i*2},'Final')==0
                        error('The only non-numeric value of "Show" is "Final".');
                    end
                case 'Goal'
                                        if sum(size(varargin{i*2}))>2
                        error([varargin{i*2-1} ' must be a scalar.']);
                    end
                otherwise
                    error(['The field "' varargin{i*2-1} '" does not exist in the struct hilloptions.']);
            end
            options = setfield(options,varargin{i*2-1},varargin{i*2});
        end
    else
        error('The number of input arguments must be even.');
    end
end