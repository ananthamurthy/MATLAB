function emsdkRootDir = getEmscriptenRootDirectory()
%GETEMSCRIPTENROOTDIRECTORY
%

%
% Copyright 2019 The MathWorks, Inc.
%

emsdkRootDir = uigetdir;    
disp("Emscripten SDK root folder provided:")
disp(emsdkRootDir);

end

