package ICSolar "Package of all the necessary components to create an Integrated Concentrating Solar simulation"
  extends Modelica.Icons.Package;

  model ICS_Skeleton "This model calculates the electrical and thermal generation of ICSolar. This model is used as a skeleton piece to hold together the other models until it is packages as an FMU."
    parameter Real FLensWidth = 0.25019 "Lens width";
    parameter Real CellWidth = 0.01 "PV Cell width";
    parameter Modelica.SIunits.Pressure PAmb(displayUnit = "PA") = 101325 "Ambient pressure";
    Modelica.Thermal.FluidHeatFlow.Sources.Ambient Source(constantAmbientPressure = PAmb, constantAmbientTemperature = 298, medium = Modelica.Thermal.FluidHeatFlow.Media.Water(), useTemperatureInput = false) "Thermal fluid source" annotation(Placement(visible = true, transformation(origin = {-80, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow Pump(constantVolumeFlow = 2e-006, m = 0, medium = Modelica.Thermal.FluidHeatFlow.Media.Water(), T0 = 293) "Fluid pump for thermal fluid" annotation(Placement(visible = true, transformation(origin = {-40, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.FluidHeatFlow.Sources.Ambient Sink(constantAmbientPressure = PAmb, constantAmbientTemperature = 298, medium = Modelica.Thermal.FluidHeatFlow.Media.Water()) "Thermal fluid sink, will be replaced with a tank later" annotation(Placement(visible = true, transformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ICSolar.ICS_Context ics_context1 annotation(Placement(visible = true, transformation(origin = {-80, 40}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
    ICSolar.Envelope.ICS_EnvelopeCassette ics_envelopecassette1 annotation(Placement(visible = true, transformation(origin = {0, 40}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
    //Modelica.Blocks.Sources.CombiTimeTable ExperimentalTemperature(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [28561622.622,25.3;28561633.075,25.4;28561643.572,25.4;28561654.096,25.5;28561662.587,25.6;28561673.035,25.6;28561683.502,25.7;28561694.002,25.8;28561702.412,25.8;28561712.86,25.9;28561723.285,25.9;28561733.811,26.0;28561737.976,26.0;28561783.794,26.3;28561792.155,26.3;28561802.608,26.4;28561813.105,26.4;28561823.635,26.5;28561834.054,26.5;28561842.426,26.6;28561852.85,26.6;28561863.288,26.7;28561873.733,26.7;28561882.099,26.8;28561892.454,26.8;28561902.92,26.9;28561913.333,27.0;28561921.998,27.0;28561932.579,27.0;28561943.041,27.1;28561953.463,27.1;28561963.962,27.1;28561972.308,27.1;28561982.794,27.2;28561993.402,27.2;28562003.928,27.3;28562012.445,27.3;28562022.883,27.3;28562033.444,27.4;28562043.927,27.4;28562052.284,27.4;28562062.735,27.4;28562073.187,27.5;28562083.685,27.5;28562092.066,27.5;28562102.501,27.5;28562112.984,27.6;28562123.493,27.6;28562133.961,27.7;28562142.322,27.7;28562152.822,27.7;28562163.292,27.8;28562173.724,27.8;28562182.086,27.8;28562192.571,27.9;28562203.082,28.0;28562213.503,28.2;28562223.999,28.4;28562232.377,28.5;28562242.847,28.6;28562253.325,28.8;28562263.829,29.0;28562272.299,29.1;28562282.749,29.3;28562293.202,29.4;28562303.696,29.6;28562312.089,29.7;28562322.604,29.9;28562333.041,30.1;28562343.478,30.3;28562353.946,30.5;28562362.337,30.7;28562366.594,30.8;28562492.064,33.3;28562502.449,33.5;28562512.917,33.7;28562523.385,33.9;28562533.96,34.1;28562542.353,34.2;28562552.819,34.4;28562563.392,34.5;28562573.845,34.7;28562582.206,34.8;28562592.624,35.0;28562603.06,35.1;28562613.495,35.3;28562623.874,35.4;28562632.283,35.5;28562642.778,35.7;28562653.165,35.8;28562663.577,36.0;28562671.978,36.1;28562682.433,36.2;28562692.928,36.3;28562703.414,36.4;28562711.914,36.5;28562722.443,36.7;28562732.97,36.8;28562743.452,36.9;28562753.876,37.0;28562762.255,37.2;28562772.69,37.3;28562783.169,37.4;28562793.625,37.5;28562801.981,37.6;28562812.463,37.7;28562822.904,37.8;28562833.386,37.9;28562843.989,38.0;28562852.351,38.1;28562862.806,38.2;28562873.306,38.3;28562883.815,38.4;28562892.213,38.5;28562902.736,38.6;28562913.267,38.8;28562923.879,38.9;28562932.219,39.0;28562942.691,39.1;28562953.189,39.2;28562963.656,39.3;28562972.156,39.4;28562982.64,39.5;28562993.181,39.7;28563003.695,39.8;28563012.124,39.9;28563022.726,40.0;28563033.224,40.1;28563043.679,40.2;28563052.099,40.3;28563062.633,40.4;28563073.037,40.5;28563083.552,40.6;28563093.971,40.6;28563102.345,40.7;28563112.861,40.8;28563123.293,40.9;28563133.719,41.0;28563142.089,41.1;28563152.574,41.2;28563163.154,41.3;28563173.621,41.4;28563182.087,41.4;28563192.592,41.5;28563203.038,41.6;28563213.629,41.7;28563222.007,41.7;28563232.568,41.8;28563243.081,41.9;28563253.578,42.0;28563261.926,42.1;28563272.424,42.2;28563282.903,42.3;28563293.403,42.3;28563303.856,42.5;28563312.33,42.5;28563322.824,42.6;28563333.257,42.7;28563343.71,42.8;28563352.104,42.8;28563362.606,42.9;28563373.104,43.0;28563383.508,43.0;28563393.973,43.1;28563402.368,43.2;28563412.836,43.2;28563423.272,43.3;28563433.748,43.4;28563442.126,43.5;28563452.598,43.5;28563463.064,43.6;28563473.449,43.7;28563483.875,43.7;28563492.199,43.8;28563502.589,43.8;28563513.012,43.9;28563523.554,43.9;28563531.92,44.0;28563542.325,44.0;28563552.806,44.1;28563563.274,44.1;28563573.722,44.2;28563582.176,44.2;28563592.673,44.3;28563603.124,44.3;28563613.598,44.4;28563621.94,44.4;28563632.409,44.5;28563642.89,44.6;28563653.297,44.7;28563663.778,44.7;28563672.095,44.8;28563682.525,44.8;28563693.012,44.8;28563703.574,44.9;28563711.934,44.9;28563722.443,45.0;28563732.927,45.0;28563743.379,45.1;28563753.845,45.2;28563762.304,45.2;28563772.802,45.2;28563783.239,45.3;28563793.721,45.4;28563802.08,45.4;28563812.565,45.4;28563823.041,45.5;28563833.514,45.6;28563841.965,45.6;28563852.447,45.6;28563862.931,45.7;28563873.459,45.7;28563883.942,45.8;28563892.288,45.8;28563902.712,45.9;28563913.196,45.9;28563923.689,46.0;28563932.112,46.0;28563942.659,46.1;28563953.141,46.1;28563963.577,46.2;28563972.02,46.3;28563982.423,46.3;28563992.936,46.4;28564003.417,46.4;28564013.92,46.5;28564022.296,46.5;28564032.748,46.6;28564043.226,46.6;28564053.663,46.7;28564062.044,46.7;28564072.476,46.8;28564082.93,46.8;28564093.331,46.9;28564103.816,46.9;28564112.221,47.0;28564122.812,47.0;28564133.346,47.1;28564143.721,47.2;28564152.077,47.2;28564162.497,47.3;28564172.95,47.3;28564183.389,47.3;28564193.851,47.3;28564202.323,47.3;28564212.825,47.4;28564223.335,47.4;28564233.848,47.4;28564242.214,47.5;28564252.681,47.5;28564263.142,47.5;28564273.615,47.6;28564282.056,47.6;28564292.504,47.6;28564302.958,47.7;28564313.374,47.7;28564323.808,47.7;28564332.129,47.8;28564342.669,47.8;28564353.155,47.8;28564363.592,47.9;28564371.967,47.9;28564382.389,47.9;28564392.822,47.9;28564403.317,48.0;28564413.697,48.0;28564422.041,48.1;28564432.614,48.1;28564443.179,48.1;28564453.782,48.1;28564462.175,48.2;28564472.642,48.2;28564483.094,48.2;28564493.528,48.2;28564501.898,48.2;28564512.374,48.3;28564522.811,48.3;28564533.267,48.3;28564543.734,48.4;28564552.151,48.4;28564562.554,48.4;28564572.984,48.5;28564583.424,48.5;28564591.93,48.5;28564602.341,48.5;28564612.826,48.6;28564623.252,48.6;28564633.756,48.6;28564642.17,48.6;28564652.638,48.6;28564663.163,48.7;28564673.709,48.7;28564682.112,48.7;28564692.593,48.7;28564703.098,48.7;28564713.558,48.7;28564721.982,48.8;28564732.452,48.8;28564742.865,48.8;28564753.272,48.8;28564763.733,48.8;28564772.078,48.8;28564782.539,48.8;28564792.994,48.9;28564803.449,48.9;28564813.942,48.9;28564822.303,48.9;28564832.7,48.9;28564843.169,48.9;28564853.715,48.9;28564862.094,48.9;28564872.519,48.9;28564882.941,48.9;28564893.407,49.0;28564903.832,49.0;28564912.174,49.0;28564922.613,49.0;28564933.05,49.0;28564943.463,49.1;28564953.944,49.1;28564962.353,49.1;28564972.93,49.1;28564983.555,49.1;28564994.008,49.1;28565002.338,49.1;28565012.767,49.2;28565023.204,49.1;28565033.643,49.1;28565042.021,49.1;28565052.459,49.1;28565062.94,49.1;28565073.383,49.1;28565083.805,49.1;28565092.167,49.1;28565102.607,49.1;28565113.073,49.2;28565123.527,49.1;28565132.011,49.1;28565142.467,49.2;28565153.058,49.2;28565163.495,49.2;28565173.902,49.2;28565182.231,49.1;28565192.639,49.1;28565203.119,49.2;28565213.62,49.2;28565224.093,49.1;28565232.402,49.1;28565242.89,49.1;28565253.308,49.1;28565263.666,49.1;28565274.103,49.1;28565282.486,49.1;28565292.917,49.1;28565303.448,49.1;28565313.884,49.2;28565322.263,49.1;28565332.764,49.1;28565343.312,49.1;28565353.871,49.1;28565362.247,49.1;28565372.767,49.2;28565383.206,49.2;28565393.765,49.2;28565402.155,49.2;28565412.684,49.2;28565423.138,49.2;28565433.635,49.2;28565444.105,49.2;28565452.45,49.2;28565462.889,49.2;28565473.33,49.3;28565483.781,49.3;28565492.142,49.3;28565502.606,49.3;28565513.032,49.3;28565523.469,49.3;28565533.999,49.3;28565542.313,49.3;28565552.769,49.3;28565563.188,49.3;28565573.653,49.3;28565584.09,49.3;28565592.42,49.3;28565602.891,49.3;28565613.362,49.3;28565623.858,49.3;28565632.237,49.3;28565642.642,49.3;28565653.059,49.3;28565663.611,49.2;28565674.043,49.2;28565682.469,49.2;28565692.936,49.2;28565703.488,49.3;28565713.924,49.3;28565722.318,49.3;28565732.736,49.2;28565743.187,49.2;28565753.608,49.2;28565764.077,49.2;28565772.502,49.2;28565782.985,49.2;28565793.499,49.2;28565803.894,49.1;28565812.24,49.1;28565822.77,49.1;28565833.238,49.1;28565843.676,49.1;28565854.11,49.1;28565862.507,49.0;28565873.03,49.0;28565883.421,49.0;28565893.971,49.0;28565902.376,49.0;28565912.817,49.0;28565923.345,49.0;28565933.783,49.0;28565944.14,49.0;28565952.501,48.9;28565962.923,48.9;28565973.391,48.9;28565983.863,48.9;28565992.238,48.9;28566002.663,48.8;28566013.084,48.8;28566023.489,48.8;28566033.938,48.8;28566042.3,48.7;28566052.726,48.7;28566063.175,48.7;28566073.631,48.7;28566084.1,48.6;28566092.427,48.6;28566102.928,48.6;28566113.365,48.6;28566123.829,48.5;28566132.18,48.5;28566142.629,48.5;28566153.085,48.5;28566163.519,48.4;28566173.943,48.4;28566182.29,48.4;28566192.728,48.4;28566203.165,48.3;28566213.614,48.3;28566224.051,48.2;28566232.379,48.2;28566242.883,48.2;28566253.321,48.2;28566263.704,48.1;28566274.148,48.1;28566282.541,48.1;28566292.991,48.1;28566303.444,48.0;28566313.943,48.0;28566322.288,48.0;28566332.789,48.0;28566343.181,47.9;28566353.603,47.9;28566364.068,47.8;28566372.402,47.8;28566382.839,47.8;28566393.333,47.7;28566403.759,47.0;28566412.117,46.7;28566422.589,46.3;28566433.21,45.9;28566443.728,45.6;28566452.054,45.3;28566462.633,45.0;28566473.135,44.7;28566483.6,44.4;28566494.118,44.2;28566502.668,44.0;28566513.162,43.7;28566523.602,43.4;28566534.052,43.2;28566542.444,43.0;28566552.913,42.7;28566563.416,42.5;28566573.896,42.3;28566582.321,42.1;28566592.728,41.9;28566603.121,41.7;28566613.619,41.5;28566624.105,41.3;28566632.477,41.1]) annotation(Placement(visible = true, transformation(origin = {-80,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    //extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic,
  equation
    connect(ics_envelopecassette1.flowport_b, Sink.flowPort) annotation(Line(points = {{25, 40}, {41.2098, 40}, {41.2098, 0.378072}, {50, 0.378072}, {50, 0}}));
    connect(Pump.flowPort_b, ics_envelopecassette1.flowport_a) annotation(Line(points = {{-30, -20}, {-28.3554, -20}, {-28.3554, 19.6597}, {-23.75, 19.6597}, {-23.75, 18.75}}));
    connect(ics_context1.DNI, ics_envelopecassette1.DNI) annotation(Line(points = {{-55, 25}, {-24.1966, 25}, {-25, 25}}));
    connect(ics_context1.AOI, ics_envelopecassette1.AOI) annotation(Line(points = {{-55, 30}, {-24.9527, 30}, {-25, 30}}));
    connect(ics_context1.SunAzi, ics_envelopecassette1.SunAzi) annotation(Line(points = {{-55, 35}, {-24.9527, 35}, {-25, 35}}));
    connect(ics_context1.SunAlt, ics_envelopecassette1.SunAlt) annotation(Line(points = {{-55, 40}, {-24.5747, 40}, {-25, 40}}));
    connect(ics_context1.SurfOrientation_out, ics_envelopecassette1.SurfaceOrientation) annotation(Line(points = {{-55, 45}, {-25.7089, 45}, {-25, 45}}));
    connect(ics_context1.SurfTilt_out, ics_envelopecassette1.SurfaceTilt) annotation(Line(points = {{-55, 50}, {-25.7089, 50}, {-25, 50}}));
    connect(ics_context1.TDryBul, ics_envelopecassette1.TAmb_in) annotation(Line(points = {{-55, 55}, {-25.3308, 55}, {-25, 55}}));
    connect(Source.flowPort, Pump.flowPort_a) "connects fluid source to pump" annotation(Line(points = {{-70, -20}, {-49.7653, -20}, {-50, -20}}));
    annotation(experiment(StartTime = 28561600.0, StopTime = 28566600.0, Tolerance = 1e-006, Interval = 10.2459));
  end ICS_Skeleton;

  model ICS_Context "This model provides the pieces necessary to set up the context to run the simulation, in FMU practice this will be cut out and provided from the EnergyPlus file"
    parameter Real Lat = 40.71 * Modelica.Constants.pi / 180 "Latitude";
    parameter Real SurfOrientation = 0 "Surface orientation: Change 'S' to 'W','E', or 'N' for other orientations";
    parameter Real SurfTilt = 0 "0 wall, pi/2 roof";
    Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam = "modelica://Buildings/Resources/weatherdata/USA_NY_New.York-Central.Park.725033_TMY3.mos", pAtmSou = Buildings.BoundaryConditions.Types.DataSource.Parameter, TDryBul(displayUnit = "K"), TDewPoi(displayUnit = "K"), totSkyCovSou = Buildings.BoundaryConditions.Types.DataSource.Parameter, opaSkyCovSou = Buildings.BoundaryConditions.Types.DataSource.Parameter, totSkyCov = 0.01, opaSkyCov = 0.01) "Weather data reader for New York Central Park" annotation(Placement(visible = true, transformation(origin = {-40, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Buildings.BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTil(til = SurfTilt, azi = SurfOrientation, lat = Lat) "Irradiance on tilted surface" annotation(Placement(visible = true, transformation(origin = {20, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b TDryBul "Dry bulb temperature" annotation(Placement(visible = true, transformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Buildings.BoundaryConditions.SolarGeometry.BaseClasses.Declination decAng "Solar declination (seasonal offset)" annotation(Placement(visible = true, transformation(origin = {-40, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Buildings.BoundaryConditions.SolarGeometry.BaseClasses.SolarHourAngle solHouAng "Solar hour angle" annotation(Placement(visible = true, transformation(origin = {-40, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Buildings.BoundaryConditions.WeatherData.Bus weatherBus "Connector to put variables from the weather file" annotation(Placement(visible = true, transformation(origin = {20, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {20, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Buildings.HeatTransfer.Sources.PrescribedTemperature TOutside "Outside temperature" annotation(Placement(visible = true, transformation(origin = {60, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput SurfOrientation_out "Surface Orientation" annotation(Placement(visible = true, transformation(origin = {100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput SurfTilt_out "Surface tilt" annotation(Placement(visible = true, transformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput SunAlt "Solar altitude" annotation(Placement(visible = true, transformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput SunAzi "Solar azimuth" annotation(Placement(visible = true, transformation(origin = {100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput AOI "Angle of incidence" annotation(Placement(visible = true, transformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput DNI "Direct normal irradiance" annotation(Placement(visible = true, transformation(origin = {100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable ExperimentalResults(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [28561622.622, 2.5; 28561633.075, 1.5; 28561643.572, 1.5; 28561654.096, 451.5; 28561662.587, 455.4; 28561673.035, 453.2; 28561683.502, 431.2; 28561694.002, 415.2; 28561702.412, 443.6; 28561712.86, 447.0; 28561723.285, 432.9; 28561733.811, 440.6; 28561737.976, 431.3; 28561783.794, 518.3; 28561792.155, 509.2; 28561802.608, 518.6; 28561813.105, 525.0; 28561823.635, 527.6; 28561834.054, 541.6; 28561842.426, 565.6; 28561852.85, 569.4; 28561863.288, 579.0; 28561873.733, 576.1; 28561882.099, 555.6; 28561892.454, 563.6; 28561902.92, 558.2; 28561913.333, 538.0; 28561921.998, 518.9; 28561932.579, 524.2; 28561943.041, 485.9; 28561953.463, 386.9; 28561963.962, 454.6; 28561972.308, 490.2; 28561982.794, 477.8; 28561993.402, 539.7; 28562003.928, 496.6; 28562012.445, 600.5; 28562022.883, 607.7; 28562033.444, 611.3; 28562043.927, 614.7; 28562052.284, 615.6; 28562062.735, 612.8; 28562073.187, 608.5; 28562083.685, 610.4; 28562092.066, 610.3; 28562102.501, 603.1; 28562112.984, 594.4; 28562123.493, 594.8; 28562133.961, 610.8; 28562142.322, 615.9; 28562152.822, 614.8; 28562163.292, 610.9; 28562173.724, 611.7; 28562182.086, 612.8; 28562192.571, 611.7; 28562203.082, 611.2; 28562213.503, 612.6; 28562223.999, 615.3; 28562232.377, 617.0; 28562242.847, 615.3; 28562253.325, 615.0; 28562263.829, 615.6; 28562272.299, 617.0; 28562282.749, 617.4; 28562293.202, 617.3; 28562303.696, 616.0; 28562312.089, 616.3; 28562322.604, 616.8; 28562333.041, 616.6; 28562343.478, 616.3; 28562353.946, 615.5; 28562362.337, 614.5; 28562366.594, 614.9; 28562492.064, 617.9; 28562502.449, 616.9; 28562512.917, 615.9; 28562523.385, 615.1; 28562533.96, 613.3; 28562542.353, 612.2; 28562552.819, 612.4; 28562563.392, 610.6; 28562573.845, 609.7; 28562582.206, 609.0; 28562592.624, 608.9; 28562603.06, 607.6; 28562613.495, 607.1; 28562623.874, 607.2; 28562632.283, 606.2; 28562642.778, 607.3; 28562653.165, 605.9; 28562663.577, 605.1; 28562671.978, 604.6; 28562682.433, 603.0; 28562692.928, 601.4; 28562703.414, 601.5; 28562711.914, 601.2; 28562722.443, 601.4; 28562732.97, 601.3; 28562743.452, 602.6; 28562753.876, 603.6; 28562762.255, 604.0; 28562772.69, 580.4; 28562783.169, 545.1; 28562793.625, 569.3; 28562801.981, 602.0; 28562812.463, 600.0; 28562822.904, 599.9; 28562833.386, 600.5; 28562843.989, 600.4; 28562852.351, 599.9; 28562862.806, 599.1; 28562873.306, 598.9; 28562883.815, 601.1; 28562892.213, 601.6; 28562902.736, 602.8; 28562913.267, 602.2; 28562923.879, 603.4; 28562932.219, 602.0; 28562942.691, 602.2; 28562953.189, 601.8; 28562963.656, 603.1; 28562972.156, 602.2; 28562982.64, 603.2; 28562993.181, 603.0; 28563003.695, 601.8; 28563012.124, 601.6; 28563022.726, 602.0; 28563033.224, 600.9; 28563043.679, 601.1; 28563052.099, 599.8; 28563062.633, 598.8; 28563073.037, 599.6; 28563083.552, 600.3; 28563093.971, 600.2; 28563102.345, 599.8; 28563112.861, 599.0; 28563123.293, 599.4; 28563133.719, 600.4; 28563142.089, 598.6; 28563152.574, 599.7; 28563163.154, 598.8; 28563173.621, 598.5; 28563182.087, 597.0; 28563192.592, 597.5; 28563203.038, 598.4; 28563213.629, 598.2; 28563222.007, 598.4; 28563232.568, 597.7; 28563243.081, 597.7; 28563253.578, 597.3; 28563261.926, 597.0; 28563272.424, 597.9; 28563282.903, 596.7; 28563293.403, 596.7; 28563303.856, 596.8; 28563312.33, 595.0; 28563322.824, 594.5; 28563333.257, 595.0; 28563343.71, 594.9; 28563352.104, 596.1; 28563362.606, 595.7; 28563373.104, 594.9; 28563383.508, 593.9; 28563393.973, 593.1; 28563402.368, 593.6; 28563412.836, 593.6; 28563423.272, 594.5; 28563433.748, 594.6; 28563442.126, 595.1; 28563452.598, 595.1; 28563463.064, 595.6; 28563473.449, 595.9; 28563483.875, 595.1; 28563492.199, 593.9; 28563502.589, 595.5; 28563513.012, 594.1; 28563523.554, 592.5; 28563531.92, 594.1; 28563542.325, 592.7; 28563552.806, 593.5; 28563563.274, 592.3; 28563573.722, 592.9; 28563582.176, 591.0; 28563592.673, 591.0; 28563603.124, 589.7; 28563613.598, 588.5; 28563621.94, 588.4; 28563632.409, 587.4; 28563642.89, 587.5; 28563653.297, 585.8; 28563663.778, 586.2; 28563672.095, 585.7; 28563682.525, 585.4; 28563693.012, 585.0; 28563703.574, 583.0; 28563711.934, 583.7; 28563722.443, 584.5; 28563732.927, 583.5; 28563743.379, 582.6; 28563753.845, 583.8; 28563762.304, 583.4; 28563772.802, 582.8; 28563783.239, 583.7; 28563793.721, 583.5; 28563802.08, 581.7; 28563812.565, 580.8; 28563823.041, 580.3; 28563833.514, 579.4; 28563841.965, 582.4; 28563852.447, 581.7; 28563862.931, 581.9; 28563873.459, 582.0; 28563883.942, 580.1; 28563892.288, 579.8; 28563902.712, 579.5; 28563913.196, 579.5; 28563923.689, 579.3; 28563932.112, 580.7; 28563942.659, 580.9; 28563953.141, 579.6; 28563963.577, 579.9; 28563972.02, 581.2; 28563982.423, 577.8; 28563992.936, 580.2; 28564003.417, 580.5; 28564013.92, 578.2; 28564022.296, 578.7; 28564032.748, 579.0; 28564043.226, 578.8; 28564053.663, 579.4; 28564062.044, 577.9; 28564072.476, 578.4; 28564082.93, 577.8; 28564093.331, 577.1; 28564103.816, 577.5; 28564112.221, 577.5; 28564122.812, 577.1; 28564133.346, 576.5; 28564143.721, 575.9; 28564152.077, 576.2; 28564162.497, 576.8; 28564172.95, 576.2; 28564183.389, 576.2; 28564193.851, 575.8; 28564202.323, 575.6; 28564212.825, 573.9; 28564223.335, 573.2; 28564233.848, 573.5; 28564242.214, 572.3; 28564252.681, 573.4; 28564263.142, 571.1; 28564273.615, 571.3; 28564282.056, 571.8; 28564292.504, 573.0; 28564302.958, 571.5; 28564313.374, 569.2; 28564323.808, 569.8; 28564332.129, 568.6; 28564342.669, 568.6; 28564353.155, 558.4; 28564363.592, 567.1; 28564371.967, 568.3; 28564382.389, 569.4; 28564392.822, 568.9; 28564403.317, 567.8; 28564413.697, 568.4; 28564422.041, 566.8; 28564432.614, 567.9; 28564443.179, 567.2; 28564453.782, 567.8; 28564462.175, 566.9; 28564472.642, 564.3; 28564483.094, 564.2; 28564493.528, 563.6; 28564501.898, 563.2; 28564512.374, 561.7; 28564522.811, 558.2; 28564533.267, 543.9; 28564543.734, 563.8; 28564552.151, 564.5; 28564562.554, 564.2; 28564572.984, 564.5; 28564583.424, 560.1; 28564591.93, 560.0; 28564602.341, 555.4; 28564612.826, 556.9; 28564623.252, 556.2; 28564633.756, 558.7; 28564642.17, 556.7; 28564652.638, 557.6; 28564663.163, 559.5; 28564673.709, 558.1; 28564682.112, 553.9; 28564692.593, 556.3; 28564703.098, 558.1; 28564713.558, 557.8; 28564721.982, 557.9; 28564732.452, 559.4; 28564742.865, 557.5; 28564753.272, 557.1; 28564763.733, 557.6; 28564772.078, 558.6; 28564782.539, 556.8; 28564792.994, 554.4; 28564803.449, 553.4; 28564813.942, 553.0; 28564822.303, 552.2; 28564832.7, 547.4; 28564843.169, 546.3; 28564853.715, 544.4; 28564862.094, 540.7; 28564872.519, 540.0; 28564882.941, 537.2; 28564893.407, 542.9; 28564903.832, 541.5; 28564912.174, 544.0; 28564922.613, 542.4; 28564933.05, 541.3; 28564943.463, 539.5; 28564953.944, 537.1; 28564962.353, 536.0; 28564972.93, 532.7; 28564983.555, 532.2; 28564994.008, 532.2; 28565002.338, 531.4; 28565012.767, 531.6; 28565023.204, 527.9; 28565033.643, 526.2; 28565042.021, 520.8; 28565052.459, 517.9; 28565062.94, 509.8; 28565073.383, 513.9; 28565083.805, 512.1; 28565092.167, 505.3; 28565102.607, 496.4; 28565113.073, 492.2; 28565123.527, 487.6; 28565132.011, 481.1; 28565142.467, 469.6; 28565153.058, 465.9; 28565163.495, 463.0; 28565173.902, 462.3; 28565182.231, 461.4; 28565192.639, 463.8; 28565203.119, 464.1; 28565213.62, 462.9; 28565224.093, 460.4; 28565232.402, 461.5; 28565242.89, 464.4; 28565253.308, 462.2; 28565263.666, 467.5; 28565274.103, 469.6; 28565282.486, 474.0; 28565292.917, 475.4; 28565303.448, 477.4; 28565313.884, 480.4; 28565322.263, 484.9; 28565332.764, 493.3; 28565343.312, 499.0; 28565353.871, 504.8; 28565362.247, 505.9; 28565372.767, 502.7; 28565383.206, 497.7; 28565393.765, 453.6; 28565402.155, 473.0; 28565412.684, 501.9; 28565423.138, 509.7; 28565433.635, 511.1; 28565444.105, 503.1; 28565452.45, 498.6; 28565462.889, 482.8; 28565473.33, 469.2; 28565483.781, 468.1; 28565492.142, 473.9; 28565502.606, 477.8; 28565513.032, 478.0; 28565523.469, 475.6; 28565533.999, 477.6; 28565542.313, 473.1; 28565552.769, 458.7; 28565563.188, 443.4; 28565573.653, 416.5; 28565584.09, 396.7; 28565592.42, 375.6; 28565602.891, 369.9; 28565613.362, 345.6; 28565623.858, 334.5; 28565632.237, 351.5; 28565642.642, 351.8; 28565653.059, 359.8; 28565663.611, 387.6; 28565674.043, 414.7; 28565682.469, 428.3; 28565692.936, 420.4; 28565703.488, 397.3; 28565713.924, 380.9; 28565722.318, 355.2; 28565732.736, 340.9; 28565743.187, 355.1; 28565753.608, 385.0; 28565764.077, 398.7; 28565772.502, 407.3; 28565782.985, 371.2; 28565793.499, 364.8; 28565803.894, 336.3; 28565812.24, 327.3; 28565822.77, 309.5; 28565833.238, 303.9; 28565843.676, 310.0; 28565854.11, 316.3; 28565862.507, 316.6; 28565873.03, 346.6; 28565883.421, 379.5; 28565893.971, 398.6; 28565902.376, 421.3; 28565912.817, 436.5; 28565923.345, 422.4; 28565933.783, 414.6; 28565944.14, 403.8; 28565952.501, 384.3; 28565962.923, 348.7; 28565973.391, 313.6; 28565983.863, 270.7; 28565992.238, 233.5; 28566002.663, 199.2; 28566013.084, 166.5; 28566023.489, 140.4; 28566033.938, 112.7; 28566042.3, 85.40000000000001; 28566052.726, 63.0; 28566063.175, 44.4; 28566073.631, 33.7; 28566084.1, 20.9; 28566092.427, 15.3; 28566102.928, 13.3; 28566113.365, 11.9; 28566123.829, 10.8; 28566132.18, 10.5; 28566142.629, 9.6; 28566153.085, 8.800000000000001; 28566163.519, 7.7; 28566173.943, 7.2; 28566182.29, 6.7; 28566192.728, 6.2; 28566203.165, 5.8; 28566213.614, 5.6; 28566224.051, 5.2; 28566232.379, 4.9; 28566242.883, 4.5; 28566253.321, 4.2; 28566263.704, 4.0; 28566274.148, 3.7; 28566282.541, 4.0; 28566292.991, 4.4; 28566303.444, 3.5; 28566313.943, 3.2; 28566322.288, 2.8; 28566332.789, 2.6; 28566343.181, 2.5; 28566353.603, 2.3; 28566364.068, 2.1; 28566372.402, 2.0; 28566382.839, 2.0; 28566393.333, 1.9; 28566403.759, 2.0; 28566412.117, 2.2; 28566422.589, 2.4; 28566433.21, 2.5; 28566443.728, 2.6; 28566452.054, 2.6; 28566462.633, 2.6; 28566473.135, 2.5; 28566483.6, 2.6; 28566494.118, 2.1; 28566502.668, 1.9; 28566513.162, 1.7; 28566523.602, 1.6; 28566534.052, 1.5; 28566542.444, 1.4; 28566552.913, 1.3; 28566563.416, 1.3; 28566573.896, 1.3; 28566582.321, 1.3; 28566592.728, 1.3; 28566603.121, 1.3; 28566613.619, 1.2; 28566624.105, 1.2; 28566632.477, 1.3]) annotation(Placement(visible = true, transformation(origin = {60, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  protected
    Real del_c = Modelica.Math.cos(decAng.decAng);
    Real del_s = Modelica.Math.sin(decAng.decAng);
    Real phi_c = Modelica.Math.cos(Lat);
    Real phi_s = Modelica.Math.sin(Lat);
    Real omg_c = Modelica.Math.cos(solHouAng.solHouAng);
    Real omg_s = Modelica.Math.sin(solHouAng.solHouAng);
    Real bet_c = Modelica.Math.cos(Modelica.Constants.pi / 2 - SurfTilt);
    Real bet_s = Modelica.Math.sin(Modelica.Constants.pi / 2 - SurfTilt);
    Real gam_c = Modelica.Math.cos(SurfOrientation);
    Real gam_s = Modelica.Math.sin(SurfOrientation);
  equation
    // connect(weatherBus.HDirNor,DNI) "Connects Hourly Direct Normal Irradiance from the weather file to the DNI output of context";
    connect(ExperimentalResults.y[1], DNI) annotation(Line(points = {{71, -20}, {94.06529999999999, -20}, {94.06529999999999, -20.178}, {94.06529999999999, -20.178}}));
    connect(SurfOrientation, SurfOrientation_out) "Connects Surface Orientation Parameter to Surface Orientation Output";
    connect(SurfTilt, SurfTilt_out) "Connects Surface Tilt Parameter to Surface Tilt Output";
    connect(TOutside.port, TDryBul) "Connects the prescribed heat model to the Dry Bulb heat port outlet" annotation(Line(points = {{70, 20}, {97.8229, 20}, {97.8229, 20}, {100, 20}}));
    connect(weatherBus.TDryBul, TOutside.T) "Connects the weather file Dry Bult to the TOutside prescribed temperature model" annotation(Line(points = {{20, 20}, {47.0247, 20}, {47.0247, 20}, {48, 20}}));
    connect(weatherBus, HDirTil.weaBus) "Connects the weather bus to the irradiance based on wall tilt calculation model (HDirTil)" annotation(Line(points = {{20, 20}, {19.7388, 20}, {19.7388, -17.4165}, {-3.48331, -17.4165}, {-3.48331, -40.0581}, {10, -40.0581}, {10, -40}}));
    //  connect(HDirTil.inc,AOI) "Connects incident angle to angle of incidence out" annotation(Line(points = {{31,-44},{45.5733,-44},{45.5733,-40.0581},{100,-40.0581},{100,-40}}));
    connect(weatherBus.solTim, solHouAng.solTim) "Connects solar time to solar hour angle model" annotation(Line(points = {{20, 20}, {19.7388, 20}, {19.7388, -17.4165}, {-63.5704, -17.4165}, {-63.5704, -79.8258}, {-52, -79.8258}, {-52, -80}}));
    connect(weatherBus.cloTim, decAng.nDay) "Calculates clock time to day number" annotation(Line(points = {{20, 20}, {19.7388, 20}, {19.7388, -17.4165}, {-63.5704, -17.4165}, {-63.5704, -40.0581}, {-52, -40.0581}, {-52, -40}}));
    connect(weaDat.weaBus, weatherBus) "Connects weather data to weather bus" annotation(Line(points = {{-20, 20}, {20.6096, 20}, {20, 20}}));
    //Uses the decAng and solHouAng to calculate the Declication and Solar Hour angles
    SunAlt = Modelica.Math.asin(Modelica.Math.sin(Lat) * Modelica.Math.sin(decAng.decAng) + Modelica.Math.cos(Lat) * Modelica.Math.cos(decAng.decAng) * Modelica.Math.cos(solHouAng.solHouAng));
    //Eq 1.6.6 Solar Engineering of Thermal Processes - Duff & Beckman
    SunAzi = sign(Modelica.Math.sin(solHouAng.solHouAng)) * abs(Modelica.Math.acos((Modelica.Math.cos(abs(Modelica.Constants.pi / 2 - SunAlt)) * Modelica.Math.sin(Lat) - Modelica.Math.sin(decAng.decAng)) / (Modelica.Math.cos(Lat) * Modelica.Math.sin(abs(Modelica.Constants.pi / 2 - SunAlt)))));
    //Eq 1.6.2 Solar Engineering of Thermal Processes - Duff & Beckman
    AOI = Modelica.Math.acos(del_s * phi_s * bet_c - del_s * phi_c * bet_s * gam_c + del_c * phi_c * bet_c * omg_c + del_c * phi_s * bet_s * gam_c * omg_c + del_c * bet_s * gam_s * omg_s);
    annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
  end ICS_Context;

  package Envelope "Package of all the Envelope components to create an Integrated Concentrating Solar simulation"
    extends Modelica.Icons.Package;

    model ICS_EnvelopeCassette "This model in the Envelope Cassette (Double-Skin Facade) that houses the ICSolar Stack and Modules. This presents a building envelope"
      parameter Real StackHeight = 6.0 "Number of Modules in a stack, currently not used";
      parameter Real NumStacks = 4.0 "Number of stacks in an envelope, currently not used";
      parameter Modelica.SIunits.Area ArrayArea = 1 "Area of the array";
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in "Ambient cavity temperature" annotation(Placement(visible = true, transformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a "Thermal fluid inflow port, before heat exchange" annotation(Placement(visible = true, transformation(origin = {-100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-95, -85}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "DNI from weather file" annotation(Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput AOI "Angle of incidence" annotation(Placement(visible = true, transformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SunAlt "Altitude of the sun " annotation(Placement(visible = true, transformation(origin = {-100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SunAzi "Azimuth of the sun " annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfaceOrientation annotation(Placement(visible = true, transformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfaceTilt annotation(Placement(visible = true, transformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      ICSolar.Envelope.ICS_GlazingLosses ics_glazinglosses1 annotation(Placement(visible = true, transformation(origin = {-55, 55}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      ICSolar.Envelope.ICS_SelfShading ics_selfshading1 annotation(Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-17.5, -17.5}, {17.5, 17.5}}, rotation = 0)));
      ICSolar.Stack.ICS_Stack ics_stack1 annotation(Placement(visible = true, transformation(origin = {40, 0}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput Power_Electric "Electric power generated" annotation(Placement(visible = true, transformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b "Thermal fluid outflow port, after heat exchange" annotation(Placement(visible = true, transformation(origin = {100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      // Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b Power_Heat "Heat power generated" annotation(Placement(visible = true, transformation(origin = {100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      // Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort generated_enthalpy "Placeholder to make" annotation(Placement(visible = false));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedtemperature1(T = 72 + 274.15) annotation(Placement(visible = true, transformation(origin = {-20, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      ICSolar.Envelope.CavityHeatBalance cavityheatbalance1 annotation(Placement(visible = true, transformation(origin = {20, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(fixedtemperature1.port, cavityheatbalance1.Interior) annotation(Line(points = {{-10, 60}, {-1.48368, 60}, {-1.48368, 55.7864}, {9.79228, 55.7864}, {9.79228, 55.7864}}));
      connect(cavityheatbalance1.ICS_Heat, ics_stack1.TAmb_in) annotation(Line(points = {{20, 50}, {0.593472, 50}, {0.593472, 20.178}, {15, 20.178}, {15, 20}}));
      connect(TAmb_in, cavityheatbalance1.Exterior) annotation(Line(points = {{-100, 80}, {5.04451, 80}, {5.04451, 65.8754}, {10, 66}, {10, 66}}));
      // generated_enthalpy = if ics_stack1.flowport_b1 < 0 then -ics_stack1.flowport_b1 else ics_stack1.flowport_b1;
      // Power_Heat = (-ics_stack1.flowport_b1) - ics_stack1.flowport_a;
      connect(flowport_a, ics_stack1.flowport_a1) annotation(Line(points = {{-100, -80}, {3.78072, -80}, {3.78072, -15.5009}, {15, -15.5009}, {15, -15}}));
      connect(ics_selfshading1.DNI_out, ics_stack1.DNI) annotation(Line(points = {{-2.5, 3.5}, {6.04915, 3.5}, {6.04915, -4.53686}, {15, -4.53686}, {15, -5}}));
      connect(ics_stack1.flowport_b1, flowport_b) annotation(Line(points = {{65, 0}, {80.1512, 0}, {80.1512, -22.3062}, {100, -22.3062}, {100, -20}}));
      connect(ics_stack1.Power_out, Power_Electric) annotation(Line(points = {{65, 10}, {80.9074, 10}, {80.9074, 18.9036}, {100, 18.9036}, {100, 20}}));
      connect(SurfaceTilt, ics_selfshading1.SurfTilt) annotation(Line(points = {{-100, -40}, {-45.5285, -40}, {-45.5285, -14.0921}, {-37.5, -14.0921}, {-37.5, -14}}));
      connect(SurfaceOrientation, ics_selfshading1.SurfOrientation) annotation(Line(points = {{-100, -20}, {-57.7236, -20}, {-57.7236, -6.50407}, {-37.5, -6.50407}, {-37.5, -7}}));
      connect(SunAzi, ics_selfshading1.SunAzi) annotation(Line(points = {{-100, 0}, {-37.9404, 0}, {-37.5, 0}}));
      connect(SunAlt, ics_selfshading1.SunAlt) annotation(Line(points = {{-100, 20}, {-57.1816, 20}, {-57.1816, 6.77507}, {-37.5, 6.77507}, {-37.5, 7}}));
      connect(ics_glazinglosses1.SurfDirNor, ics_selfshading1.DNI_in) annotation(Line(points = {{-40, 58}, {-32.7913, 58}, {-32.7913, 33.6043}, {-50.1355, 33.6043}, {-50.1355, 14.0921}, {-37.5, 14.0921}, {-37.5, 14}}));
      connect(AOI, ics_glazinglosses1.AOI) annotation(Line(points = {{-100, 40}, {-83.1978, 40}, {-83.1978, 45.7995}, {-70, 45.7995}, {-70, 46}}));
      connect(DNI, ics_glazinglosses1.DNI) annotation(Line(points = {{-100, 60}, {-75.88079999999999, 60}, {-75.88079999999999, 63.9566}, {-70, 63.9566}, {-70, 64}}));
      ics_stack1.StackHeight = StackHeight "linking variables of stack heigh";
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {14.1802, -9.308960000000001}, extent = {{-81.85129999999999, 57.4687}, {64.45999999999999, -43.48}}, textString = "Envelope")}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
    end ICS_EnvelopeCassette;

    model ICS_GlazingLosses "This model calculates the transmittance of a single glass layer and discounts the DNI by the absorption and reflection"
      parameter Real Trans_glaz = 0.74 "Good glass: Guardian Ultraclear 6mm: 0.87. For our studio IGUs, measured 0.71. But give it 0.74, because we measured at ~28degrees, which will increase absorptance losses.";
      Modelica.Blocks.Interfaces.RealOutput SurfDirNor "Surface direct normal solar irradiance" annotation(Placement(visible = true, transformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput AOI "Angle of incidence" annotation(Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "Direct normal irradiance" annotation(Placement(visible = true, transformation(origin = {-100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      if AOI <= 1.57 then
        SurfDirNor = DNI * ((-1.03279 * AOI ^ 6) + 3.67852 * AOI ^ 5 + (-5.11451 * AOI ^ 4) + 3.27596 * AOI ^ 3 + (-0.9393 * AOI ^ 2) + 0.09071 * AOI + 0.96) * ((-0.1167 * AOI ^ 3) + 0.139 * AOI ^ 2 + (-0.0643 * AOI ^ 1) + 0.95) * Trans_glaz / (0.96 * 0.95) "Fresnel Reflection and material absorption losses from Polyfits where P_Transmitted(AOI)";
        //direct normal attenuated by...
        //first the fresnel losses polynomial fit, from snell's and indices of refraction ("fresnel loss with glazing.xlsx")
        //then the absorption losses polynomial fit, working from guardian UltraWhite data
        //working off their catalog at https://glassanalytics.guardian.com/PerformanceCalculator.aspx,and "Guardian UltraWhite specs.xlsx"
        //the final Trans_glaz/(other constants) brings the normal transmittance in-line with 6mm guardian UltraWhite solar transmittance of 87%, or whatever the studio-measured empirical trans is.
        //baseline absorptance transmission from guardian data for 6mm glass is ~95%
        //note: spectral mismatch between glazing and CCA was investigated, deemed negigible ("spectral transmittance of glazing and CPV performance.xlsx")
        //updated by NEN nov9-14
      else
        SurfDirNor = 0;
      end if;
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {-2.81, 1.48}, extent = {{-67, 33.14}, {67, -33.14}}, textString = "Glazing Losses")}));
    end ICS_GlazingLosses;

    model ICS_SelfShading "This model multiplies the DNI in by a shaded factor determined from the solar altitude and azimuth"
      Modelica.Blocks.Interfaces.RealOutput DNI_out "DNI after shading factor multiplication" annotation(Placement(visible = true, transformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Tables.CombiTable2D Shading(table = [0, -3.1415926, -1.04719, -0.959927, -0.872667, -0.785397, -0.6981270000000001, -0.610867, -0.523597, -0.436327, -0.349067, -0.261797, -0.174837, -0.08726730000000001, 0, 0.08726730000000001, 0.174837, 0.261797, 0.349067, 0.436327, 0.523597, 0.610867, 0.6981270000000001, 0.785397, 0.872667, 0.959927, 1.04719, 3.1415926; -0.872665, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0; -0.785398, 0, 0, 0.515733288, 0.582273933, 0.644111335, 0.700774874, 0.751833306, 0.796898047, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.796898047, 0.751833306, 0.700774874, 0.644111335, 0.582273933, 0.515733288, 0, 0; -0.698132, 0, 0, 0.558719885, 0.630806722, 0.697798298, 0.759184768, 0.814498944, 0.86331985, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.86331985, 0.814498944, 0.759184768, 0.697798298, 0.630806722, 0.558719885, 0, 0; -0.610865, 0, 0, 0.5974542859999999, 0.674538691, 0.746174596, 0.811816808, 0.870965752, 0.923171268, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.923171268, 0.870965752, 0.811816808, 0.746174596, 0.674538691, 0.5974542859999999, 0, 0; -0.523599, 0, 0, 0.6316417, 0.713137013, 0.788872054, 0.8582704330000001, 0.920803986, 0.975996795, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.975996795, 0.920803986, 0.8582704330000001, 0.788872054, 0.713137013, 0.6316417, 0, 0; -0.436332, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; -0.349066, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; -0.261799, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; -0.174533, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; -0.087266, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; 0, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; 0.087266, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; 0.174533, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; 0.261799, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; 0.349066, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; 0.436332, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; 0.523599, 0, 0, 0.6316417, 0.713137013, 0.788872054, 0.8582704330000001, 0.920803986, 0.975996795, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.975996795, 0.920803986, 0.8582704330000001, 0.788872054, 0.713137013, 0.6316417, 0, 0; 0.610865, 0, 0, 0.5974542859999999, 0.674538691, 0.746174596, 0.811816808, 0.870965752, 0.923171268, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.923171268, 0.870965752, 0.811816808, 0.746174596, 0.674538691, 0.5974542859999999, 0, 0; 0.698132, 0, 0, 0.558719885, 0.630806722, 0.697798298, 0.759184768, 0.814498944, 0.86331985, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.86331985, 0.814498944, 0.759184768, 0.697798298, 0.630806722, 0.558719885, 0, 0; 0.785398, 0, 0, 0.515733288, 0.582273933, 0.644111335, 0.700774874, 0.751833306, 0.796898047, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.796898047, 0.751833306, 0.700774874, 0.644111335, 0.582273933, 0.515733288, 0, 0; 0.872665, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]) "Shading factors based on altitude and azimuth" annotation(Placement(visible = true, transformation(origin = {-20, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI_in "DNI in before shading factor multiplication" annotation(Placement(visible = true, transformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Product product1 "Multiplication of DNI and shading factor" annotation(Placement(visible = true, transformation(origin = {20, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      ICSolar.Envelope.RotationMatrixForSphericalCood rotationmatrixforsphericalcood1 annotation(Placement(visible = true, transformation(origin = {-60, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SunAzi "Solar azimuth" annotation(Placement(visible = true, transformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfTilt annotation(Placement(visible = true, transformation(origin = {-100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SunAlt "Solar altitude" annotation(Placement(visible = true, transformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfOrientation annotation(Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      product1.u2 = if Shading.y < 0 then 0 else Shading.y;
      connect(rotationmatrixforsphericalcood1.SurfYaw, Shading.u2) annotation(Line(points = {{-50, -34}, {-45.283, -34}, {-45.283, -46.1538}, {-32, -46.1538}, {-32, -46}}));
      connect(rotationmatrixforsphericalcood1.SurfPitch, Shading.u1) annotation(Line(points = {{-50, -44}, {-43.2511, -44}, {-43.2511, -34.2525}, {-32, -34.2525}, {-32, -34}}));
      connect(SurfTilt, rotationmatrixforsphericalcood1.SurfaceTilt) annotation(Line(points = {{-100, -80}, {-75.60980000000001, -80}, {-75.60980000000001, -46.3415}, {-70, -46.3415}, {-70, -44}}));
      connect(SurfOrientation, rotationmatrixforsphericalcood1.SurfaceOrientation) annotation(Line(points = {{-100, -60}, {-78.8618, -60}, {-78.8618, -42.0054}, {-70, -42.0054}, {-70, -40}}));
      connect(SunAlt, rotationmatrixforsphericalcood1.SunAlt) annotation(Line(points = {{-100, -40}, {-78.8618, -40}, {-78.8618, -37.9404}, {-70, -37.9404}, {-70, -36}}));
      connect(SunAzi, rotationmatrixforsphericalcood1.SunAzi) annotation(Line(points = {{-100, -20}, {-76.6938, -20}, {-76.6938, -33.8753}, {-70, -33.8753}, {-70, -32}}));
      connect(product1.y, DNI_out) "DNI after multiplication connected to output of model" annotation(Line(points = {{31, 40}, {58.5909, 40}, {58.5909, 19.7775}, {100, 19.7775}, {100, 20}}));
      //connect(Shading.y,product1.u2) "Shading factor connecting to product" annotation(Line(points = {{-9,-40},{-0.741656,-40},{-0.741656,33.869},{8,33.869},{8,34}}));
      connect(DNI_in, product1.u1) "Model input DNI connecting to product" annotation(Line(points = {{-100, 80}, {-36.3412, 80}, {-36.3412, 45.9827}, {8, 45.9827}, {8, 46}}));
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {-4.59, 2.51}, extent = {{-72.63, 35.36}, {72.63, -35.36}}, textString = "Self Shading")}));
    end ICS_SelfShading;

    class RotationMatrixForSphericalCood "This models changes the reference frame from the Solar Altitude / Aizmuth to the surface yaw and pitch angles based on building orientatino and surface tilt"
      // parameter Real RollAng = 0;  Not included in current model verison
      Modelica.Blocks.Interfaces.RealOutput SurfYaw annotation(Placement(visible = true, transformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 60}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput SurfPitch annotation(Placement(visible = true, transformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -40}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      // Construction of Spherical to Cartesain Matrix
      Real phi = 3 * Modelica.Constants.pi / 2 - SunAzi;
      Real theta = Modelica.Constants.pi / 2 - SunAlt "Solar Zeneth Angle";
      Real PitchAng = SurfaceTilt "Tilt back from Vertical Position";
      Real YawAng = SurfaceOrientation "Zero is direct SOUTH";
      Real vSphToCart[3, 1] = [Modelica.Math.sin(theta) * Modelica.Math.cos(phi); Modelica.Math.sin(theta) * Modelica.Math.sin(phi); Modelica.Math.cos(theta)];
      // Result of Cartesian to Spherical
      Real vCartToSph[3, 1];
      // Rotation around X-axis --> RollAng
      Real Rx[3, 3] = [1, 0, 0; 0, Modelica.Math.cos(PitchAng), -1 * Modelica.Math.sin(PitchAng); 0, Modelica.Math.sin(PitchAng), Modelica.Math.cos(PitchAng)];
      // Rotation around Y-axis --> PitchAng
      //	Real Ry[3,3] = [Modelica.Math.cos(-1*PitchAng),0,Modelica.Math.sin(-1*PitchAng);0,1,0;-1 * Modelica.Math.sin(-1*PitchAng),0,Modelica.Math.cos(-1*PitchAng)];
      // Rotation around the Z-axis --> YawAng
      Real Rz[3, 3] = [Modelica.Math.cos(YawAng), -1 * Modelica.Math.sin(YawAng), 0; Modelica.Math.sin(YawAng), Modelica.Math.cos(YawAng), 0; 0, 0, 1];
      Modelica.Blocks.Interfaces.RealInput SunAzi annotation(Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 80}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SunAlt annotation(Placement(visible = true, transformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 40}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfaceOrientation annotation(Placement(visible = true, transformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfaceTilt annotation(Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -40}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
    equation
      vCartToSph = Rx * Rz * vSphToCart;
      SurfPitch = Modelica.Constants.pi / 2 - Modelica.Math.acos(vCartToSph[3, 1]);
      SurfYaw = (-1 * Modelica.Math.atan(vCartToSph[2, 1] / vCartToSph[1, 1])) - sign(vCartToSph[1, 1]) * Modelica.Constants.pi / 2;
      annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {16.0156, 3.67356}, extent = {{-101.49, 60.28}, {73.98, -63.83}}, textString = "Transform Matrix")}), experiment(StartTime = 0, StopTime = 86400, Tolerance = 0.001, Interval = 86.5731));
    end RotationMatrixForSphericalCood;

    function EnthalpyDifferential
      input Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a baseline_enthalpy annotation(Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      input Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a generated_enthalpy annotation(Placement(visible = true, transformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      output Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b enthalpy_power annotation(Placement(visible = true, transformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      generated_enthalpy = if generated_enthalpy < 0 then -generated_enthalpy else generated_enthalpy;
      baseline_enthalpy = if baseline_enthalpy < 0 then -baseline_enthalpy else baseline_enthalpy;
      enthalpy_power = generated_enthalpy - baseline_enthalpy;
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics));
    end EnthalpyDifferential;

    model CavityHeatBalance
      extends ICSolar.Parameters;
      parameter Real GlassArea = NumModules * 0.3 * 0.3;
      parameter Real CavityVolume = GlassArea * 0.5;
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor Conduction_Exterior(G = 10.17809 * GlassArea) "Lumped Thermal Conduction between Exterior and Cavity" annotation(Placement(visible = true, transformation(origin = {-40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Interior annotation(Placement(visible = true, transformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Exterior annotation(Placement(visible = true, transformation(origin = {-100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor CavityHeatCapacity(C = 2.072 * 1000) "Includes Air and ICS Components to add to the Heat Capacity of the Cavity" annotation(Placement(visible = true, transformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor Conduction_Interior(G = 3.309792 * GlassArea) "Conduction Heat Transfer between Cavity and Interior" annotation(Placement(visible = true, transformation(origin = {40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b ICS_Heat annotation(Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(Conduction_Interior.port_a, Interior) annotation(Line(points = {{50, 20}, {101.78, 20}, {101.78, 20.4748}, {101.78, 20.4748}}));
      connect(ICS_Heat, CavityHeatCapacity.port) annotation(Line(points = {{0, -100}, {0.593472, -100}, {0.593472, 29.9703}, {0.593472, 29.9703}}));
      connect(Conduction_Interior.port_b, CavityHeatCapacity.port) annotation(Line(points = {{30, 20}, {0.296736, 20}, {0.296736, 29.3769}, {0.296736, 29.3769}}));
      connect(Conduction_Exterior.port_b, CavityHeatCapacity.port) annotation(Line(points = {{-30, 20}, {0.296736, 20}, {0.296736, 30.5638}, {0.296736, 30.5638}}));
      connect(Exterior, Conduction_Exterior.port_a) annotation(Line(points = {{-100, 20}, {-50.1484, 20}, {-50.1484, 20.4748}, {-50.1484, 20.4748}}));
      annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {2.37855, 61.2725}, extent = {{-50.45, 33.98}, {50.45, -33.98}}, textString = "Cavity"), Text(origin = {0.742849, 12.7626}, extent = {{-52.37, 30.56}, {52.37, -30.56}}, textString = "Heat"), Text(origin = {2.22528, -43.7642}, extent = {{-61.28, 22.7}, {61.28, -22.7}}, textString = "Balance")}));
    end CavityHeatBalance;
  end Envelope;

  package Stack "Package of all the necessary components to create an Integrated Concentrating Solar simulation"
    extends Modelica.Icons.Package;

    model ICS_Stack "This model represents an individual Integrated Concentrating Solar Stack"
      Modelica.Blocks.Interfaces.RealInput StackHeight "Might be used later to multiply Modules" annotation(Placement(visible = true, transformation(origin = {-100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "DNI in from Envelope (Parent)" annotation(Placement(visible = true, transformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1 "Thermal fluid inflow port" annotation(Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1 "Thermal fluid outflow port" annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in "Ambient temperature of the cavity" annotation(Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput Power_out "Electrical power generated" annotation(Placement(visible = true, transformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      ICSolar.Module.ICS_Module ics_module1 annotation(Placement(visible = true, transformation(origin = {0, 20}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
      ICSolar.Module.ICS_Module ics_module2 annotation(Placement(visible = true, transformation(origin = {0, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      ICSolar.Module.ICS_Module ics_module3 annotation(Placement(visible = true, transformation(origin = {0, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Add3 add31 annotation(Placement(visible = true, transformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(add31.y, Power_out) annotation(Line(points = {{71, 40}, {92.28489999999999, 40}, {92.28489999999999, 39.7626}, {92.28489999999999, 39.7626}}));
      connect(ics_module3.Power_out, add31.u3) annotation(Line(points = {{10, -56}, {44.5104, -56}, {44.5104, 31.7507}, {47.181, 31.7507}, {47.181, 31.7507}}));
      connect(ics_module2.Power_out, add31.u2) annotation(Line(points = {{10, -16}, {39.1691, -16}, {39.1691, 39.7626}, {46.8843, 39.7626}, {46.8843, 39.7626}}));
      connect(ics_module1.Power_out, add31.u1) annotation(Line(points = {{25, 30}, {32.0475, 30}, {32.0475, 48.368}, {46.8843, 48.368}, {46.8843, 48.368}}));
      connect(ics_module3.flowport_b1, flowport_b1) annotation(Line(points = {{10, -64}, {64.3917, -64}, {64.3917, 0.890208}, {101.484, 0.890208}, {101.484, 0.890208}}));
      connect(DNI, ics_module3.DNI) annotation(Line(points = {{-100, -20}, {-25.5193, -20}, {-25.5193, -57.8635}, {-9.79228, -57.8635}, {-9.79228, -57.8635}}));
      connect(DNI, ics_module2.DNI) annotation(Line(points = {{-100, -20}, {-16.0237, -20}, {-16.0237, -18.3976}, {-9.79228, -18.3976}, {-9.79228, -18.3976}}));
      connect(flowport_a1, ics_module1.flowport_a1) annotation(Line(points = {{-100, -60}, {-39.7171, -60.2967}, {-39.7171, 9.911160000000001}, {-25, 10.2079}, {-25, 10}}));
      connect(TAmb_in, ics_module3.TAmb_in) annotation(Line(points = {{-100, 60}, {-34.1246, 60}, {-34.1246, -52.5223}, {-10.089, -52.5223}, {-10.089, -52.5223}}));
      connect(TAmb_in, ics_module2.TAmb_in) annotation(Line(points = {{-100, 60}, {-34.1246, 60}, {-34.1246, -12.1662}, {-9.79228, -12.1662}, {-9.79228, -12.1662}}));
      connect(ics_module2.flowport_b1, ics_module3.flowport_a1) annotation(Line(points = {{10, -24}, {13.3531, -24}, {13.3531, -44.5104}, {-20.4748, -44.5104}, {-20.4748, -64.095}, {-10.3858, -64.095}, {-10.3858, -64.095}}));
      connect(ics_module1.flowport_b1, ics_module2.flowport_a1) annotation(Line(points = {{25, 10}, {36.4985, 10}, {36.4985, -4.74777}, {-21.365, -4.74777}, {-21.365, -24.6291}, {-9.79228, -24.6291}, {-9.79228, -24.6291}}));
      connect(DNI, ics_module1.DNI) annotation(Line(points = {{-100, -20}, {-46.1248, -20}, {-46.1248, 25.7089}, {-25, 25.7089}, {-25, 25}}));
      connect(TAmb_in, ics_module1.TAmb_in) annotation(Line(points = {{-100, 60}, {-34.0265, 60}, {-34.0265, 39.3195}, {-25, 39.3195}, {-25, 40}}));
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {0.95, 5.29}, extent = {{-61.06, 40.08}, {61.06, -40.08}}, textString = "Stack")}));
    end ICS_Stack;
  end Stack;

  package Module "Package of all the necessary components to create an Integrated Concentrating Solar simulation"
    extends Modelica.Icons.Package;

    model ICS_Module "This model contains all the components and equations that simulate one module of Integrated Concentrating Solar"
      parameter Modelica.SIunits.Length LensWidth = 0.25019 "Width of Fresnel Lens, meters";
      parameter Modelica.SIunits.Length CellWidth = 0.01 "Width of the PV cell, meters";
      //  parameter String FresMat = "PMMA" "'PMMA' or 'Silicon on Glass', use the exact spellings provided";
      //  parameter Real FNum = 0.85 "FNum determines the lens transmittance based on concentrating";
      //  Integer FMatNum "Integer used to pipe the material to other models";
      parameter Real Gc_Receiver = 3.66 * 401 / (2 * (0.003175 + 0.01905)) * (2 * Modelica.Constants.pi * (0.003175 + 0.01905) * 0.01 + 2 * Modelica.Constants.pi * (0.003175 + 0.01905) ^ 2) "Convection Heat Transfer of Receiver to air Nu(=3.66) * kofWater / Diameter * Surface Area";
      parameter Real Gc_WaterTube = 3.66 * 0.58 / (2 * 0.003175) * (2 * Modelica.Constants.pi * 0.003175 * 0.3 + 2 * Modelica.Constants.pi * 0.003175 ^ 2) "Convection Heat Transfer of Water to Piping Nu(=3.66) * kofWater / Diameter * Surface Area";
      parameter Real Gc_InsulationAir = 3.66 * 0.023 / (2 * (0.003175 + 0.01905)) * (2 * Modelica.Constants.pi * (0.003175 + 0.01905) * 0.3 + 2 * Modelica.Constants.pi * (0.003175 + 0.01905) ^ 2) "Convection Heat Transfer of Piping to Air Nu(=3.66) * kofWater / Diameter * Surface Area";
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1 "Outflow port of the thermal fluid (to Parent)" annotation(Placement(visible = true, transformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1 "Inflow port of the thermal fluid (from Parent)" annotation(Placement(visible = true, transformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "DNI into the Module" annotation(Placement(visible = true, transformation(origin = {-100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in "Ambient temperature of the cavity into Module model for use in the heat receiver" annotation(Placement(visible = true, transformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      ICSolar.Receiver.moduleReceiver modulereceiver1 "Heat Receiver to calculate the heat transfer between heat gen and heat transfered to thermal fluid" annotation(Placement(visible = true, transformation(origin = {65, -5}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput Power_out "Electrical generation outflow (to Parent)" annotation(Placement(visible = true, transformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      ICSolar.Module.ICS_LensLosses ics_lenslosses1 annotation(Placement(visible = true, transformation(origin = {-60, -2}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      ICSolar.Module.ICS_PVPerformance ics_pvperformance1 annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-16.25, -16.25}, {16.25, 16.25}}, rotation = 0)));
    equation
      connect(ics_pvperformance1.ElectricalGen, Power_out) annotation(Line(points = {{16.25, 6.5}, {33.9773, 6.5}, {33.9773, 39.3195}, {100, 39.3195}, {100, 40}}));
      connect(ics_pvperformance1.ThermalGen, modulereceiver1.ThermalGen) annotation(Line(points = {{16.25, -7.3125}, {45.38, -7.3125}, {45.38, 6.04915}, {50, 6.04915}, {50, -0.714286}}));
      connect(ics_lenslosses1.ConcentrationFactor, ics_pvperformance1.ConcentrationFactor) annotation(Line(points = {{-45, -11}, {-39.3195, -11}, {-39.3195, -9.82987}, {-16.25, -9.82987}, {-16.25, -9.75}}));
      connect(ics_lenslosses1.DNI_out, ics_pvperformance1.DNI_in) annotation(Line(points = {{-45, 4}, {-34.4045, 4}, {-34.4045, 0.378072}, {-16.25, 0.378072}, {-16.25, 0}}));
      connect(DNI, ics_lenslosses1.DNI_in) annotation(Line(points = {{-100, 20}, {-75, 20}, {-75, -2}}));
      connect(modulereceiver1.flowport_a1, flowport_a1) "Connect pump flow the heat receiver" annotation(Line(points = {{62, 10}, {39.4366, 10}, {39.4366, -40.1408}, {-100, -40.1408}, {-100, -40}}));
      connect(TAmb_in, modulereceiver1.TAmb_in) "Connect Ambient temperature from Context to the HeatReceivers calculations" annotation(Line(points = {{-100, 80}, {25.7277, 80}, {25.7277, 0.08450000000000001}, {50, 0.08450000000000001}, {50, 6.78571}}));
      connect(modulereceiver1.flowport_b1, flowport_b1) "Connect HeatReceiver fluid flow out to the flowport outlet of Module" annotation(Line(points = {{80, -0.714286}, {87.08920000000001, -0.714286}, {87.08920000000001, -39.2019}, {100, -39.2019}, {100, -40}}));
      //  if FresMat == "PMMA" then
      //    FMatNum = 1;
      //  elseif FresMat == "Silicon on Glass" then
      //    FMatNum = 2;
      //  else
      //  end if;
      //  ics_lens1.FMat = FMatNum "Connects FMatNum calculated in Module to Lens FMat input";
      ics_lenslosses1.LensWidth = LensWidth "Connects LensWidth defined in Module to Lens LensWidth";
      ics_lenslosses1.CellWidth = CellWidth "Connect CellWidth defined in Module to CellWidth in Lens";
      ics_pvperformance1.CellWidth = CellWidth "Connect CellWidth defined in Module to CellWidth in PVPerformance for EIPC calc on Cell";
      // ics_lens1.FNum = FNum "Connects the FNumber defined in Module to FNum in Lens for concentration and transmission equations";
      modulereceiver1.Input_waterBlock_1 = Gc_Receiver "connect(Gc_Receiver,modulereceiver1.Input_waterBlock_1)";
      modulereceiver1.Input_heatLossTube_1 = Gc_WaterTube "connect(Gc_WaterTube,modulereceiver1.Input_heatLossTube_1)";
      modulereceiver1.Input_heatLossTube_2 = Gc_InsulationAir "connect(Gc_InsulationAir,modulereceiver1.Input_heatLossTube_2)";
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {-1.41, 9.98}, extent = {{-67.14, 46.6}, {67.14, -46.6}}, textString = "Module")}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
    end ICS_Module;

    model ICS_Lens "This model does the concentrating lens calculations: transmission losses and concentration. DNI_out is the DNI after concentration"
      Modelica.Blocks.Interfaces.RealInput DNI_in "DNI in from Module (Parent)" annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput FNum "F Number of concentrating Lens" annotation(Placement(visible = false, transformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput LensWidth "Width of Concentrating Lens" annotation(Placement(visible = false, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput CellWidth "Width of PV Cell" annotation(Placement(visible = false, transformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.IntegerInput FMat "Integer describing lens material and selecting tran losses equation accordingly" annotation(Placement(visible = false, transformation(origin = {-100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Real ModuleDepth = LensWidth * sqrt(2) * FNum;
      Real LensTrans "Lens transmittance variable";
      Modelica.Blocks.Interfaces.RealOutput DNI_out "Output DNI after Lens manipulation (including concentration)" annotation(Placement(visible = true, transformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput ConcentrationFactor = LensWidth ^ 2 / CellWidth ^ 2 "Concentration Factor determined from area of Lens in relation to area of Cell" annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      if FMat == 1 then
        LensTrans = ((-20.833 * FNum ^ 3) - 23.214 * FNum ^ 2 + 106.1 * FNum + 23.207) / 100;
      else
        LensTrans = ((-104.17 * FNum ^ 3) + 171.43 * FNum ^ 2 - 40.744 * FNum + 57.236) / 100;
      end if;
      DNI_out = DNI_in * LensTrans * ConcentrationFactor "Calculating DNI after Lens Transmission Losses and Lens Concentration";
    end ICS_Lens;

    model ICS_PVPerformance "This model uses the EIPC (based on cell area) and PVEfficiency (based on ConcentrationFactor) to calculate the ElectricalGen and ThermalGen"
      Modelica.Blocks.Interfaces.RealInput CellWidth "Width of the PV Cell" annotation(Placement(visible = false, transformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Real CellEfficiency = 0.36436 + (52.5 - ThermalGen.T) * 0.0005004 + (ConcentrationFactor - 627.5) * 1.9965e-006 "Equation to determine the PVEfficiency from the ConcentrationFactor and Cell Temperature";
      Real EIPC "Energy In Per Cell";
      Modelica.Blocks.Interfaces.RealInput ConcentrationFactor "Used to represent 'suns' for the calculation of PVEfficiency" annotation(Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput ElectricalGen "Real output for piping the generated electrical energy out" annotation(Placement(visible = true, transformation(origin = {100, 20}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {100, 40}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b ThermalGen "Output heat port to pipe the generated heat out and to the heat receiver" annotation(Placement(visible = true, transformation(origin = {100, -60}, extent = {{-15, -15}, {15, 15}}, rotation = 0), iconTransformation(origin = {100, -45}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI_in "DNI in from the Lens model (include Concentration)" annotation(Placement(visible = true, transformation(origin = {-100, 20}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
    equation
      EIPC = DNI_in * CellWidth ^ 2 "Energy In Per Cell, used to calculate maximum energy on the cell";
      ElectricalGen = EIPC * CellEfficiency "Electrical energy conversion";
      ThermalGen.Q_flow = -EIPC * (1 - CellEfficiency) "Energy left over after electrical gen is converted to heat";
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {-3.11195, -3.79298}, extent = {{-63.55, 45.8}, {63.55, -45.8}}, textString = "PV Performance")}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
    end ICS_PVPerformance;

    model ICS_LensLosses "This model does the concentrating lens calculations: transmission losses and concentration. DNI_out is the DNI after concentration"
      parameter Real Eff_Optic = 0.882;
      Modelica.Blocks.Interfaces.RealInput DNI_in annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput LensWidth annotation(Placement(visible = false, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput CellWidth annotation(Placement(visible = false, transformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput DNI_out annotation(Placement(visible = true, transformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput ConcentrationFactor = LensWidth ^ 2 / CellWidth ^ 2 annotation(Placement(visible = true, transformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      DNI_out = DNI_in * Eff_Optic * ConcentrationFactor;
      annotation(Documentation(info = "<HTML>
<p><b> Tramission losses associated with the lens / optic elements. Ratio of power on the cell to power on the entry aperture.</b></p>

<p>Optical efficiency from LBI Benitez <b>High performance Fresnel-based photovoltaic concentrator</b> where Eff_Opt(F#). Assuming anti-reflective coating on secondary optic element (SOE), current Gen8 module design Eff_Opt(0.84) = 88.2%</p> 

<b>More Information:</b>
<p> The F-number for a Fresnal-Köhler lens is the ratio of the distance between cell and Fresenel lens to the diagonal measurement of the front lens. The concentrator optical efficiency is defined as the ratio of power on the cell to the power on the entry aperture when the sun is exactly on-axis.</p>
</HTML>"), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {0.694127, 36.2079}, extent = {{-72.52, 54.46}, {72.52, -54.46}}, textString = "Lens Losses")}));
    end ICS_LensLosses;
  end Module;

  package Receiver "Package of all the necessary components to create an Integrated Concentrating Solar simulation"
    extends Modelica.Icons.Package;

    model moduleReceiver
      parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium = Modelica.Thermal.FluidHeatFlow.Media.Water() "Water" annotation(choicesAllMatching = true);
      parameter Modelica.SIunits.Pressure PAmb(displayUnit = "PA") = 101325 "Ambient pressure";
      parameter Modelica.SIunits.Temperature TAmb(displayUnit = "degK") = 293.15 "Ambient temperature";
      ICSolar.Receiver.subClasses.receiverInternalEnergy receiverInternalEnergy1 annotation(Placement(visible = true, transformation(origin = {-158.447, -48.4473}, extent = {{-23.4473, -23.4473}, {23.4473, 23.4473}}, rotation = 0)));
      ICSolar.Receiver.subClasses.Water_Block_HX water_Block_HX1 annotation(Placement(visible = true, transformation(origin = {-28.4646, 3.4646}, extent = {{-33.4646, -33.4646}, {33.4646, 33.4646}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput Input_heatLossTube_1 annotation(Placement(visible = true, transformation(origin = {22.5, 42.5}, extent = {{-12.5, -12.5}, {12.5, 12.5}}, rotation = 0), iconTransformation(origin = {-200, -10}, extent = {{-20.0, -20.0}, {20.0, 20.0}}, rotation = 0)));
      ICSolar.Receiver.subClasses.Tubing_Losses tubing_Losses1(Tubing(medium = medium, m = 0.0023, T0 = 298.15, V_flowLaminar(displayUnit = "l/min") = 4.1666666666667e-006, dpLaminar(displayUnit = "kPa") = 1000, V_flowNominal(displayUnit = "l/min") = 0.00041666666666667, dpNominal(displayUnit = "kPa") = 100000, h_g = 0.3)) annotation(Placement(visible = true, transformation(origin = {61.4355, -1.4355}, extent = {{-31.4355, -31.4355}, {31.4355, 31.4355}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambientTemperature_2(T = TAmb) annotation(Placement(visible = true, transformation(origin = {190, -16.6949}, extent = {{10.0, -10.0}, {-10.0, 10.0}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput Input_heatLossTube_2 annotation(Placement(visible = true, transformation(origin = {60, 42.5}, extent = {{-12.5, -12.5}, {12.5, 12.5}}, rotation = 0), iconTransformation(origin = {-200, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1 annotation(Placement(visible = true, transformation(origin = {200, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {200, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in annotation(Placement(visible = true, transformation(origin = {-200, 170}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-200, 170}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput Input_waterBlock_1 annotation(Placement(visible = true, transformation(origin = {-200, 97.5}, extent = {{-17.5, -17.5}, {17.5, 17.5}}, rotation = 0), iconTransformation(origin = {-200, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermalGen annotation(Placement(visible = true, transformation(origin = {-200, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-200, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1 annotation(Placement(visible = true, transformation(origin = {-200, 40}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-40, 200}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(tubing_Losses1.flowport_b1, flowport_b1) annotation(Line(points = {{92.871, -1.4355}, {137.358, -1.4355}, {137.358, 58.1132}, {200, 58.1132}, {200, 60}}));
      connect(ThermalGen, water_Block_HX1.energyFrom_CCA) annotation(Line(points = {{-200, -10}, {-119.049, -10}, {-119.049, -9.753500000000001}, {-61.9292, -9.753500000000001}, {-61.9292, -9.921239999999999}}));
      connect(receiverInternalEnergy1.port_b, water_Block_HX1.heatCap_waterBlock) annotation(Line(visible = true, origin = {-79.7717, -20.413}, points = {{-55.228, -13.9659}, {-5.2283, -13.9659}, {-5.2283, -4.587}, {17.8425, -4.587}, {17.8425, -2.89408}}, color = {191, 0, 0}));
      connect(Input_heatLossTube_2, tubing_Losses1.input_Convection_1) annotation(Line(visible = true, origin = {75.3643, 39}, points = {{-15.3643, 3.5}, {4.6357, 3.5}, {4.6357, 1}, {3.04637, 1}, {3.04637, -9}}, color = {0, 0, 127}));
      connect(Input_heatLossTube_1, tubing_Losses1.input_Convection_2) annotation(Line(visible = true, origin = {40.7871, 39}, points = {{-18.2871, 3.5}, {4.2129, 3.5}, {4.2129, 1}, {4.93065, 1}, {4.93065, -9}}, color = {0, 0, 127}));
      connect(water_Block_HX1.flowport_b1, tubing_Losses1.flowport_a1) annotation(Line(visible = true, origin = {21.1339, -0.3516}, points = {{-15.4646, 2.47762}, {-1.1339, 2.47762}, {-1.1339, -1.9357}, {8.866099999999999, -1.9357}, {8.866099999999999, -1.0839}}, color = {255, 0, 0}));
      connect(tubing_Losses1.port_a, ambientTemperature_2.port) annotation(Line(visible = true, origin = {104.881, -25}, points = {{-11.3813, 1.55965}, {5.1188, 1.55965}, {5.1188, 8.305099999999999}, {75.119, 8.305099999999999}}, color = {191, 0, 0}));
      connect(Input_waterBlock_1, water_Block_HX1.Gc_Receiver) annotation(Line(points = {{-200, 97.5}, {-100, 97.5}, {-100, 30.2363}, {-61.9292, 30.2363}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(flowport_a1, water_Block_HX1.flowport_a1) annotation(Line(points = {{-200, 40}, {-130, 40}, {-130, 16.8504}, {-61.9292, 16.8504}}, color = {255, 0, 0}, smooth = Smooth.None));
      connect(TAmb_in, water_Block_HX1.heatLoss_to_ambient) annotation(Line(points = {{-200, 170}, {-140, 170}, {-140, 3.4646}, {-61.9292, 3.4646}}, color = {191, 0, 0}, smooth = Smooth.None));
      annotation(Diagram(coordinateSystem(extent = {{-200, -80}, {200, 200}}, preserveAspectRatio = false, initialScale = 0.1, grid = {10, 10}), graphics = {Text(origin = {12.5, 110}, fillPattern = FillPattern.Solid, extent = {{-42.5, -5}, {42.5, 5}}, textString = "Bring the Ambient Sources and pump Outside the Class ", fontName = "Arial")}), Icon(coordinateSystem(extent = {{-200, -80}, {200, 200}}, preserveAspectRatio = false, initialScale = 0.1, grid = {10, 10}), graphics = {Text(origin = {-176.897, 44.8507}, fillPattern = FillPattern.Solid, extent = {{-21.0405, -8.383100000000001}, {21.0405, 8.383100000000001}}, textString = "Gc_Reveiver", fontName = "Arial"), Text(origin = {-171.755, 4.4444}, fillPattern = FillPattern.Solid, extent = {{-28.2454, -4.4444}, {28.2454, 4.4444}}, textString = "Gc_Water-Tube", fontName = "Arial"), Text(origin = {-173.964, -36.4781}, fillPattern = FillPattern.Solid, extent = {{-26.0359, -3.5219}, {26.0359, 3.5219}}, textString = "Gc_Insulation-Air", fontName = "Arial"), Text(origin = {3.12, 117.49}, extent = {{-133.92, 40.92}, {133.92, -40.92}}, textString = "Heat"), Text(origin = {9.854509999999999, 16.9292}, extent = {{-154.79, 56.03}, {154.79, -56.03}}, textString = "Receiver")}));
    end moduleReceiver;

    package subClasses "Contains the subClasses for receiver"
      extends Modelica.Icons.Package;

      connector Egen_port
        Modelica.SIunits.Power p "Power in Watts at the port" annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(points = {{100, 100}, {-100, 100}, {-100, -100}, {100, -100}, {100, 100}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Text(extent = {{-150, -90}, {150, -150}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid, textString = "%name"), Polygon(points = {{70, 70}, {-70, 70}, {-70, -70}, {70, -70}, {70, 70}}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid)}), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(points = {{100, 100}, {-100, 100}, {-100, -100}, {100, -100}, {100, 100}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{70, 70}, {-70, 70}, {-70, -70}, {70, -70}, {70, 70}}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid)}));
      end Egen_port;

      class receiverInternalEnergy
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation(Placement(visible = true, transformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatcapacitor1(C = 60) "60 J/K is calculated in spreadsheet in 1-DOCS\\calculators ...thermal mass or heat capacity of receiver.xlsx" annotation(Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
      equation
        connect(heatcapacitor1.port, port_b) annotation(Line(points = {{-20, 10}, {-20.023, 10}, {-20.023, 60.5293}, {100, 60.5293}, {100, 60}}));
      end receiverInternalEnergy;

      class CCA_energyBalance
        Modelica.Blocks.Interfaces.RealInput wattsIn_perCell annotation(Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-15, -15}, {15, 15}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput PV_eff annotation(Placement(visible = true, transformation(origin = {-100, -40}, extent = {{-15, -15}, {15, 15}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation(Placement(visible = true, transformation(origin = {100, -40}, extent = {{-15, -15}, {15, 15}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealOutput Power_out annotation(Placement(visible = true, transformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        Power_out = wattsIn_perCell * PV_eff;
        port_b.Q_flow = -wattsIn_perCell * (1 - PV_eff);
      end CCA_energyBalance;

      class Water_Block_HX
        parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium = Modelica.Thermal.FluidHeatFlow.Media.Water() "Water" annotation(choicesAllMatching = true);
        parameter Modelica.SIunits.Temperature TAmb(displayUnit = "degK") = 293.15 "Ambient temperature";
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1(medium = medium) annotation(Placement(visible = true, transformation(origin = {100.0, 40.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0), iconTransformation(origin = {102.0, -4.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput Gc_Receiver annotation(Placement(visible = true, transformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1(medium = medium) annotation(Placement(visible = true, transformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.FluidHeatFlow.Components.HeatedPipe heatedpipe1(h_g = 0, T0 = TAmb, medium = medium, T(start = TAmb), pressureDrop(fixed = false), T0fixed = false, m = 0.003, dpNominal(displayUnit = "kPa") = 62270, V_flowLaminar(displayUnit = "l/min") = 1.6666666666667e-006, dpLaminar(displayUnit = "kPa") = 14690, V_flowNominal(displayUnit = "l/min") = 3.995e-006) annotation(Placement(visible = true, transformation(origin = {-20, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalconductor1(G = 0.037 * 0.0381) annotation(Placement(visible = true, transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.Convection convection1 annotation(Placement(visible = true, transformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a energyFrom_CCA annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalcollector1 annotation(Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCap_waterBlock annotation(Placement(visible = true, transformation(origin = {-100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatLoss_to_ambient annotation(Placement(visible = true, transformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(heatedpipe1.flowPort_b, flowport_b1) annotation(Line(visible = true, points = {{-10.0, 40.0}, {102.579, 40.0}, {102.579, 39.4841}, {100.0, 40.0}}));
        connect(heatLoss_to_ambient, convection1.fluid) annotation(Line(points = {{-100, -40}, {84.4649, -40}, {84.4649, 0}, {70, 0}}));
        connect(heatCap_waterBlock, thermalcollector1.port_b) annotation(Line(points = {{-100, -80}, {-19.7929, -80}, {-19.7929, -10}, {-20, -10}}));
        connect(energyFrom_CCA, thermalcollector1.port_a[1]) annotation(Line(points = {{-100, 0}, {-82.1634, 0}, {-82.1634, 10.817}, {-19.3326, 10.817}, {-19.3326, 10.6667}, {-20, 10.6667}}));
        connect(heatedpipe1.heatPort, thermalcollector1.port_a[2]) annotation(Line(points = {{-20, 30}, {-20.0397, 30}, {-20, -9.920629999999999}, {-20, 10}}));
        connect(thermalcollector1.port_a[3], thermalconductor1.port_a) annotation(Line(points = {{-20, 9.33333}, {-6.74603, 9.33333}, {-6.74603, -0.198413}, {10, -0.198413}, {10, 0}}));
        connect(Gc_Receiver, convection1.Gc) annotation(Line(points = {{-100, 80}, {57.3413, 80}, {57.3413, 10.119}, {60, 10.119}, {60, 10}}));
        connect(flowport_a1, heatedpipe1.flowPort_a) annotation(Line(points = {{-100, 40}, {-30.1587, 40}, {-30, 40}}));
        connect(thermalconductor1.port_b, convection1.solid) annotation(Line(points = {{30, 0}, {50, 0}}));
        annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
      end Water_Block_HX;

      class Tubing_Losses
        parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium = Modelica.Thermal.FluidHeatFlow.Media.Water() "Water" annotation(choicesAllMatching = true);
        Modelica.Thermal.FluidHeatFlow.Components.HeatedPipe Tubing(medium = medium, V_flowLaminar = 1e-006, V_flowNominal = 1e-005, h_g = 0, m = 0.0025, T0 = 293, dpLaminar = 0.45, dpNominal = 10) annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Modelica.Thermal.HeatTransfer.Components.Convection convection1 annotation(Placement(visible = true, transformation(origin = {80.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor Conduction_Insulation(G = 0.037 * 0.0381) annotation(Placement(visible = true, transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor Conduction_Tube(G = 0.145 * 0.0015) annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.Convection convection2 annotation(Placement(visible = true, transformation(origin = {-40, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a(T(start = 293)) annotation(Placement(visible = true, transformation(origin = {100.0, -60.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0), iconTransformation(origin = {102.0, -70.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput input_Convection_2 annotation(Placement(visible = true, transformation(origin = {-60.0, 60.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0), iconTransformation(origin = {-50.0, 100.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput input_Convection_1 annotation(Placement(visible = true, transformation(origin = {60.0, 60.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0), iconTransformation(origin = {54.0, 100.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1(medium = medium) annotation(Placement(visible = true, transformation(origin = {-80, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1(medium = medium) annotation(Placement(visible = true, transformation(origin = {-80.0, -80.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0), iconTransformation(origin = {-100.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
      equation
        connect(input_Convection_1, convection1.Gc) annotation(Line(visible = true, points = {{60.0, 60.0}, {80.3571, 60.0}, {80.3571, 10.3175}, {80.0, 10.0}}));
        connect(input_Convection_2, convection2.Gc) annotation(Line(visible = true, points = {{-60.0, 60.0}, {-39.881, 60.0}, {-39.881, 10.9127}, {-40.0, 10.0}}));
        connect(convection1.fluid, port_a) annotation(Line(visible = true, points = {{90.0, 0.0}, {97.8175, 0.0}, {97.8175, -43.8492}, {87.5, -43.8492}, {87.5, -60.9127}, {98.61109999999999, -60.9127}, {100.0, -60.0}}));
        connect(Conduction_Insulation.port_b, convection1.solid) annotation(Line(visible = true, points = {{50.0, 0.0}, {70.4365, 0.0}, {70.4365, 0.1984}, {70.0, 0.0}}));
        connect(flowport_a1, Tubing.flowPort_a) annotation(Line(visible = true, points = {{-80.0, -80.0}, {-79.9603, -80.0}, {-79.9603, -10.3175}, {-80.0, -10.0}}));
        connect(flowport_b1, Tubing.flowPort_b) annotation(Line(points = {{-80, 80}, {-79.9615, 80}, {-79.9615, 10}, {-80, 10}}));
        connect(Conduction_Tube.port_b, Conduction_Insulation.port_a) annotation(Line(points = {{10, 0}, {30.5556, 0}, {30, 0}}));
        connect(convection2.solid, Conduction_Tube.port_a) annotation(Line(points = {{-30, 0}, {-9.920629999999999, 0}, {-10, 0}}));
        connect(Tubing.heatPort, convection2.fluid) annotation(Line(points = {{-70, -6.12303e-016}, {-70, 0}, {-50, 0}}));
        annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
      end Tubing_Losses;
    end subClasses;
  end Receiver;

  model Parameters
    parameter Real SystemsFlow = 2e-006;
    Real HeatSinkResistivity = 0.0282 * SystemsFlow ^ (-0.773);
    parameter Real NumModules = 3 "Number of Modules being simulated";
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end Parameters;

  model HeatCapacitorPCMLike00 "Lumped thermal element storing heat with temperature-varying capacitance"
    //  extends Modelica.Thermal.HeatTransfer.Components.HeatCapacitor;
    Modelica.SIunits.HeatCapacity C "Heat capacity of element (= cp*m)";
    Modelica.SIunits.Temperature T(start = 293.15 + 40, displayUnit = "degC") "Temperature of element";
    Modelica.SIunits.TemperatureSlope der_T(start = 0) "Time derivative of temperature (= der(T))";
    // Modelica.SIunits.Mass m_h20;
    // Modelica.SIunits.Mass m_PCM;
    //   extends Modelica.Thermal.HeatTransfer.Components.HeatCapacitor;
    import Modelica.Media.Water.ConstantPropertyLiquidWater;
    //  import Modelica.SIunits.Temperature;
    //  import Modelica.SIunits.Mass;
    //  import Modelica.SIUnits.Volume;
    //  import Modelica.SIunits.Area;
    //  import SpecificHeat = Modelica.SIunits.SpecificHeatCapacity;
    type HeatFusion = Real(unit = "kJ/kg", min = 0.01);
    //  Modelica.SIunits.Volume V
    //    "functioning volume of storage element, in water and PCM";
    parameter Real cp_h2o = 4.177 "spec heat cap water";
    parameter Real cp_PCM = 2.9 "spec heat cap paraffin";
    parameter Real rho_h2o = 995 "density water";
    parameter Real rho_PCM = 900 "density PCM";
    parameter Real V_tank = 1 "density PCM";
    parameter Real fracPCM_vol = 0.6 "fraction of volume that is PCM";
    parameter HeatFusion hfg_pcm = 200;
    parameter Modelica.SIunits.Temperature T_sc = 293 + 65 "lowest subcooling temperature";
    parameter Modelica.SIunits.Temperature T_melt = 293 + 65 + 6 "highest melting temperature";
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port annotation(Placement(transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  equation
    T = port.T;
    der_T = der(T);
    C * der(T) = port.Q_flow;
    if T < T_sc then
      C = cp_h2o * V_tank * (1 - fracPCM_vol) * rho_h2o + cp_PCM * V_tank * fracPCM_vol * rho_PCM;
      //  C = (cp_const*(V*(1-fracPCM))*d_const) + (cp_const*(2.9/4.177)*(V*(fracPCM))*(d_const*(900/995)));
      //  C = (Modelica.Thermal.FluidHeatFlow.Media.Water.cp*(V*(1-fracPCM))*Modelica.Thermal.FluidHeatFlow.Media.Water.rho) + (Modelica.Thermal.FluidHeatFlow.Media.Water.cp*(2.9/4.177)*(V*(fracPCM))*(Modelica.Thermal.FluidHeatFlow.Media.Water.rho*(900/995)));
      //constant fractions are used to set the cp and rho values for paraffin relative to water. source: engineering toolbox online.
    elseif T > T_melt then
      C = cp_h2o * V_tank * (1 - fracPCM_vol) * rho_h2o + cp_PCM * V_tank * fracPCM_vol * rho_PCM;
      //  C = (cp_const*(V*(1-fracPCM))*d_const) + (cp_const*(2.9/4.177)*(V*(fracPCM))*(d_const*(900/995)));
      //  C = (Modelica.Thermal.Media.Water.cp*(V*(1-fracPCM))*Modelica.Thermal.FluidHeatFlow.Media.Water.rho) + (Modelica.Thermal.FluidHeatFlow.Media.Water.cp*(2.9/4.177)*(V*(fracPCM))*(Modelica.Thermal.FluidHeatFlow.Media.Water.rho*(900/995)));
      //constant fractions are used to set the cp and rho values for paraffin relative to water. source: engineering toolbox online.
    else
      C = cp_h2o * V_tank * (1 - fracPCM_vol) * rho_h2o + hfg_pcm / (T_melt - T_sc) * V_tank * fracPCM_vol * rho_h2o;
      //  C = (cp_const*(V*(1-fracPCM))*d_const) + (cp_const*(2.9/4.177)*(V*(fracPCM))*(d_const*(900/995)));
      //C = (Modelica.Thermal.FluidHeatFlow.Media.Water.cp*(V*(1-fracPCM))*Modelica.Thermal.FluidHeatFlow.Media.Water.rho) + ((hfg_pcm/(T_melt-T_sc))*V*fracPCM);
    end if;
    //  try = Modelica.Thermal.FluidHeatFlow.Media.Water.rho;
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{-150, 110}, {150, 70}}, textString = "%name", lineColor = {0, 0, 255}), Polygon(points = {{0, 67}, {-20, 63}, {-40, 57}, {-52, 43}, {-58, 35}, {-68, 25}, {-72, 13}, {-76, -1}, {-78, -15}, {-76, -31}, {-76, -43}, {-76, -53}, {-70, -65}, {-64, -73}, {-48, -77}, {-30, -83}, {-18, -83}, {-2, -85}, {8, -89}, {22, -89}, {32, -87}, {42, -81}, {54, -75}, {56, -73}, {66, -61}, {68, -53}, {70, -51}, {72, -35}, {76, -21}, {78, -13}, {78, 3}, {74, 15}, {66, 25}, {54, 33}, {44, 41}, {36, 57}, {26, 65}, {0, 67}}, lineColor = {160, 160, 164}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Polygon(points = {{-58, 35}, {-68, 25}, {-72, 13}, {-76, -1}, {-78, -15}, {-76, -31}, {-76, -43}, {-76, -53}, {-70, -65}, {-64, -73}, {-48, -77}, {-30, -83}, {-18, -83}, {-2, -85}, {8, -89}, {22, -89}, {32, -87}, {42, -81}, {54, -75}, {42, -77}, {40, -77}, {30, -79}, {20, -81}, {18, -81}, {10, -81}, {2, -77}, {-12, -73}, {-22, -73}, {-30, -71}, {-40, -65}, {-50, -55}, {-56, -43}, {-58, -35}, {-58, -25}, {-60, -13}, {-60, -5}, {-60, 7}, {-58, 17}, {-56, 19}, {-52, 27}, {-48, 35}, {-44, 45}, {-40, 57}, {-58, 35}}, lineColor = {0, 0, 0}, fillColor = {160, 160, 164}, fillPattern = FillPattern.Solid), Text(extent = {{-69, 7}, {71, -24}}, lineColor = {0, 0, 0}, textString = "%C")}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(points = {{0, 67}, {-20, 63}, {-40, 57}, {-52, 43}, {-58, 35}, {-68, 25}, {-72, 13}, {-76, -1}, {-78, -15}, {-76, -31}, {-76, -43}, {-76, -53}, {-70, -65}, {-64, -73}, {-48, -77}, {-30, -83}, {-18, -83}, {-2, -85}, {8, -89}, {22, -89}, {32, -87}, {42, -81}, {54, -75}, {56, -73}, {66, -61}, {68, -53}, {70, -51}, {72, -35}, {76, -21}, {78, -13}, {78, 3}, {74, 15}, {66, 25}, {54, 33}, {44, 41}, {36, 57}, {26, 65}, {0, 67}}, lineColor = {160, 160, 164}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Polygon(points = {{-58, 35}, {-68, 25}, {-72, 13}, {-76, -1}, {-78, -15}, {-76, -31}, {-76, -43}, {-76, -53}, {-70, -65}, {-64, -73}, {-48, -77}, {-30, -83}, {-18, -83}, {-2, -85}, {8, -89}, {22, -89}, {32, -87}, {42, -81}, {54, -75}, {42, -77}, {40, -77}, {30, -79}, {20, -81}, {18, -81}, {10, -81}, {2, -77}, {-12, -73}, {-22, -73}, {-30, -71}, {-40, -65}, {-50, -55}, {-56, -43}, {-58, -35}, {-58, -25}, {-60, -13}, {-60, -5}, {-60, 7}, {-58, 17}, {-56, 19}, {-52, 27}, {-48, 35}, {-44, 45}, {-40, 57}, {-58, 35}}, lineColor = {0, 0, 0}, fillColor = {160, 160, 164}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-6, -1}, {6, -12}}, lineColor = {255, 0, 0}, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid), Text(extent = {{11, 13}, {50, -25}}, lineColor = {0, 0, 0}, textString = "T"), Line(points = {{0, -12}, {0, -96}}, color = {255, 0, 0})}), Documentation(info = "<HTML>
<p>
This is copied from:
This is a generic model for the heat capacity of a material.
No specific geometry is assumed beyond a total volume with
uniform temperature for the entire volume.
Furthermore, it is assumed that the heat capacity
is constant (independent of temperature).
</p>
<p>
The temperature T [Kelvin] of this component is a <b>state</b>.
A default of T = 25 degree Celsius (= SIunits.Conversions.from_degC(25))
is used as start value for initialization.
This usually means that at start of integration the temperature of this
component is 25 degrees Celsius. You may, of course, define a different
temperature as start value for initialization. Alternatively, it is possible
to set parameter <b>steadyStateStart</b> to <b>true</b>. In this case
the additional equation '<b>der</b>(T) = 0' is used during
initialization, i.e., the temperature T is computed in such a way that
the component starts in <b>steady state</b>. This is useful in cases,
where one would like to start simulation in a suitable operating
point without being forced to integrate for a long time to arrive
at this point.
</p>
<p>
Note, that parameter <b>steadyStateStart</b> is not available in
the parameter menu of the simulation window, because its value
is utilized during translation to generate quite different
equations depending on its setting. Therefore, the value of this
parameter can only be changed before translating the model.
</p>
<p>
This component may be used for complicated geometries where
the heat capacity C is determined my measurements. If the component
consists mainly of one type of material, the <b>mass m</b> of the
component may be measured or calculated and multiplied with the
<b>specific heat capacity cp</b> of the component material to
compute C:
</p>
<pre>
   C = cp*m.
   Typical values for cp at 20 degC in J/(kg.K):
      aluminium   896
      concrete    840
      copper      383
      iron        452
      silver      235
      steel       420 ... 500 (V2A)
      wood       2500
</pre>
</html>"));
  end HeatCapacitorPCMLike00;

  function EnthalpyDifferential
    input Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a baseline_enthalpy annotation(Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    input Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a generated_enthalpy annotation(Placement(visible = true, transformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    output Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b enthalpy_power annotation(Placement(visible = true, transformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    generated_enthalpy = if generated_enthalpy < 0 then -generated_enthalpy else generated_enthalpy;
    baseline_enthalpy = if baseline_enthalpy < 0 then -baseline_enthalpy else baseline_enthalpy;
    enthalpy_power = generated_enthalpy - baseline_enthalpy;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics));
  end EnthalpyDifferential;

  model ICS_Skeleton_wStorage "This model calculates the electrical and thermal generation of ICSolar. This model is used as a skeleton piece to hold together the other models until it is packages as an FMU."
    parameter Real FLensWidth = 0.25019 "Lens width";
    parameter Real CellWidth = 0.01 "PV Cell width";
    parameter Modelica.SIunits.Pressure PAmb(displayUnit = "PA") = 101325 "Ambient pressure";
    ICSolar.ICS_Context ics_context1 annotation(Placement(visible = true, transformation(origin = {-80, 40}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
    ICSolar.Envelope.ICS_EnvelopeCassette ics_envelopecassette1 annotation(Placement(visible = true, transformation(origin = {0, 40}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
    HeatCapacitorPCMLike00 heatCapacitorPCMLike00_1 annotation(Placement(transformation(extent = {{72, -4}, {92, 16}})));
    Modelica.Thermal.FluidHeatFlow.Components.HeatedPipe heatedPipe(m = 50, T0 = 295.15, T0fixed = true, h_g = -1, V_flowLaminar = 8e-006, dpLaminar = 10000.0, V_flowNominal = 0.0008, dpNominal = 1000000.0, frictionLoss = 1) annotation(Placement(visible = true, transformation(origin = {60, -18}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
    Modelica.Thermal.FluidHeatFlow.Sources.PressureIncrease pressureIncrease(medium = Modelica.Thermal.FluidHeatFlow.Media.Water(), m = 0.1, constantPressureIncrease(displayUnit = "kPa") = 100000) annotation(Placement(transformation(extent = {{-66, -22}, {-46, -2}})));
  equation
    connect(ics_envelopecassette1.flowport_b, heatedPipe.flowPort_a) annotation(Line(points = {{25, 40}, {32, 40}, {60, 40}, {60, -8}}, color = {255, 0, 0}));
    connect(heatCapacitorPCMLike00_1.port, heatedPipe.heatPort) annotation(Line(points = {{82, -4}, {82, -18}, {70, -18}}, color = {191, 0, 0}));
    connect(ics_context1.DNI, ics_envelopecassette1.DNI) annotation(Line(points = {{-55, 25}, {-24.1966, 25}, {-25, 25}}));
    connect(ics_context1.AOI, ics_envelopecassette1.AOI) annotation(Line(points = {{-55, 30}, {-24.9527, 30}, {-25, 30}}));
    connect(ics_context1.SunAzi, ics_envelopecassette1.SunAzi) annotation(Line(points = {{-55, 35}, {-24.9527, 35}, {-25, 35}}));
    connect(ics_context1.SunAlt, ics_envelopecassette1.SunAlt) annotation(Line(points = {{-55, 40}, {-24.5747, 40}, {-25, 40}}));
    connect(ics_context1.SurfOrientation_out, ics_envelopecassette1.SurfaceOrientation) annotation(Line(points = {{-55, 45}, {-25.7089, 45}, {-25, 45}}));
    connect(ics_context1.SurfTilt_out, ics_envelopecassette1.SurfaceTilt) annotation(Line(points = {{-55, 50}, {-25.7089, 50}, {-25, 50}}));
    connect(ics_context1.TDryBul, ics_envelopecassette1.TAmb_in) annotation(Line(points = {{-55, 55}, {-25.3308, 55}, {-25, 55}}));
    connect(ics_envelopecassette1.flowport_a, pressureIncrease.flowPort_b) annotation(Line(points = {{-23.75, 18.75}, {-23.75, -12}, {-46, -12}}, color = {255, 0, 0}, smooth = Smooth.None));
    connect(heatedPipe.flowPort_b, pressureIncrease.flowPort_a) annotation(Line(points = {{60, -28}, {60, -46}, {-92, -46}, {-92, -12}, {-66, -12}}, color = {255, 0, 0}, smooth = Smooth.None));
    annotation(experiment(StartTime = 16588800, StopTime = 16675200, Tolerance = 1e-006, Interval = 9.866390000000001), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
  end ICS_Skeleton_wStorage;

  model ICS_Skeleton_wStorage_woutICS "This model calculates the electrical and thermal generation of ICSolar. This model is used as a skeleton piece to hold together the other models until it is packages as an FMU."
    parameter Real FLensWidth = 0.25019 "Lens width";
    parameter Real CellWidth = 0.01 "PV Cell width";
    parameter Modelica.SIunits.Pressure PAmb(displayUnit = "PA") = 101325 "Ambient pressure";
    Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow Pump(medium = Modelica.Thermal.FluidHeatFlow.Media.Water(), m = 0.1, T0 = 293, useVolumeFlowInput = false, constantVolumeFlow(displayUnit = "m3/s") = 2e-006) "Fluid pump for thermal fluid" annotation(Placement(visible = true, transformation(origin = {-40, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.FluidHeatFlow.Components.HeatedPipe heatedPipe(m = 50, T0fixed = true, V_flowLaminar(displayUnit = "l/min") = 1.6666666666667e-005, V_flowNominal(displayUnit = "l/min") = 0.00016666666666667, frictionLoss = 1, dpLaminar(displayUnit = "kPa") = 100000, dpNominal(displayUnit = "kPa") = 1000000, T0 = 295.15, h_g = 1) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {58, -18})));
    HeatCapacitorPCMLike00 heatCapacitorPCMLike00_1 annotation(Placement(transformation(extent = {{66, 32}, {86, 52}})));
  equation
    connect(heatedPipe.flowPort_b, Pump.flowPort_a) annotation(Line(points = {{58, -8}, {60, -8}, {60, 4}, {-82, 4}, {-82, -20}, {-50, -20}}, color = {255, 0, 0}, smooth = Smooth.None));
    connect(Pump.flowPort_b, heatedPipe.flowPort_a) annotation(Line(points = {{-30, -20}, {-14, -20}, {-14, -54}, {58, -54}, {58, -28}}, color = {255, 0, 0}, smooth = Smooth.None));
    connect(heatedPipe.heatPort, heatCapacitorPCMLike00_1.port) annotation(Line(points = {{68, -18}, {74, -18}, {74, 14}, {76, 14}, {76, 32}}, color = {191, 0, 0}, smooth = Smooth.None));
    annotation(experiment(StartTime = 16588800, StopTime = 16675200, Tolerance = 1e-006, Interval = 9.866390000000001), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
  end ICS_Skeleton_wStorage_woutICS;

  model ICS_Skeleton_MixingVolume "This model calculates the electrical and thermal generation of ICSolar. This model is used as a skeleton piece to hold together the other models until it is packages as an FMU."
    parameter Real FLensWidth = 0.25019 "Lens width";
    parameter Real CellWidth = 0.01 "PV Cell width";
    parameter Modelica.SIunits.Pressure PAmb(displayUnit = "PA") = 101325 "Ambient pressure";
    Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow Pump(constantVolumeFlow = 2e-006, m = 0, medium = Modelica.Thermal.FluidHeatFlow.Media.Water(), T0 = 293) "Fluid pump for thermal fluid" annotation(Placement(visible = true, transformation(origin = {-40, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ICSolar.ICS_Context ics_context1 annotation(Placement(visible = true, transformation(origin = {-80, 40}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
    ICSolar.Envelope.ICS_EnvelopeCassette ics_envelopecassette1 annotation(Placement(visible = true, transformation(origin = {0, 40}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
    Buildings.Fluid.MixingVolumes.MixingVolume vol annotation(Placement(visible = true, transformation(origin = {60, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(vol.heatPort, Pump.flowPort_a) annotation(Line(points = {{50, -20}, {22.5519, -20}, {22.5519, -46.8843}, {-50.1484, -46.8843}, {-50.1484, -20.178}, {-50.1484, -20.178}}));
    connect(ics_envelopecassette1.flowport_b, vol.heatPort) annotation(Line(points = {{25, 40}, {38.8724, 40}, {38.8724, -20.178}, {50.7418, -20.178}, {50.7418, -20.178}}));
    connect(Pump.flowPort_b, ics_envelopecassette1.flowport_a) annotation(Line(points = {{-30, -20}, {-28.3554, -20}, {-28.3554, 19.6597}, {-23.75, 19.6597}, {-23.75, 18.75}}));
    connect(ics_context1.DNI, ics_envelopecassette1.DNI) annotation(Line(points = {{-55, 25}, {-24.1966, 25}, {-25, 25}}));
    connect(ics_context1.AOI, ics_envelopecassette1.AOI) annotation(Line(points = {{-55, 30}, {-24.9527, 30}, {-25, 30}}));
    connect(ics_context1.SunAzi, ics_envelopecassette1.SunAzi) annotation(Line(points = {{-55, 35}, {-24.9527, 35}, {-25, 35}}));
    connect(ics_context1.SunAlt, ics_envelopecassette1.SunAlt) annotation(Line(points = {{-55, 40}, {-24.5747, 40}, {-25, 40}}));
    connect(ics_context1.SurfOrientation_out, ics_envelopecassette1.SurfaceOrientation) annotation(Line(points = {{-55, 45}, {-25.7089, 45}, {-25, 45}}));
    connect(ics_context1.SurfTilt_out, ics_envelopecassette1.SurfaceTilt) annotation(Line(points = {{-55, 50}, {-25.7089, 50}, {-25, 50}}));
    connect(ics_context1.TDryBul, ics_envelopecassette1.TAmb_in) annotation(Line(points = {{-55, 55}, {-25.3308, 55}, {-25, 55}}));
    annotation(experiment(StartTime = 16588800, StopTime = 16675200, Tolerance = 1e-006, Interval = 9.866390000000001));
  end ICS_Skeleton_MixingVolume;
  annotation(uses(Modelica(version = "3.2.1"), Buildings(version = "1.6")));
end ICSolar;