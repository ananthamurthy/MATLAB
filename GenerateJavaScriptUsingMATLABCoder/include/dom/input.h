// Copyright 2019 The MathWorks, Inc.
#ifndef DOM_INPUT_H
#define DOM_INPUT_H

#include <iostream>
#include "dom/element.h"
#include <emscripten.h>
#include <emscripten/bind.h>
#include <emscripten/val.h>
#include <string>

namespace DOM
{
class Input : public Element
{

public:	
    Input(const std::string id);

    // Checked
    auto checked(void) -> bool;
    auto setChecked(const bool value) -> void;

    // Value
    auto value(void) -> std::string;
    auto setValue(const std::string value) -> void;
};
} // namespace DOM

#endif // DOM_INPUT_H