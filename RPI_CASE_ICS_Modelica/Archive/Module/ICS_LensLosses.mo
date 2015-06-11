model ICS_LensLosses
  parameter Real LensTrans = 0.96;
  Modelica.Blocks.Interfaces.RealOutput DNI_out annotation(Placement(visible = true, transformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput DNI_in annotation(Placement(visible = true, transformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
equation
  DNI_out = DNI_in * LensTrans;
  annotation(Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Text(origin = {-2.37,12.66}, extent = {{-66.56,63.48},{66.56,-63.48}}, textString = "Lens Losses")}));
end ICS_LensLosses;

