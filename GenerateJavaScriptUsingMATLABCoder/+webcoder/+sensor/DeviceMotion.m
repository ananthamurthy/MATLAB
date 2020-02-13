classdef DeviceMotion
    %DEVICEMOTION Virtual sensor on Supported Device
    %   The DeviceMoiton object is a virtual sensor that combines the real
    %   accelerometer, rate gyrometer, and magnetometer into a single
    %   sensor that provides full-axis measurements of the device
    %   translation and orientation.
    %
    %   Copyright 2019 The MathWorks, Inc.
    
    properties (GetAccess = private, SetAccess = immutable)
        cppDeviceMotion
    end
    
    properties (SetAccess = private)
        callbacks       
    end
    
    methods
        %% Constructor
        function obj = DeviceMotion
            coder.cinclude("<functional>");
            coder.cinclude("<memory>");
            coder.cinclude("<string>");
            coder.cinclude("sensor/device.h");   
            coder.updateBuildInfo('addSourceFiles','_device.cpp','$(SUPPORTPACKAGEROOT)/src/sensor');
            
            obj.cppDeviceMotion = coder.opaque("std::unique_ptr<Sensor::Device>","NULL","HeaderFile","sensor/device.h");
            obj.cppDeviceMotion = coder.ceval("std::make_unique<Sensor::Device>");            
        end
    end
    
    methods                  
        
        %% Callback Interaction
        function addDeviceOrientationEventListener(obj,callbackFcnName)
            % Add DeviceOrientation event listener to the app
            %
            % Use the addDeviceOrientationEventListener method to add a 
            % callback function to the app that is run when new device 
            % orientation data arrives. The callback function must be 
            % labelled in your project as a DeviceOrientation and
            % must use the following syntax:
            % 
            %   function callbackFcnName(event)
            %
            % where event is a MATLAB structure with the following form:
            %
            %   event = struct with fields:
            %           alpha: [double] - Yaw of device in degrees
            %            beta: [double] - Pitch of device in degrees
            %           gamma: [double] - Roll of device in degrees
            %        absolute: [logical] - Is measurement magnetometer corrected?       
			%       timeStamp: [double]
			%       isTrusted: [logical] - was event triggered by trusted source?
            %
            %
            % Inputs:
            %   obj - Element object
            %       webcoder.dom.Element            
            %   callbackFcnName - Name of callback function
            %       character vector
            %
            % Example:
            %   obj = webcoder.sensor.DeviceMotion();
            %   addDeviceOrientationEventListener(obj,'myCallbackFcn');
            %
            %   where
            %
            %   function myCallbackFcn(event)
            %       webcoder.console.log(['Pitch is ', sprintf('%f',event.beta)]);
            %   end
            %
            coder.cinclude("<functional>");
            coder.cinclude("<memory>");
            coder.cinclude("<string>");
            coder.cinclude("sensor/device.h");  
            
            coder.extrinsic('webcoder.internal.project.isCallback');
            cond = coder.const(webcoder.internal.project.isCallback(string(callbackFcnName),"Callbacks","DeviceOrientationEvent"));
            coder.internal.assert(cond,'webcoder:codegen:CallbackFunctionRequiresDeviceOrientationEventLabel',callbackFcnName);
                           
            eventNameStr = coder.opaque("std::string","""deviceorientation""");
            
            callbackFcnNameStr = coder.opaque("std::string","NULL");
            callbackFcnNameStr = coder.ceval("std::string",[callbackFcnName,0]); 
            
            coder.ceval(...
                'std::mem_fn(&Sensor::Device::addEventListener)',...
                obj.cppDeviceMotion,eventNameStr,callbackFcnNameStr);
        end
                      
        function removeDeviceOrientationEventListener(obj,callbackFcnName)
            % Remove DeviceOrientation event listener from the app
            %
            % Use the removeDeviceOrientationEventListener method to remove
            % a callback function from the app that is run when new device 
            % orientation data arrives. The callback function must have 
            % been previously added to the app using the 
            % addDeviceOrientationEventListener method. 
            %
            %
            % Inputs:
            %   obj - Element object
            %       webcoder.dom.Element            
            %   callbackFcnName - Name of callback function
            %       character vector
            %
            % Example:
            %   obj = webcoder.sensor.DeviceMotion();
            %   removeDeviceOrientationEventListener(obj,'myCallbackFcn');
            %
            %   where
            %
            %   function myCallbackFcn(event)
            %       webcoder.console.log(['Pitch is ', sprintf('%f',event.beta)]);
            %   end
            %
            coder.cinclude("<functional>");
            coder.cinclude("<memory>");
            coder.cinclude("<string>");
            coder.cinclude("sensor/device.h");  
            
            coder.extrinsic('webcoder.internal.project.isCallback');
            cond = coder.const(webcoder.internal.project.isCallback(string(callbackFcnName),"Callbacks","DeviceOrientationEvent"));
            coder.internal.assert(cond,'webcoder:codegen:CallbackFunctionRequiresDeviceOrientationEventLabel',callbackFcnName);
                           
            eventNameStr = coder.opaque("std::string","""deviceorientation""");
            
            callbackFcnNameStr = coder.opaque("std::string","NULL");
            callbackFcnNameStr = coder.ceval("std::string",[callbackFcnName,0]); 
                        
            coder.ceval(...
                'std::mem_fn(&Sensor::Device::removeEventListener)',...
                obj.cppDeviceMotion,eventNameStr,callbackFcnNameStr);
        end
   
        function addDeviceMotionEventListener(obj,callbackFcnName)
            % Add DeviceMotion event listener to the app
            %
            % Use the addDeviceOrientationEventListener method to add a 
            % callback function to the app that is run when new device 
            % orientation data arrives. The callback function must be 
            % labelled in your project as a DeviceOrientation and
            % must use the following syntax:
            % 
            %   function callbackFcnName(event)
            %
            % where event is a MATLAB structure with the following form:
            %
            %   event = struct with fields:
            %       acceleration: [struct]
            %               .x: [double] - Acceleration in x-axis
            %               .y: [double] - Acceleration in y-axis
            %               .z: [double] - Acceleration in z-axis
            %   accelerationIncludingGravity: [struct]
            %               .x: [double] - Acceleration in x-axis
            %               .y: [double] - Acceleration in y-axis
            %               .z: [double] - Acceleration in z-axis
            %       rotationRate: [struct]
            %           .alpha: [double] - Yaw of device in degrees
            %            .beta: [double] - Pitch of device in degrees
            %           .gamma: [double] - Roll of device in degrees
            %       absolute: [logical] - Is measurement magnetometer corrected?       
			%       timeStamp: [double]
			%      isTrusted: [logical] - was event triggered by trusted source?
            %        interval: [double]
            %
            %
            % Inputs:
            %   obj - Element object
            %       webcoder.dom.Element            
            %   callbackFcnName - Name of callback function
            %       character vector
            %
            % Example:
            %   obj = webcoder.sensor.DeviceMotion();
            %   addDeviceMotionEventListener(obj,'myCallbackFcn');
            %
            %   where
            %
            %   function myCallbackFcn(event)
            %       webcoder.console.log(['Pitch is ', sprintf('%f',event.beta)]);
            %   end
            %
            coder.cinclude("<functional>");
            coder.cinclude("<memory>");
            coder.cinclude("<string>");
            coder.cinclude("sensor/device.h");  
            
            coder.extrinsic('webcoder.internal.project.isCallback');
            cond = coder.const(webcoder.internal.project.isCallback(string(callbackFcnName),"Callbacks","DeviceMotionEvent"));
            coder.internal.assert(cond,'webcoder:codegen:CallbackFunctionRequiresDeviceMotionEventLabel',callbackFcnName);
                           
            eventNameStr = coder.opaque("std::string","""devicemotion""");
            
            callbackFcnNameStr = coder.opaque("std::string","NULL");
            callbackFcnNameStr = coder.ceval("std::string",[callbackFcnName,0]); 
            
            coder.ceval(...
                'std::mem_fn(&Sensor::Device::addEventListener)',...
                obj.cppDeviceMotion,eventNameStr,callbackFcnNameStr);
        end
                      
        function removeDeviceMotionEventListener(obj,callbackFcnName)
            % Remove DeviceMotion event listener to the app
            %
            % Use the removeDeviceMotionEventListener method to remove
            % a callback function from the app that is run when new device 
            % motion data arrives. The callback function must have been 
            % previously added to the app using the 
            % addDeviceMotionEventListener method. 
            %
            %
            % Inputs:
            %   obj - Element object
            %       webcoder.dom.Element            
            %   callbackFcnName - Name of callback function
            %       character vector
            %
            % Example:
            %   obj = webcoder.sensor.DeviceMotion();
            %   removeDeviceMotionEventListener(obj,'myCallbackFcn');
            %
            %   where
            %
            %   function myCallbackFcn(event)
            %       webcoder.console.log(['Pitch is ', sprintf('%f',event.beta)]);
            %   end
            %
            coder.cinclude("<functional>");
            coder.cinclude("<memory>");
            coder.cinclude("<string>");
            coder.cinclude("sensor/device.h");  
            
            coder.extrinsic('webcoder.internal.project.isCallback');
            cond = coder.const(webcoder.internal.project.isCallback(string(callbackFcnName),"Callbacks","DeviceMotionEvent"));
            coder.internal.assert(cond,'webcoder:codegen:CallbackFunctionRequiresDeviceMotionEventLabel',callbackFcnName);
                           
            eventNameStr = coder.opaque("std::string","""devicemotion""");
            
            callbackFcnNameStr = coder.opaque("std::string","NULL");
            callbackFcnNameStr = coder.ceval("std::string",[callbackFcnName,0]); 
                        
            coder.ceval(...
                'std::mem_fn(&Sensor::Device::removeEventListener)',...
                obj.cppDeviceMotion,eventNameStr,callbackFcnNameStr);
        end
        
    end
end

