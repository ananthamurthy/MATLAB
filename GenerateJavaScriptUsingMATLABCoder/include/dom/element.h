// Copyright 2019 The MathWorks, Inc.
#ifndef DOM_ELEMENT_H
#define DOM_ELEMENT_H

#include <iostream>
#include <emscripten.h>
#include <emscripten/bind.h>
#include <emscripten/val.h>
#include <string>

namespace DOM
{
class Element
{

protected:
	emscripten::val element_;

public:
	Element(const std::string id);

	// Inner Text and HTML
	auto getInnerText(void) -> std::string;
	auto setInnerText(const std::string innerText) -> void;

	auto getInnerHTML(void) -> std::string;	
	auto setInnerHTML(const std::string innerHTML) -> void;

	// Cascading Style Sheet (CSS)
	auto getStyle(const std::string property) -> std::string;
	auto setStyle(const std::string property, const std::string value) -> void;

	// Callbacks
	auto addEventListener(const std::string eventName, const std::string callbackFcnName) -> void;
	auto removeEventListener(const std::string eventName, const std::string callbackFcnName) -> void;
};
} // namespace DOM

#endif // DOM_ELEMENT_H