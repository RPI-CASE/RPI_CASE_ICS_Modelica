model ICS_EnvelopeCassette
  parameter Integer StackHeight = 6;
  parameter Integer NumStacks = 4;
  // parameter Modelica.SIunits.Length VSpace = 0.2794;
  //  parameter Modelica.SIunits.Length HSpace = 0.2794;
  parameter Modelica.SIunits.Area ArrayArea = 1;
  Modelica.Blocks.Interfaces.RealInput DNI annotation(Placement(visible = true, transformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput AOI annotation(Placement(visible = true, transformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput SurfAlt annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput SurfAzi annotation(Placement(visible = true, transformation(origin = {-100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  ICS_GlazingLosses ics_glazinglosses1 annotation(Placement(visible = true, transformation(origin = {-40,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Current annotation(Placement(visible = true, transformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Heat annotation(Placement(visible = true, transformation(origin = {100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  ICS_SelfShading ics_selfshading1 annotation(Placement(visible = true, transformation(origin = {0,20}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  ICS_Stack ics_stack1 annotation(Placement(visible = true, transformation(origin = {60,0}, extent = {{-15,-15},{15,15}}, rotation = 0)));
equation
  connect(SurfAzi,ics_selfshading1.SurfAzi) annotation(Line(points = {{-100,-80},{-46.2963,-80},{-46.2963,7.61317},{-15.8436,7.61317},{-15.8436,7.61317}}));
  connect(SurfAlt,ics_selfshading1.SurfAlt) annotation(Line(points = {{-100,-40},{-59.2593,-40},{-59.2593,13.9918},{-15.6379,13.9918},{-15.6379,13.9918}}));
  connect(ics_selfshading1.DNI_out,ics_stack1.DNI) annotation(Line(points = {{15,23},{22.2222,23},{22.2222,9.0535},{44.4444,9.0535},{44.4444,9.0535}}));
  connect(ics_glazinglosses1.HDirNor,ics_selfshading1.DNI_in) annotation(Line(points = {{-30,42},{-25.1029,42},{-25.1029,32.0988},{-15.0206,32.0988},{-15.0206,32.0988}}));
  connect(DNI,ics_glazinglosses1.DNI) annotation(Line(points = {{-100,60},{-71.6981,60},{-71.6981,39.7678},{-50.2177,39.7678},{-50.2177,39.7678}}));
  annotation(Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Text(origin = {-2.46552,1.74055}, extent = {{-55.88,45.86},{55.88,-45.86}}, textString = "Envelope")}));
end ICS_EnvelopeCassette;

