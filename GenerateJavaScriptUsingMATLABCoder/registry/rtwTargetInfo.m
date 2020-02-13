function rtwTargetInfo(tr)
%RTWTARGETINFO Registration file for custom toolchains.
%
% Copyright 2019 The MathWorks, Inc.
%

tr.registerTargetInfo(...
    @loc_addToolchain);

end


function config = loc_addToolchain

config      =       coder.make.ToolchainInfoRegistry;
config.Name =       'Emscripten';
config.FileName =   fullfile(...
    webcoder.internal.utilities.getSupportPackageRootDirectory,...
    'registry','emscripten_tc.mat');
end

