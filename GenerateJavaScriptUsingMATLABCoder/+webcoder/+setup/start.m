function start()
%Start Open the setup script
%

%
% Copyright 2019 The MathWorks, Inc.
%

filename = fullfile(...
    webcoder.internal.utilities.getSupportPackageRootDirectory,...
    'doc','Setup.mlx');
edit(filename);

end

