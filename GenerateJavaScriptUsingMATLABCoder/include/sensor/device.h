// Copyright 2019 The MathWorks, Inc.
#ifndef SENSOR_DEVICE_H
#define SENSOR_DEVICE_H

#include <iostream>
#include <emscripten.h>
#include <emscripten/bind.h>
#include <emscripten/val.h>
#include <string>

namespace Sensor
{
class Device
{

private:
	const emscripten::val window_;

public:
	Device(void);

	// Callbacks
	auto addEventListener(const std::string eventName, const std::string callbackFcnName) -> void;
	auto removeEventListener(const std::string eventName, const std::string callbackFcnName) -> void;
};
} // namespace Sensor

#endif // SENSOR_DEVICE_H