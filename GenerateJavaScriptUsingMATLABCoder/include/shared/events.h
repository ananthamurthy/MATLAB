// Copyright 2019 The MathWorks, Inc.
#include <iostream>
#include <emscripten.h>
#include <emscripten/bind.h>
#include <emscripten/val.h>
#include <string>
#include <cmath>

#if defined(MOUSEEVENT) || \
defined(MESSAGEEVENT) || \
defined(EVENT)
#include MATLAB_GENERATED_EMXAPI_HEADER
#include MATLAB_GENERATED_TYPES_HEADER
#endif

using namespace emscripten;

namespace Shared {
namespace Event {

    #ifdef EVENT
    template<auto (*callback)(const EventData *)->void>
    static void eventCallbackWrapper(val event)
    {
        const std::string id = event["target"]["id"].as<std::string>();		
		int size[2] = {(int)1, (int)id.size()};
		
		EventData eventData = {
			.id = emxCreateWrapperND_char_T(const_cast<char*>(id.c_str()), 2, size),
			.timeStamp = event["timeStamp"].as<double>(),
			.isTrusted = event["isTrusted"].as<bool>()
		};
        
        callback(&eventData);
        return;
    };    
    #endif
    
    #ifdef MOUSEEVENT	
    template<auto (*callback)(const MouseEventData *)->void>
    static void mouseEventCallbackWrapper(val event)
    {
		const std::string id = event["target"]["id"].as<std::string>();		
		int size[2] = {(int)1, (int)id.size()};
		
		MouseEventData mouseEventData = {
			.id = emxCreateWrapperND_char_T(const_cast<char*>(id.c_str()), 2, size),
			.offsetX = event["offsetX"].as<double>(),
			.offsetY = event["offsetY"].as<double>(),
			.timeStamp = event["timeStamp"].as<double>(),
			.isTrusted = event["isTrusted"].as<bool>()
		};
        
        callback(&mouseEventData);
        return;
    };
    #endif

    #ifdef MESSAGEEVENT
    template <auto (*callback)(const MessageEventData *)->void>
    static void messageEventCallbackWrapper(emscripten::val event)
    {
        const std::string data = event["data"].as<std::string>();
        int size[2] = {(int)1, (int)data.size()};

        MessageEventData messageEventData = {
            emxCreateWrapperND_char_T(const_cast<char *>(data.c_str()), 2, size)};

        callback(&messageEventData);
        return;
    };
    #endif

    #ifdef DEVICEMOTIONEVENT
    template <auto (*callback)(const DeviceMotionEventData *)->void>
    static void deviceMotionEventCallbackWrapper(emscripten::val event)
    {

        emscripten::val window = emscripten::val::global("window");
        window["console"].call<void>("log", event);
        
        auto getValue = [](emscripten::val value)
        {
            if(value == emscripten::val::null())
                return std::nan("1");
            else
                return value.as<double>();
        };        

        DeviceMotionEventData deviceMotionEventData = {
			.acceleration.x = getValue(event["acceleration"]["x"]),
            .acceleration.y = getValue(event["acceleration"]["y"]),
            .acceleration.z = getValue(event["acceleration"]["z"]),
            .accelerationIncludingGravity.x = getValue(event["accelerationIncludingGravity"]["x"]),
            .accelerationIncludingGravity.y = getValue(event["accelerationIncludingGravity"]["y"]),
            .accelerationIncludingGravity.z = getValue(event["accelerationIncludingGravity"]["z"]),
            .rotationRate.alpha = getValue(event["rotationRate"]["alpha"]),
            .rotationRate.beta = getValue(event["rotationRate"]["beta"]),
            .rotationRate.gamma = getValue(event["rotationRate"]["gamma"]),
            .interval = getValue(event["interval"]),
            .timeStamp = getValue(event["timeStamp"]),
			.isTrusted = event["isTrusted"].as<bool>()
		};
        
        callback(&deviceMotionEventData);
        return;
    };
    #endif

    #ifdef DEVICEORIENTATIONEVENT
    template <auto (*callback)(const DeviceOrientationEventData *)->void>
    static void deviceOrientationEventCallbackWrapper(emscripten::val event)
    {
        emscripten::val window = emscripten::val::global("window");

        auto getEventValue = [](emscripten::val event, const std::string property)
        {
            if(event[property] == emscripten::val::null())
                return std::nan("1");
            else
                return event[property].as<double>();
        };

        DeviceOrientationEventData deviceOrientationEventData = {
            .alpha = getEventValue(event,"alpha"),
            .beta = getEventValue(event,"beta"),
            .gamma = getEventValue(event,"gamma"),
            .absolute = event["absolute"].as<bool>(),
			.timeStamp = getEventValue(event,"timeStamp"),
			.isTrusted = event["isTrusted"].as<bool>()
		};
        
        callback(&deviceOrientationEventData);
        return;
    };
    #endif
}
}