// Copyright 2019 The MathWorks, Inc.

#include "console/log.h"
#include <iostream>
#include <string>

void console::log(const char* message)
{
    std::cout << std::string(message) << std::endl;
}