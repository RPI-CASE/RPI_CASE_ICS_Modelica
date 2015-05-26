function simulate
  input String var;
  input Real value;
  output Real RootMean[:];

loadModel(Modelica);
loadFile("RMSE.mo");

//loadModel(Builinds1.6);
loadFile("D:/Application/OpenModelica1.9.1/lib/omlibrary/Buildings 1.6/package.mo");





//load IC Solar Fiel
loadFile("C:/Users/Kenton/Documents/GitHub/RPI_CASE_ICS_Modelica/ICSolar.mo");
// Use this to report the error is run the script
getErrorString(); 


//Make sure we have the proper path
setParameterValue(ICSolar.Parameters, Path, "C:\\Users\\Kenton\\Documents\\GitHub\\RPI_CASE_ICS_Modelica\\");
setParameterValue(ICSolar.shadingImport, Path_2, "C:\\Users\\Kenton\\Documents\\GitHub\\RPI_CASE_ICS_Modelica\\shading_matrices\\");
  
algorithm 
setParameterValue(ICSolar.Parameters, var, value);
simulate(ICSolar.ICS_Skeleton,startTime=7123000.0, StopTime = 7147500.0, Interval = 120.098);

size := readSimulationResultSize("ICSolar.ICS_Skeleton_res.mat");


	A := readSimulationResult("ICSolar.ICS_Skeleton_res.mat",Egen_arrayTotal,size);
	eGen_M := A[1,95:123];

	A:=readSimulationResult("ICSolar.ICS_Skeleton_res.mat",measured_Egen,size);
	eGen_O :=  A[1,95:123];


	RootMean:= RMSE(eGen_O,eGen_M);

end simulate;

