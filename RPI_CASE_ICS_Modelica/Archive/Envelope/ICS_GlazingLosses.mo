model ICS_GlazingLosses
  Modelica.Blocks.Interfaces.RealOutput HDirNor annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  parameter Real G1Tran = 0.99 "Glazing layer 1 solar transmittance, can be made more accurate later";
  Modelica.Blocks.Math.Product GlazingLoss annotation(Placement(visible = true, transformation(origin = {0,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput DNI annotation(Placement(visible = true, transformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
equation
  connect(DNI,GlazingLoss.u1) annotation(Line(points = {{-100,20},{-42.3803,20},{-42.3803,26.1248},{-12,26.1248},{-12,26}}));
  connect(GlazingLoss.y,HDirNor) annotation(Line(points = {{11,20},{94.3396,20},{94.3396,19.7388},{94.3396,19.7388}}));
  connect(G1Tran,GlazingLoss.u2);
  annotation(Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Rectangle(origin = {3.05,-10.45}, fillColor = {85,255,255}, fillPattern = FillPattern.Solid, extent = {{-25.98,109.43},{26.27,-89.40000000000001}})}));
end ICS_GlazingLosses;