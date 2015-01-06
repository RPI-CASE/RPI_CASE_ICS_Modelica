model ICS_Module "This model contains all the components and equations that simulate one module of Integrated Concentrating Solar"
  parameter Modelica.SIunits.Length LensWidth = 0.25019 "Width of Fresnel Lens, meters";
  parameter Modelica.SIunits.Area LensArea = LensWidth ^ 2 "Area of Fresnel Lens sqmeters";
  parameter Modelica.SIunits.Length CellWidth = 0.01 "Width of the PV cell, meters";
  parameter Modelica.SIunits.Area CellArea = CellWidth ^ 2 "Area of PV cell, square meters";
  parameter Real FNum = 0.85;
  parameter String FresMat = "PMMA" "'PMMA' or 'Silicon on Glass', use the exact spellings provided";
  Integer FMatNum;
  Modelica.Blocks.Interfaces.RealInput DNI annotation(Placement(visible = true, transformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  ICS_LensLosses ics_lenslosses1 annotation(Placement(visible = true, transformation(origin = {-60,20}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  ICS_CPVOpticalPerformance ics_cpvopticalperformance1 annotation(Placement(visible = true, transformation(origin = {0,0}, extent = {{-15,-15},{15,15}}, rotation = 0)));
equation
  connect(ics_lenslosses1.DNI_out,ics_cpvopticalperformance1.DNI_in) annotation(Line(points = {{-45,20},{-31.6872,20},{-31.6872,11.9342},{-15.6379,11.9342},{-15.6379,11.9342}}));
  connect(DNI,ics_lenslosses1.DNI_in) annotation(Line(points = {{-100,20},{-75.1029,20},{-75.1029,19.9588},{-75.1029,19.9588}}));
  if FresMat == "PMMA" then
    FMatNum = 1;
  elseif FresMat == "Silicon on Glass" then
    FMatNum = 2;
  else
  end if;
  connect(FMatNum,ics_cpvopticalperformance1.FMat);
  connect(LensWidth,ics_cpvopticalperformance1.LensWidth);
  connect(CellWidth,ics_cpvopticalperformance1.CellWidth);
  connect(FNum,ics_cpvopticalperformance1.FNum);
  annotation(Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Text(origin = {-1.01827,18.4359}, extent = {{-47.75,33.24},{47.75,-33.24}}, textString = "Module")}));
end ICS_Module;

