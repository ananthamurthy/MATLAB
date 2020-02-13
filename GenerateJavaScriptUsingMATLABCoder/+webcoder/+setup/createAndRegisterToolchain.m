function createAndRegisterToolchain()
% CREATEANDREGISTERTOOLCHAIN

%
% Copyright 2019 The MathWorks, Inc.
%

webcoder.internal.setup.addMessageCatalog();

webcoder.internal.coder.generateToolchainFile;
disp("Emscripten toolchain definition created.");

RTW.TargetRegistry.getInstance('reset');
disp("Emscripten toolchain registered with MATLAB Coder.");

end

