% AUTHOR: Kambadur Ananthamurthy
function methodList = determineMethod(runA, runB, runC, runD, runE)

methodList = "";

if runA
    methodList = strcat(methodList, "A");
end

if runB
    methodList = strcat(methodList, "B");
end

if runC
    methodList = strcat(methodList, "C");
end

if runD
    methodList = strcat(methodList, "D");
end

if runE
    methodList = strcat(methodList, "E");
end