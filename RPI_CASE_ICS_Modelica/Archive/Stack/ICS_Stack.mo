model ICS_Stack "This model represents an individual Integrated Concentrating Solar Stack"
  Modelica.Blocks.Interfaces.RealInput StackHeight annotation(Placement(visible = true, transformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  ICS_Module ics_module1 annotation(Placement(visible = true, transformation(origin = {0,20}, extent = {{-25,-25},{25,25}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput DNI annotation(Placement(visible = true, transformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
equation
  connect(DNI,ics_module1.DNI) annotation(Line(points = {{-100,40},{-65.8926,40},{-65.8926,25.5443},{-31.0595,40},{-25,40}}));
  annotation(Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Text(origin = {-1.45,1.74}, extent = {{-65.02,41.8},{65.02,-41.8}}, textString = "Stack")}));
end ICS_Stack;

