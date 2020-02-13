classdef WebSocketClient < handle
    %WEBSOCKETCLIENT Manage a web socket client connection
    %   The WebSocketClient object represents a client web socket in the 
    %   browser that connects to the specified external domain. With this 
    %   object, you can send messages to the web socket server. Adding 
    %   callbacks, functions can be triggered and run when messages are 
    %   recieved in the browser. 
    %
    %   Copyright 2019 The MathWorks, Inc.
    %
    
   properties (GetAccess = private, SetAccess = immutable)
        cppClient
    end
    
    properties (SetAccess = private)
        callbacks       
    end
    
    methods
        %% Constructor
        function obj = WebSocketClient(url)
            coder.cinclude("<functional>");
            coder.cinclude("<memory>");
            coder.cinclude("<string>");
            coder.cinclude("network/websocket/client.h");       
            coder.updateBuildInfo('addSourceFiles','_client.cpp','$(SUPPORTPACKAGEROOT)/src/network/websocket');
            
            % Get Client
            urlStr = coder.opaque("std::string","NULL");
            urlStr = coder.ceval("std::string",[url,0]);   
            
            obj.cppClient = coder.opaque("std::unique_ptr<Network::WebSocket::Client>","NULL","HeaderFile","network/websocket/client.h");
            obj.cppClient = coder.ceval("std::make_unique<Network::WebSocket::Client>",urlStr);
                     
        end
        
        %% Destructor
        function delete(~)
            % coder.cinclude("<memory>");
            % coder.ceval("std::mem_fn(&reset)",obj.cppClient);
        end
  
        %% Interaction
        function send(obj,message)
            % Send message to web socket server
            %
            % Use the send method to send messages to the web socket
            % server.
            %
            % Inputs:
            %   obj - WebSocketClient object
            %       webcoder.network.WebSocketClient
            %   message - Message text
            %       character vector            
            %
            % Example:
            %   obj = webcoder.network.WebSocketClient('ws://echo.websocket.org');
            %   send(obj,'Hello from a client-side MATLAB app!');
            %
            coder.cinclude("<functional>");
            coder.cinclude("<memory>");
            coder.cinclude("<string>");
            coder.cinclude("network/websocket/client.h");            
            
            messageStr = coder.opaque("std::string","NULL");
            messageStr = coder.ceval("std::string",[message,0]);  
            
            coder.ceval(...
                'std::mem_fn(&Network::WebSocket::Client::send)',...
                obj.cppClient,messageStr);            
        end
        
        function value = url(obj)
            % Get the URL of the web socket server
            %
            % Use the url method to get the address of the web socket server.
            %
            % Inputs:
            %   obj - WebSocketClient object
            %       webcoder.network.WebSocketClient                   
            %
            % Example:
            %   obj = webcoder.network.WebSocketClient('ws://echo.websocket.org');
            %   value = url(obj);
            %
            coder.cinclude("<functional>");
            coder.cinclude("<memory>");
            coder.cinclude("<string>");
            coder.cinclude("network/websocket/client.h");   
                        
            urlStr = coder.opaque("std::string","NULL","HeaderFile","<string>");            
            urlStr = coder.ceval("std::mem_fn(&Newtork::WebSocket::Client::url)",obj.cppClient);     
            
            size_t = coder.opaque("size_t","NULL","HeaderFile","<string>");
            size_t = coder.ceval('std::mem_fn(&std::string::length)',urlStr);
            length = uint32(0);
            length = coder.ceval('(int)',size_t);
            
            value = char(zeros(1,length));
            coder.ceval('std::mem_fn(&std::string::copy)',urlStr,coder.ref(value),size_t,0);                       
            
            return;
        end    
        
        function close(obj)
            % Close the eb socket connection
            %
            % Use the close method to close the conection to the web socket 
            % server. Once the connection is closed, it cannot be reopened;
            % use the remove method to remove this connection then create a
            % new webcoder.network.WebSocketClient object.
            %
            % Inputs:
            %   obj - WebSocketClient object
            %       webcoder.network.WebSocketClient                   
            %
            % Example:
            %   obj = webcoder.network.WebSocketClient('ws://echo.websocket.org');
            %   end(obj,'Hello from a client-side MATLAB app!');
            %   close(obj);
            %   remove(obj);
            %
            coder.cinclude("<functional>");
            coder.cinclude("<memory>");
            coder.cinclude("network/websocket/client.h");            
                        
            coder.ceval('std::mem_fn(&Network::WebSocket::Client::close)',obj.cppClient);  
        end
        
        %% Callback Interaction
        function addMessageEventListener(obj,callbackFcnName)
             % Add message event listener to the web socket object
            %
            % Use the addMouseEventListener method to add a callback
            % function to the HTML element that is run when the
            % event, eventName, is triggered on the element. The callback
            % function must be labelled in your project as a MouseEvent and
            % must use the following syntax:
            % 
            %   function callbackFcnName(event)
            %
            % where event is a MATLAB structure with the following form:
            %
            %   event = struct with fields:
            %            data: [1xn char] - message data received on web socket
			%          origin: [1xn char] - address of web socket server
			%       timeStamp: [double] - time since start of app in millseconds
			%       isTrusted: [logical] - was event triggered by trusted source?
            %
            %
            % Inputs:
            %   obj - Web socket object
            %       webcoder.dom.Element            
            %   callbackFcnName - Name of callback function
            %       character vector
            %
            % Example:
            %   obj = webcoder.network.WebSocketClient('ws://echo.websocket.org');   
            %   addMessageEventListener(obj,'myCallbackFcn');
            %   send(obj,'Hello from a client-side MATLAB app!');
            %
            %   where
            %
            %   function myCallbackFcn(event)
            %       webcoder.console.log(event.data);
            %   end
            %
            coder.cinclude("<functional>");
            coder.cinclude("<memory>");
            coder.cinclude("<string>");
            coder.cinclude("network/websocket/client.h");  
            
            coder.updateBuildInfo('addDefines','WEBSOCKETCLIENTMESSAGE');
            
            eventNameStr = coder.opaque("std::string","NULL");
            eventNameStr = coder.ceval("std::string",['message',0]);  
            
            callbackFcnNameStr = coder.opaque("std::string","NULL");
            callbackFcnNameStr = coder.ceval("std::string",[callbackFcnName,0]); 
            
            coder.ceval(...
                'std::mem_fn(&Network::WebSocket::Client::addEventListener)',...
                obj.cppClient,eventNameStr,callbackFcnNameStr);
        end
                      
        function removeMessageEventListener(obj,eventName,callbackFcnName)
            coder.cinclude("<functional>");
            coder.cinclude("<memory>");
            coder.cinclude("<string>");
            coder.cinclude("network/websocket/client.h"); 
                        
            eventNameStr = coder.opaque("std::string","NULL");
            eventNameStr = coder.ceval("std::string",[eventName,0]);  
            
            callbackFcnNameStr = coder.opaque("std::string","NULL");
            callbackFcnNameStr = coder.ceval("std::string",[callbackFcnName,0]); 
            
            coder.ceval(...
                'std::mem_fn(&Network::WebSocket::Client::removeEventListener)',...
                obj.cppClient,eventNameStr,callbackFcnNameStr);
        end
        
    end
    
    methods(Static)
        function remove(url)
            % Remove the web socket connection
            %
            % Use the remove method to remove the conection to the web socket 
            % server. Once a connection is closed, it cannot be reopened;
            % use the remove method to remove this connection then create a
            % new webcoder.network.WebSocketClient object.
            %
            % Inputs:
            %   obj - WebSocketClient object
            %       webcoder.network.WebSocketClient                   
            %
            % Example:
            %   obj = webcoder.network.WebSocketClient('ws://echo.websocket.org');
            %   send(obj,'Hello from a client-side MATLAB app!');
            %   close(obj);
            %   remove(obj);
            %
         
            coder.cinclude("<functional>");
            coder.cinclude("<memory>");
            coder.cinclude("<string>");
            coder.cinclude("network/websocket/client.h");               
            coder.updateBuildInfo('addSourceFiles','_client.cpp','$(SUPPORTPACKAGEROOT)/src/network/websocket');
                        
            urlStr = coder.opaque("std::string","NULL");
            urlStr = coder.ceval("std::string",[url,0]); 
                        
            coder.ceval("Network::WebSocket::Client::remove",urlStr);  
        end
    end
end

