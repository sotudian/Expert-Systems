% Shahab SOtudian
% Hill climbing Optimization.
function [x,Function_Value,Gfunction,Output_Hill]=Hill_Climbing_Optimization(fitnessfun,x0,options,varargin)

x0=x0(:);

if nargin<3 | isempty(options)==1
    options=OPTIONs;
end

if size(options.space,1)==1
    for i=2:length(x0)
        options.space(i,:)=options.space(1,:);
    end
elseif size(options.space,1)~=length(x0)
    error('space are not equal to the number of dimensions.');
end

space = options.space;
MaxIter = options.MaxIter;
prec = options.prec;
line = options.line;
Display = options.Display;
TimeLimit = options.TimeLimit;
Goal = options.Goal;

if any(x0<space(:,1)) | any(x0>space(:,2))
    error('x0 is outside the space boundaries.');
end

if Display>0 & strcmp(Display,'Final')==0
    fprintf('                              \n');
    fprintf('   Iteration           f(x)   \n');
    fprintf('   __________      ___________\n');
    fprintf('                              \n');
end

tic;
Time = 0;
Output_Hill.reason = 'Optimization terminated: maximum number of climbs reached.';

h=10^(-prec)*(space(:,2)-space(:,1));

Gfunction(1,:)=[feval(fitnessfun,x0,varargin{:}) x0(:)'];

ymin=-inf;

for i=1:MaxIter
    
      y0=Gfunction(i,1);
    
        for j=1:length(x0)
        
        x=x0;
        
       
        x(j)=max(space(j,1),x0(j)-h(j));
        ybefore(j)=feval(fitnessfun,x,varargin{:});
        
        
        x(j)=min(x0(j)+h(j),space(j,2));
        yafter(j)=feval(fitnessfun,x,varargin{:});
        
    end
    
    
    ybefore=ybefore-y0;
    yafter=yafter-y0;
    if length(x0)==1
        I1=[1 1];
        [ymin,I2]=min([ybefore;yafter]);
    else
        [ymin,I1]=min([ybefore;yafter]');
        [ymin,I2]=min(ymin);
    end
    
    if ymin<0
         
        I=I1(I2);
        x0=x;
        
        if line==0
            
            x0(I)=x0(I)+sign(I2-1.5)*h(I);
        else
           
            for j=1:line
                x0line=x0;
                x0line(I)=x0(I)+sign(I2-1.5)*(j+1)*h(I);
                if x0line(I)<space(I,2) | x0line(I)>space(I,1)
                    yminnew=feval(fitnessfun,x0line,varargin{:})-y0;
                    if yminnew<ymin
                        ymin=yminnew;
                    else break;
                    end
                else break;
                end
            end
            if j==line
                x0=x0line;
            else
                x0(I)=x0(I)+sign(I2-1.5)*(j-1)*h(I);
            end
        end
        Gfunction(i+1,:)=[ymin+y0 x0(:)'];
    else
       
        Output_Hill.reason = 'Optimization terminated: a peak is reached.';
        break;        
    end
    
    
    if Display>0 & rem(i,Display)==0
        fprintf('     %4.0f           %8.4f  \n',i,Gfunction(i+1,1));
    end
    
    
    Time=Time+toc;
    tic;
    if Time>TimeLimit
        Output_Hill.reason = 'Optimization terminated: Time Limit exceeded.';
        break;
    end
    if Gfunction(i,1)<=Goal
        Output_Hill.reason = 'Optimization terminated: Goal reached or exceeded.';
        break;
    end
    
end

Output_Hill.climbs = i-1;
Output_Hill.time = Time;

if Display>0 & strcmp(Display,'Final')==0
    fprintf('   __________      ___________\n');
    fprintf('                              \n');
    disp('Output_Hill:');
    disp(Output_Hill);
elseif strcmp(Display,'Final')==1
    fprintf('Global minimum reached: %8.4f\n',Gfunction(end,1));
end

x=Gfunction(end,2:end);

Function_Value=Gfunction(end,1);