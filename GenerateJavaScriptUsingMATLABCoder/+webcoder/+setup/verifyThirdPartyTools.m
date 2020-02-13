function verifyThirdPartyTools(emsdkRootDir)
%VERIFYTHIRDPARTYTOOLS
%  

%
% Copyright 2019 The MathWorks, Inc.
%

webcoder.internal.setup.verifyEmscripten(emsdkRootDir);
webcoder.internal.setup.verifyJava(emsdkRootDir);
webcoder.internal.setup.verifyNode(emsdkRootDir);
webcoder.internal.setup.verifyPython(emsdkRootDir);
disp("EMSDK and external tools have been verified.");

end

