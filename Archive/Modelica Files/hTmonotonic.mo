model hTmonotonic
  Modelica.Blocks.Tables.CombiTable1D TinHout(table = [0,0;200,1;273,2;333,102;338,302;373,342;473,442]) annotation(Placement(visible = true, transformation(origin = {-19.5221,-20.0884}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput enthalpy_out annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100.956,19.2832}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput T_in annotation(Placement(visible = true, transformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-94.0263,7.78973}, extent = {{-10,-10},{10,10}}, rotation = 0)));
equation
  connect(TinHout.y[2],enthalpy_out) annotation(Line(points = {{-8.5221,-20.0884},{93.4289,-20.0884},{93.4289,20},{100,20}}));
  connect(T_in,TinHout.u[1]) annotation(Line(points = {{-100,-20},{-32.2581,-20},{-32.2581,-20.0884},{-31.5221,-20.0884}}));
  annotation(Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Rectangle(borderPattern = BorderPattern.Sunken, extent = {{-90,90},{90,-90}}),Text(origin = {0.955795,38.7097}, extent = {{-61.6487,24.6117},{61.6487,-24.6117}}, textString = "hTmono")}));
end hTmonotonic;

