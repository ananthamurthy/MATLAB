// Copyright 2019 The MathWorks, Inc.
#include "dom/input.h"

using namespace emscripten;

DOM::Input::Input(const std::string id) : DOM::Element::Element(id)
{
    // throw excpetion for element not found.
};

// Inner Text and HTML
auto DOM::Input::checked(void) -> bool
{
    return this->element_["checked"].as<bool>();
};

auto DOM::Input::setChecked(const bool value) -> void
{
    this->element_.set("checked",val(value));
    return;
};

auto DOM::Input::value(void) -> std::string
{
    return this->element_["value"].as<std::string>();
};

auto DOM::Input::setValue(const std::string value) -> void
{
    this->element_.set("value",val(value));
    return;
};