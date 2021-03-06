function verifyShellEnvironment()
%VERIFYSHELLENVIRONMENT Verify MATLAB shell is BASH
%   Verify that the MATLAB shell is configured to BASH.
%
%   Copyright 2019 The MathWorks, Inc.

[status,~] = system('[[ $0 == "/bin/bash" ]]');


errorMessage = "The Emscripten SDK and tools require that MATLAB use a BASH shell." + newline + ...
    "To configure MATLAB to use a BASH shell, you must set the MATLAB_SHELL " + ... 
    "environment variable to /bin/bash shell prior to MATLAB starting." + newline + ...
    "For example:" + newline + ...
    "(1)   Exit MATLAB." + newline + ...
    "(2)   Navigate to the installation location of MATLAB." + newline + ...
    "          cd <matlab-installation>/bin" + newline + ...
    "(3)   Start MATLAB using the following command." + newline + ...
    "          export MATLAB_SHELL=""/bin/bash"" && ./matlab";

assert(~logical(status),errorMessage);



end

