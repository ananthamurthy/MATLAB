function log(charArray)
%% LOG Display text to the MATLAB prompt, Browser console, or NodeJS output.
%   The disp function prints informational and logging text to the MATLAB
%   command prompt when running in simulation. When deployed to a browser
%   or NodeJS environment, the text gets displayed to their respective
%   consoles as log.
%
%   Example:
%       webcoder.console.log('Hello Browser');
%
%   Copyright 2019 The MathWorks, Inc.
%

if coder.target('MATLAB')
    disp(charArray);
else
    coder.cinclude('console/log.h');
    coder.updateBuildInfo('addIncludePaths','$(SUPPORTPACKAGEROOT)/include');
    coder.updateBuildInfo('addSourceFiles','_log.cpp','$(SUPPORTPACKAGEROOT)/src/console');
    coder.ceval('console::log',[charArray,0]);
end

end

