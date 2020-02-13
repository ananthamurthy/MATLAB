function error(charArray)
%ERROR Display error to the MATLAB prompt, Browser error, or NodeJS output.
%
% Copyright 2019 The MathWorks, Inc.
%

if coder.target('MATLAB')
    error(charArray);
else
    coder.cinclude('console/error.h');
    coder.updateBuildInfo('addSourceFiles','_error.cpp','$(SUPPORTPACKAGEROOT)/src/console');
    coder.ceval('console::error',[charArray,10,0]);
end

end

