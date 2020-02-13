classdef Input < webcoder.dom.Element
    %INPUT Document Object Model (DOM) Input Element
    %   The Input Element object represents an Element in the DOM of an HTML
    %   page. With this object, you can access and modify the CSS style,
    %   text, and HTML content of the element. Adding callbacks, functions
    %   can be triggered and run when a mouse or change event occurs on the
    %   object.
    %
    %   Copyright 2019 The MathWorks, Inc.
    %
    
    properties (GetAccess = private, SetAccess = immutable)
        cppInputElement
    end
    
    methods
        %% Constructor
        function obj = Input(id)           
             
            coder.cinclude("dom/input.h"); 
            coder.updateBuildInfo('addSourceFiles','_input.cpp','$(SUPPORTPACKAGEROOT)/src/dom');
            
            obj = obj@webcoder.dom.Element(id);                    
        end
    end
    
    methods        
        %% Checked Status
        function setChecked(obj,value)
            % Set checked status of Input object
            %
            % Use the setChecked method to set the checked value 
            % of the Input object. The following example shows how to set
            % the checked status of the Input object.
            %
            % Inputs:
            %   obj - Input object
            %       webcoder.dom.Input
            %   value - Checked value Input object
            %       character vector
            %
            % Example:
            %   The following example shows how to set the checked value of 
            %   an Input object, <input type="checkbox" id="myCheckbox></input>,
            %   in the HTML DOM.
            %
            %   obj = webcoder.dom.Input('myCheckbox');
            %   setChecked(obj,true);
            %
            coder.cinclude("<functional>");
            coder.cinclude("<memory>");
            coder.cinclude("<string>");
            coder.cinclude("dom/element.h"); 
            coder.cinclude("dom/input.h"); 
            
            cppInput = coder.opaque("std::shared_ptr<DOM::Input>","NULL","HeaderFile","dom/input.h");
            cppInput = coder.ceval("std::static_pointer_cast<DOM::Input>",obj.cppElement); 
                                    
            coder.ceval(...
                'std::mem_fn(&DOM::Input::setChecked)',...
                cppInput,logical(value));            
            
        end
        
        function value = getChecked(obj)
            % Get checked value of Input object
            %
            % Use the getChecked method to get the checked value of the
            % Input object. 
            %
            % Inputs:
            %   obj - Input object
            %       webcoder.dom.Input
            %   property - CSS property, see https://www.w3schools.com/cssref/
            %       character vector
            % Outputs:
            %   value - Value of CSS property, see Property Values in https://www.w3schools.com/cssref/
            %       character vector
            %
            % Example:
            %   The following example shows how to get the checked value of 
            %   an Input object, <input type="checkbox" id="myCheckbox></input>,
            %   in the HTML DOM.
            %
            %   obj = webcoder.dom.Input('myCheckbox');
            %   tf = getChecked(obj);
            %
            coder.cinclude("<functional>");
            coder.cinclude("<memory>");
            coder.cinclude("<string>");
            coder.cinclude("dom/element.h"); 
            coder.cinclude("dom/input.h"); 
            
            cppInput = coder.opaque("std::shared_ptr<DOM::Input>","NULL","HeaderFile","dom/input.h");
            cppInput = coder.ceval("std::static_pointer_cast<DOM::Input>",obj.cppElement); 
                                    
            value = false;
            value = coder.ceval(...
                'std::mem_fn(&DOM::Input::checked)',cppInput);
            
            return;
        end
        
        function setValue(obj,value)
            % Set value of Input object
            %
            % Use the setValue method to set the value property of the 
            % Input object.
            %
            % Inputs:
            %   obj - Input object
            %       webcoder.dom.Input
            %   value - Value of value property
            %       character vector
            %
            % Example:
            %   The following code shows how to set value of the 
            %   Input element, <input type="text" id="myEditbox></input>,
            %   in the HTML DOM to 'Hello Browser'.
            %
            %   obj = webcoder.dom.Input('myEditbox');
            %   setValue(obj,'Hello Browser');
            %
            coder.cinclude("<functional>");
            coder.cinclude("<memory>");
            coder.cinclude("<string>");
            coder.cinclude("dom/element.h"); 
            coder.cinclude("dom/input.h");
                                    
            valueStr = coder.opaque("std::string","NULL");
            valueStr = coder.ceval("std::string",[value,0]); 
                        
            cppInput = coder.opaque("std::shared_ptr<DOM::Input>","NULL","HeaderFile","dom/input.h");
            cppInput = coder.ceval("std::static_pointer_cast<DOM::Input>",obj.cppElement); 
                                    
            coder.ceval(...
                'std::mem_fn(&DOM::Input::setValue)',...
                cppInput,valueStr);   
        end
        
        function value = getValue(obj)
            % Get value of Input object
            %
            % Use the getValue method to get the current value of the 
            % Input object value property.
            %
            % Inputs:
            %   obj - Input object
            %       webcoder.dom.Input
            % Outputs:
            %   value - Value of Input
            %       character vector
            %
            % Example:
            %   The following code shows how to get value from the 
            %   Input element, <input type="text" id="myEditbox></input>,
            %   in the HTML DOM.
            %
            %   obj = webcoder.dom.Input('myEditbox');
            %   value = getValue(obj);
            %
            coder.cinclude("<functional>");
            coder.cinclude("<memory>");
            coder.cinclude("<string>");
            coder.cinclude("dom/element.h"); 
            coder.cinclude("dom/input.h");
                        
            cppInput = coder.opaque("std::shared_ptr<DOM::Input>","NULL","HeaderFile","dom/input.h");
            cppInput = coder.ceval("std::static_pointer_cast<DOM::Input>",obj.cppElement); 
            
            valueStr = coder.opaque("std::string","NULL","HeaderFile","<string>");
                        
            valueStr = coder.ceval(...
                'std::mem_fn(&DOM::Input::value)',cppInput);     
            
            size_t = coder.opaque("size_t","NULL","HeaderFile","<string>");
            size_t = coder.ceval('std::mem_fn(&std::string::length)',valueStr);
            length = uint32(0);
            length = coder.ceval('(int)',size_t);
            
            value = char(zeros(1,length));
            coder.ceval('std::mem_fn(&std::string::copy)',valueStr,coder.ref(value),size_t,0);                       
            
            return;
        end
                
        %% Callback Interaction
        function addChangeEventListener(obj,callbackFcnName)
            % Add Change event listener to Input object
            %
            % Use the addChangeEventListener method to add a callback
            % function to the HTML element that is run when a change
            % event is triggered on the element. The callback
            % function must be labelled in your project as an Event and
            % must use the following syntax:
            % 
            %   function callbackFcnName(event)
            %
            % where event is a MATLAB structure with the following form:
            %
            %   event = struct with fields:
            %              id: [1xn char] - id of element that launched the callback
			%       timeStamp: [double] - 
			%       isTrusted: [logical] - was event triggered by trusted source?
            %
            %
            % Inputs:
            %   obj - Input object
            %       webcoder.dom.Input           
            %   callbackFcnName - Name of callback function
            %       character vector
            %
            % Example:
            %   obj = webcoder.dom.Input('myEditBox');
            %   addChangeEventListener(obj,'myCallbackFcn');
            %
            %   where
            %
            %   function myCallbackFcn(event)
            %       webcoder.console.log([event.id,' changed!']);
            %   end
            %
            coder.cinclude("<functional>");
            coder.cinclude("<memory>");
            coder.cinclude("<string>");
            coder.cinclude("dom/element.h");
            
            coder.extrinsic('webcoder.internal.project.isCallback');
            cond = coder.const(webcoder.internal.project.isCallback(string(callbackFcnName),"Callbacks","Event"));
            coder.internal.assert(cond,'webcoder:codegen:CallbackFunctionRequiresMouseEventLabel',callbackFcnName);
            
               
            eventNameStr = coder.opaque("std::string","NULL");
            eventNameStr = coder.ceval("std::string",['change',0]);  
            
            callbackFcnNameStr = coder.opaque("std::string","NULL");
            callbackFcnNameStr = coder.ceval("std::string",[callbackFcnName,0]); 
            
            coder.ceval(...
                'std::mem_fn(&DOM::Element::addEventListener)',...
                obj.cppElement,eventNameStr,callbackFcnNameStr);
        end
                      
        function removeChangeEventListener(obj,callbackFcnName)
            % Remove Change event listener from Element object
            %
            % Use the addChangeEventListener method to remove a callback
            % function from the HTML input element that is run when a change
            % event is triggered on the element. The callback function must 
            % be labelled in your project as a MouseEvent and must use the 
            % following syntax:
            % 
            %   function callbackFcnName(event)
            %
            % where event is a MATLAB structure with the following form:
            %
            %   event = struct with fields:
            %              id: [1xn char]
			%       timeStamp: [double]
			%       isTrusted: [logical]
            %
            %
            % Inputs:
            %   obj - Element object
            %       webcoder.dom.Element
            %   callbackFcnName - Name of callback function
            %       character vector
            %
            % Example:
            %   obj = webcoder.dom.Input('myEditBox');
            %   removeChangeEventListener(obj,'myCallbackFcn');
            %
            %   where
            %
            %   function myCallbackFcn(event)
            %       webcoder.console.log([event.id,' was clicked!']);
            %   end
            %
            coder.cinclude("<functional>");
            coder.cinclude("<memory>");
            coder.cinclude("<string>");
            coder.cinclude("dom/element.h"); 
            coder.cinclude("dom/input.h");
            
            coder.extrinsic('webcoder.internal.project.isCallback');
            cond = coder.const(webcoder.internal.project.isCallback(string(callbackFcnName),"Callbacks","Event"));
            coder.internal.assert(cond,'webcoder:codegen:CallbackFunctionRequiresEventLabel',callbackFcnName);
                        
            eventNameStr = coder.opaque("std::string","NULL");
            eventNameStr = coder.ceval("std::string",[eventName,0]);  
            
            callbackFcnNameStr = coder.opaque("std::string","NULL");
            callbackFcnNameStr = coder.ceval("std::string",[callbackFcnName,0]); 
            
            coder.ceval(...
                'std::mem_fn(&DOM::Element::removeEventListener)',...
                obj.cppElement,eventNameStr,callbackFcnNameStr);
        end
                
    end
end

