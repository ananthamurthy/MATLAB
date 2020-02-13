function saveThirdPartyToolPaths(emsdkRootDir)
%SAVETHIRDPARTYTOOLPATHS
%

%
% Copyright 2019 The MathWorks, Inc.
%

toolInfoDir = fullfile(...
    webcoder.internal.utilities.getSupportPackageRootDirectory(),...
    'thirdpartytoolpaths');
[~,~,~] = rmdir(toolInfoDir,'s');
mkdir(toolInfoDir);
webcoder.internal.setup.setThirdPartyToolPath(emsdkRootDir);
disp("Third party toolpaths saved with WebCoder.");


end

