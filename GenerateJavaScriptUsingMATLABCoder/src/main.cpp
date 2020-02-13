// Copyright 2019 The MathWorks, Inc.

#include <emscripten.h>
#include "start.h"
#include "render.h"


int main() {
    
    start();
    
    emscripten_set_main_loop(&render, 10, 1);
   
    return 0;
}

