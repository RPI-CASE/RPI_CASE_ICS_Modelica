// INCLUDE YOUR LIBRARY
loadModel(Modelica);
//loadModel(Builinds1.6);
loadFile("D:/Application/OpenModelica1.9.1/lib/omlibrary/Buildings 1.6/package.mo");


loadFile("C:/Users/Kenton/Documents/GitHub/RPI_CASE_ICS_Modelica/ICSolar.mo")


getErrorString(); // this is her for some reason

simulate(BouncingBall, stopTime=3.0);
getErrorString();
// plotting height h and flying status
plot({h,flying});
// or plotting speed v
// plot(v);
// plotting all variables
// plotAll(BouncingBall);
// Remove generated files is disabled because if you run it at the same time as plotting, the plot tool might crash
// system("rm -rf BouncingBall.log BouncingBall.makefile BouncingBall BouncingBall.exe BouncingBall.libs BouncingBall.cpp BouncingBall_* output.log");


experiment(StartTime = 7.137e+06, StopTime = 7.1412e+06, Tolerance = 1e-06, Interval = 10));

simulate(ICSolar.ICS_Skeleton,startTime=7.137e+06, StopTime = 7.1412e+06, Interval = 10)