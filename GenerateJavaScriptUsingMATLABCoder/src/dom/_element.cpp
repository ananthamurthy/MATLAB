// Copyright 2019 The MathWorks, Inc.
#include "dom/element.h"

using namespace emscripten;

DOM::Element::Element(const std::string id) : element_(val::global("document").call<val>("getElementById", id))
{
    // throw excpetion for element not found.
};

// Inner Text and HTML
auto DOM::Element::getInnerText(void) -> std::string
{
    return this->element_["innerText"].as<std::string>();
};

auto DOM::Element::getInnerHTML(void) -> std::string
{
    return this->element_["innerHTML"].as<std::string>();
};

auto DOM::Element::setInnerText(const std::string innerText) -> void
{
    this->element_.set("innerText",val(innerText));
    return;
};

auto DOM::Element::setInnerHTML(const std::string innerHTML) -> void
{
    this->element_.set("innerHTML",val(innerHTML));
    return;
};

// Cascading Style Sheet (CSS)
auto DOM::Element::getStyle(const std::string property) -> std::string
{
    const val window = val::global("window");
    const val style = window.call<val>("getComputedStyle", this->element_);
    return style[property].as<std::string>();
};

auto DOM::Element::setStyle(const std::string property, const std::string value) -> void
{
    this->element_["style"].call<void>("setProperty", property, value);
};

// Callbacks
auto DOM::Element::addEventListener(const std::string eventName, const std::string callbackFcnName) -> void
{
    const val callbackWrapperFcn = val::global("Module")[callbackFcnName];
    this->element_.call<void>("addEventListener", val(eventName), callbackWrapperFcn);
    return;
};

auto DOM::Element::removeEventListener(const std::string eventName, const std::string callbackFcnName) -> void
{
    const val callbackWrapperFcn = val::global("Module")[callbackFcnName];
    this->element_.call<void>("removeEventListener", val(eventName), callbackWrapperFcn);
    return;
};