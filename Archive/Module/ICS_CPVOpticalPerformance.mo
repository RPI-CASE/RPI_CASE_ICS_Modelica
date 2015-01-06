model ICS_CPVOpticalPerformance "This model calculates the amount of solar energy on the PV cell after concentration"
  Modelica.Blocks.Interfaces.RealInput DNI_in annotation(Placement(visible = true, transformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput FNum annotation(Placement(visible = true, transformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput LensWidth annotation(Placement(visible = true, transformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput CellWidth annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Real Concentration = LensWidth ^ 2 / CellWidth ^ 2;
  Real ModuleDepth = LensWidth * sqrt(2) * FNum;
  Real Fresnel;
  Modelica.Blocks.Interfaces.RealOutput EIPC_out annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.IntegerInput FMat annotation(Placement(visible = true, transformation(origin = {-100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
equation
  if FMat == 1 then
    Fresnel = (-20.833 * FNum ^ 3 - 23.214 * FNum ^ 2 + 106.1 * FNum + 23.207) / 3;
  elseif FMat == 2 then
    Fresnel = (-104.17 * FNum ^ 3 + 171.43 * FNum ^ 2 - 40.744 * FNum + 57.236) / 100;
  else
  end if;
  EIPC_out = DNI_in * CellWidth ^ 2 * Fresnel * Concentration;
  annotation(Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Text(origin = {-3.46485,57.2329}, extent = {{-54.14,25.34},{54.14,-25.34}}, textString = "CPV"),Text(origin = {-2.34888,3.70691}, extent = {{-52.04,29.42},{52.04,-29.42}}, textString = "Optical"),Text(origin = {-12.9742,-48.5823}, extent = {{-66.38,29.05},{98.7657,-30.2861}}, textString = "Performance")}));
end ICS_CPVOpticalPerformance;

