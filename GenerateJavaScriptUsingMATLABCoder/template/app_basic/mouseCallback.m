function sampleCallback(event)
%SAMPLECALLBACK A sample callback functione
%   The callback(event) function is a sample callback function that can be
%   assigned, by name, to an HTML dom element or JavaScript object to react
%   to asynchronous events, such as a button click.
%   The "event" input is structure containing information about the event.
%   For HTML DOM objects, the minimum information is the HTML id tag the
%   callback is attached to.

%
% Copyright 2019 The MathWorks, Inc.
%

webcoder.console.log(['Event source = ',event.id]);




end

