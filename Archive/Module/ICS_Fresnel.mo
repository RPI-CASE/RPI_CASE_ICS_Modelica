model ICS_Fresnel
  parameter Real FNO = 0.85 "F-number, Fresnel focus factor";
  parameter String FMat = "PMMA" "Fresnel material, can be PMMA or Silicon on Glass";
  Real FLensWidth = FLensWidth_a;
  Real CellWidth = CellWidth_a;
  Real Fresnel;
  Modelica.Blocks.Interfaces.RealOutput Concentration annotation(Placement(visible = true, transformation(origin = {100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput ModuleDepth annotation(Placement(visible = true, transformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput HDirNor_b annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput HDirNor_a annotation(Placement(visible = true, transformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Blocks.Math.Product DNI_Fresnel annotation(Placement(visible = true, transformation(origin = {0,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput CellWidth_a annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput FLensWidth_a annotation(Placement(visible = true, transformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
equation
  connect(Fresnel,DNI_Fresnel.u2) annotation(Line(points = {{-29,20},{-23.8026,20},{-23.8026,33.9623},{-11.9013,33.9623},{-11.9013,33.9623}}));
  connect(HDirNor_a,DNI_Fresnel.u1) annotation(Line(points = {{-100,60},{-50.508,60},{-50.508,45.8636},{-12.4819,45.8636},{-12.4819,45.8636}}));
  connect(DNI_Fresnel.y,HDirNor_b) annotation(Line(points = {{11,40},{94.3396,40},{94.3396,19.7388},{94.3396,19.7388}}));
  if FMat == "PMMA" then
    Fresnel = ((-20.833 * FNO ^ 3) - 23.214 * FNO ^ 2 + 106.1 * FNO + 23.207) / 3;
  elseif FMat == "Silicon on Glass" then
    Fresnel = ((-104.17 * FNO ^ 3) + 171.43 * FNO ^ 2 - 40.744 * FNO + 57.236) / 100;
  else
  end if;
  Concentration = FLensWidth ^ 2 / CellWidth ^ 2;
  ModuleDepth = FLensWidth * sqrt(2) * FNO;
  annotation(Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
end ICS_Fresnel;