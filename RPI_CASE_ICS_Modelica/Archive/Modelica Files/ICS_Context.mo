model ICS_Context
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam = "modelica://Buildings/Resources/weatherdata/USA_NY_New.York-Central.Park.725033_TMY3.mos") "Weather data reader for New York Central Park" annotation(Placement(visible = true, transformation(origin = {-40,20}, extent = {{-20,-20},{20,20}}, rotation = 0)));
  parameter Real BuildingOrientation;
  parameter Real WallTilt;
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TOut annotation(Placement(visible = true, transformation(origin = {60,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation(Placement(visible = true, transformation(origin = {20,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {20,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Buildings.BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTil(til = Buildings.HeatTransfer.Types.Tilt.Wall, azi = 3.14, lat = 0.6457718232379) annotation(Placement(visible = true, transformation(origin = {20,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput AOI annotation(Placement(visible = true, transformation(origin = {100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput DNI annotation(Placement(visible = true, transformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Buildings.BoundaryConditions.SolarGeometry.BaseClasses.WallSolarAzimuth wallSolAzi annotation(Placement(visible = true, transformation(origin = {20,-80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
equation
  connect(weaDat.alt,wallSolAzi.alt) annotation(Line(points = {{-20,20},{-7.66378,20},{-7.66378,-75.4017},{7.41656,-75.4017},{7.41656,-75.4017}}));
  connect(HDirTil.inc,wallSolAzi.incAng) annotation(Line(points = {{31,-44},{41.78,-44},{41.78,-58.5909},{-22.0025,-58.5909},{-22.0025,-84.796},{7.16934,-84.796},{7.16934,-84.796}}));
  connect(HDirTil.inc,AOI) annotation(Line(points = {{31,-44},{60.7981,-44},{60.7981,-60.5634},{91.3146,-60.5634},{91.3146,-60.5634}}));
  connect(HDirTil.H,DNI) annotation(Line(points = {{31,-40},{93.4688,-40},{93.4688,-40.0581},{93.4688,-40.0581}}));
  connect(weaDat.weaBus,HDirTil.weaBus) annotation(Line(points = {{-20,20},{0,20},{0,-40.0581},{30,-40},{10,-40}}));
  connect(weaDat.weaBus,weaBus) annotation(Line(points = {{-20,20},{20.3193,20},{20.3193,19.7388},{20.3193,19.7388}}));
  connect(weaBus.TDryBul,TOut.T) annotation(Line(points = {{20,20},{48.5915,20},{48.5915,20.1878},{48.5915,20.1878}}));
  annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
end ICS_Context;

