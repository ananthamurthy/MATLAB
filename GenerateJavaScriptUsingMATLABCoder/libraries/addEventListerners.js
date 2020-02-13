Module["ML_CallbackRegistration"] = {
    eventCallbacks: new Map(),
    mouseEventCallbacks: new Map(),
    addEventListener: () => {},
    addMouseEventListener: (id,eventName,callbackName) => {

        console.log(id);
        console.log(eventName);
        console.log(callbackName);


        const element = document.getElementById(id);

        const key = {
            eventName: eventName,
            callbackName: callbackName
        };

        if (!(element._mlMouseCallbacks instanceof Map)) {
            element._mlMouseCallbacks = new Map();
        };

        if (element._mlMouseCallbacks.has(key)) {
            return true;
        };

        const callbackFcn = (mouseEvent) => {
            let id = mouseEvent.target.id;
            let event = {
                X: mouseEvent.offsetX,
                Y: mouseEvent.offsetY
            };

            //Module.ccall(callbackName, // name of C function
            //    null, // return type
            //    null, // argument types
            //    [null]); // arguments

            Module.ccall(callbackName); // arguments

        };

        element.addEventListener(eventName,callbackFcn);

        element._mlMouseCallbacks.set(key,callbackFcn);

        return false;


    }
};