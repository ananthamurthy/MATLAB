classdef Element
    %ELEMENT Document Object Model (DOM) Element
    %   The Element object represents an Element in the DOM of an HTML
    %   page. With this object, you can access and modify the CSS style,
    %   text, and HTML content of the element. Adding callbacks, functions
    %   can be triggered and run when a mouse event occurs on the object.
    %
    %   Copyright 2019 The MathWorks, Inc.
    %
    
    properties (GetAccess = protected, SetAccess = immutable)
        cppElement
    end
    
    properties (SetAccess = private)
        callbacks       
    end
    
    methods
        %% Constructor
        function obj = Element(id)
            coder.cinclude("<functional>");
            coder.cinclude("<memory>");
            coder.cinclude("<string>");
            coder.cinclude("dom/element.h");   
            coder.updateBuildInfo('addSourceFiles','_element.cpp','$(SUPPORTPACKAGEROOT)/src/dom');
            
            cppStr = coder.opaque("std::string","NULL");
            cppStr = coder.ceval("std::string",[id,0]);               
            
            obj.cppElement = coder.opaque("std::shared_ptr<DOM::Element>","NULL","HeaderFile","dom/element.h");
            obj.cppElement = coder.ceval("std::make_shared<DOM::Element>",cppStr);            
        end
    end
    
    methods        
        %% CSS Interaction
        function setStyle(obj,property,value)
            % Set CSS style of Element object
            %
            % Use the setStyle method to set the value of CSS properties of
            % the Element object. The following example shows how to set
            % the background color of the Element to blue.
            %
            % Inputs:
            %   obj - Element object
            %       webcoder.dom.Element
            %   property - CSS property, see https://www.w3schools.com/cssref/
            %       character vector
            %   value - Value of CSS property, see Property Values in https://www.w3schools.com/cssref/
            %       character vector
            %
            % Example:
            %   obj = webcoder.dom.Element('myBtn');
            %   setStyle(obj,'background','blue');
            %
            coder.cinclude("<functional>");
            coder.cinclude("<memory>");
            coder.cinclude("<string>");
            coder.cinclude("dom/element.h"); 
            
            propertyStr = coder.opaque("std::string","NULL");
            propertyStr = coder.ceval("std::string",[property,0]);  
            
            valueStr = coder.opaque("std::string","NULL");
            valueStr = coder.ceval("std::string",[value,0]); 
            
            coder.ceval(...
                'std::mem_fn(&DOM::Element::setStyle)',...
                obj.cppElement,propertyStr,valueStr);            
            
        end
        
        function value = getStyle(obj,property)
            % Get CSS style of Element object
            %
            % Use the getStyle method to get the rendered value of CSS 
            % properties of the Element object. 
            %
            % Inputs:
            %   obj - Element object
            %       webcoder.dom.Element
            %   property - CSS property, see https://www.w3schools.com/cssref/
            %       character vector
            % Outputs:
            %   value - Value of CSS property, see Property Values in https://www.w3schools.com/cssref/
            %       character vector
            %
            % Example:
            %   The following example shows how to get the background color 
            %   of the Element.
            %
            %   obj = webcoder.dom.Element('myBtn');
            %   style = getStyle(obj,'background');
            %
            coder.cinclude("<functional>");
            coder.cinclude("<memory>");
            coder.cinclude("<string>");
            coder.cinclude("dom/element.h"); 
            
            propertyStr = coder.opaque("std::string","NULL","HeaderFile","<string>");
            propertyStr = coder.ceval("std::string",[property,0]);  
            
            valueStr = coder.opaque("std::string","NULL","HeaderFile","<string>");
            
            valueStr = coder.ceval(...
                'std::mem_fn(&DOM::Element::getStyle)',...
                obj.cppElement,propertyStr);     
            
            size_t = coder.opaque("size_t","NULL","HeaderFile","<string>");
            size_t = coder.ceval('std::mem_fn(&std::string::length)',valueStr);
            length = uint32(0);
            length = coder.ceval('(int)',size_t);
            
            value = char(zeros(1,length));
            coder.ceval('std::mem_fn(&std::string::copy)',valueStr,coder.ref(value),size_t,0);                       
            
            return;
        end
        
        function setInnerText(obj,value)
            % Set inner text of Element object
            %
            % Use the setInnerText method to set the inner text of the 
            % Element object. The inner text does not include any HTML
            % content within the HTML element. 
            %
            % Inputs:
            %   obj - Element object
            %       webcoder.dom.Element
            %   value - Value of inner text
            %       character vector
            %
            % Example:
            %   The following code shows how to set inner test of the 
            %   Element to 'Hello Browser'.
            %
            %   obj = webcoder.dom.Element('myBtn');
            %   setInnerText(obj,'Hello Browser');
            %
            coder.cinclude("<functional>");
            coder.cinclude("<memory>");
            coder.cinclude("<string>");
            coder.cinclude("dom/element.h"); 
                                    
            valueStr = coder.opaque("std::string","NULL");
            valueStr = coder.ceval("std::string",[value,0]); 
            
            coder.ceval(...
                'std::mem_fn(&DOM::Element::setInnerText)',...
                obj.cppElement,valueStr); 
            
            return;
        end
        
        function value = getInnerText(obj)
            % Get inner text of Element object
            %
            % Use the getInnerText method to get the inner text of the 
            % Element object. The inner text does not include any HTML
            % content within the HTML element. 
            %
            % Inputs:
            %   obj - Element object
            %       webcoder.dom.Element
            % Outputs:
            %   value - Value of inner text
            %       character vector
            %
            % Example:
            %   The following code shows how to get inner test from the 
            %   Element.
            %
            %   obj = webcoder.dom.Element('myBtn');
            %   value = getInnerText(obj);
            %
            coder.cinclude("<functional>");
            coder.cinclude("<memory>");
            coder.cinclude("<string>");
            coder.cinclude("dom/element.h"); 
                        
            valueStr = coder.opaque("std::string","NULL","HeaderFile","<string>");
            
            valueStr = coder.ceval(...
                'std::mem_fn(&DOM::Element::getInnerText)',...
                obj.cppElement);     
            
            size_t = coder.opaque("size_t","NULL","HeaderFile","<string>");
            size_t = coder.ceval('std::mem_fn(&std::string::length)',valueStr);
            length = uint32(0);
            length = coder.ceval('(int)',size_t);
            
            value = char(zeros(1,length));
            coder.ceval('std::mem_fn(&std::string::copy)',valueStr,coder.ref(value),size_t,0);                       
            
            return;
        end
        
        function setInnerHTML(obj,value)
            % Set inner HTML of Element object
            %
            % Use the setInnerHTML method to set the inner HTML of the 
            % Element object. 
            %
            % Inputs:
            %   obj - Element object
            %       webcoder.dom.Element
            %   value - Value of inner text
            %       character vector
            %
            % Example:
            %   The following code shows how to set inner text of the 
            %   Element to '<strong>Hello Browser</strong>'.
            %
            %   obj = webcoder.dom.Element('myBtn');
            %   setInnerHTML(obj,'<strong>Hello Browser</strong>');
            %
            coder.cinclude("<functional>");
            coder.cinclude("<memory>");
            coder.cinclude("<string>");
            coder.cinclude("dom/element.h"); 
                                    
            valueStr = coder.opaque("std::string","NULL");
            valueStr = coder.ceval("std::string",[value,0]); 
            
            coder.ceval(...
                'std::mem_fn(&DOM::Element::setInnerHTML)',...
                obj.cppElement,valueStr); 
            
            return;
        end
        
        function value = getInnerHTML(obj)
            % Get inner HTML of Element object
            %
            % Use the getInnerHTML method to get the inner HTML of the 
            % Element object.  
            %
            % Inputs:
            %   obj - Element object
            %       webcoder.dom.Element
            % Outputs:
            %   value - Value of inner HTML
            %       character vector
            %
            % Example:
            %   The following code shows how to get inner HTML from the 
            %   Element.
            %
            %   obj = webcoder.dom.Element('myBtn');
            %   htmlText = getInnerText(obj);
            %
            coder.cinclude("<functional>");
            coder.cinclude("<memory>");
            coder.cinclude("<string>");
            coder.cinclude("dom/element.h"); 
                        
            valueStr = coder.opaque("std::string","NULL","HeaderFile","<string>");
            
            valueStr = coder.ceval(...
                'std::mem_fn(&DOM::Element::getInnerHTML)',...
                obj.cppElement);     
            
            size_t = coder.opaque("size_t","NULL","HeaderFile","<string>");
            size_t = coder.ceval('std::mem_fn(&std::string::length)',valueStr);
            length = uint32(0);
            length = coder.ceval('(int)',size_t);
            
            value = char(zeros(1,length));
            coder.ceval('std::mem_fn(&std::string::copy)',valueStr,coder.ref(value),size_t,0);                       
            
            return;
        end
        
        %% Callback Interaction
        function addMouseEventListener(obj,eventName,callbackFcnName)
            % Add Mouse event listener to Element object
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
            %              id: [1xn char] - id of element that launched the callback
			%         offsetX: [double] - pixel distance from left side of the element 
			%         offsetY: [double] - pixel distance from top side of the element
			%       timeStamp: [double] - time since start of app in millseconds
			%       isTrusted: [logical] - was event triggered by trusted source?
            %
            %
            % Inputs:
            %   obj - Element object
            %       webcoder.dom.Element
            %   eventName - Name of event to trigger callback function
            %       click | dblclick | contextmenu | mousedown | mouseup
            %       | mouseleave | mousemove | mouseout | mouseover |
            %       mouseup
            %   callbackFcnName - Name of callback function
            %       character vector
            %
            % Example:
            %   obj = webcoder.dom.Element('myBtn');
            %   addMouseEventListener(obj,'click','myCallbackFcn');
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
            
            coder.extrinsic('webcoder.internal.project.isCallback');
            cond = coder.const(webcoder.internal.project.isCallback(string(callbackFcnName),"Callbacks","MouseEvent"));
            coder.internal.assert(cond,'webcoder:codegen:CallbackFunctionRequiresMouseEventLabel',callbackFcnName);
            
               
            eventNameStr = coder.opaque("std::string","NULL");
            eventNameStr = coder.ceval("std::string",[eventName,0]);  
            
            callbackFcnNameStr = coder.opaque("std::string","NULL");
            callbackFcnNameStr = coder.ceval("std::string",[callbackFcnName,0]); 
            
            coder.ceval(...
                'std::mem_fn(&DOM::Element::addEventListener)',...
                obj.cppElement,eventNameStr,callbackFcnNameStr);
        end
                      
        function removeMouseEventListener(obj,eventName,callbackFcnName)
            % Remove Mouse event listener from Element object
            %
            % Use the addMouseEventListener method to remove a callback
            % function from the HTML element that is run by the
            % event, eventName, is triggered on the element. The callback
            % function must be labelled in your project as a MouseEvent and
            % must use the following syntax:
            % 
            %   function callbackFcnName(event)
            %
            % where event is a MATLAB structure with the following form:
            %
            %   event = struct with fields:
            %              id: [1xn char]
			%         offsetX: [double]
			%         offsetY: [double]
			%       timeStamp: [double]
			%       isTrusted: [logical]
            %
            %
            % Inputs:
            %   obj - Element object
            %       webcoder.dom.Element
            %   eventName - Name of event to trigger callback function
            %       click | dblclick | contextmenu | mousedown | mouseup
            %       | mouseleave | mousemove | mouseout | mouseover |
            %       mouseup
            %   callbackFcnName - Name of callback function
            %       character vector
            %
            % Example:
            %   obj = webcoder.dom.Element('myBtn');
            %   removeMouseEventListener(obj,'click','myCallbackFcn');
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
            
            coder.extrinsic('webcoder.internal.project.isCallback');
            cond = coder.const(webcoder.internal.project.isCallback(string(callbackFcnName),"Callbacks","MouseEvent"));
            coder.internal.assert(cond,'webcoder:codegen:CallbackFunctionRequiresMouseEventLabel',callbackFcnName);
                        
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

