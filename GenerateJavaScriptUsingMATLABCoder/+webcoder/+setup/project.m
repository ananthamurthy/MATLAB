function proj = project(varargin)
%PROJECT Create a new JavaScript project
%   Create a new MATLAB project to for either a JavaScript library or app.
%   The project is automatically configured with Category-Label pairs to
%   identify Callbacks, User Interface, and EntryPoint functions.
%
% Inputs (Name-Value Pairs):
%   Name (string) - Name of the project.
%   Directory (string) - Directory to create the project.
%       [ pwd (default) | directory on host computer ]
%   BuildConfiguration (string) - Build configuration of project.
%       [ 'Faster Builds' (default) | 'Faster Runs' ]
%   OutputType (string) - Define project as App or Library.
%       Use the 'EXE' to create an app, 'DLL' to create a library, and
%       'LIB' to create bytecode.
%       [ 'EXE' (default) | 'DLL' | 'LIB' ]
%
% Example:
%   To create a new project in the current directory, run
%   >> proj = webcoder.setup.project("MyNewApp");
%
% Copyright 2019 The MathWorks, Inc.
%

proj = webcoder.internal.project.createProject(varargin{:});

end


