// Copyright 2019 The MathWorks, Inc.
#include "sensor/device.h"
#include <iostream>
#include <string>

using namespace emscripten;

Sensor::Device::Device() : window_(val::global("window"))
{};

// Callbacks
auto Sensor::Device::addEventListener(const std::string eventName, const std::string callbackFcnName) -> void
{
    const val callbackWrapperFcn = val::global("Module")[callbackFcnName];
    this->window_.call<void>("addEventListener", val(eventName), callbackWrapperFcn);    
    return;
};

auto Sensor::Device::removeEventListener(const std::string eventName, const std::string callbackFcnName) -> void
{
    const val callbackWrapperFcn = val::global("Module")[callbackFcnName];
    this->window_.call<void>("removeEventListener", val(eventName), callbackWrapperFcn);
    return;
};