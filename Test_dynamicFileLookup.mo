model Test_CASE
  parameter String Path = "C:\\Users\\kenton.phillips\\Documents\\GitHub\\RPI_CASE_ICS_Modelica\\20150323\\";
  parameter Real i = 1;
  parameter String s = num2str(1);
  Modelica.Blocks.Sources.CombiTimeTable IC_Data_all(tableOnFile = true, fileName = Path + s + ".txt", tableName = "test", nout = 2, columns = {2});
  Real out = IC_Data_all.y[1];
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-200,-100},{200,100}}), graphics), experiment(StartTime = 7137000.0, StopTime = 7141200.0, Tolerance = 1e-006, Interval = 100));
end Test_CASE;