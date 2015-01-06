model h_sandbox
  Modelica.Blocks.Interfaces.RealOutput Real_out annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Blocks.Sources.Sine sine1 annotation(Placement(visible = true, transformation(origin = {-69.5341,-9.55795}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  hTmonotonic htmonotonic1 annotation(Placement(visible = true, transformation(origin = {4.54002,5.49581}, extent = {{-10,-10},{10,10}}, rotation = 0)));
equation
  connect(sine1.y,htmonotonic1.T_in) annotation(Line(points = {{-58.5341,-9.55795},{-26.0454,-9.55795},{-26.0454,-1.91159},{-7.96894,6.27479},{-4.86261,6.27479}}));
  connect(htmonotonic1.enthalpy_out,Real_out) annotation(Line(points = {{14.6356,7.42413},{31.5412,7.42413},{31.5412,21.2664},{91.2784,21.2664},{91.2784,20},{100,20}}));
  annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
end h_sandbox;

