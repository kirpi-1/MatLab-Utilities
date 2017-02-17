function dataStruct = cdfStructGenerator(varargin)
% out = cdfStructGenerator('field1Name','field1Type',...)
% legal types correspond with matlab types (uint8, uint 16, single, double, etc)
% you can also put a number after the type label to indicate a size (useful
% for char)
% myStruct = ('time','single','name','char',32) will create a struct with
% the field "time" with 1 single (float) and the field "name" that is 32
% characters long
    tmp = [];
    a = 1;
    while a<nargin
        typename = varargin{a};
        maybeSize = 0;
        size = 1;
        if(a<=nargin-1)
            type = varargin{a+1};
        else
            error('Did not find a type for the final field');
        end
        if(a<=nargin-2)
            maybeSize = varargin{a+2};
        end
        
        if ~isempty(strfind(type,'int')) || ~isempty(strfind(type,'uint')) ||...
                ~isempty(strfind(type,'single')) || ~isempty(strfind(type,'double')) ||...
                ~isempty(strfind(type,'char'))
            % if the maybeSize isn't a string (i.e. it is a number)
            if ~ischar(maybeSize)
                size = maybeSize;                
                a=a+1;
            end            
            s = sprintf('%s(zeros(%d,0))',type,size);
            
            try
                tmp.(typename) = eval(s);
            catch                
                error('Detected an error with argument #%d, %s...check for typos',a,varargin{a+1});            
            end
            a = a+2;
        else
            error('found unexpected type %s for field %d(%s), is this a typo?',type,a,varargin{a});
        end         
    end
    dataStruct = tmp;
end