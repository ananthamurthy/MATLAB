// Copyright 2019 The MathWorks, Inc.

#include "console/error.h"
#include <emscripten/val.h>
#include <string>

void console::error(const std::string message)
{
    emscripten::val window = emscripten::val::global("window");
    window["console"].call<void>("error", message);
}