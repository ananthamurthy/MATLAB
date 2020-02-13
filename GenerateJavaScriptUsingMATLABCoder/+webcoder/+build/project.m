function project(proj)
%PROJECT Build JavaScript project
% Build a JavaScript library or app from a MATLAB project. This function 
% takes a MATLAB proj, containing the functions with labels. Output of this 
% function is two extra directories in the project folder. A build 
% directory, |build|, containing the intermediate C++ and Make files
% and a distribution directory, |dist|, containing the compiled JavaScript 
% file or JavaScript file with HTML and CSS files.
%
% Example:
%   To build the project in the current directory, run code.
%   >> proj = openProject(pwd);
%   >> webcoder.build.project(proj);
%
% Copyright 2019 The MathWorks, Inc.
%

webcoder.internal.coder.buildProject(proj);

end