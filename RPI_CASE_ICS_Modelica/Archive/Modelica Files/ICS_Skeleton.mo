model ICS_Skeleton
  parameter Real FLensWidth = 0.25019;
  parameter Real CellWidth = 0.01;
  parameter Real HSpace;
  parameter Real VSpace;
  ICS_Context ics_context1 annotation(Placement(visible = true, transformation(origin = {-80,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  ICS_EnvelopeCassette ics_envelopecassette1 annotation(Placement(visible = true, transformation(origin = {-20,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
equation
  connect(ics_context1.AOI,ics_envelopecassette1.AOI) annotation(Line(points = {{-70,14},{-47.466,14},{-47.466,22.2497},{-30.4079,22.2497},{-30.4079,22.2497}}));
  connect(ics_context1.DNI,ics_envelopecassette1.DNI) annotation(Line(points = {{-70,24},{-51.1743,24},{-51.1743,28.1829},{-30.4079,28.1829},{-30.4079,28.1829}}));
  annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
end ICS_Skeleton;

