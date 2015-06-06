package ICSolar "Integrated Concentrating Solar simulation, packaged for hierarchy construction"
  extends Modelica.Icons.Package;
  model ICS_Skeleton "This model calculates the electrical and thermal generation of ICSolar. This model is used as a skeleton piece to hold together the other models until it is packages as an FMU."
    extends ICSolar.Parameters;
    //extends ICSolar.measured_data;
    /////////////////////
    /// Measured Data ///
    /////////////////////
    // DNI, T inlet, vFlow...and then aaaalll the T ins and outs. Total situational awareness. good for tuning both
    //module behavior and whole-array behavior
    Modelica.Blocks.Sources.CombiTimeTable IC_Data_all(tableOnFile = true, fileName = Path + Date + "measuredData.txt", tableName = "DNI_THTFin_vdot", nout = 22, columns = {2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23}) annotation(Placement(visible = true, transformation(origin = {-80,0}, extent = {{-15,-15},{15,15}}, rotation = 0)));
    Real measured_DNI = IC_Data_all.y[1];
    Real measured_T_HTFin = IC_Data_all.y[2];
    Real measured_vFlow = IC_Data_all.y[3];
    Real measured_Egen = IC_Data_all.y[4];
    Real measured_T_HTFout = IC_Data_all.y[5];
    Real measured_T_cavAvg = IC_Data_all.y[6];
    Real measured_T_s3m6in = IC_Data_all.y[7];
    Real measured_T_s3m6out = IC_Data_all.y[8];
    Real measured_T_s3m5in = IC_Data_all.y[9];
    Real measured_T_s3m5out = IC_Data_all.y[10];
    Real measured_T_s3m4in = IC_Data_all.y[11];
    Real measured_T_s3m4out = IC_Data_all.y[12];
    Real measured_T_s3m3in = IC_Data_all.y[13];
    Real measured_T_s3m3out = IC_Data_all.y[14];
    Real measured_T_s3m2in = IC_Data_all.y[15];
    Real measured_T_s3m2out = IC_Data_all.y[16];
    Real measured_T_s3m1in = IC_Data_all.y[17];
    Real measured_T_s3m1out = IC_Data_all.y[18];
    Real measured_T_s2m6in = IC_Data_all.y[19];
    Real measured_T_s2m1out = IC_Data_all.y[20];
    Real measured_T_s2CPVa_s3m3 = IC_Data_all.y[21];
    Real measured_T_s2CPVb_s3m2 = IC_Data_all.y[22];
    //Real measured_yaw = IC_Data_all.y[23];
    //Real measured_pitch = IC_Data_all.y[24];
    // Processed Data
    Real measured_T_drop_jumper = measured_T_s2m6in - measured_T_s3m1out;
    Real measured_Qgen = measured_vFlow * mediumHTF.rho * mediumHTF.cp * (measured_T_HTFout - measured_T_HTFin);
    // Uncertainity Qualification
    Real UQ_measured_Egen_upper = measured_Egen + 0.73;
    Real UQ_measured_Egen_lower = measured_Egen - 0.73;
    Real UQ_measured_T_HTFout_upper = measured_T_HTFout + 0.5;
    Real UQ_measured_T_HTFout_lower = measured_T_HTFout - 0.5;
    // Ambient / Cavity Temp
    Modelica.Blocks.Sources.CombiTimeTable T_cav_in(tableOnFile = true, fileName = Path + Date + "T_Cav_data.txt", tableName = "T_Cav");
    Real measured_T_amb = measured_T_cavAvg;
    //  Real measured_T_amb = T_cav_in.y[1];
    /////////////////////////////
    ///  Energy / Exergy Var. ///
    /////////////////////////////
    //work in the measured flow rate vector here
    Real temp_flowport_a = ics_envelopecassette1.flowport_a.H_flow / (measured_vFlow * mediumHTF.rho * mediumHTF.cp);
    Real temp_flowport_b = abs(ics_envelopecassette1.ics_stack2.ICS_Module_Twelve_1[1].modulereceiver1.water_Block_HX1.flowport_b1.H_flow / (measured_vFlow * mediumHTF.rho * mediumHTF.cp));
    //
    //calculating power output and efficiencies...
    Real Qgen_mods = ics_envelopecassette1.ics_stack1.ICS_Module_Twelve_1[2].Qgen_mod + ics_envelopecassette1.ics_stack1.ICS_Module_Twelve_1[3].Qgen_mod + ics_envelopecassette1.ics_stack1.ICS_Module_Twelve_1[6].Qgen_mod + ics_envelopecassette1.ics_stack2.ICS_Module_Twelve_1[2].Qgen_mod + ics_envelopecassette1.ics_stack2.ICS_Module_Twelve_1[3].Qgen_mod + ics_envelopecassette1.ics_stack2.ICS_Module_Twelve_1[6].Qgen_mod;
    Real Qgen_arrayTotal = abs(ics_envelopecassette1.ics_stack2.ICS_Module_Twelve_1[1].modulereceiver1.water_Block_HX1.flowport_b1.H_flow) - ics_envelopecassette1.flowport_a.H_flow;
    Real Egen_arrayTotal = ics_envelopecassette1.Power_Electric;
    // Area of modules is assumed to be 0.3^2
    Real eta_Q = Qgen_mods * Trans_glazinglosses_eta / (measured_DNI * cos(ics_envelopecassette1.AOI) * GlassArea_perMod * 6);
    Real eta_E = ics_envelopecassette1.Power_Electric * Trans_glazinglosses_eta / (measured_DNI * cos(ics_envelopecassette1.AOI) * GlassArea_perMod * 6);
    Real eta_combined = eta_Q + eta_E;
    // m_dot*cp*(1 - Tamb/T2)
    Real Ex_carnot_arrayTotal = Qgen_arrayTotal * (1 - TAmb / temp_flowport_b);
    // m_dot*cp*(T2 - T1 - Tamb*ln(T2/T1))
    // note "log" in OMedit is the natural log.  "log10" is log base 10 in OM
    Real Ex_arrayTotal = ics_envelopecassette1.flowport_a.m_flow * mediumHTF.cp * (temp_flowport_b - temp_flowport_a - TAmb * log(temp_flowport_b / temp_flowport_a)) + ics_envelopecassette1.Power_Electric;
    //epsilon = the Exergenic efficiency (~93% for sunlight)
    Real Ex_epsilon_solar = 0.93 "exergic efficiency of sunlight";
    Real Ex_epsilon = Ex_arrayTotal / (measured_DNI * GlassArea * cos(ics_envelopecassette1.AOI) * Ex_epsilon_solar);
    ////////////////////////
    /// Init. Components ///
    ////////////////////////
    // IC Comp.
    ICSolar.ICS_Context ics_context1(SurfOrientation = 40 * 2 * Modelica.Constants.pi / 360) annotation(Placement(visible = true, transformation(origin = {-180,40}, extent = {{-25,-25},{25,25}}, rotation = 0)));
    ICSolar.Envelope.ICS_EnvelopeCassette_Twelve ics_envelopecassette1 annotation(Placement(visible = true, transformation(origin = {20,40}, extent = {{-25,-25},{25,25}}, rotation = 0)));
    // Fluid Comp.
    Modelica.Thermal.FluidHeatFlow.Sources.Ambient Source(medium = mediumHTF, useTemperatureInput = true, constantAmbientPressure = 101325, constantAmbientTemperature = T_HTF_start) "Thermal fluid source" annotation(Placement(visible = true, transformation(origin = {-60,-40}, extent = {{-10,-10},{10,10}}, rotation = 180)));
    Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow Pump(constantVolumeFlow = OneBranchFlow, m = 0.01, medium = mediumHTF, T0 = T_HTF_start, T0fixed = true, useVolumeFlowInput = true) "Fluid pump for thermal fluid" annotation(Placement(visible = true, transformation(origin = {-20,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Thermal.FluidHeatFlow.Sources.Ambient Sink(medium = mediumHTF, constantAmbientPressure = 101325, constantAmbientTemperature = T_HTF_start) "Thermal fluid sink, will be replaced with a tank later" annotation(Placement(visible = true, transformation(origin = {80,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  equation
    //set the HTF temperature according to measured data
    connect(measured_T_HTFin,Source.ambientTemperature) annotation(Line(points = {{-123.5,-60},{-87.87690000000001,-60},{-87.87690000000001,-32.9846},{-70.1538,-32.9846},{-70.1538,-32.9846}}, color = {0,0,127}));
    //set flow rate according to measured data
    connect(measured_vFlow,Pump.volumeFlow) annotation(Line(points = {{-63.5,0},{-20.1846,0},{-20.1846,-29.5385},{-20.1846,-29.5385}}, color = {0,0,127}));
    connect(Source.flowPort,Pump.flowPort_a) annotation(Line(points = {{-50,-40},{-37.8122,-39.5049},{-30,-40}}));
    connect(Pump.flowPort_b,ics_envelopecassette1.flowport_a) annotation(Line(points = {{-10,-40},{-8.167590000000001,-39.5049},{-4.3554,17.6597},{6.25,18.75},{-3.75,18.75}}));
    //connect outlet of cassette
    connect(ics_envelopecassette1.flowport_b,Sink.flowPort) annotation(Line(points = {{45,40},{60.0812,40},{60.0812,-20.2977},{70,-20.2977},{70,-20}}, color = {255,0,0}));
    //connect weatherdata variables
    connect(ics_context1.AOI,ics_envelopecassette1.AOI) annotation(Line(points = {{-155,30},{-5,30}}));
    connect(ics_context1.SunAzi,ics_envelopecassette1.SunAzi) annotation(Line(points = {{-155,35},{-5,35}}));
    connect(ics_context1.SunAlt,ics_envelopecassette1.SunAlt) annotation(Line(points = {{-155,40},{-5,40}}));
    connect(ics_context1.SurfOrientation_out,ics_envelopecassette1.SurfaceOrientation) annotation(Line(points = {{-155,45},{-5,45}}));
    connect(ics_context1.SurfTilt_out,ics_envelopecassette1.SurfaceTilt) annotation(Line(points = {{-155,50},{-5,50}}));
    connect(ics_context1.TDryBul,ics_envelopecassette1.TAmb_in) annotation(Line(points = {{-155,55},{-5,55}}));
    connect(ics_context1.DNI,ics_envelopecassette1.DNI) annotation(Line(points = {{-155,25},{-5,25}}, color = {0,0,127}));
    //connect measured data for DNI and cavity temperature to cassette (kept as Reals)
    connect(measured_DNI,ics_envelopecassette1.DNI_measured);
    connect(measured_T_cavAvg,ics_envelopecassette1.Tcav_measured);
    //experiment(StartTime = 7036600, StopTime = 7061100, Tolerance = 1e-006, Interval = 60));
    //  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-200,-100},{200,100}}), graphics), experiment(StartTime = 4365153, StopTime = 4376623, Tolerance = 1e-006, Interval = 60));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-200,-100},{200,100}}), graphics), experiment(StartTime = 7047000, StopTime = 7050593, Tolerance = 1e-006, Interval = 10));
  end ICS_Skeleton;
  model ICS_Context "This model provides the pieces necessary to set up the context to run the simulation, in FMU practice this will be cut out and provided from the EnergyPlus file"
    extends ICSolar.Parameters;
    parameter Real Lat = BuildingLatitude "Latitude";
    parameter Real SurfOrientation = BuildingOrientation "Surface orientation: Change 'S' to 'W','E', or 'N' for other orientations";
    parameter Real SurfTilt = ArrayTilt "Tilt of the ICSolar array";
    Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam = "modelica://ICSolar/weatherdata/USA_NY_New.York-Central.Park.725033_TMY3.mos", pAtmSou = Buildings.BoundaryConditions.Types.DataSource.Parameter, TDryBul(displayUnit = "K"), TDewPoi(displayUnit = "K"), totSkyCovSou = Buildings.BoundaryConditions.Types.DataSource.Parameter, opaSkyCovSou = Buildings.BoundaryConditions.Types.DataSource.Parameter, totSkyCov = 0.01, opaSkyCov = 0.01) "Weather data reader for New York Central Park" annotation(Placement(visible = true, transformation(origin = {-40,20}, extent = {{-20,-20},{20,20}}, rotation = 0)));
    Buildings.BoundaryConditions.SolarGeometry.BaseClasses.Declination decAng "Solar declination (seasonal offset)" annotation(Placement(visible = true, transformation(origin = {-40,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Buildings.BoundaryConditions.SolarGeometry.BaseClasses.SolarHourAngle solHouAng "Solar hour angle" annotation(Placement(visible = true, transformation(origin = {-40,-80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Buildings.BoundaryConditions.WeatherData.Bus weatherBus "Connector to put variables from the weather file" annotation(Placement(visible = true, transformation(origin = {20,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {20,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Buildings.HeatTransfer.Sources.PrescribedTemperature TOutside "Outside temperature" annotation(Placement(visible = true, transformation(origin = {60,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput SurfOrientation_out "Surface Orientation" annotation(Placement(visible = true, transformation(origin = {100,80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput SurfTilt_out "Surface tilt" annotation(Placement(visible = true, transformation(origin = {100,60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput SunAlt "Solar altitude" annotation(Placement(visible = true, transformation(origin = {100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput SunAzi "Solar azimuth" annotation(Placement(visible = true, transformation(origin = {100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput AOI "Angle of incidence" annotation(Placement(visible = true, transformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput DNI "Direct normal irradiance" annotation(Placement(visible = true, transformation(origin = {100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    // Modelica.Blocks.Sources.CombiTimeTable ICSg8_Egen_data_11252013(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, 0; 28561626.199, 0.0; 28561636.32, 0.0; 28561646.261, 0.0; 28561656.197, 0.0; 28561666.207, 0.0; 28561676.262, 0.0; 28561686.195, 0.0; 28561696.208, 0.0; 28561706.385, 0.0; 28561716.208, 0.0; 28561726.209, 0.0; 28561736.192, 0.0; 28561777.538, 0.0; 28561786.19, 0.0; 28561796.189, 0.0; 28561806.321, 0.0; 28561816.188, 0.0; 28561826.203, 0.0; 28561836.187, 0.0; 28561846.186, 0.0; 28561856.345, 0.0; 28561866.185, 0.0; 28561876.184, 0.0; 28561886.184, 0.0; 28561896.183, 0.0; 28561906.25, 0.0; 28561916.182, 0.0; 28561926.182, 0.0; 28561936.37, 0.0; 28561946.18, 0.0; 28561956.18, 0.0; 28561966.179, 0.0; 28561976.2, 0.0; 28561986.178, 0.0; 28561996.203, 0.0; 28562006.177, 0.0; 28562016.176, 0.0; 28562026.199, 0.0; 28562036.175, 0.0; 28562046.175, 0.0; 28562056.2, 0.0; 28562066.174, 0.0; 28562076.173, 0.0; 28562086.199, 24.8; 28562096.252, 25.8; 28562106.433, 25.3; 28562116.171, 25.1; 28562126.17, 25.4; 28562136.17, 25.9; 28562146.201, 26.1; 28562156.168, 26.0; 28562166.168, 25.8; 28562176.197, 25.9; 28562186.167, 25.9; 28562196.195, 25.9; 28562206.166, 25.8; 28562216.197, 25.9; 28562226.164, 26.0; 28562236.164, 26.0; 28562246.163, 26.1; 28562256.203, 26.0; 28562266.162, 26.1; 28562276.532, 26.1; 28562286.321, 26.1; 28562296.197, 26.1; 28562306.16, 26.0; 28562316.159, 26.0; 28562326.159, 25.9; 28562336.158, 26.1; 28562346.194, 26.0; 28562356.618, 26.0; 28562366.585, 25.9; 28562492.064, 25.9; 28562496.149, 8.800000000000001; 28562506.148, 25.7; 28562516.188, 25.9; 28562526.187, 25.8; 28562536.147, 25.7; 28562546.146, 25.6; 28562556.146, 25.7; 28562566.539, 25.7; 28562576.144, 25.7; 28562586.144, 25.6; 28562596.143, 25.5; 28562606.143, 25.6; 28562616.142, 25.5; 28562626.142, 25.5; 28562636.184, 25.5; 28562646.14, 25.6; 28562656.14, 25.5; 28562666.139, 25.6; 28562676.139, 25.5; 28562686.138, 25.4; 28562696.138, 25.4; 28562706.137, 25.3; 28562716.136, 25.4; 28562726.136, 25.3; 28562736.184, 25.4; 28562746.135, 25.4; 28562756.134, 25.3; 28562766.134, 25.4; 28562776.133, 23.9; 28562786.132, 23.1; 28562796.181, 25.0; 28562806.131, 25.2; 28562816.183, 25.2; 28562826.13, 25.2; 28562836.183, 25.2; 28562846.129, 25.2; 28562856.128, 25.2; 28562866.182, 25.2; 28562876.127, 25.1; 28562886.127, 25.2; 28562896.178, 25.2; 28562906.192, 25.2; 28562916.125, 25.2; 28562926.124, 25.2; 28562936.124, 25.2; 28562946.123, 25.1; 28562956.854, 25.2; 28562966.122, 25.1; 28562976.122, 25.2; 28562986.121, 25.1; 28562996.12, 25.1; 28563006.12, 25.1; 28563016.119, 25.1; 28563026.119, 25.1; 28563036.118, 25.2; 28563046.183, 25.0; 28563056.117, 25.0; 28563066.116, 24.9; 28563076.116, 24.9; 28563086.223, 24.9; 28563096.115, 24.9; 28563106.177, 24.9; 28563116.114, 24.8; 28563126.113, 24.9; 28563136.763, 24.9; 28563146.112, 24.9; 28563156.174, 24.7; 28563166.111, 24.8; 28563176.11, 24.8; 28563186.11, 24.7; 28563196.109, 24.7; 28563206.108, 24.7; 28563216.875, 24.7; 28563226.107, 24.6; 28563236.171, 24.6; 28563246.106, 24.7; 28563256.106, 24.7; 28563266.105, 24.6; 28563276.104, 24.6; 28563286.104, 24.6; 28563296.103, 24.6; 28563306.103, 24.6; 28563316.102, 24.5; 28563326.178, 24.5; 28563336.17, 24.4; 28563346.1, 24.6; 28563356.17, 24.6; 28563366.167, 24.5; 28563376.099, 24.5; 28563386.168, 24.2; 28563396.098, 24.2; 28563406.097, 24.4; 28563416.168, 24.3; 28563426.096, 24.5; 28563437.118, 24.3; 28563446.095, 24.3; 28563456.166, 24.4; 28563466.094, 24.4; 28563476.093, 24.3; 28563486.168, 24.3; 28563496.092, 24.3; 28563506.233, 24.4; 28563516.091, 24.2; 28563526.09, 24.1; 28563536.174, 24.1; 28563546.167, 24.1; 28563556.088, 24.1; 28563566.088, 24.1; 28563576.167, 24.1; 28563586.087, 24.1; 28563596.086, 24.1; 28563606.085, 23.9; 28563616.085, 24.0; 28563626.084, 24.0; 28563636.168, 24.0; 28563646.083, 23.9; 28563656.083, 23.9; 28563666.161, 23.9; 28563676.081, 23.9; 28563686.081, 23.9; 28563696.08, 23.8; 28563706.08, 23.8; 28563716.079, 23.9; 28563726.079, 23.8; 28563736.078, 23.8; 28563746.077, 23.8; 28563756.077, 23.8; 28563766.076, 23.8; 28563776.076, 23.8; 28563786.075, 23.8; 28563796.075, 23.8; 28563806.074, 23.7; 28563816.073, 23.7; 28563826.073, 23.7; 28563836.072, 23.7; 28563846.072, 23.6; 28563856.071, 23.7; 28563866.162, 23.7; 28563876.159, 23.6; 28563886.069, 23.6; 28563896.069, 23.6; 28563906.068, 23.5; 28563916.068, 23.6; 28563926.159, 23.5; 28563936.067, 23.6; 28563946.066, 23.5; 28563956.065, 23.5; 28563966.065, 23.5; 28563976.064, 23.6; 28563986.064, 23.5; 28563996.163, 23.4; 28564006.063, 23.5; 28564016.062, 23.5; 28564026.063, 23.4; 28564036.155, 23.4; 28564046.06, 0.0; 28564056.06, 23.5; 28564066.155, 23.4; 28564076.059, 23.3; 28564086.058, 23.3; 28564096.154, 23.3; 28564106.158, 23.4; 28564116.056, 23.3; 28564126.056, 23.3; 28564136.055, 23.2; 28564146.055, 23.2; 28564156.054, 23.3; 28564166.053, 23.3; 28564176.053, 23.3; 28564186.052, 23.2; 28564196.052, 23.2; 28564206.051, 23.2; 28564216.051, 23.1; 28564226.05, 23.1; 28564236.157, 23.1; 28564246.049, 23.0; 28564256.048, 23.0; 28564266.048, 23.0; 28564276.047, 23.0; 28564286.047, 23.1; 28564296.046, 23.0; 28564306.156, 23.0; 28564316.148, 22.8; 28564326.044, 22.9; 28564336.155, 22.8; 28564346.043, 22.8; 28564356.043, 22.4; 28564366.042, 22.8; 28564376.041, 22.8; 28564386.041, 22.8; 28564396.15, 22.8; 28564406.153, 22.7; 28564416.039, 22.6; 28564426.039, 22.6; 28564436.038, 22.6; 28564446.037, 22.7; 28564456.037, 22.6; 28564466.036, 22.6; 28564476.935, 22.4; 28564487.708, 22.4; 28564496.035, 22.4; 28564506.034, 22.3; 28564516.033, 22.3; 28564526.033, 22.1; 28564536.035, 22.1; 28564546.155, 22.4; 28564556.044, 22.4; 28564566.049, 22.3; 28564576.053, 22.3; 28564586.057, 22.1; 28564596.062, 22.0; 28564606.066, 22.1; 28564616.071, 22.0; 28564626.075, 22.0; 28564636.08, 22.1; 28564646.084, 22.1; 28564656.088, 22.1; 28564666.277, 22.1; 28564676.097, 21.9; 28564686.102, 22.1; 28564696.106, 22.0; 28564706.111, 22.0; 28564716.115, 22.3; 28564726.119, 22.0; 28564737.719, 22.1; 28564746.128, 22.1; 28564756.133, 22.0; 28564766.293, 22.1; 28564776.142, 22.0; 28564786.146, 21.9; 28564796.15, 21.9; 28564806.155, 21.9; 28564816.159, 21.8; 28564826.164, 21.9; 28564836.166, 21.7; 28564846.168, 21.6; 28564856.295, 21.5; 28564866.17, 21.4; 28564876.299, 21.3; 28564886.173, 21.4; 28564896.306, 21.4; 28564906.307, 21.3; 28564916.306, 21.4; 28564926.309, 21.3; 28564936.18, 21.4; 28564946.182, 21.2; 28564956.183, 21.3; 28564966.185, 21.2; 28564976.186, 21.0; 28564986.188, 21.0; 28564996.189, 20.8; 28565006.19, 20.9; 28565016.323, 20.9; 28565026.193, 20.8; 28565036.195, 20.7; 28565046.334, 20.5; 28565056.198, 20.4; 28565066.199, 20.3; 28565076.339, 20.1; 28565088.297, 20.0; 28565096.203, 19.8; 28565106.205, 19.4; 28565116.206, 19.3; 28565126.208, 19.0; 28565136.209, 18.5; 28565146.209, 18.3; 28565156.349, 18.1; 28565168.487, 18.0; 28565176.352, 17.9; 28565186.211, 18.0; 28565196.212, 18.0; 28565206.356, 18.0; 28565216.349, 17.9; 28565226.213, 18.0; 28565236.363, 17.9; 28565247.61, 18.1; 28565256.36, 18.1; 28565266.36, 18.1; 28565276.215, 18.2; 28565288.329, 18.4; 28565296.363, 18.4; 28565306.361, 18.7; 28565316.217, 18.7; 28565326.365, 18.8; 28565336.218, 19.2; 28565346.218, 19.3; 28565356.218, 19.5; 28565366.219, 19.4; 28565376.219, 19.3; 28565386.366, 19.3; 28565397.935, 19.2; 28565406.221, 19.3; 28565416.221, 19.5; 28565426.379, 19.7; 28565436.374, 19.1; 28565446.222, 19.1; 28565456.371, 19.0; 28565466.373, 18.3; 28565478.263, 17.9; 28565488.418, 17.8; 28565496.378, 18.1; 28565506.225, 18.6; 28565516.225, 18.5; 28565526.382, 18.5; 28565536.226, 18.5; 28565546.227, 18.2; 28565556.227, 17.8; 28565566.227, 17.1; 28565576.228, 16.0; 28565586.228, 15.1; 28565596.229, 14.5; 28565606.384, 14.2; 28565616.23, 13.3; 28565626.23, 13.4; 28565637.968, 13.7; 28565646.231, 13.7; 28565656.385, 14.3; 28565666.232, 15.4; 28565676.232, 16.4; 28565686.233, 16.6; 28565696.233, 16.1; 28565706.393, 15.1; 28565718.766, 14.4; 28565726.392, 13.5; 28565736.235, 13.0; 28565746.235, 13.8; 28565756.399, 15.1; 28565766.408, 15.8; 28565776.236, 15.6; 28565786.402, 14.6; 28565796.412, 13.5; 28565806.403, 12.9; 28565817.933, 12.3; 28565826.595, 11.6; 28565836.239, 11.7; 28565848.516, 11.9; 28565856.24, 12.0; 28565866.24, 12.1; 28565876.241, 12.6; 28565886.241, 13.2; 28565898.65, 12.2; 28565906.242, 12.0; 28565916.242, 10.7; 28565926.243, 9.1; 28565936.243, 7.6; 28565946.244, 6.1; 28565956.244, 4.7; 28565966.413, 3.4; 28565976.245, 2.3; 28565986.413, 1.5; 28565996.246, 1.0; 28566006.246, 0.6; 28566016.247, 0.4; 28566026.42, 0.3; 28566036.248, 0.2; 28566046.425, 0.2; 28566056.248, 0.1; 28566066.249, 0.1; 28566076.249, 0.0; 28566086.25, 0.0; 28566096.25, 0.0; 28566106.428, 0.0; 28566116.251, 0.0; 28566126.251, 0.0; 28566136.455, 0.0; 28566148.668, 0.0; 28566156.253, 0.0; 28566166.441, 0.0; 28566176.429, 0.0; 28566186.435, 0.0; 28566196.429, 0.0; 28566206.435, 0.0; 28566216.255, 0.0; 28566229.023, 0.0; 28566236.256, 0.0; 28566246.434, 0.0; 28566259.013, 0.0; 28566266.257, 0.0; 28566276.442, 0.0; 28566286.258, 0.0; 28566296.259, 0.0; 28566306.452, 0.0; 28566316.259, 0.0; 28566326.444, 0.0; 28566336.442, 0.0; 28566346.261, 0.0; 28566356.447, 0.0; 28566366.45, 0.0; 28566376.262, 0.0; 28566386.262, 0.0; 28566396.263, 0.0; 28566406.446, 0.0; 28566416.453, 0.0; 28566426.264, 0.0; 28566436.454, 0.0; 28566446.458, 0.0; 28566456.265, 0.0; 28566468.931, 0.0; 28566476.266, 0.0; 28566487.038, 0.0; 28566496.267, 0.0; 28566506.268, 0.0; 28566516.268, 0.0; 28566526.268, 0.0; 28566536.269, 0.0; 28566546.269, 0.0; 28566556.27, 0.0; 28566566.459, 0.0; 28566576.463, 0.0; 28566586.47, 0.0; 28566596.271, 0.0; 28566606.272, 0.0; 28566616.272, 0.0; 28566626.273, 0.0; 28566636.465, 0.0; 28566636.466, 0; 3.15569e8, 0]) annotation(Placement(visible = true, transformation(origin = {-22, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    // Modelica.Blocks.Interfaces.RealOutput ICSg8_Egen_data_11252013_conn "egen data from icsg8" annotation(Placement(visible = true, transformation(origin = {100, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    // Modelica.Blocks.Sources.CombiTimeTable ICSg8_Qgen_data_11252013(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, 0; 28561622.622, 2.9; 28561633.075, 3.9; 28561643.572, 23.4; 28561654.096, 47.8; 28561662.587, 60.1; 28561673.035, 65.3; 28561683.502, 73.40000000000001; 28561694.002, 73.3; 28561702.412, 73.5; 28561712.86, 76.09999999999999; 28561723.285, 77.3; 28561733.811, 77.8; 28561737.976, 77.90000000000001; 28561783.794, 89.7; 28561792.155, 91.7; 28561802.608, 92.5; 28561813.105, 93.8; 28561823.635, 95.09999999999999; 28561834.054, 96.3; 28561842.426, 98.3; 28561852.85, 100.5; 28561863.288, 102.2; 28561873.733, 103.7; 28561882.099, 103.7; 28561892.454, 102.8; 28561902.92, 103.1; 28561913.333, 102.6; 28561921.998, 101.2; 28561932.579, 98.90000000000001; 28561943.041, 97.59999999999999; 28561953.463, 90.59999999999999; 28561963.962, 85.40000000000001; 28561972.308, 88.09999999999999; 28561982.794, 89.2; 28561993.402, 92.09999999999999; 28562003.928, 95.7; 28562012.445, 100.0; 28562022.883, 105.6; 28562033.444, 109.2; 28562043.927, 111.3; 28562052.284, 112.3; 28562062.735, 113.1; 28562073.187, 113.5; 28562083.685, 112.8; 28562092.066, 102.8; 28562102.501, 91.90000000000001; 28562112.984, 86.40000000000001; 28562123.493, 83.40000000000001; 28562133.961, 82.7; 28562142.322, 82.7; 28562152.822, 82.8; 28562163.292, 82.5; 28562173.724, 81.7; 28562182.086, 78.0; 28562192.571, 69.5; 28562203.082, 61.2; 28562213.503, 58.6; 28562223.999, 57.9; 28562232.377, 57.6; 28562242.847, 57.5; 28562253.325, 57.3; 28562263.829, 57.4; 28562272.299, 57.5; 28562282.749, 39.9; 28562293.202, 40.9; 28562303.696, 40.9; 28562312.089, 40.0; 28562322.604, 38.8; 28562333.041, 38.5; 28562343.478, 38.4; 28562353.946, 38.2; 28562362.337, 38.2; 28562366.594, 38.3; 28562492.064, 38.7; 28562502.449, 42.9; 28562512.917, 41.6; 28562523.385, 40.2; 28562533.96, 39.9; 28562542.353, 39.9; 28562552.819, 40.0; 28562563.392, 40.0; 28562573.845, 40.0; 28562582.206, 40.0; 28562592.624, 39.9; 28562603.06, 40.0; 28562613.495, 39.9; 28562623.874, 40.0; 28562632.283, 39.9; 28562642.778, 39.8; 28562653.165, 39.8; 28562663.577, 39.9; 28562671.978, 39.8; 28562682.433, 39.7; 28562692.928, 39.6; 28562703.414, 39.4; 28562711.914, 39.4; 28562722.443, 39.3; 28562732.97, 39.2; 28562743.452, 39.3; 28562753.876, 39.2; 28562762.255, 39.4; 28562772.69, 39.0; 28562783.169, 37.2; 28562793.625, 36.5; 28562801.981, 37.6; 28562812.463, 38.6; 28562822.904, 38.7; 28562833.386, 38.8; 28562843.989, 38.9; 28562852.351, 38.7; 28562862.806, 38.5; 28562873.306, 38.3; 28562883.815, 38.7; 28562892.213, 38.5; 28562902.736, 38.2; 28562913.267, 38.1; 28562923.879, 38.5; 28562932.219, 38.6; 28562942.691, 38.6; 28562953.189, 38.3; 28562963.656, 38.2; 28562972.156, 37.8; 28562982.64, 37.6; 28562993.181, 37.6; 28563003.695, 37.7; 28563012.124, 37.7; 28563022.726, 37.7; 28563033.224, 37.4; 28563043.679, 37.2; 28563052.099, 37.2; 28563062.633, 37.2; 28563073.037, 37.3; 28563083.552, 37.4; 28563093.971, 37.4; 28563102.345, 37.5; 28563112.861, 37.4; 28563123.293, 37.4; 28563133.719, 37.4; 28563142.089, 37.4; 28563152.574, 37.5; 28563163.154, 37.4; 28563173.621, 37.4; 28563182.087, 37.5; 28563192.592, 37.5; 28563203.038, 37.5; 28563213.629, 37.5; 28563222.007, 37.6; 28563232.568, 37.8; 28563243.081, 37.8; 28563253.578, 37.9; 28563261.926, 37.8; 28563272.424, 37.6; 28563282.903, 37.5; 28563293.403, 37.4; 28563303.856, 37.2; 28563312.33, 37.1; 28563322.824, 37.0; 28563333.257, 37.1; 28563343.71, 37.1; 28563352.104, 37.2; 28563362.606, 37.3; 28563373.104, 37.2; 28563383.508, 37.2; 28563393.973, 37.1; 28563402.368, 37.1; 28563412.836, 37.1; 28563423.272, 36.9; 28563433.748, 36.9; 28563442.126, 36.9; 28563452.598, 37.0; 28563463.064, 37.2; 28563473.449, 37.2; 28563483.875, 37.4; 28563492.199, 37.5; 28563502.589, 37.6; 28563513.012, 37.9; 28563523.554, 38.0; 28563531.92, 37.9; 28563542.325, 38.1; 28563552.806, 37.9; 28563563.274, 38.0; 28563573.722, 37.9; 28563582.176, 37.9; 28563592.673, 38.0; 28563603.124, 38.0; 28563613.598, 37.9; 28563621.94, 37.8; 28563632.409, 37.9; 28563642.89, 38.0; 28563653.297, 37.9; 28563663.778, 37.9; 28563672.095, 37.9; 28563682.525, 38.0; 28563693.012, 37.9; 28563703.574, 37.9; 28563711.934, 37.8; 28563722.443, 37.8; 28563732.927, 37.8; 28563743.379, 37.7; 28563753.845, 37.6; 28563762.304, 37.6; 28563772.802, 37.3; 28563783.239, 37.2; 28563793.721, 37.2; 28563802.08, 37.3; 28563812.565, 37.2; 28563823.041, 37.2; 28563833.514, 37.0; 28563841.965, 37.1; 28563852.447, 37.3; 28563862.931, 37.3; 28563873.459, 37.3; 28563883.942, 37.2; 28563892.288, 37.2; 28563902.712, 37.1; 28563913.196, 37.1; 28563923.689, 37.2; 28563932.112, 37.3; 28563942.659, 37.2; 28563953.141, 37.2; 28563963.577, 37.2; 28563972.02, 37.2; 28563982.423, 37.1; 28563992.936, 37.1; 28564003.417, 37.1; 28564013.92, 37.1; 28564022.296, 37.2; 28564032.748, 37.1; 28564043.226, 37.1; 28564053.663, 37.0; 28564062.044, 37.1; 28564072.476, 37.0; 28564082.93, 36.8; 28564093.331, 36.8; 28564103.816, 36.9; 28564112.221, 36.9; 28564122.812, 36.9; 28564133.346, 36.7; 28564143.721, 36.6; 28564152.077, 36.5; 28564162.497, 36.6; 28564172.95, 36.6; 28564183.389, 36.7; 28564193.851, 36.6; 28564202.323, 36.6; 28564212.825, 36.6; 28564223.335, 36.6; 28564233.848, 36.5; 28564242.214, 36.5; 28564252.681, 36.5; 28564263.142, 36.5; 28564273.615, 36.5; 28564282.056, 36.4; 28564292.504, 36.4; 28564302.958, 36.4; 28564313.374, 36.4; 28564323.808, 36.3; 28564332.129, 36.3; 28564342.669, 36.3; 28564353.155, 36.1; 28564363.592, 36.2; 28564371.967, 36.3; 28564382.389, 36.3; 28564392.822, 36.4; 28564403.317, 36.3; 28564413.697, 36.3; 28564422.041, 36.4; 28564432.614, 36.3; 28564443.179, 36.3; 28564453.782, 36.3; 28564462.175, 36.4; 28564472.642, 36.2; 28564483.094, 36.2; 28564493.528, 36.2; 28564501.898, 36.1; 28564512.374, 35.9; 28564522.811, 35.9; 28564533.267, 35.4; 28564543.734, 35.7; 28564552.151, 35.8; 28564562.554, 35.9; 28564572.984, 36.0; 28564583.424, 35.8; 28564591.93, 35.8; 28564602.341, 35.7; 28564612.826, 35.6; 28564623.252, 35.6; 28564633.756, 35.6; 28564642.17, 35.6; 28564652.638, 35.7; 28564663.163, 35.7; 28564673.709, 35.7; 28564682.112, 35.7; 28564692.593, 35.8; 28564703.098, 35.7; 28564713.558, 35.8; 28564721.982, 35.8; 28564732.452, 35.8; 28564742.865, 35.9; 28564753.272, 36.1; 28564763.733, 36.0; 28564772.078, 36.1; 28564782.539, 35.9; 28564792.994, 35.9; 28564803.449, 35.9; 28564813.942, 35.9; 28564822.303, 35.9; 28564832.7, 35.8; 28564843.169, 35.8; 28564853.715, 35.8; 28564862.094, 35.6; 28564872.519, 35.6; 28564882.941, 35.4; 28564893.407, 35.6; 28564903.832, 35.5; 28564912.174, 35.6; 28564922.613, 35.7; 28564933.05, 35.8; 28564943.463, 35.7; 28564953.944, 35.6; 28564962.353, 35.4; 28564972.93, 35.4; 28564983.555, 35.4; 28564994.008, 35.3; 28565002.338, 35.2; 28565012.767, 35.1; 28565023.204, 35.1; 28565033.643, 35.0; 28565042.021, 34.8; 28565052.459, 34.7; 28565062.94, 34.5; 28565073.383, 34.3; 28565083.805, 34.2; 28565092.167, 34.0; 28565102.607, 33.6; 28565113.073, 33.2; 28565123.527, 32.8; 28565132.011, 32.6; 28565142.467, 32.1; 28565153.058, 31.7; 28565163.495, 31.3; 28565173.902, 31.2; 28565182.231, 31.1; 28565192.639, 31.1; 28565203.119, 31.1; 28565213.62, 31.0; 28565224.093, 31.0; 28565232.402, 30.9; 28565242.89, 31.0; 28565253.308, 31.1; 28565263.666, 31.2; 28565274.103, 31.4; 28565282.486, 31.6; 28565292.917, 31.7; 28565303.448, 31.8; 28565313.884, 31.9; 28565322.263, 32.2; 28565332.764, 32.7; 28565343.312, 33.1; 28565353.871, 33.5; 28565362.247, 33.8; 28565372.767, 33.7; 28565383.206, 33.6; 28565393.765, 32.6; 28565402.155, 33.0; 28565412.684, 33.0; 28565423.138, 33.5; 28565433.635, 33.9; 28565444.105, 33.1; 28565452.45, 33.2; 28565462.889, 33.0; 28565473.33, 32.1; 28565483.781, 31.7; 28565492.142, 31.6; 28565502.606, 31.7; 28565513.032, 32.0; 28565523.469, 32.0; 28565533.999, 32.0; 28565542.313, 32.0; 28565552.769, 31.5; 28565563.188, 30.8; 28565573.653, 29.5; 28565584.09, 28.0; 28565592.42, 27.0; 28565602.891, 26.1; 28565613.362, 25.1; 28565623.858, 23.8; 28565632.237, 23.8; 28565642.642, 23.9; 28565653.059, 24.1; 28565663.611, 25.2; 28565674.043, 26.7; 28565682.469, 27.8; 28565692.936, 28.3; 28565703.488, 27.5; 28565713.924, 26.4; 28565722.318, 25.5; 28565732.736, 24.2; 28565743.187, 23.8; 28565753.608, 25.0; 28565764.077, 26.6; 28565772.502, 27.2; 28565782.985, 26.8; 28565793.499, 25.5; 28565803.894, 24.1; 28565812.24, 23.2; 28565822.77, 22.1; 28565833.238, 21.1; 28565843.676, 20.9; 28565854.11, 21.0; 28565862.507, 21.1; 28565873.03, 21.7; 28565883.421, 23.3; 28565893.971, 25.0; 28565902.376, 25.6; 28565912.817, 27.0; 28565923.345, 26.6; 28565933.783, 25.8; 28565944.14, 24.6; 28565952.501, 23.4; 28565962.923, 21.3; 28565973.391, 18.6; 28565983.863, 15.9; 28565992.238, 13.9; 28566002.663, 11.5; 28566013.084, 9.4; 28566023.489, 7.3; 28566033.938, 5.5; 28566042.3, 4.3; 28566052.726, 3.0; 28566063.175, 2.1; 28566073.631, 1.1; 28566084.1, 0.5; 28566092.427, 0.2; 28566102.928, -0.2; 28566113.365, -0.6; 28566123.829, -0.6; 28566132.18, -0.7; 28566142.629, -0.8; 28566153.085, -0.8; 28566163.519, -0.9; 28566173.943, -1.1; 28566182.29, -1.2; 28566192.728, -1.3; 28566203.165, -1.3; 28566213.614, -1.3; 28566224.051, -1.3; 28566232.379, -1.4; 28566242.883, -1.5; 28566253.321, -1.5; 28566263.704, -1.5; 28566274.148, -1.6; 28566282.541, -1.7; 28566292.991, -1.7; 28566303.444, -1.7; 28566313.943, -1.7; 28566322.288, -1.8; 28566332.789, -1.8; 28566343.181, -1.8; 28566353.603, -1.8; 28566364.068, -1.9; 28566372.402, -1.9; 28566382.839, -1.8; 28566393.333, -1.6; 28566403.759, -1.5; 28566412.117, -1.8; 28566422.589, -2.1; 28566433.21, -2.1; 28566443.728, -2.2; 28566452.054, -2.2; 28566462.633, -2.3; 28566473.135, -2.7; 28566483.6, -2.9; 28566494.118, -3.1; 28566502.668, -3.3; 28566513.162, -3.3; 28566523.602, -3.4; 28566534.052, -3.6; 28566542.444, -3.7; 28566552.913, -3.9; 28566563.416, -4.0; 28566573.896, -4.2; 28566582.321, -4.3; 28566592.728, -4.5; 28566603.121, -4.6; 28566613.619, -4.6; 28566624.105, -4.8; 28566632.477, -4.9; 28566632.478, 0; 3.15569e8, 0]) annotation(Placement(visible = true, transformation(origin = {0, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b TDryBul "Dry bulb temperature" annotation(Placement(visible = true, transformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    // Modelica.Blocks.Interfaces.RealOutput Q_gen "don't know why these experiment outputs get stuck in context, but here they are" annotation(Placement(visible = true, transformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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
    //connect(ICSFg8_DNI_Nov252013.y[1], DNI) annotation(Line(points = {{51, -80}, {65.7602, -80}, {65.7602, -19.7775}, {93.9431, -19.7775}, {93.9431, -19.7775}}, color = {0, 0, 127}));
    //connect(ICSg8_Egen_data_11252013.y[1], ICSg8_Egen_data_11252013_conn) annotation(Line(points = {{-11, 66}, {12, 66}, {12, 54}, {54, 54}, {69.5748, 53.8443}, {100, 40}, {100, 42}}, color = {0, 0, 127}));
    //[[11252013]]
    //connect(ICSg8_Qgen_data_11252013.y[1], Q_gen) annotation(Line(points = {{11, 80}, {16.0544, 80}, {16.0544, 42.9932}, {72.9252, 42.9932}, {72.9252, 19.8639}, {100, 19.8639}, {100, 20}}, color = {0, 0, 127}));
    connect(TOutside.port,TDryBul) annotation(Line(points = {{70,20},{97.8229,0},{100,0}}));
    connect(weatherBus.HDirNor,DNI) "Connects Hourly Direct Normal Irradiance from the weather file to the DNI output of context";
    connect(SurfOrientation,SurfOrientation_out) "Connects Surface Orientation Parameter to Surface Orientation Output";
    connect(SurfTilt,SurfTilt_out) "Connects Surface Tilt Parameter to Surface Tilt Output";
    connect(weatherBus.TDryBul,TOutside.T) "Connects the weather file Dry Bult to the TOutside prescribed temperature model" annotation(Line(points = {{20,20},{47.0247,20},{48,20}}));
    // connect(weatherBus, HDirTil.weaBus) "Connects the weather bus to the irradiance based on wall tilt calculation model (HDirTil)" annotation(Line(points = {{20, 20}, {19.7388, 20}, {19.7388, -17.4165}, {-3.48331, -17.4165}, {-3.48331, -40.0581}, {10, -40.0581}, {10, -40}}));
    // connect(HDirTil.inc, AOI) "Connects incident angle to angle of incidence out" annotation(Line(points = {{31, -44}, {45.5733, -44}, {45.5733, -40.0581}, {100, -40.0581}, {100, -40}}));
    connect(weatherBus.solTim,solHouAng.solTim) "Connects solar time to solar hour angle model" annotation(Line(points = {{20,20},{19.7388,20},{19.7388,-17.4165},{-63.5704,-17.4165},{-63.5704,-79.8258},{-52,-79.8258},{-52,-80}}));
    connect(weatherBus.cloTim,decAng.nDay) "Calculates clock time to day number" annotation(Line(points = {{20,20},{19.7388,20},{19.7388,-17.4165},{-63.5704,-17.4165},{-63.5704,-40.0581},{-52,-40.0581},{-52,-40}}));
    connect(weaDat.weaBus,weatherBus) "Connects weather data to weather bus" annotation(Line(points = {{-20,20},{20.6096,20},{20,20}}));
    //Uses the decAng and solHouAng to calculate the Declination and Solar Hour angles
    SunAlt = Modelica.Math.asin(Modelica.Math.sin(Lat) * Modelica.Math.sin(decAng.decAng) + Modelica.Math.cos(Lat) * Modelica.Math.cos(decAng.decAng) * Modelica.Math.cos(solHouAng.solHouAng));
    //Eq 1.6.6 Solar Engineering of Thermal Processes - Duff & Beckman
    SunAzi = sign(Modelica.Math.sin(solHouAng.solHouAng)) * abs(Modelica.Math.acos((Modelica.Math.cos(abs(Modelica.Constants.pi / 2 - SunAlt)) * Modelica.Math.sin(Lat) - Modelica.Math.sin(decAng.decAng)) / (Modelica.Math.cos(Lat) * Modelica.Math.sin(abs(Modelica.Constants.pi / 2 - SunAlt)))));
    //Eq 1.6.2 Solar Engineering of Thermal Processes - Duff & Beckman
    // Ask about the origin of this AOI when we can get AOI from HDirTil component.
    AOI = Modelica.Math.acos(del_s * phi_s * bet_c - del_s * phi_c * bet_s * gam_c + del_c * phi_c * bet_c * omg_c + del_c * phi_s * bet_s * gam_c * omg_c + del_c * bet_s * gam_s * omg_s);
    annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics), experiment(StartTime = 7084800, StopTime = 7171200, Tolerance = 1e-006, Interval = 864));
  end ICS_Context;
  package Envelope "Package of all the Envelope components to create an Integrated Concentrating Solar simulation"
    extends Modelica.Icons.Package;
    model ICS_EnvelopeCassette "This model in the Envelope Cassette (Double-Skin Facade) that houses the ICSolar Stack and Modules. This presents a building envelope"
      extends ICSolar.Parameters;
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in "Ambient cavity temperature" annotation(Placement(visible = true, transformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a(medium = mediumHTF) "Thermal fluid inflow port, before heat exchange" annotation(Placement(visible = true, transformation(origin = {-100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-95,-85}, extent = {{-5,-5},{5,5}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "DNI from weather file" annotation(Placement(visible = true, transformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput AOI "Angle of incidence" annotation(Placement(visible = true, transformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SunAlt "Altitude of the sun " annotation(Placement(visible = true, transformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SunAzi "Azimuth of the sun " annotation(Placement(visible = true, transformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfaceOrientation annotation(Placement(visible = true, transformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfaceTilt annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput Power_Electric "Electric power generated" annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,60}, extent = {{-20,-20},{20,20}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b(medium = mediumHTF) "Thermal fluid outflow port, after heat exchange" annotation(Placement(visible = true, transformation(origin = {100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      // Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b Power_Heat "Heat power generated" annotation(Placement(visible = true, transformation(origin = {100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      // Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort generated_enthalpy "Placeholder to make" annotation(Placement(visible = false));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature T_indoors(T = Temp_Indoor) annotation(Placement(visible = true, transformation(origin = {-20,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ICSolar.Envelope.CavityHeatBalance cavityheatbalance1 annotation(Placement(visible = true, transformation(origin = {20,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      // ICSolar.Envelope.ICS_GlazingLosses glazingLossesInner(Trans_glaz = 0.76) annotation(Placement(visible = true, transformation(origin = {60, -60}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      ICSolar.Envelope.ICS_GlazingLosses glazingLossesOuter annotation(Placement(visible = true, transformation(origin = {-60,60}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      ICSolar.Envelope.RotationMatrixForSphericalCood rotationmatrixforsphericalcood1 annotation(Placement(visible = true, transformation(origin = {-60,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      // Modelica.Blocks.Interfaces.RealOutput DNI_toIndoors "the DNI that slips past the modules and gets through the interior-side glazing" annotation(Placement(visible = true, transformation(origin = {100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      // ICSolar.Envelope.DNIReduction_AreaFraction dnireduction_areafraction1 annotation(Placement(visible = true, transformation(origin = {-20, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      constant Real GND = 0 "Ground input for stack power flow, Real";
      //  constant Modelica.Blocks.Sources.Constant GND(k = 0) "a zero source for the Real electrical input" annotation(Placement(visible = true, transformation(origin = {-20, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      ICSolar.Stack.ICS_Stack ics_stack1 annotation(Placement(visible = true, transformation(origin = {40,0}, extent = {{-25,-25},{25,25}}, rotation = 0)));
      ICSolar.Stack.ICS_Stack2 ics_stack2 annotation(Placement(visible = true, transformation(origin = {40,-60}, extent = {{-25,-25},{25,25}}, rotation = 0)));
      Modelica.Blocks.Sources.CombiTimeTable DNI_measured(tableOnFile = true, fileName = Path + "20150323\\ICSFdata_DLS.txt", tableName = "DNI_THTFin_vdot", nout = 2, columns = {2});
    equation
      //  pre-stacks
      //DNI into cavity
      connect(DNI,glazingLossesOuter.DNI) annotation(Line(points = {{-100,60},{-75,60},{-75,64},{-70,69},{-75,69}}));
      connect(AOI,glazingLossesOuter.AOI) annotation(Line(points = {{-100,40},{-84,40},{-84,45},{-70,51},{-75,51}}));
      connect(SunAlt,rotationmatrixforsphericalcood1.SunAlt) annotation(Line(points = {{-100,20},{-81.46339999999999,20},{-81.2162,-16.5426},{-69.75279999999999,-16.445},{-70,-16}}, color = {0,0,127}));
      connect(SunAzi,rotationmatrixforsphericalcood1.SunAzi) annotation(Line(points = {{-100,0},{-87.0732,0},{-86.82599999999999,-11.9084},{-69.75279999999999,-12.445},{-70,-12}}, color = {0,0,127}));
      connect(SurfaceOrientation,rotationmatrixforsphericalcood1.SurfaceOrientation) annotation(Line(points = {{-100,-20},{-83.9024,-20},{-83.65519999999999,-20.2011},{-69.75279999999999,-20.445},{-70,-20}}, color = {0,0,127}));
      connect(SurfaceTilt,rotationmatrixforsphericalcood1.SurfaceTilt) annotation(Line(points = {{-100,-40},{-85.60980000000001,-40},{-85.3626,-24.5913},{-69.75279999999999,-24.445},{-70,-24}}, color = {0,0,127}));
      //how much self-shading
      //thermal balance
      connect(T_indoors.port,cavityheatbalance1.Interior) annotation(Line(points = {{-10,60},{-1.48368,60},{-1.48368,55.7864},{10,55.7864},{10,56}}));
      connect(TAmb_in,cavityheatbalance1.Exterior) annotation(Line(points = {{-100,80},{5.04451,80},{5.04451,65.8754},{10,66},{10,66}}));
      //prep the stacks inputs:
      ics_stack1.Power_in = 0;
      connect(ics_stack2.Power_in,ics_stack1.Power_out);
      connect(ics_stack2.Power_out,Power_Electric);
      connect(rotationmatrixforsphericalcood1.arrayYaw,ics_stack1.arrayYaw);
      connect(rotationmatrixforsphericalcood1.arrayPitch,ics_stack1.arrayPitch);
      connect(rotationmatrixforsphericalcood1.arrayYaw,ics_stack2.arrayYaw);
      connect(rotationmatrixforsphericalcood1.arrayPitch,ics_stack2.arrayPitch);
      //  connect(glazingLossesOuter.SurfDirNor, ics_stack1.DNI);
      // connect(glazingLossesOuter.SurfDirNor, ics_stack2.DNI);
      connect(DNI_measured.y[1],ics_stack2.DNI);
      connect(DNI_measured.y[1],ics_stack1.DNI);
      connect(ics_stack1.flowport_a1,flowport_a);
      connect(ics_stack1.flowport_b1,ics_stack2.flowport_a1);
      connect(ics_stack2.flowport_b1,flowport_b);
      connect(ics_stack1.TAmb_in,cavityheatbalance1.ICS_Heat);
      connect(ics_stack2.TAmb_in,cavityheatbalance1.ICS_Heat);
    end ICS_EnvelopeCassette;
    model ICS_GlazingLosses "This model calculates the transmittance of a single glass layer and discounts the DNI by the absorption and reflection"
      extends ICSolar.Parameters;
      //
      constant Real n_air = 1.0 "optical index, air";
      constant Real n_glass = 1.53 "optical index, glass";
      constant Real R_o = ((n_air - n_glass) / (n_air + n_glass)) ^ 2 "normal reflection (Snell's)";
      Real R_Fres = R_o + (1 - R_o) * (1 - cos(AOI)) ^ 5 "for Schlick's approximation";
      //deprecate this: ?
      //      parameter Real Trans_glaz = Trans_glazinglosses "Good glass: Guardian Ultraclear 6mm: 0.87. For our studio IGUs, measured 0.71. But give it 0.74, because we measured at ~28degrees, which will increase absorptance losses.";
      Modelica.Blocks.Interfaces.RealOutput Trans_glaz_transient "momentary transmittance of exterior glazing" annotation(Placement(visible = true, transformation(origin = {100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput SurfDirNor "Surface direct normal solar irradiance" annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput AOI "Angle of incidence" annotation(Placement(visible = true, transformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "Direct normal irradiance" annotation(Placement(visible = true, transformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Real Trans_glazinglosses_Schlick = (1 - R_sfc / cos(AOI)) * ((1 - c_disp * x_lite / cos(AOI)) * (1 - 2 * R_Fres / (1 + R_Fres))) ^ n_lites "glazing transmittance vs AOI";
    equation
      if AOI <= 1.57 then
        //6.6.15: Trans_glazing losses is now a variable calculated from properties and the AOI:
        SurfDirNor = DNI * Trans_glazinglosses_Schlick;
        //that is, this is deprecated:
        //   SurfDirNor = DNI * ((-1.03279 * AOI ^ 6) + 3.67852 * AOI ^ 5 + (-5.11451 * AOI ^ 4) + 3.27596 * AOI ^ 3 + (-0.9393 * AOI ^ 2) + 0.09071 * AOI + 0.96) * ((-0.1167 * AOI ^ 3) + 0.139 * AOI ^ 2 + (-0.0643 * AOI ^ 1) + 0.95) * Trans_glaz / (0.96 * 0.95) "Fresnel Reflection and material absorption losses from Polyfits where P_Transmitted(AOI)";
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
      if DNI > 0 then
        Trans_glaz_transient = SurfDirNor / DNI;
      else
        Trans_glaz_transient = Trans_glazinglosses_Schlick;
      end if;
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Text(origin = {-2.81,1.48}, extent = {{-67,33.14},{67,-33.14}}, textString = "Glazing Losses")}), experiment(StartTime = 1, StopTime = 31536000.0, Tolerance = 1e-006, Interval = 3600));
    end ICS_GlazingLosses;
    model ICS_SelfShading "This model multiplies the DNI in by a shaded factor determined from the solar altitude and azimuth"
      Modelica.Blocks.Interfaces.RealOutput DNI_out "DNI after shading factor multiplication" annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI_in "DNI in before shading factor multiplication" annotation(Placement(visible = true, transformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Math.Product product1 "Multiplication of DNI and shading factor" annotation(Placement(visible = true, transformation(origin = {20,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayPitch "pitch (up/down) angle of 2axis tracking array (rads)" annotation(Placement(visible = true, transformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayYaw "yaw (left/right) angle of tracking array (in radians)" annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Tables.CombiTable2D Shading(table = [0,-3.1415926,-1.04719,-0.959927,-0.872667,-0.785397,-0.6981270000000001,-0.610867,-0.523597,-0.436327,-0.349067,-0.261797,-0.174837,-0.08726730000000001,0,0.08726730000000001,0.174837,0.261797,0.349067,0.436327,0.523597,0.610867,0.6981270000000001,0.785397,0.872667,0.959927,1.04719,3.1415926;-0.872665,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;-0.785398,0,0,0.515733288,0.582273933,0.644111335,0.700774874,0.751833306,0.796898047,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.796898047,0.751833306,0.700774874,0.644111335,0.582273933,0.515733288,0,0;-0.698132,0,0,0.558719885,0.630806722,0.697798298,0.759184768,0.814498944,0.86331985,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.86331985,0.814498944,0.759184768,0.697798298,0.630806722,0.558719885,0,0;-0.610865,0,0,0.5974542859999999,0.674538691,0.746174596,0.811816808,0.870965752,0.923171268,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.923171268,0.870965752,0.811816808,0.746174596,0.674538691,0.5974542859999999,0,0;-0.523599,0,0,0.6316417,0.713137013,0.788872054,0.8582704330000001,0.920803986,0.975996795,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.975996795,0.920803986,0.8582704330000001,0.788872054,0.713137013,0.6316417,0,0;-0.436332,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;-0.349066,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;-0.261799,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;-0.174533,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;-0.087266,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;0,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;0.087266,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;0.174533,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;0.261799,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;0.349066,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;0.436332,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;0.523599,0,0,0.6316417,0.713137013,0.788872054,0.8582704330000001,0.920803986,0.975996795,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.975996795,0.920803986,0.8582704330000001,0.788872054,0.713137013,0.6316417,0,0;0.610865,0,0,0.5974542859999999,0.674538691,0.746174596,0.811816808,0.870965752,0.923171268,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.923171268,0.870965752,0.811816808,0.746174596,0.674538691,0.5974542859999999,0,0;0.698132,0,0,0.558719885,0.630806722,0.697798298,0.759184768,0.814498944,0.86331985,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.86331985,0.814498944,0.759184768,0.697798298,0.630806722,0.558719885,0,0;0.785398,0,0,0.515733288,0.582273933,0.644111335,0.700774874,0.751833306,0.796898047,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.796898047,0.751833306,0.700774874,0.644111335,0.582273933,0.515733288,0,0;0.872665,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) "Shading factors based on altitude and azimuth" annotation(Placement(visible = true, transformation(origin = {-40,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      connect(arrayYaw,Shading.u2) annotation(Line(points = {{-100,-40},{-88.2927,-40},{-88.2927,-45.3659},{-32,-46},{-52,-46}}, color = {0,0,127}));
      connect(arrayPitch,Shading.u1) annotation(Line(points = {{-100,-20},{-84.39019999999999,-20},{-84.39019999999999,-32.6829},{-32,-34},{-52,-34}}, color = {0,0,127}));
      //  connect(DNI_transmitted_table.y, DNI_transmitted) annotation(Line(points = {{-9, 0}, {33.7415, 0}, {33.7415, -20.1361}, {93.0612, -20.1361}, {93.0612, -20.1361}}, color = {0, 0, 127}));
      //  connect(rotationmatrixforsphericalcood1.SurfYaw, DNI_transmitted_table.u2) annotation(Line(points = {{-50, -34}, {-45.1701, -34}, {-45.1701, -5.71429}, {-33.7415, -5.71429}, {-33.7415, -5.71429}}, color = {0, 0, 127}));
      //  connect(rotationmatrixforsphericalcood1.SurfPitch, DNI_transmitted_table.u1) annotation(Line(points = {{-50, -44}, {-42.7211, -44}, {-42.7211, 6.80272}, {-33.4694, 6.80272}, {-33.4694, 6.80272}}, color = {0, 0, 127}));
      product1.u2 = if Shading.y < 0 then 0 else Shading.y;
      connect(product1.y,DNI_out) "DNI after multiplication connected to output of model" annotation(Line(points = {{31,40},{58.5909,40},{58.5909,19.7775},{100,19.7775},{100,20}}));
      //connect(Shading.y,product1.u2) "Shading factor connecting to product" annotation(Line(points = {{-9,-40},{-0.741656,-40},{-0.741656,33.869},{8,33.869},{8,34}}));
      connect(DNI_in,product1.u1) "Model input DNI connecting to product" annotation(Line(points = {{-100,80},{-36.3412,80},{-36.3412,45.9827},{8,45.9827},{8,46}}));
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Text(origin = {-4.59,2.51}, extent = {{-72.63,35.36},{72.63,-35.36}}, textString = "Self Shading")}));
    end ICS_SelfShading;
    class RotationMatrixForSphericalCood "This models changes the reference frame from the Solar Altitude / Aizmuth to the surface yaw and pitch angles based on building orientatino and surface tilt"
      // parameter Real RollAng = 0;  Not included in current model verison
      Modelica.Blocks.Interfaces.RealOutput arrayYaw annotation(Placement(visible = true, transformation(origin = {100,60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,60}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput arrayPitch annotation(Placement(visible = true, transformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-40}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      // Construction of Spherical to Cartesain Matrix
      Real phi = 3 * Modelica.Constants.pi / 2 - SunAzi;
      Real theta = Modelica.Constants.pi / 2 - SunAlt "Solar Zeneth Angle";
      Real PitchAng = SurfaceTilt "Tilt back from Vertical Position";
      Real YawAng = SurfaceOrientation "Zero is direct SOUTH";
      Real vSphToCart[3,1] = [Modelica.Math.sin(theta) * Modelica.Math.cos(phi);Modelica.Math.sin(theta) * Modelica.Math.sin(phi);Modelica.Math.cos(theta)];
      // Result of Cartesian to Spherical
      Real vCartToSph[3,1];
      // Rotation around X-axis --> RollAng
      Real Rx[3,3] = [1,0,0;0,Modelica.Math.cos(PitchAng),-1 * Modelica.Math.sin(PitchAng);0,Modelica.Math.sin(PitchAng),Modelica.Math.cos(PitchAng)];
      // Rotation around Y-axis --> PitchAng
      //	Real Ry[3,3] = [Modelica.Math.cos(-1*PitchAng),0,Modelica.Math.sin(-1*PitchAng);0,1,0;-1 * Modelica.Math.sin(-1*PitchAng),0,Modelica.Math.cos(-1*PitchAng)];
      // Rotation around the Z-axis --> YawAng
      Real Rz[3,3] = [Modelica.Math.cos(YawAng),-1 * Modelica.Math.sin(YawAng),0;Modelica.Math.sin(YawAng),Modelica.Math.cos(YawAng),0;0,0,1];
      Modelica.Blocks.Interfaces.RealInput SunAzi annotation(Placement(visible = true, transformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,80}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SunAlt annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,40}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfaceOrientation annotation(Placement(visible = true, transformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfaceTilt annotation(Placement(visible = true, transformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-15,-15},{15,15}}, rotation = 0)));
    equation
      vCartToSph = Rx * Rz * vSphToCart;
      arrayPitch = Modelica.Constants.pi / 2 - Modelica.Math.acos(vCartToSph[3,1]);
      arrayYaw = (-1 * Modelica.Math.atan(vCartToSph[2,1] / vCartToSph[1,1])) - sign(vCartToSph[1,1]) * Modelica.Constants.pi / 2;
      annotation(Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Text(origin = {16.0156,3.67356}, extent = {{-101.49,60.28},{73.98,-63.83}}, textString = "Transform Matrix")}), experiment(StartTime = 0, StopTime = 86400, Tolerance = 0.001, Interval = 86.5731));
    end RotationMatrixForSphericalCood;
    model CavityHeatBalance
      extends ICSolar.Parameters;
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor Conduction_Exterior(G = 10.17809 * GlassArea) "Lumped Thermal Conduction between Exterior and Cavity" annotation(Placement(visible = true, transformation(origin = {-40,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Interior annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Exterior annotation(Placement(visible = true, transformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor CavityHeatCapacity(C = 2.072 * 1000) "Includes Air and ICS Components to add to the Heat Capacity of the Cavity" annotation(Placement(visible = true, transformation(origin = {0,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor Conduction_Interior(G = 3.309792 * GlassArea) "Conduction Heat Transfer between Cavity and Interior" annotation(Placement(visible = true, transformation(origin = {40,20}, extent = {{-10,-10},{10,10}}, rotation = 180)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b ICS_Heat annotation(Placement(visible = true, transformation(origin = {0,-100}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {0,-100}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Tcav_measured annotation(Placement(visible = true, transformation(origin = {-100,-55}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-70}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      connect(Tcav_measured,ICS_Heat) annotation(Line(points = {{-100,-55},{0.966184,-55},{0.966184,-98.0676},{0.966184,-98.0676}}, color = {191,0,0}));
      connect(Conduction_Interior.port_a,Interior) annotation(Line(points = {{50,20},{101.78,20},{101.78,20.4748},{101.78,20.4748}}));
      connect(ICS_Heat,CavityHeatCapacity.port) annotation(Line(points = {{0,-100},{0.593472,-100},{0.593472,29.9703},{0.593472,29.9703}}));
      connect(Conduction_Interior.port_b,CavityHeatCapacity.port) annotation(Line(points = {{30,20},{0.296736,20},{0.296736,29.3769},{0.296736,29.3769}}));
      connect(Conduction_Exterior.port_b,CavityHeatCapacity.port) annotation(Line(points = {{-30,20},{0.296736,20},{0.296736,30.5638},{0.296736,30.5638}}));
      connect(Exterior,Conduction_Exterior.port_a) annotation(Line(points = {{-100,20},{-50.1484,20},{-50.1484,20.4748},{-50.1484,20.4748}}));
      annotation(Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Text(origin = {2.37855,61.2725}, extent = {{-50.45,33.98},{50.45,-33.98}}, textString = "Cavity"),Text(origin = {0.742849,12.7626}, extent = {{-52.37,30.56},{52.37,-30.56}}, textString = "Heat"),Text(origin = {2.22528,-43.7642}, extent = {{-61.28,22.7},{61.28,-22.7}}, textString = "Balance")}));
    end CavityHeatBalance;
    model DNIReduction_AreaFraction "Outputs area-based fraction of DNI that enters cassette but is not intercepted by modules, due to array geometry/transient orientation."
      Modelica.Blocks.Interfaces.RealOutput DNI_out "DNI after area fraction reduction" annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI_in "DNI before area fraction reduction" annotation(Placement(visible = true, transformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Math.Product product1 "Multiplication of DNI area fraction" annotation(Placement(visible = true, transformation(origin = {20,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayPitch "pitch (up/down) angle of 2axis tracking array (rads)" annotation(Placement(visible = true, transformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayYaw "yaw (left/right) angle of tracking array (in radians)" annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Tables.CombiTable2D AreaFraction(table = [0.0,-1.5708,-0.41888,-0.40143,-0.38397,-0.36652,-0.34907,-0.33161,-0.31416,-0.29671,-0.27925,-0.2618,-0.24435,-0.22689,-0.20944,-0.19199,-0.17453,-0.15708,-0.13963,-0.12217,-0.10472,-0.08727,-0.06981,-0.05236,-0.03491,-0.01745,0.0,0.01745,0.03491,0.05236,0.06981,0.08727,0.10472,0.12217,0.13963,0.15708,0.17453,0.19199,0.20944,0.22689,0.24435,0.2618,0.27925,0.29671,0.31416,0.33161,0.34907,0.36652,0.38397,0.40143,0.41888,1.5708;-1.5708,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,0.01043,0.02084,0.03126,0.04168,0.05209,0.06251,0.07292999999999999,0.08334,0.09376,0.10418,0.11459,0.12501,0.13543,0.14584,0.15626,0.16668,0.15626,0.14584,0.13543,0.12501,0.11459,0.10418,0.09376,0.08334,0.07292999999999999,0.06251,0.05209,0.04168,0.03126,0.02084,0.01043,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005;-0.61087,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,0.01043,0.02084,0.03126,0.04168,0.05209,0.06251,0.07292999999999999,0.08334,0.09376,0.10418,0.11459,0.12501,0.13543,0.14584,0.15626,0.16668,0.15626,0.14584,0.13543,0.12501,0.11459,0.10418,0.09376,0.08334,0.07292999999999999,0.06251,0.05209,0.04168,0.03126,0.02084,0.01043,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005;-0.59341,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,0.01043,0.02084,0.03126,0.04168,0.05209,0.06251,0.07292999999999999,0.08334,0.09376,0.10418,0.11459,0.12501,0.13543,0.14584,0.15626,0.16668,0.15626,0.14584,0.13543,0.12501,0.11459,0.10418,0.09376,0.08334,0.07292999999999999,0.06251,0.05209,0.04168,0.03126,0.02084,0.01043,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005;-0.57596,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,0.01043,0.02084,0.03126,0.04168,0.05209,0.06251,0.07292999999999999,0.08334,0.09376,0.10418,0.11459,0.12501,0.13543,0.14584,0.15626,0.16668,0.15626,0.14584,0.13543,0.12501,0.11459,0.10418,0.09376,0.08334,0.07292999999999999,0.06251,0.05209,0.04168,0.03126,0.02084,0.01043,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005;-0.55851,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,0.01043,0.02084,0.03126,0.04168,0.05209,0.06251,0.07292999999999999,0.08334,0.09376,0.10418,0.11459,0.12501,0.13543,0.14584,0.15626,0.16668,0.15626,0.14584,0.13543,0.12501,0.11459,0.10418,0.09376,0.08334,0.07292999999999999,0.06251,0.05209,0.04168,0.03126,0.02084,0.01043,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005;-0.54105,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,0.01043,0.02084,0.03126,0.04168,0.05209,0.06251,0.07292999999999999,0.08334,0.09376,0.10418,0.11459,0.12501,0.13543,0.14584,0.15626,0.16668,0.15626,0.14584,0.13543,0.12501,0.11459,0.10418,0.09376,0.08334,0.07292999999999999,0.06251,0.05209,0.04168,0.03126,0.02084,0.01043,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005;-0.5236,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,0.01043,0.02084,0.03126,0.04168,0.05209,0.06251,0.07292999999999999,0.08334,0.09376,0.10418,0.11459,0.12501,0.13543,0.14584,0.15626,0.16668,0.15626,0.14584,0.13543,0.12501,0.11459,0.10418,0.09376,0.08334,0.07292999999999999,0.06251,0.05209,0.04168,0.03126,0.02084,0.01043,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005;-0.50615,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,0.01043,0.02084,0.03126,0.04168,0.05209,0.06251,0.07292999999999999,0.08334,0.09376,0.10418,0.11459,0.12501,0.13543,0.14584,0.15626,0.16668,0.15626,0.14584,0.13543,0.12501,0.11459,0.10418,0.09376,0.08334,0.07292999999999999,0.06251,0.05209,0.04168,0.03126,0.02084,0.01043,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005;-0.48869,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,0.01043,0.02084,0.03126,0.04168,0.05209,0.06251,0.07292999999999999,0.08334,0.09376,0.10418,0.11459,0.12501,0.13543,0.14584,0.15626,0.16668,0.15626,0.14584,0.13543,0.12501,0.11459,0.10418,0.09376,0.08334,0.07292999999999999,0.06251,0.05209,0.04168,0.03126,0.02084,0.01043,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005;-0.47124,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,0.01043,0.02084,0.03126,0.04168,0.05209,0.06251,0.07292999999999999,0.08334,0.09376,0.10418,0.11459,0.12501,0.13543,0.14584,0.15626,0.16668,0.15626,0.14584,0.13543,0.12501,0.11459,0.10418,0.09376,0.08334,0.07292999999999999,0.06251,0.05209,0.04168,0.03126,0.02084,0.01043,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005;-0.45379,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,0.01043,0.02084,0.03126,0.04168,0.05209,0.06251,0.07292999999999999,0.08334,0.09376,0.10418,0.11459,0.12501,0.13543,0.14584,0.15626,0.16668,0.15626,0.14584,0.13543,0.12501,0.11459,0.10418,0.09376,0.08334,0.07292999999999999,0.06251,0.05209,0.04168,0.03126,0.02084,0.01043,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005;-0.43633,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,0.01043,0.02084,0.03126,0.04168,0.05209,0.06251,0.07292999999999999,0.08334,0.09376,0.10418,0.11459,0.12501,0.13543,0.14584,0.15626,0.16668,0.15626,0.14584,0.13543,0.12501,0.11459,0.10418,0.09376,0.08334,0.07292999999999999,0.06251,0.05209,0.04168,0.03126,0.02084,0.01043,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005;-0.41888,0.00523,0.00523,0.00523,0.00523,0.00523,0.00523,0.00523,0.00523,0.00523,0.00523,0.01559,0.02595,0.03631,0.04668,0.05704,0.0674,0.07776,0.08813,0.09848999999999999,0.10885,0.11921,0.12958,0.13994,0.1503,0.16066,0.17102,0.16066,0.1503,0.13994,0.12958,0.11921,0.10885,0.09848999999999999,0.08813,0.07776,0.0674,0.05704,0.04668,0.03631,0.02595,0.01559,0.00523,0.00523,0.00523,0.00523,0.00523,0.00523,0.00523,0.00523,0.00523,0.00523;-0.40143,0.01044,0.01044,0.01044,0.01044,0.01044,0.01044,0.01044,0.01044,0.01044,0.01044,0.02075,0.03106,0.04137,0.05168,0.06198,0.07228999999999999,0.08260000000000001,0.09291000000000001,0.10322,0.11352,0.12383,0.13414,0.14445,0.15476,0.16506,0.17537,0.16506,0.15476,0.14445,0.13414,0.12383,0.11352,0.10322,0.09291000000000001,0.08260000000000001,0.07228999999999999,0.06198,0.05168,0.04137,0.03106,0.02075,0.01044,0.01044,0.01044,0.01044,0.01044,0.01044,0.01044,0.01044,0.01044,0.01044;-0.38397,0.01566,0.01566,0.01566,0.01566,0.01566,0.01566,0.01566,0.01566,0.01566,0.01566,0.02592,0.03617,0.04642,0.05668,0.06693,0.07718,0.08744,0.09769,0.10794,0.1182,0.12845,0.13871,0.14896,0.15921,0.16947,0.17972,0.16947,0.15921,0.14896,0.13871,0.12845,0.1182,0.10794,0.09769,0.08744,0.07718,0.06693,0.05668,0.04642,0.03617,0.02592,0.01566,0.01566,0.01566,0.01566,0.01566,0.01566,0.01566,0.01566,0.01566,0.01566;-0.36652,0.02088,0.02088,0.02088,0.02088,0.02088,0.02088,0.02088,0.02088,0.02088,0.02088,0.03108,0.04128,0.05148,0.06168,0.07188,0.08208,0.09227,0.10247,0.11267,0.12287,0.13307,0.14327,0.15347,0.16367,0.17387,0.18407,0.17387,0.16367,0.15347,0.14327,0.13307,0.12287,0.11267,0.10247,0.09227,0.08208,0.07188,0.06168,0.05148,0.04128,0.03108,0.02088,0.02088,0.02088,0.02088,0.02088,0.02088,0.02088,0.02088,0.02088,0.02088;-0.34907,0.0261,0.0261,0.0261,0.0261,0.0261,0.0261,0.0261,0.0261,0.0261,0.0261,0.03624,0.04639,0.05653,0.06668,0.07682,0.08697000000000001,0.09711,0.10726,0.1174,0.12755,0.13769,0.14784,0.15798,0.16813,0.17827,0.18842,0.17827,0.16813,0.15798,0.14784,0.13769,0.12755,0.1174,0.10726,0.09711,0.08697000000000001,0.07682,0.06668,0.05653,0.04639,0.03624,0.0261,0.0261,0.0261,0.0261,0.0261,0.0261,0.0261,0.0261,0.0261,0.0261;-0.33161,0.03131,0.03131,0.03131,0.03131,0.03131,0.03131,0.03131,0.03131,0.03131,0.03131,0.0414,0.0515,0.06159,0.07167999999999999,0.08177,0.09186,0.10195,0.11204,0.12213,0.13222,0.14231,0.1524,0.16249,0.17258,0.18267,0.19276,0.18267,0.17258,0.16249,0.1524,0.14231,0.13222,0.12213,0.11204,0.10195,0.09186,0.08177,0.07167999999999999,0.06159,0.0515,0.0414,0.03131,0.03131,0.03131,0.03131,0.03131,0.03131,0.03131,0.03131,0.03131,0.03131;-0.31416,0.03653,0.03653,0.03653,0.03653,0.03653,0.03653,0.03653,0.03653,0.03653,0.03653,0.04657,0.0566,0.06664,0.07668,0.08671,0.09675,0.10679,0.11682,0.12686,0.13689,0.14693,0.15697,0.167,0.17704,0.18708,0.19711,0.18708,0.17704,0.167,0.15697,0.14693,0.13689,0.12686,0.11682,0.10679,0.09675,0.08671,0.07668,0.06664,0.0566,0.04657,0.03653,0.03653,0.03653,0.03653,0.03653,0.03653,0.03653,0.03653,0.03653,0.03653;-0.29671,0.04175,0.04175,0.04175,0.04175,0.04175,0.04175,0.04175,0.04175,0.04175,0.04175,0.05173,0.06171,0.07169,0.08168,0.09166000000000001,0.10164,0.11162,0.1216,0.13159,0.14157,0.15155,0.16153,0.17151,0.1815,0.19148,0.20146,0.19148,0.1815,0.17151,0.16153,0.15155,0.14157,0.13159,0.1216,0.11162,0.10164,0.09166000000000001,0.08168,0.07169,0.06171,0.05173,0.04175,0.04175,0.04175,0.04175,0.04175,0.04175,0.04175,0.04175,0.04175,0.04175;-0.27925,0.04697,0.04697,0.04697,0.04697,0.04697,0.04697,0.04697,0.04697,0.04697,0.04697,0.05689,0.06682,0.07675,0.08667999999999999,0.09660000000000001,0.10653,0.11646,0.12639,0.13631,0.14624,0.15617,0.1661,0.17602,0.18595,0.19588,0.20581,0.19588,0.18595,0.17602,0.1661,0.15617,0.14624,0.13631,0.12639,0.11646,0.10653,0.09660000000000001,0.08667999999999999,0.07675,0.06682,0.05689,0.04697,0.04697,0.04697,0.04697,0.04697,0.04697,0.04697,0.04697,0.04697,0.04697;-0.2618,0.05218,0.05218,0.05218,0.05218,0.05218,0.05218,0.05218,0.05218,0.05218,0.05218,0.06206,0.07192999999999999,0.0818,0.09168,0.10155,0.11142,0.1213,0.13117,0.14104,0.15092,0.16079,0.17066,0.18054,0.19041,0.20028,0.21015,0.20028,0.19041,0.18054,0.17066,0.16079,0.15092,0.14104,0.13117,0.1213,0.11142,0.10155,0.09168,0.0818,0.07192999999999999,0.06206,0.05218,0.05218,0.05218,0.05218,0.05218,0.05218,0.05218,0.05218,0.05218,0.05218;-0.24435,0.0574,0.0574,0.0574,0.0574,0.0574,0.0574,0.0574,0.0574,0.0574,0.0574,0.06722,0.07704,0.08686000000000001,0.09668,0.1065,0.11631,0.12613,0.13595,0.14577,0.15559,0.16541,0.17523,0.18505,0.19487,0.20468,0.2145,0.20468,0.19487,0.18505,0.17523,0.16541,0.15559,0.14577,0.13595,0.12613,0.11631,0.1065,0.09668,0.08686000000000001,0.07704,0.06722,0.0574,0.0574,0.0574,0.0574,0.0574,0.0574,0.0574,0.0574,0.0574,0.0574;-0.22689,0.06262,0.06262,0.06262,0.06262,0.06262,0.06262,0.06262,0.06262,0.06262,0.06262,0.07238,0.08215,0.09191000000000001,0.10168,0.11144,0.12121,0.13097,0.14073,0.1505,0.16026,0.17003,0.17979,0.18956,0.19932,0.20909,0.21885,0.20909,0.19932,0.18956,0.17979,0.17003,0.16026,0.1505,0.14073,0.13097,0.12121,0.11144,0.10168,0.09191000000000001,0.08215,0.07238,0.06262,0.06262,0.06262,0.06262,0.06262,0.06262,0.06262,0.06262,0.06262,0.06262;-0.20944,0.06784,0.06784,0.06784,0.06784,0.06784,0.06784,0.06784,0.06784,0.06784,0.06784,0.07754999999999999,0.08726,0.09697,0.10668,0.11639,0.1261,0.13581,0.14552,0.15523,0.16494,0.17465,0.18436,0.19407,0.20378,0.21349,0.2232,0.21349,0.20378,0.19407,0.18436,0.17465,0.16494,0.15523,0.14552,0.13581,0.1261,0.11639,0.10668,0.09697,0.08726,0.07754999999999999,0.06784,0.06784,0.06784,0.06784,0.06784,0.06784,0.06784,0.06784,0.06784,0.06784;-0.19199,0.07305,0.07305,0.07305,0.07305,0.07305,0.07305,0.07305,0.07305,0.07305,0.07305,0.08271000000000001,0.09236999999999999,0.10202,0.11168,0.12133,0.13099,0.14064,0.1503,0.15996,0.16961,0.17927,0.18892,0.19858,0.20823,0.21789,0.22755,0.21789,0.20823,0.19858,0.18892,0.17927,0.16961,0.15996,0.1503,0.14064,0.13099,0.12133,0.11168,0.10202,0.09236999999999999,0.08271000000000001,0.07305,0.07305,0.07305,0.07305,0.07305,0.07305,0.07305,0.07305,0.07305,0.07305;-0.17453,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.08787,0.09747,0.10708,0.11668,0.12628,0.13588,0.14548,0.15508,0.16468,0.17429,0.18389,0.19349,0.20309,0.21269,0.22229,0.23189,0.22229,0.21269,0.20309,0.19349,0.18389,0.17429,0.16468,0.15508,0.14548,0.13588,0.12628,0.11668,0.10708,0.09747,0.08787,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001;-0.15708,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.09304,0.10258,0.11213,0.12168,0.13122,0.14077,0.15032,0.15987,0.16941,0.17896,0.18851,0.19805,0.2076,0.21715,0.22669,0.23624,0.22669,0.21715,0.2076,0.19805,0.18851,0.17896,0.16941,0.15987,0.15032,0.14077,0.13122,0.12168,0.11213,0.10258,0.09304,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999;-0.13963,0.08871,0.08871,0.08871,0.08871,0.08871,0.08871,0.08871,0.08871,0.08871,0.08871,0.0982,0.10769,0.11718,0.12668,0.13617,0.14566,0.15515,0.16465,0.17414,0.18363,0.19313,0.20262,0.21211,0.2216,0.2311,0.24059,0.2311,0.2216,0.21211,0.20262,0.19313,0.18363,0.17414,0.16465,0.15515,0.14566,0.13617,0.12668,0.11718,0.10769,0.0982,0.08871,0.08871,0.08871,0.08871,0.08871,0.08871,0.08871,0.08871,0.08871,0.08871;-0.12217,0.09392,0.09392,0.09392,0.09392,0.09392,0.09392,0.09392,0.09392,0.09392,0.09392,0.10336,0.1128,0.12224,0.13168,0.14112,0.15055,0.15999,0.16943,0.17887,0.18831,0.19775,0.20718,0.21662,0.22606,0.2355,0.24494,0.2355,0.22606,0.21662,0.20718,0.19775,0.18831,0.17887,0.16943,0.15999,0.15055,0.14112,0.13168,0.12224,0.1128,0.10336,0.09392,0.09392,0.09392,0.09392,0.09392,0.09392,0.09392,0.09392,0.09392,0.09392;-0.10472,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.10852,0.11791,0.12729,0.13668,0.14606,0.15544,0.16483,0.17421,0.1836,0.19298,0.20237,0.21175,0.22113,0.23052,0.2399,0.24929,0.2399,0.23052,0.22113,0.21175,0.20237,0.19298,0.1836,0.17421,0.16483,0.15544,0.14606,0.13668,0.12729,0.11791,0.10852,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001;-0.08727,0.10436,0.10436,0.10436,0.10436,0.10436,0.10436,0.10436,0.10436,0.10436,0.10436,0.11369,0.12302,0.13235,0.14168,0.15101,0.16034,0.16967,0.179,0.18833,0.19765,0.20698,0.21631,0.22564,0.23497,0.2443,0.25363,0.2443,0.23497,0.22564,0.21631,0.20698,0.19765,0.18833,0.179,0.16967,0.16034,0.15101,0.14168,0.13235,0.12302,0.11369,0.10436,0.10436,0.10436,0.10436,0.10436,0.10436,0.10436,0.10436,0.10436,0.10436;-0.06981,0.10958,0.10958,0.10958,0.10958,0.10958,0.10958,0.10958,0.10958,0.10958,0.10958,0.11885,0.12813,0.1374,0.14668,0.15595,0.16523,0.1745,0.18378,0.19305,0.20233,0.2116,0.22088,0.23015,0.23943,0.24871,0.25798,0.24871,0.23943,0.23015,0.22088,0.2116,0.20233,0.19305,0.18378,0.1745,0.16523,0.15595,0.14668,0.1374,0.12813,0.11885,0.10958,0.10958,0.10958,0.10958,0.10958,0.10958,0.10958,0.10958,0.10958,0.10958;-0.05236,0.11479,0.11479,0.11479,0.11479,0.11479,0.11479,0.11479,0.11479,0.11479,0.11479,0.12401,0.13323,0.14246,0.15168,0.1609,0.17012,0.17934,0.18856,0.19778,0.207,0.21622,0.22544,0.23467,0.24389,0.25311,0.26233,0.25311,0.24389,0.23467,0.22544,0.21622,0.207,0.19778,0.18856,0.17934,0.17012,0.1609,0.15168,0.14246,0.13323,0.12401,0.11479,0.11479,0.11479,0.11479,0.11479,0.11479,0.11479,0.11479,0.11479,0.11479;-0.03491,0.12001,0.12001,0.12001,0.12001,0.12001,0.12001,0.12001,0.12001,0.12001,0.12001,0.12918,0.13834,0.14751,0.15668,0.16584,0.17501,0.18418,0.19334,0.20251,0.21168,0.22084,0.23001,0.23918,0.24834,0.25751,0.26668,0.25751,0.24834,0.23918,0.23001,0.22084,0.21168,0.20251,0.19334,0.18418,0.17501,0.16584,0.15668,0.14751,0.13834,0.12918,0.12001,0.12001,0.12001,0.12001,0.12001,0.12001,0.12001,0.12001,0.12001,0.12001;-0.01745,0.12523,0.12523,0.12523,0.12523,0.12523,0.12523,0.12523,0.12523,0.12523,0.12523,0.13434,0.14345,0.15256,0.16168,0.17079,0.1799,0.18901,0.19813,0.20724,0.21635,0.22546,0.23458,0.24369,0.2528,0.26191,0.27102,0.26191,0.2528,0.24369,0.23458,0.22546,0.21635,0.20724,0.19813,0.18901,0.1799,0.17079,0.16168,0.15256,0.14345,0.13434,0.12523,0.12523,0.12523,0.12523,0.12523,0.12523,0.12523,0.12523,0.12523,0.12523;0.0,0.13044,0.13044,0.13044,0.13044,0.13044,0.13044,0.13044,0.13044,0.13044,0.13044,0.1395,0.14856,0.15762,0.16668,0.17573,0.18479,0.19385,0.20291,0.21197,0.22102,0.23008,0.23914,0.2482,0.25726,0.26631,0.27537,0.26631,0.25726,0.2482,0.23914,0.23008,0.22102,0.21197,0.20291,0.19385,0.18479,0.17573,0.16668,0.15762,0.14856,0.1395,0.13044,0.13044,0.13044,0.13044,0.13044,0.13044,0.13044,0.13044,0.13044,0.13044;0.01745,0.12523,0.12523,0.12523,0.12523,0.12523,0.12523,0.12523,0.12523,0.12523,0.12523,0.13434,0.14345,0.15256,0.16168,0.17079,0.1799,0.18901,0.19813,0.20724,0.21635,0.22546,0.23458,0.24369,0.2528,0.26191,0.27102,0.26191,0.2528,0.24369,0.23458,0.22546,0.21635,0.20724,0.19813,0.18901,0.1799,0.17079,0.16168,0.15256,0.14345,0.13434,0.12523,0.12523,0.12523,0.12523,0.12523,0.12523,0.12523,0.12523,0.12523,0.12523;0.03491,0.12001,0.12001,0.12001,0.12001,0.12001,0.12001,0.12001,0.12001,0.12001,0.12001,0.12918,0.13834,0.14751,0.15668,0.16584,0.17501,0.18418,0.19334,0.20251,0.21168,0.22084,0.23001,0.23918,0.24834,0.25751,0.26668,0.25751,0.24834,0.23918,0.23001,0.22084,0.21168,0.20251,0.19334,0.18418,0.17501,0.16584,0.15668,0.14751,0.13834,0.12918,0.12001,0.12001,0.12001,0.12001,0.12001,0.12001,0.12001,0.12001,0.12001,0.12001;0.05236,0.11479,0.11479,0.11479,0.11479,0.11479,0.11479,0.11479,0.11479,0.11479,0.11479,0.12401,0.13323,0.14246,0.15168,0.1609,0.17012,0.17934,0.18856,0.19778,0.207,0.21622,0.22544,0.23467,0.24389,0.25311,0.26233,0.25311,0.24389,0.23467,0.22544,0.21622,0.207,0.19778,0.18856,0.17934,0.17012,0.1609,0.15168,0.14246,0.13323,0.12401,0.11479,0.11479,0.11479,0.11479,0.11479,0.11479,0.11479,0.11479,0.11479,0.11479;0.06981,0.10958,0.10958,0.10958,0.10958,0.10958,0.10958,0.10958,0.10958,0.10958,0.10958,0.11885,0.12813,0.1374,0.14668,0.15595,0.16523,0.1745,0.18378,0.19305,0.20233,0.2116,0.22088,0.23015,0.23943,0.24871,0.25798,0.24871,0.23943,0.23015,0.22088,0.2116,0.20233,0.19305,0.18378,0.1745,0.16523,0.15595,0.14668,0.1374,0.12813,0.11885,0.10958,0.10958,0.10958,0.10958,0.10958,0.10958,0.10958,0.10958,0.10958,0.10958;0.08727,0.10436,0.10436,0.10436,0.10436,0.10436,0.10436,0.10436,0.10436,0.10436,0.10436,0.11369,0.12302,0.13235,0.14168,0.15101,0.16034,0.16967,0.179,0.18833,0.19765,0.20698,0.21631,0.22564,0.23497,0.2443,0.25363,0.2443,0.23497,0.22564,0.21631,0.20698,0.19765,0.18833,0.179,0.16967,0.16034,0.15101,0.14168,0.13235,0.12302,0.11369,0.10436,0.10436,0.10436,0.10436,0.10436,0.10436,0.10436,0.10436,0.10436,0.10436;0.10472,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.10852,0.11791,0.12729,0.13668,0.14606,0.15544,0.16483,0.17421,0.1836,0.19298,0.20237,0.21175,0.22113,0.23052,0.2399,0.24929,0.2399,0.23052,0.22113,0.21175,0.20237,0.19298,0.1836,0.17421,0.16483,0.15544,0.14606,0.13668,0.12729,0.11791,0.10852,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001,0.09914000000000001;0.12217,0.09392,0.09392,0.09392,0.09392,0.09392,0.09392,0.09392,0.09392,0.09392,0.09392,0.10336,0.1128,0.12224,0.13168,0.14112,0.15055,0.15999,0.16943,0.17887,0.18831,0.19775,0.20718,0.21662,0.22606,0.2355,0.24494,0.2355,0.22606,0.21662,0.20718,0.19775,0.18831,0.17887,0.16943,0.15999,0.15055,0.14112,0.13168,0.12224,0.1128,0.10336,0.09392,0.09392,0.09392,0.09392,0.09392,0.09392,0.09392,0.09392,0.09392,0.09392;0.13963,0.08871,0.08871,0.08871,0.08871,0.08871,0.08871,0.08871,0.08871,0.08871,0.08871,0.0982,0.10769,0.11718,0.12668,0.13617,0.14566,0.15515,0.16465,0.17414,0.18363,0.19313,0.20262,0.21211,0.2216,0.2311,0.24059,0.2311,0.2216,0.21211,0.20262,0.19313,0.18363,0.17414,0.16465,0.15515,0.14566,0.13617,0.12668,0.11718,0.10769,0.0982,0.08871,0.08871,0.08871,0.08871,0.08871,0.08871,0.08871,0.08871,0.08871,0.08871;0.15708,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.09304,0.10258,0.11213,0.12168,0.13122,0.14077,0.15032,0.15987,0.16941,0.17896,0.18851,0.19805,0.2076,0.21715,0.22669,0.23624,0.22669,0.21715,0.2076,0.19805,0.18851,0.17896,0.16941,0.15987,0.15032,0.14077,0.13122,0.12168,0.11213,0.10258,0.09304,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999,0.08348999999999999;0.17453,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.08787,0.09747,0.10708,0.11668,0.12628,0.13588,0.14548,0.15508,0.16468,0.17429,0.18389,0.19349,0.20309,0.21269,0.22229,0.23189,0.22229,0.21269,0.20309,0.19349,0.18389,0.17429,0.16468,0.15508,0.14548,0.13588,0.12628,0.11668,0.10708,0.09747,0.08787,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001,0.07827000000000001;0.19199,0.07305,0.07305,0.07305,0.07305,0.07305,0.07305,0.07305,0.07305,0.07305,0.07305,0.08271000000000001,0.09236999999999999,0.10202,0.11168,0.12133,0.13099,0.14064,0.1503,0.15996,0.16961,0.17927,0.18892,0.19858,0.20823,0.21789,0.22755,0.21789,0.20823,0.19858,0.18892,0.17927,0.16961,0.15996,0.1503,0.14064,0.13099,0.12133,0.11168,0.10202,0.09236999999999999,0.08271000000000001,0.07305,0.07305,0.07305,0.07305,0.07305,0.07305,0.07305,0.07305,0.07305,0.07305;0.20944,0.06784,0.06784,0.06784,0.06784,0.06784,0.06784,0.06784,0.06784,0.06784,0.06784,0.07754999999999999,0.08726,0.09697,0.10668,0.11639,0.1261,0.13581,0.14552,0.15523,0.16494,0.17465,0.18436,0.19407,0.20378,0.21349,0.2232,0.21349,0.20378,0.19407,0.18436,0.17465,0.16494,0.15523,0.14552,0.13581,0.1261,0.11639,0.10668,0.09697,0.08726,0.07754999999999999,0.06784,0.06784,0.06784,0.06784,0.06784,0.06784,0.06784,0.06784,0.06784,0.06784;0.22689,0.06262,0.06262,0.06262,0.06262,0.06262,0.06262,0.06262,0.06262,0.06262,0.06262,0.07238,0.08215,0.09191000000000001,0.10168,0.11144,0.12121,0.13097,0.14073,0.1505,0.16026,0.17003,0.17979,0.18956,0.19932,0.20909,0.21885,0.20909,0.19932,0.18956,0.17979,0.17003,0.16026,0.1505,0.14073,0.13097,0.12121,0.11144,0.10168,0.09191000000000001,0.08215,0.07238,0.06262,0.06262,0.06262,0.06262,0.06262,0.06262,0.06262,0.06262,0.06262,0.06262;0.24435,0.0574,0.0574,0.0574,0.0574,0.0574,0.0574,0.0574,0.0574,0.0574,0.0574,0.06722,0.07704,0.08686000000000001,0.09668,0.1065,0.11631,0.12613,0.13595,0.14577,0.15559,0.16541,0.17523,0.18505,0.19487,0.20468,0.2145,0.20468,0.19487,0.18505,0.17523,0.16541,0.15559,0.14577,0.13595,0.12613,0.11631,0.1065,0.09668,0.08686000000000001,0.07704,0.06722,0.0574,0.0574,0.0574,0.0574,0.0574,0.0574,0.0574,0.0574,0.0574,0.0574;0.2618,0.05218,0.05218,0.05218,0.05218,0.05218,0.05218,0.05218,0.05218,0.05218,0.05218,0.06206,0.07192999999999999,0.0818,0.09168,0.10155,0.11142,0.1213,0.13117,0.14104,0.15092,0.16079,0.17066,0.18054,0.19041,0.20028,0.21015,0.20028,0.19041,0.18054,0.17066,0.16079,0.15092,0.14104,0.13117,0.1213,0.11142,0.10155,0.09168,0.0818,0.07192999999999999,0.06206,0.05218,0.05218,0.05218,0.05218,0.05218,0.05218,0.05218,0.05218,0.05218,0.05218;0.27925,0.04697,0.04697,0.04697,0.04697,0.04697,0.04697,0.04697,0.04697,0.04697,0.04697,0.05689,0.06682,0.07675,0.08667999999999999,0.09660000000000001,0.10653,0.11646,0.12639,0.13631,0.14624,0.15617,0.1661,0.17602,0.18595,0.19588,0.20581,0.19588,0.18595,0.17602,0.1661,0.15617,0.14624,0.13631,0.12639,0.11646,0.10653,0.09660000000000001,0.08667999999999999,0.07675,0.06682,0.05689,0.04697,0.04697,0.04697,0.04697,0.04697,0.04697,0.04697,0.04697,0.04697,0.04697;0.29671,0.04175,0.04175,0.04175,0.04175,0.04175,0.04175,0.04175,0.04175,0.04175,0.04175,0.05173,0.06171,0.07169,0.08168,0.09166000000000001,0.10164,0.11162,0.1216,0.13159,0.14157,0.15155,0.16153,0.17151,0.1815,0.19148,0.20146,0.19148,0.1815,0.17151,0.16153,0.15155,0.14157,0.13159,0.1216,0.11162,0.10164,0.09166000000000001,0.08168,0.07169,0.06171,0.05173,0.04175,0.04175,0.04175,0.04175,0.04175,0.04175,0.04175,0.04175,0.04175,0.04175;0.31416,0.03653,0.03653,0.03653,0.03653,0.03653,0.03653,0.03653,0.03653,0.03653,0.03653,0.04657,0.0566,0.06664,0.07668,0.08671,0.09675,0.10679,0.11682,0.12686,0.13689,0.14693,0.15697,0.167,0.17704,0.18708,0.19711,0.18708,0.17704,0.167,0.15697,0.14693,0.13689,0.12686,0.11682,0.10679,0.09675,0.08671,0.07668,0.06664,0.0566,0.04657,0.03653,0.03653,0.03653,0.03653,0.03653,0.03653,0.03653,0.03653,0.03653,0.03653;0.33161,0.03131,0.03131,0.03131,0.03131,0.03131,0.03131,0.03131,0.03131,0.03131,0.03131,0.0414,0.0515,0.06159,0.07167999999999999,0.08177,0.09186,0.10195,0.11204,0.12213,0.13222,0.14231,0.1524,0.16249,0.17258,0.18267,0.19276,0.18267,0.17258,0.16249,0.1524,0.14231,0.13222,0.12213,0.11204,0.10195,0.09186,0.08177,0.07167999999999999,0.06159,0.0515,0.0414,0.03131,0.03131,0.03131,0.03131,0.03131,0.03131,0.03131,0.03131,0.03131,0.03131;0.34907,0.0261,0.0261,0.0261,0.0261,0.0261,0.0261,0.0261,0.0261,0.0261,0.0261,0.03624,0.04639,0.05653,0.06668,0.07682,0.08697000000000001,0.09711,0.10726,0.1174,0.12755,0.13769,0.14784,0.15798,0.16813,0.17827,0.18842,0.17827,0.16813,0.15798,0.14784,0.13769,0.12755,0.1174,0.10726,0.09711,0.08697000000000001,0.07682,0.06668,0.05653,0.04639,0.03624,0.0261,0.0261,0.0261,0.0261,0.0261,0.0261,0.0261,0.0261,0.0261,0.0261;0.36652,0.02088,0.02088,0.02088,0.02088,0.02088,0.02088,0.02088,0.02088,0.02088,0.02088,0.03108,0.04128,0.05148,0.06168,0.07188,0.08208,0.09227,0.10247,0.11267,0.12287,0.13307,0.14327,0.15347,0.16367,0.17387,0.18407,0.17387,0.16367,0.15347,0.14327,0.13307,0.12287,0.11267,0.10247,0.09227,0.08208,0.07188,0.06168,0.05148,0.04128,0.03108,0.02088,0.02088,0.02088,0.02088,0.02088,0.02088,0.02088,0.02088,0.02088,0.02088;0.38397,0.01566,0.01566,0.01566,0.01566,0.01566,0.01566,0.01566,0.01566,0.01566,0.01566,0.02592,0.03617,0.04642,0.05668,0.06693,0.07718,0.08744,0.09769,0.10794,0.1182,0.12845,0.13871,0.14896,0.15921,0.16947,0.17972,0.16947,0.15921,0.14896,0.13871,0.12845,0.1182,0.10794,0.09769,0.08744,0.07718,0.06693,0.05668,0.04642,0.03617,0.02592,0.01566,0.01566,0.01566,0.01566,0.01566,0.01566,0.01566,0.01566,0.01566,0.01566;0.40143,0.01044,0.01044,0.01044,0.01044,0.01044,0.01044,0.01044,0.01044,0.01044,0.01044,0.02075,0.03106,0.04137,0.05168,0.06198,0.07228999999999999,0.08260000000000001,0.09291000000000001,0.10322,0.11352,0.12383,0.13414,0.14445,0.15476,0.16506,0.17537,0.16506,0.15476,0.14445,0.13414,0.12383,0.11352,0.10322,0.09291000000000001,0.08260000000000001,0.07228999999999999,0.06198,0.05168,0.04137,0.03106,0.02075,0.01044,0.01044,0.01044,0.01044,0.01044,0.01044,0.01044,0.01044,0.01044,0.01044;0.41888,0.00523,0.00523,0.00523,0.00523,0.00523,0.00523,0.00523,0.00523,0.00523,0.00523,0.01559,0.02595,0.03631,0.04668,0.05704,0.0674,0.07776,0.08813,0.09848999999999999,0.10885,0.11921,0.12958,0.13994,0.1503,0.16066,0.17102,0.16066,0.1503,0.13994,0.12958,0.11921,0.10885,0.09848999999999999,0.08813,0.07776,0.0674,0.05704,0.04668,0.03631,0.02595,0.01559,0.00523,0.00523,0.00523,0.00523,0.00523,0.00523,0.00523,0.00523,0.00523,0.00523;0.43633,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,0.01043,0.02084,0.03126,0.04168,0.05209,0.06251,0.07292999999999999,0.08334,0.09376,0.10418,0.11459,0.12501,0.13543,0.14584,0.15626,0.16668,0.15626,0.14584,0.13543,0.12501,0.11459,0.10418,0.09376,0.08334,0.07292999999999999,0.06251,0.05209,0.04168,0.03126,0.02084,0.01043,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005;0.45379,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,0.01043,0.02084,0.03126,0.04168,0.05209,0.06251,0.07292999999999999,0.08334,0.09376,0.10418,0.11459,0.12501,0.13543,0.14584,0.15626,0.16668,0.15626,0.14584,0.13543,0.12501,0.11459,0.10418,0.09376,0.08334,0.07292999999999999,0.06251,0.05209,0.04168,0.03126,0.02084,0.01043,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005;0.47124,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,0.01043,0.02084,0.03126,0.04168,0.05209,0.06251,0.07292999999999999,0.08334,0.09376,0.10418,0.11459,0.12501,0.13543,0.14584,0.15626,0.16668,0.15626,0.14584,0.13543,0.12501,0.11459,0.10418,0.09376,0.08334,0.07292999999999999,0.06251,0.05209,0.04168,0.03126,0.02084,0.01043,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005;0.48869,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,0.01043,0.02084,0.03126,0.04168,0.05209,0.06251,0.07292999999999999,0.08334,0.09376,0.10418,0.11459,0.12501,0.13543,0.14584,0.15626,0.16668,0.15626,0.14584,0.13543,0.12501,0.11459,0.10418,0.09376,0.08334,0.07292999999999999,0.06251,0.05209,0.04168,0.03126,0.02084,0.01043,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005;0.50615,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,0.01043,0.02084,0.03126,0.04168,0.05209,0.06251,0.07292999999999999,0.08334,0.09376,0.10418,0.11459,0.12501,0.13543,0.14584,0.15626,0.16668,0.15626,0.14584,0.13543,0.12501,0.11459,0.10418,0.09376,0.08334,0.07292999999999999,0.06251,0.05209,0.04168,0.03126,0.02084,0.01043,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005;0.5236,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,0.01043,0.02084,0.03126,0.04168,0.05209,0.06251,0.07292999999999999,0.08334,0.09376,0.10418,0.11459,0.12501,0.13543,0.14584,0.15626,0.16668,0.15626,0.14584,0.13543,0.12501,0.11459,0.10418,0.09376,0.08334,0.07292999999999999,0.06251,0.05209,0.04168,0.03126,0.02084,0.01043,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005;0.54105,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,0.01043,0.02084,0.03126,0.04168,0.05209,0.06251,0.07292999999999999,0.08334,0.09376,0.10418,0.11459,0.12501,0.13543,0.14584,0.15626,0.16668,0.15626,0.14584,0.13543,0.12501,0.11459,0.10418,0.09376,0.08334,0.07292999999999999,0.06251,0.05209,0.04168,0.03126,0.02084,0.01043,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005;0.55851,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,0.01043,0.02084,0.03126,0.04168,0.05209,0.06251,0.07292999999999999,0.08334,0.09376,0.10418,0.11459,0.12501,0.13543,0.14584,0.15626,0.16668,0.15626,0.14584,0.13543,0.12501,0.11459,0.10418,0.09376,0.08334,0.07292999999999999,0.06251,0.05209,0.04168,0.03126,0.02084,0.01043,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005;0.57596,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,0.01043,0.02084,0.03126,0.04168,0.05209,0.06251,0.07292999999999999,0.08334,0.09376,0.10418,0.11459,0.12501,0.13543,0.14584,0.15626,0.16668,0.15626,0.14584,0.13543,0.12501,0.11459,0.10418,0.09376,0.08334,0.07292999999999999,0.06251,0.05209,0.04168,0.03126,0.02084,0.01043,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005;0.59341,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,0.01043,0.02084,0.03126,0.04168,0.05209,0.06251,0.07292999999999999,0.08334,0.09376,0.10418,0.11459,0.12501,0.13543,0.14584,0.15626,0.16668,0.15626,0.14584,0.13543,0.12501,0.11459,0.10418,0.09376,0.08334,0.07292999999999999,0.06251,0.05209,0.04168,0.03126,0.02084,0.01043,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005;0.61087,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,0.01043,0.02084,0.03126,0.04168,0.05209,0.06251,0.07292999999999999,0.08334,0.09376,0.10418,0.11459,0.12501,0.13543,0.14584,0.15626,0.16668,0.15626,0.14584,0.13543,0.12501,0.11459,0.10418,0.09376,0.08334,0.07292999999999999,0.06251,0.05209,0.04168,0.03126,0.02084,0.01043,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005;1.5708,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,0.01043,0.02084,0.03126,0.04168,0.05209,0.06251,0.07292999999999999,0.08334,0.09376,0.10418,0.11459,0.12501,0.13543,0.14584,0.15626,0.16668,0.15626,0.14584,0.13543,0.12501,0.11459,0.10418,0.09376,0.08334,0.07292999999999999,0.06251,0.05209,0.04168,0.03126,0.02084,0.01043,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005,1e-005]) "AreaFraction factors based on altitude and azimuth. bottoms out before 0 to avoid div by zero errors" annotation(Placement(visible = true, transformation(origin = {-40,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      connect(AreaFraction.y,product1.u2) annotation(Line(points = {{-29,-40},{-15.5102,-40},{-15.5102,34.5578},{7.89116,34.5578},{7.89116,34.5578}}, color = {0,0,127}));
      connect(arrayPitch,AreaFraction.u1) annotation(Line(points = {{-100,-20},{-84.39019999999999,-20},{-84.39019999999999,-32.6829},{-32,-34},{-52,-34}}, color = {0,0,127}));
      connect(arrayYaw,AreaFraction.u2) annotation(Line(points = {{-100,-40},{-88.2927,-40},{-88.2927,-45.3659},{-32,-46},{-52,-46}}, color = {0,0,127}));
      //  product1.u2 = if AreaFraction.y < 0 then 0 else AreaFraction.y;
      connect(product1.y,DNI_out) "DNI after multiplication connected to output of model" annotation(Line(points = {{31,40},{58.5909,40},{58.5909,19.7775},{100,19.7775},{100,20}}));
      connect(DNI_in,product1.u1) "Model input DNI connecting to product" annotation(Line(points = {{-100,80},{-36.3412,80},{-36.3412,45.9827},{8,45.9827},{8,46}}));
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Text(origin = {-4.59,2.51}, extent = {{-72.63,35.36},{72.63,-35.36}}, textString = "DNI x Area Fraction")}));
    end DNIReduction_AreaFraction;
    model ICS_EnvelopeCassette_Twelve "This model in the Envelope Cassette (Double-Skin Facade) that houses the ICSolar Stack and Modules. This presents a building envelope"
      extends ICSolar.Parameters;
      /// Redundant but here to true model
      //  Modelica.Blocks.Sources.CombiTimeTable IC_Data_all(tableOnFile = true, fileName = Path + "20150323\\ICSFdata_DLS.txt", tableName = "DNI_THTFin_vdot", nout = 3, columns = {2, 3, 4}) annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      Integer stackNum_1 = 1;
      Integer stackNum_2 = 2;
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a(medium = mediumHTF) "Thermal fluid inflow port, before heat exchange" annotation(Placement(visible = true, transformation(origin = {-100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-95,-85}, extent = {{-5,-5},{5,5}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput AOI "Angle of incidence" annotation(Placement(visible = true, transformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SunAlt "Altitude of the sun " annotation(Placement(visible = true, transformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SunAzi "Azimuth of the sun " annotation(Placement(visible = true, transformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfaceOrientation annotation(Placement(visible = true, transformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfaceTilt annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput Power_Electric "Electric power generated" annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,60}, extent = {{-20,-20},{20,20}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b(medium = mediumHTF) "Thermal fluid outflow port, after heat exchange" annotation(Placement(visible = true, transformation(origin = {100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      // Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b Power_Heat "Heat power generated" annotation(Placement(visible = true, transformation(origin = {100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      // Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort generated_enthalpy "Placeholder to make" annotation(Placement(visible = false));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature T_indoors(T = Temp_Indoor) annotation(Placement(visible = true, transformation(origin = {-20,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ICSolar.Envelope.CavityHeatBalance cavityheatbalance1 annotation(Placement(visible = true, transformation(origin = {20,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      // ICSolar.Envelope.ICS_GlazingLosses glazingLossesInner(Trans_glaz = 0.76) annotation(Placement(visible = true, transformation(origin = {60, -60}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      ICSolar.Envelope.ICS_GlazingLosses glazingLossesOuter annotation(Placement(visible = true, transformation(origin = {-60,60}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      ICSolar.Envelope.RotationMatrixForSphericalCood rotationmatrixforsphericalcood1 annotation(Placement(visible = true, transformation(origin = {-60,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      // Modelica.Blocks.Interfaces.RealOutput DNI_toIndoors "the DNI that slips past the modules and gets through the interior-side glazing" annotation(Placement(visible = true, transformation(origin = {100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      // ICSolar.Envelope.DNIReduction_AreaFraction dnireduction_areafraction1 annotation(Placement(visible = true, transformation(origin = {-20, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      constant Real GND = 0 annotation(Placement(visible = true, transformation(origin = {-40,0}, extent = {{-25,-25},{25,25}}, rotation = 0)));
      ICSolar.Stack.ICS_Stack_Twelve ics_stack2 annotation(Placement(visible = true, transformation(origin = {40,0}, extent = {{-25,-25},{25,25}}, rotation = 0)));
      //  Modelica.Blocks.Sources.Constant GND(k = 0) = 0 "Ground input for stack power flow, Real" annotation(Placement(visible = true, transformation(origin = {-20, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      ICSolar.Stack.ICS_Stack_Twelve ics_stack1 annotation(Placement(visible = true, transformation(origin = {0,-60}, extent = {{-25,-25},{25,25}}, rotation = 0)));
      //  Real DNI_measured = IC_Data_all.y[1] annotation(Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI_measured "DNI from data file" annotation(Placement(visible = true, transformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "DNI from weather file" annotation(Placement(visible = true, transformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in "Ambient cavity temperature" annotation(Placement(visible = true, transformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput Tcav_measured annotation(Placement(visible = true, transformation(origin = {-60,100}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,90}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedtemperature1 annotation(Placement(visible = true, transformation(origin = {-20,100}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalconductor1(G = 0.2) annotation(Placement(visible = true, transformation(origin = {80,-80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Components.HeatedPipe Tubing(medium = mediumHTF, V_flowLaminar = OneBranchFlow, V_flowNominal = 1e-005, h_g = 0, m = 0.0025, T0 = T_HTF_start, T0fixed = true, dpLaminar = 0.45, dpNominal = 10) annotation(Placement(visible = true, transformation(origin = {40,-80}, extent = {{-10,-10},{10,10}}, rotation = 90)));
    equation
      connect(ics_stack1.flowport_b1,Tubing.flowPort_a) annotation(Line(points = {{25,-60},{28.5063,-60},{28.5063,-90.5359},{39.9088,-90.5359},{39.9088,-90.5359}}, color = {255,0,0}));
      connect(ics_stack2.flowport_a1,Tubing.flowPort_b) annotation(Line(points = {{15,-15},{10.9464,-15},{10.9464,-30.7868},{67.5029,-30.7868},{67.5029,-64.0821},{39.6807,-64.0821},{39.6807,-70.01139999999999},{39.6807,-70.01139999999999}}, color = {255,0,0}));
      connect(Tubing.heatPort,thermalconductor1.port_a) annotation(Line(points = {{50,-80},{50,-80.5017},{70.4675,-80.5017},{70.4675,-80.5017}}, color = {191,0,0}));
      connect(prescribedtemperature1.port,cavityheatbalance1.Tcav_measured) annotation(Line(points = {{-10,100},{-2.657,100},{-2.657,52.657},{10,52.657},{10,53}}, color = {191,0,0}));
      connect(Tcav_measured,prescribedtemperature1.T) annotation(Line(points = {{-60,100},{-32.1256,100},{-32.1256,100},{-32,100}}, color = {0,0,127}));
      //  connect(Tcav_measured, cavityheatbalance1.Tcav_measured) annotation(Line(points = {{-60, 100}, {-0.483092, 100}, {-0.483092, 52.657}, {10, 52.657}, {10, 53}}, color = {191, 0, 0}));
      connect(TAmb_in,cavityheatbalance1.Exterior) annotation(Line(points = {{-100,80},{5.04451,80},{5.04451,65.8754},{10,66},{10,66}}));
      connect(DNI,glazingLossesOuter.DNI) annotation(Line(points = {{-100,60},{-75,60},{-75,64},{-70,69},{-75,69}}));
      //  pre-stacks
      //DNI into cavity
      connect(AOI,glazingLossesOuter.AOI) annotation(Line(points = {{-100,40},{-84,40},{-84,45},{-70,51},{-75,51}}));
      connect(SunAlt,rotationmatrixforsphericalcood1.SunAlt) annotation(Line(points = {{-100,20},{-81.46339999999999,20},{-81.2162,-16.5426},{-69.75279999999999,-16.445},{-70,-16}}, color = {0,0,127}));
      connect(SunAzi,rotationmatrixforsphericalcood1.SunAzi) annotation(Line(points = {{-100,0},{-87.0732,0},{-86.82599999999999,-11.9084},{-69.75279999999999,-12.445},{-70,-12}}, color = {0,0,127}));
      connect(SurfaceOrientation,rotationmatrixforsphericalcood1.SurfaceOrientation) annotation(Line(points = {{-100,-20},{-83.9024,-20},{-83.65519999999999,-20.2011},{-69.75279999999999,-20.445},{-70,-20}}, color = {0,0,127}));
      connect(SurfaceTilt,rotationmatrixforsphericalcood1.SurfaceTilt) annotation(Line(points = {{-100,-40},{-85.60980000000001,-40},{-85.3626,-24.5913},{-69.75279999999999,-24.445},{-70,-24}}, color = {0,0,127}));
      //how much self-shading
      //thermal balance
      connect(T_indoors.port,cavityheatbalance1.Interior) annotation(Line(points = {{-10,60},{-1.48368,60},{-1.48368,55.7864},{10,55.7864},{10,56}}));
      //
      connect(rotationmatrixforsphericalcood1.arrayYaw,ics_stack1.arrayYaw);
      connect(rotationmatrixforsphericalcood1.arrayPitch,ics_stack1.arrayPitch);
      connect(rotationmatrixforsphericalcood1.arrayYaw,ics_stack2.arrayYaw);
      connect(rotationmatrixforsphericalcood1.arrayPitch,ics_stack2.arrayPitch);
      //
      //prep the stacks inputs:
      ics_stack1.Power_in = 0;
      //connect(GND.y, ics_stack1.Power_in) annotation(Line(points = {{-9, -60}, {0.816327, -60}, {0.816327, -20.6803}, {17.1429, -20.6803}, {17.1429, -20.6803}}, color = {0, 0, 127}));
      connect(ics_stack1.Power_out,ics_stack2.Power_in);
      connect(ics_stack2.Power_out,Power_Electric);
      //these two are used with weatherdata input
      //  connect(glazingLossesOuter.SurfDirNor, ics_stack1.DNI);
      // connect(glazingLossesOuter.SurfDirNor, ics_stack2.DNI);
      //
      //these are used with experimental data:
      connect(DNI_measured,ics_stack1.DNI);
      connect(DNI_measured,ics_stack2.DNI);
      connect(ics_stack1.flowport_a1,flowport_a);
      connect(ics_stack2.flowport_b1,flowport_b);
      connect(ics_stack1.TAmb_in,cavityheatbalance1.ICS_Heat);
      connect(ics_stack2.TAmb_in,cavityheatbalance1.ICS_Heat);
      connect(thermalconductor1.port_b,cavityheatbalance1.ICS_Heat);
      connect(stackNum_1,ics_stack1.stackNum);
      connect(stackNum_2,ics_stack2.stackNum);
      //stacks:
      //make the connections between stacks: electrical
      //for i in 1:NumOfStacks - 1 loop
      //connect(ics_stack[i].Power_out, ics_stack[i + 1].Power_in);
      //end for;
      //make the connections for all stacks: Flow in, flow out, shading, heat port (loss)
      //for i in 1:NumOfStacks loop
      // ics_stack[i].StackNumber = i;
      //  connect(rotationmatrixforsphericalcood1.arrayYaw, ics_stack[i].arrayYaw);
      // connect(rotationmatrixforsphericalcood1.arrayPitch, ics_stack[i].arrayPitch);
      //  connect(glazingLossesOuter.SurfDirNor, ics_stack[i].DNI);
      //  connect(ics_stack[i].flowport_a1, flowport_a) annotation(Line(points = {{15, -15}, {5.78072, -15}, {5.78072, -13.5009}, {-100, -13.5009}, {-100, -80}}));
      // connect(ics_stack[i].flowport_b1, flowport_b) annotation(Line(points = {{65, 0}, {80, 0}, {80, -21.2245}, {100, -21.2245}, {100, -20}}, color = {255, 0, 0}));
      // connect(ics_stack[i].TAmb_in, cavityheatbalance1.ICS_Heat) annotation(Line(points = {{15, 20}, {0.593472, 20}, {0.593472, 20.178}, {20, 20.178}, {20, 50}}));
      // end for;
      //after the stacks
    end ICS_EnvelopeCassette_Twelve;
  end Envelope;
  package Stack "Package of all the necessary components to create an Integrated Concentrating Solar simulation"
    extends Modelica.Icons.Package;
    model ICS_Stack "This model represents an individual Integrated Concentrating Solar Stack"
      extends ICSolar.Parameters;
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1(medium = mediumHTF) "Thermal fluid outflow port" annotation(Placement(visible = true, transformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in "Ambient temperature of the cavity" annotation(Placement(visible = true, transformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      output Modelica.Blocks.Interfaces.RealOutput Power_out "Electrical power generated" annotation(Placement(visible = true, transformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1(medium = mediumHTF) "Thermal fluid inflow port" annotation(Placement(visible = true, transformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      input Modelica.Blocks.Interfaces.RealInput Power_in(start = 0) "Power input to stack from (GND?)" annotation(Placement(visible = true, transformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-90,-86}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "DNI in from Envelope (Parent)" annotation(Placement(visible = true, transformation(origin = {-100,26}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-90,46}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayYaw annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayPitch annotation(Placement(visible = true, transformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Module.ICS_Module iCS_Module[StackHeight] annotation(Placement(visible = true, transformation(origin = {25.75,36.25}, extent = {{-18.25,-16.25},{18.25,16.25}}, rotation = 0)));
      Modelica.Blocks.Tables.CombiTable2D Shading11(tableOnFile = true, fileName = "modelica://ICSolar/ShadingTable2014.txt", tableName = "ShadingTable2014");
      Modelica.Blocks.Tables.CombiTable2D Shading21(tableOnFile = true, fileName = "modelica://ICSolar/ShadingTable2014.txt", tableName = "ShadingTable2014");
      Modelica.Blocks.Tables.CombiTable2D Shading31(tableOnFile = true, fileName = "modelica://ICSolar/ShadingTable2014.txt", tableName = "ShadingTable2014");
      Modelica.Blocks.Tables.CombiTable2D Shading41(tableOnFile = true, fileName = "modelica://ICSolar/ShadingTable2014.txt", tableName = "ShadingTable2014");
      Modelica.Blocks.Tables.CombiTable2D Shading51(tableOnFile = true, fileName = "modelica://ICSolar/ShadingTable2014.txt", tableName = "ShadingTable2014");
      Modelica.Blocks.Tables.CombiTable2D Shading61(tableOnFile = true, fileName = "modelica://ICSolar/ShadingTable2014.txt", tableName = "ShadingTable2014");
      Modelica.Blocks.Tables.CombiTable2D Shading1(tableOnFile = true, fileName = "modelica://ICSolar/shading/ICSF_shading_matrices_studio.txt", tableName = "1");
      Modelica.Blocks.Math.Product product11 "Multiplication of DNI and shading factor";
      Modelica.Blocks.Math.Product product21 "Multiplication of DNI and shading factor";
      Modelica.Blocks.Math.Product product31 "Multiplication of DNI and shading factor";
      Modelica.Blocks.Math.Product product41 "Multiplication of DNI and shading factor";
      Modelica.Blocks.Math.Product product51 "Multiplication of DNI and shading factor";
      Modelica.Blocks.Math.Product product61 "Multiplication of DNI and shading factor";
    equation
      //make the connections between modules: electrical and flow
      for i in 1:StackHeight - 1 loop
      connect(iCS_Module[i].flowport_b1,iCS_Module[i + 1].flowport_a1);
      connect(iCS_Module[i].Power_out,iCS_Module[i + 1].Power_in);

      end for;
      //make the connections between modules and the world: DNI, T_ambient
      for i in 1:StackHeight loop
      //chooseshadematrix1[i].ModuleColumn = 1;
      //chooseshadematrix1[i].ModuleRow = 1;
      //shading1[i].ShadingTable = chooseshadematrix1[i].ShadeMatrixEnum;
      //connect(arrayYaw, shading1[i].arrayYaw);
      //connect(arrayPitch, shading1[i].arrayPitch);
      //connect(DNI, shading1[i].DNI_in);
      //connect(shading1[i].DNI_out, iCS_Module[i].DNI);
      connect(iCS_Module[i].TAmb_in,TAmb_in);

      end for;
      connect(iCS_Module[1].flowport_a1,flowport_a1);
      connect(iCS_Module[StackHeight].flowport_b1,flowport_b1);
      connect(iCS_Module[1].Power_in,Power_in);
      connect(iCS_Module[StackHeight].Power_out,Power_out);
      //Manual connection of shading matrixes and products
      //Module1
      product11.u2 = if Shading11.y < 0 then 0 else Shading11.y;
      connect(product11.y,iCS_Module[1].DNI) "DNI after multiplication connected to output of model";
      connect(DNI,product11.u1) "Model input DNI connecting to product";
      connect(arrayYaw,Shading11.u2);
      connect(arrayPitch,Shading11.u1);
      //Module2
      product21.u2 = if Shading21.y < 0 then 0 else Shading21.y;
      connect(product21.y,iCS_Module[2].DNI) "DNI after multiplication connected to output of model";
      connect(DNI,product21.u1) "Model input DNI connecting to product";
      connect(arrayYaw,Shading21.u2);
      connect(arrayPitch,Shading21.u1);
      //Module3
      product31.u2 = if Shading31.y < 0 then 0 else Shading31.y;
      connect(product31.y,iCS_Module[3].DNI) "DNI after multiplication connected to output of model";
      connect(DNI,product31.u1) "Model input DNI connecting to product";
      connect(arrayYaw,Shading31.u2);
      connect(arrayPitch,Shading31.u1);
      //Module4
      product41.u2 = if Shading41.y < 0 then 0 else Shading41.y;
      connect(product41.y,iCS_Module[4].DNI) "DNI after multiplication connected to output of model";
      connect(DNI,product41.u1) "Model input DNI connecting to product";
      connect(arrayYaw,Shading41.u2);
      connect(arrayPitch,Shading41.u1);
      //Module5
      product51.u2 = if Shading51.y < 0 then 0 else Shading51.y;
      connect(product51.y,iCS_Module[5].DNI) "DNI after multiplication connected to output of model";
      connect(DNI,product51.u1) "Model input DNI connecting to product";
      connect(arrayYaw,Shading51.u2);
      connect(arrayPitch,Shading51.u1);
      //Module6
      product61.u2 = if Shading61.y < 0 then 0 else Shading61.y;
      connect(product61.y,iCS_Module[6].DNI) "DNI after multiplication connected to output of model";
      connect(DNI,product61.u1) "Model input DNI connecting to product";
      connect(arrayYaw,Shading61.u2);
      connect(arrayPitch,Shading61.u1);
      annotation(Placement(transformation(extent = {{-10,64},{10,84}})), Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2,2}), graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}, fillPattern = FillPattern.VerticalCylinder, fillColor = {215,215,215}),Text(origin = {0.95,5.29}, extent = {{-61.06,40.08},{61.06,-40.08}}, textString = "Stack"),Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0})}), experiment(StartTime = 0, StopTime = 315360, Tolerance = 1e-006, Interval = 3710.12), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2,2}), graphics = {Rectangle(origin = {0,-0.288066}, extent = {{-100,100},{100,-100}})}));
    end ICS_Stack;
    model ICS_Stack2 "This model represents an individual Integrated Concentrating Solar Stack"
      extends ICSolar.Parameters;
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1(medium = mediumHTF) "Thermal fluid outflow port" annotation(Placement(visible = true, transformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in "Ambient temperature of the cavity" annotation(Placement(visible = true, transformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      output Modelica.Blocks.Interfaces.RealOutput Power_out "Electrical power generated" annotation(Placement(visible = true, transformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1(medium = mediumHTF) "Thermal fluid inflow port" annotation(Placement(visible = true, transformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      input Modelica.Blocks.Interfaces.RealInput Power_in(start = 0) "Power input to stack from (GND?)" annotation(Placement(visible = true, transformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-90,-86}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "DNI in from Envelope (Parent)" annotation(Placement(visible = true, transformation(origin = {-100,26}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-90,46}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayYaw annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayPitch annotation(Placement(visible = true, transformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Module.ICS_Module iCS_Module[StackHeight] annotation(Placement(visible = true, transformation(origin = {25.75,36.25}, extent = {{-18.25,-16.25},{18.25,16.25}}, rotation = 0)));
      Modelica.Blocks.Tables.CombiTable2D Shading12(tableOnFile = true, fileName = "modelica://ICSolar/ShadingTable2014.txt", tableName = "ShadingTable2014");
      Modelica.Blocks.Tables.CombiTable2D Shading22(tableOnFile = true, fileName = "modelica://ICSolar/ShadingTable2014.txt", tableName = "ShadingTable2014");
      Modelica.Blocks.Tables.CombiTable2D Shading32(tableOnFile = true, fileName = "modelica://ICSolar/ShadingTable2014.txt", tableName = "ShadingTable2014");
      Modelica.Blocks.Tables.CombiTable2D Shading42(tableOnFile = true, fileName = "modelica://ICSolar/ShadingTable2014.txt", tableName = "ShadingTable2014");
      Modelica.Blocks.Tables.CombiTable2D Shading52(tableOnFile = true, fileName = "modelica://ICSolar/ShadingTable2014.txt", tableName = "ShadingTable2014");
      Modelica.Blocks.Tables.CombiTable2D Shading62(tableOnFile = true, fileName = "modelica://ICSolar/ShadingTable2014.txt", tableName = "ShadingTable2014");
      //  Modelica.Blocks.Tables.CombiTable2D Shading12(tableOnFile = true, fileName = "modelica://ICSolar/shading/ICSF_shading_matrices_studio.txt", tableName = "7");
      //  Modelica.Blocks.Tables.CombiTable2D Shading22(tableOnFile = true, fileName = "modelica://ICSolar/shading/ICSF_shading_matrices_studio.txt", tableName = "8");
      //  Modelica.Blocks.Tables.CombiTable2D Shading32(tableOnFile = true, fileName = "modelica://ICSolar/shading/ICSF_shading_matrices_studio.txt", tableName = "9");
      //  Modelica.Blocks.Tables.CombiTable2D Shading42(tableOnFile = true, fileName = "modelica://ICSolar/shading/ICSF_shading_matrices_studio.txt", tableName = "10");
      //  Modelica.Blocks.Tables.CombiTable2D Shading52(tableOnFile = true, fileName = "modelica://ICSolar/shading/ICSF_shading_matrices_studio.txt", tableName = "11");
      //  Modelica.Blocks.Tables.CombiTable2D Shading62(tableOnFile = true, fileName = "modelica://ICSolar/shading/ICSF_shading_matrices_studio.txt", tableName = "12");
      Modelica.Blocks.Math.Product product1 "Multiplication of DNI and shading factor";
      Modelica.Blocks.Math.Product product2 "Multiplication of DNI and shading factor";
      Modelica.Blocks.Math.Product product3 "Multiplication of DNI and shading factor";
      Modelica.Blocks.Math.Product product4 "Multiplication of DNI and shading factor";
      Modelica.Blocks.Math.Product product5 "Multiplication of DNI and shading factor";
      Modelica.Blocks.Math.Product product6 "Multiplication of DNI and shading factor";
    equation
      //make the connections between modules: electrical and flow
      for i in 1:StackHeight - 1 loop
      connect(iCS_Module[i].flowport_b1,iCS_Module[i + 1].flowport_a1);
      connect(iCS_Module[i].Power_out,iCS_Module[i + 1].Power_in);

      end for;
      //make the connections between modules and the world: DNI, T_ambient
      for i in 1:StackHeight loop
      //chooseshadematrix1[i].ModuleColumn = 1;
      //chooseshadematrix1[i].ModuleRow = 1;
      //shading1[i].ShadingTable = chooseshadematrix1[i].ShadeMatrixEnum;
      //connect(arrayYaw, shading1[i].arrayYaw);
      //connect(arrayPitch, shading1[i].arrayPitch);
      //connect(DNI, shading1[i].DNI_in);
      //connect(shading1[i].DNI_out, iCS_Module[i].DNI);
      connect(iCS_Module[i].TAmb_in,TAmb_in);

      end for;
      connect(iCS_Module[1].flowport_a1,flowport_a1);
      connect(iCS_Module[StackHeight].flowport_b1,flowport_b1);
      connect(iCS_Module[1].Power_in,Power_in);
      connect(iCS_Module[StackHeight].Power_out,Power_out);
      //Manual connection of shading matrixes and products
      //Module1
      product1.u2 = if Shading12.y < 0 then 0 else Shading12.y;
      connect(product1.y,iCS_Module[1].DNI) "DNI after multiplication connected to output of model";
      connect(DNI,product1.u1) "Model input DNI connecting to product";
      connect(arrayYaw,Shading12.u2);
      connect(arrayPitch,Shading12.u1);
      //Module2
      product2.u2 = if Shading22.y < 0 then 0 else Shading22.y;
      connect(product2.y,iCS_Module[2].DNI) "DNI after multiplication connected to output of model";
      connect(DNI,product2.u1) "Model input DNI connecting to product";
      connect(arrayYaw,Shading22.u2);
      connect(arrayPitch,Shading22.u1);
      //Module3
      product3.u2 = if Shading32.y < 0 then 0 else Shading32.y;
      connect(product3.y,iCS_Module[3].DNI) "DNI after multiplication connected to output of model";
      connect(DNI,product3.u1) "Model input DNI connecting to product";
      connect(arrayYaw,Shading32.u2);
      connect(arrayPitch,Shading32.u1);
      //Module4
      product4.u2 = if Shading42.y < 0 then 0 else Shading42.y;
      connect(product4.y,iCS_Module[4].DNI) "DNI after multiplication connected to output of model";
      connect(DNI,product4.u1) "Model input DNI connecting to product";
      connect(arrayYaw,Shading42.u2);
      connect(arrayPitch,Shading42.u1);
      //Module5
      product5.u2 = if Shading52.y < 0 then 0 else Shading52.y;
      connect(product5.y,iCS_Module[5].DNI) "DNI after multiplication connected to output of model";
      connect(DNI,product5.u1) "Model input DNI connecting to product";
      connect(arrayYaw,Shading52.u2);
      connect(arrayPitch,Shading52.u1);
      //Module6
      product6.u2 = if Shading62.y < 0 then 0 else Shading62.y;
      connect(product6.y,iCS_Module[6].DNI) "DNI after multiplication connected to output of model";
      connect(DNI,product6.u1) "Model input DNI connecting to product";
      connect(arrayYaw,Shading62.u2);
      connect(arrayPitch,Shading62.u1);
      annotation(Placement(transformation(extent = {{-10,64},{10,84}})), Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2,2}), graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}, fillPattern = FillPattern.VerticalCylinder, fillColor = {215,215,215}),Text(origin = {0.95,5.29}, extent = {{-61.06,40.08},{61.06,-40.08}}, textString = "Stack"),Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0})}), experiment(StartTime = 0, StopTime = 315360, Tolerance = 1e-006, Interval = 3710.12), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2,2}), graphics = {Rectangle(origin = {0,-0.288066}, extent = {{-100,100},{100,-100}})}));
    end ICS_Stack2;
    model Shading
      Modelica.Blocks.Interfaces.RealOutput DNI_out "DNI after shading factor multiplication" annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Math.Product product1 "Multiplication of DNI and shading factor" annotation(Placement(visible = true, transformation(origin = {20,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      parameter Modelica.Blocks.Interfaces.IntegerInput ShadingTable annotation(Placement(visible = true, transformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      //for picking different shading matrices:
      //  final parameter String ShadingName = String(ShadingTable);
      Modelica.Blocks.Tables.CombiTable2D Shading_matrix(tableOnFile = true, fileName = "modelica://ICSolar/ShadingTable2014.txt", tableName = ShadingName) annotation(Placement(visible = true, transformation(origin = {-40,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayPitch "pitch (up/down) angle of 2axis tracking array (rads)" annotation(Placement(visible = true, transformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayYaw "yaw (left/right) angle of tracking array (in radians)" annotation(Placement(visible = true, transformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI_in "DNI in before shading factor multiplication" annotation(Placement(visible = true, transformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      product1.u2 = if Shading_matrix.y < 0 then 0 else Shading_matrix.y;
      connect(product1.y,DNI_out) "DNI after multiplication connected to output of model" annotation(Line(points = {{31,40},{58.5909,40},{58.5909,19.7775},{100,19.7775},{100,20}}));
      connect(DNI_in,product1.u1) "Model input DNI connecting to product" annotation(Line(points = {{-100,80},{-36.3412,80},{-36.3412,45.9827},{8,45.9827},{8,46}}));
      connect(arrayYaw,Shading_matrix.u2);
      connect(arrayPitch,Shading_matrix.u1);
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Text(origin = {-4.59,2.51}, extent = {{-72.63,35.36},{72.63,-35.36}}, textString = "Self Shading")}), Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
    end Shading;
    model ICS_Stack_Twelve "This model represents an individual Integrated Concentrating Solar Stack"
      extends ICSolar.Parameters;
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1(medium = mediumHTF) "Thermal fluid outflow port" annotation(Placement(visible = true, transformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      output Modelica.Blocks.Interfaces.RealOutput Power_out "Electrical power generated" annotation(Placement(visible = true, transformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1(medium = mediumHTF) "Thermal fluid inflow port" annotation(Placement(visible = true, transformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      input Modelica.Blocks.Interfaces.RealInput Power_in(start = 0) "Power input to stack from (GND?)" annotation(Placement(visible = true, transformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-90,-86}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "DNI in from Envelope (Parent)" annotation(Placement(visible = true, transformation(origin = {-100,26}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-90,46}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayYaw annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayPitch annotation(Placement(visible = true, transformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      //  Modelica.Blocks.Tables.CombiTable2D Shading11(tableOnFile = true, fileName = "modelica://ICSolar/ShadingTable2014.txt", tableName = "ShadingTable2014");
      ICSolar.Module.ICS_Module_Twelve ICS_Module_Twelve_1[StackHeight] annotation(Placement(visible = true, transformation(origin = {-60,-80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.IntegerInput stackNum annotation(Placement(visible = true, transformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in "Ambient temperature of the cavity" annotation(Placement(visible = true, transformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      //make the connections between modules: electrical and flow
      //  for i in 1:StackHeight - 1 loop
      //  connect(ICS_Module_Twelve_1[i].flowport_b1,ICS_Module_Twelve_1[i + 1].flowport_a1);
      //  connect(ICS_Module_Twelve_1[i].Power_out,ICS_Module_Twelve_1[i + 1].Power_in);
      for i in 1:StackHeight - 1 loop
      connect(ICS_Module_Twelve_1[StackHeight + 1 - i].flowport_b1,ICS_Module_Twelve_1[StackHeight - i].flowport_a1);
      connect(ICS_Module_Twelve_1[StackHeight + 1 - i].Power_out,ICS_Module_Twelve_1[StackHeight - i].Power_in);

      end for;
      //make the connections between modules and the world: DNI, T_ambient, pitch, yaw
      for i in 1:StackHeight loop
      connect(ICS_Module_Twelve_1[i].DNI,DNI);
      connect(ICS_Module_Twelve_1[i].arrayPitch,arrayPitch);
      connect(ICS_Module_Twelve_1[i].arrayYaw,arrayYaw);
      connect(ICS_Module_Twelve_1[i].TAmb_in,TAmb_in);
      ICS_Module_Twelve_1[StackHeight + 1 - i].modNum = i + (stackNum - 1) * StackHeight;

      end for;
      ///////////Legacy from reversed plumbing
      //connect the inlets and outlets of the stack
      //  connect(ICS_Module_Twelve_1[1].flowport_a1,flowport_a1);
      //  connect(ICS_Module_Twelve_1[StackHeight].flowport_b1,flowport_b1);
      //  connect(ICS_Module_Twelve_1[1].Power_in,Power_in);
      //  connect(ICS_Module_Twelve_1[StackHeight].Power_out,Power_out);
      connect(ICS_Module_Twelve_1[StackHeight].flowport_a1,flowport_a1);
      connect(ICS_Module_Twelve_1[1].flowport_b1,flowport_b1);
      connect(ICS_Module_Twelve_1[StackHeight].Power_in,Power_in);
      connect(ICS_Module_Twelve_1[1].Power_out,Power_out);
      //annotation
      annotation(Placement(transformation(extent = {{-10,64},{10,84}})), Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2,2}), graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}, fillPattern = FillPattern.VerticalCylinder, fillColor = {215,215,215}),Text(origin = {0.95,5.29}, extent = {{-61.06,40.08},{61.06,-40.08}}, textString = "Stack"),Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0})}), experiment(StartTime = 0, StopTime = 315360, Tolerance = 1e-006, Interval = 3710.12), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2,2}), graphics = {Rectangle(origin = {0,-0.288066}, extent = {{-100,100},{100,-100}})}));
    end ICS_Stack_Twelve;
  end Stack;
  package Module "Package of all the necessary components to create an Integrated Concentrating Solar simulation"
    extends Modelica.Icons.Package;
    model ICS_Module "This model contains all the components and equations that simulate one module of Integrated Concentrating Solar"
      extends ICSolar.Parameters;
      parameter Modelica.SIunits.Length LensWidth = 0.25019 "Width of Fresnel Lens, meters";
      parameter Modelica.SIunits.Length CellWidth = 0.01 "Width of the PV cell, meters";
      //  parameter String FresMat = "PMMA" "'PMMA' or 'Silicon on Glass', use the exact spellings provided";
      //  parameter Real FNum = 0.85 "FNum determines the lens transmittance based on concentrating";
      //  Integer FMatNum "Integer used to pipe the material to other models";
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1(medium = mediumHTF) "Outflow port of the thermal fluid (to Parent)" annotation(Placement(visible = true, transformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1(medium = mediumHTF) "Inflow port of the thermal fluid (from Parent)" annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "DNI into the Module" annotation(Placement(visible = true, transformation(origin = {-100,18}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,18}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in "Ambient temperature of the cavity into Module model for use in the heat receiver" annotation(Placement(visible = true, transformation(origin = {-100,78}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,78}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      input Modelica.Blocks.Interfaces.RealInput Power_in "electrical power in from previous module or GND" annotation(Placement(visible = true, transformation(origin = {-100,46}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,46}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput Power_out "Electrical generation outflow (to Parent)" annotation(Placement(visible = true, transformation(origin = {100,54}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,54}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ICSolar.Module.ICS_LensLosses ics_lenslosses1 annotation(Placement(visible = true, transformation(origin = {-60,-2}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      ICSolar.Module.ICS_PVPerformance ics_pvperformance1 annotation(Placement(visible = true, transformation(origin = {0,0}, extent = {{-16.25,-16.25},{16.25,16.25}}, rotation = 0)));
      Modelica.Blocks.Math.Add add annotation(Placement(transformation(extent = {{36,32},{46,42}})));
      ICSolar.Receiver.moduleReceiver modulereceiver1 "Heat Receiver to calculate the heat transfer between heat gen and heat transfered to thermal fluid" annotation(Placement(visible = true, transformation(origin = {60,0}, extent = {{-15,-8.571440000000001},{15,21.4286}}, rotation = 0)));
    equation
      connect(modulereceiver1.flowport_b1,flowport_b1) annotation(Line(points = {{75,10.7143},{86.535,10.7143},{86.535,-40.2154},{99.4614,-40.2154},{99.4614,-40.2154}}, color = {255,0,0}));
      connect(TAmb_in,modulereceiver1.TAmb_in) annotation(Line(points = {{-100,78},{-2.90276,78},{-2.90276,13.0624},{50,18.2143},{45,18.2143}}));
      connect(ics_pvperformance1.ThermalGen,modulereceiver1.ThermalGen) annotation(Line(points = {{16.25,-7.3125},{45.38,-7.3125},{45.38,6.04915},{50,10.7143},{45,10.7143}}));
      connect(modulereceiver1.flowport_a1,flowport_a1) annotation(Line(points = {{57,21.4286},{39.4366,21.4286},{39.4366,-40.1408},{-100,-40.1408},{-100,-40}}));
      connect(ics_lenslosses1.ConcentrationFactor,ics_pvperformance1.ConcentrationFactor) annotation(Line(points = {{-45,-11},{-39.3195,-11},{-39.3195,-9.82987},{-16.25,-9.82987},{-16.25,-9.75}}));
      connect(ics_lenslosses1.DNI_out,ics_pvperformance1.DNI_in) annotation(Line(points = {{-45,4},{-34.4045,4},{-34.4045,0.378072},{-16.25,0.378072},{-16.25,0}}));
      connect(DNI,ics_lenslosses1.DNI_in) annotation(Line(points = {{-100,18},{-75,18},{-75,7}}));
      //  if FresMat == "PMMA" then
      //    FMatNum = 1;
      //  elseif FresMat == "Silicon on Glass" then
      //    FMatNum = 2;
      //  else
      //  end if;
      //  ics_lens1.FMat = FMatNum "Connects FMatNum calculated in Module to Lens FMat input";
      ics_lenslosses1.LensWidth = LensWidth "Connects LensWidth defined in Module to Lens LensWidth";
      ics_lenslosses1.CellWidth = CellWidth "Connect CellWidth defined in Module to CellWidth in Lens";
      // ics_pvperformance1.CellWidth = CellWidth "Connect CellWidth defined in Module to CellWidth in PVPerformance for EIPC calc on Cell";
      // ics_lens1.FNum = FNum "Connects the FNumber defined in Module to FNum in Lens for concentration and transmission equations";
      connect(Power_in,add.u1) annotation(Line(points = {{-100,46},{-28,46},{-28,40},{35,40}}, color = {0,0,127}, smooth = Smooth.None));
      connect(ics_pvperformance1.ElectricalGen,add.u2) annotation(Line(points = {{16.25,6.5},{16.25,31.25},{35,31.25},{35,34}}, color = {0,0,127}, smooth = Smooth.None));
      connect(add.y,Power_out) annotation(Line(points = {{46.5,37},{69.25,37},{69.25,54},{100,54}}, color = {0,0,127}, smooth = Smooth.None));
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Text(origin = {-1.41,9.98}, extent = {{-67.14,46.6},{67.14,-46.6}}, textString = "Module")}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
    end ICS_Module;
    model ICS_Lens "This model does the concentrating lens calculations: transmission losses and concentration. DNI_out is the DNI after concentration"
      Modelica.Blocks.Interfaces.RealInput DNI_in "DNI in from Module (Parent)" annotation(Placement(visible = true, transformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput FNum "F Number of concentrating Lens" annotation(Placement(visible = false, transformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput LensWidth "Width of Concentrating Lens" annotation(Placement(visible = false, transformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput CellWidth "Width of PV Cell" annotation(Placement(visible = false, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.IntegerInput FMat "Integer describing lens material and selecting tran losses equation accordingly" annotation(Placement(visible = false, transformation(origin = {-100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Real ModuleDepth = LensWidth * sqrt(2) * FNum;
      Real LensTrans "Lens transmittance variable";
      Modelica.Blocks.Interfaces.RealOutput DNI_out "Output DNI after Lens manipulation (including concentration)" annotation(Placement(visible = true, transformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput ConcentrationFactor = LensWidth ^ 2 / CellWidth ^ 2 "Concentration Factor determined from area of Lens in relation to area of Cell" annotation(Placement(visible = true, transformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      if FMat == 1 then
        LensTrans = ((-20.833 * FNum ^ 3) - 23.214 * FNum ^ 2 + 106.1 * FNum + 23.207) / 100;
      else
        LensTrans = ((-104.17 * FNum ^ 3) + 171.43 * FNum ^ 2 - 40.744 * FNum + 57.236) / 100;
      end if;
      DNI_out = DNI_in * LensTrans * ConcentrationFactor "Calculating DNI after Lens Transmission Losses and Lens Concentration";
    end ICS_Lens;
    model ICS_PVPerformance "This model uses the EIPC (based on cell area) and PVEfficiency (based on ConcentrationFactor) to calculate the ElectricalGen and ThermalGen"
      extends ICSolar.Parameters;
      //
      //##############################################################################
      // parameter Real Eta_Observed = Exp_Observed "From ICSolar.Parameters, observed electrical efficiency of ICSFg8";
      // parameter Real Eta_nom_tweak = Exp_nom_tweak "From ICSolar.Parameters, matching the observed to modeled data, compensating for temperature 'unknown'. 0.364 matches the Nov25-13 data well when eta_observed is 0.215. set same as eta_obs for full-strength output.";
      Real CellWidth = 0.01 "Width of the PV Cell";
      Real CellEfficiency = 0.36436 + (52.5 - (ThermalGen.T - 273.15)) * 0.0005004 + (ConcentrationFactor - 627.5) * 1.9965e-006;
      //* Exp_Observed / Exp_nom_tweak "Equation to determine the PVEfficiency from the ConcentrationFactor and Cell Temperature";
      Real EIPC "Energy In Per Cell";
      //
      //##############################################################################
      Modelica.Blocks.Interfaces.RealOutput ElectricalGen "Real output for piping the generated electrical energy out" annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-25,-25},{25,25}}, rotation = 0), iconTransformation(origin = {100,40}, extent = {{-25,-25},{25,25}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b ThermalGen "Output heat port to pipe the generated heat out and to the heat receiver" annotation(Placement(visible = true, transformation(origin = {100,-60}, extent = {{-15,-15},{15,15}}, rotation = 0), iconTransformation(origin = {100,-45}, extent = {{-25,-25},{25,25}}, rotation = 0)));
      //Modelica.Blocks.Interfaces.IntegerInput modNum annotation(Placement(visible = true, transformation(origin = {-100,80}, extent = {{-25,-25},{25,25}}, rotation = 0), iconTransformation(origin = {-80,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput ConcentrationFactor "Used to represent 'suns's for the calculation of PVEfficiency" annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-25,-25},{25,25}}, rotation = 0), iconTransformation(origin = {-100,-60}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI_in "DNI in from the Lens model (include Concentration)" annotation(Placement(visible = true, transformation(origin = {-100,0}, extent = {{-25,-25},{25,25}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput PV_on annotation(Placement(visible = true, transformation(origin = {-100,40}, extent = {{-25,-25},{25,25}}, rotation = 0), iconTransformation(origin = {-40,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      //##############################################################################
    equation
      EIPC = DNI_in * CellWidth ^ 2 "Energy In Per Cell, used to calculate maximum energy on the cell";
      ElectricalGen = EIPC * CellEfficiency * PV_on "Electrical energy conversion";
      ThermalGen.Q_flow = -1 * (EIPC - ElectricalGen);
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Text(origin = {-3.11195,-3.79298}, extent = {{-63.55,45.8},{63.55,-45.8}}, textString = "PV Performance")}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
    end ICS_PVPerformance;
    model ICS_LensLosses "This model does the concentrating lens calculations: transmission losses and concentration. DNI_out is the DNI after concentration"
      extends ICSolar.Parameters;
      parameter Real Eff_Optic = OpticalEfficiency "Optical efficiency of the concentrating lens and optical device before the photovoltaic cell, value comes from ICSolar.Parameter";
      Modelica.Blocks.Interfaces.RealInput LensWidth annotation(Placement(visible = false, transformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput CellWidth annotation(Placement(visible = false, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput DNI_out annotation(Placement(visible = true, transformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput ConcentrationFactor = LensWidth ^ 2 / CellWidth ^ 2 annotation(Placement(visible = true, transformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI_in annotation(Placement(visible = true, transformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      DNI_out = DNI_in * Eff_Optic * ConcentrationFactor;
      annotation(Documentation(info = "<HTML>
                                                                                                                                                                                 <p><b> Tramission losses associated with the lens / optic elements. Ratio of power on the cell to power on the entry aperture.</b></p>

                                                                                                                                                                                 <p>Optical efficiency from LBI Benitez <b>High performance Fresnel-based photovoltaic concentrator</b> where Eff_Opt(F#). Assuming anti-reflective coating on secondary optic element (SOE), current Gen8 module design Eff_Opt(0.84) = 88.2%</p> 

                                                                                                                                                                                 <b>More Information:</b>
                                                                                                                                                                                 <p> The F-number for a Fresnal-Köhler lens is the ratio of the distance between cell and Fresenel lens to the diagonal measurement of the front lens. The concentrator optical efficiency is defined as the ratio of power on the cell to the power on the entry aperture when the sun is exactly on-axis.</p>
                                                                                                                                                                                 </HTML>"), Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Text(origin = {0.694127,36.2079}, extent = {{-72.52,54.46},{72.52,-54.46}}, textString = "Lens Losses")}));
    end ICS_LensLosses;
    model chooseShadeMatrix "based on a module's position in an array, choose it's shading matrix. Two modes of operation, based on the value of the isStudioExperiment boolean flag in Parameters"
      //  extends ICSolar.Envelope.ICS_EnvelopeCassette;
      //  extends ICSolar.Stack.ICS_Stack;
      extends ICSolar.Parameters;
      //  input String TestOutString (start = "initttt");
      output Modelica.Blocks.Interfaces.IntegerOutput ShadeMatrixEnum "Enumeration of shading matrix" annotation(Placement(visible = true, transformation(origin = {60,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-90,-86}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      parameter Modelica.Blocks.Interfaces.IntegerInput ModuleColumn "Module Column" annotation(Placement(visible = true, transformation(origin = {-60,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-90,-86}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      parameter Modelica.Blocks.Interfaces.IntegerInput ModuleRow "Module Row" annotation(Placement(visible = true, transformation(origin = {-60,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-90,-86}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    algorithm
      //step through the rows outer and columns inner, assigning shadeMatrix enumeration
      if isStudioExperiment then 
        if ModuleRow == 1 then 
          if ModuleColumn == 1 then 
            ShadeMatrixEnum:=11;
          elseif ModuleColumn == 2 then
            ShadeMatrixEnum:=12;
          else

          end if;
        elseif ModuleRow == 2 then
          if ModuleColumn == 1 then 
            ShadeMatrixEnum:=21;
          elseif ModuleColumn == 2 then
            ShadeMatrixEnum:=22;
          else

          end if;

        elseif ModuleRow == 3 then
          if ModuleColumn == 1 then 
            ShadeMatrixEnum:=31;
          elseif ModuleColumn == 2 then
            ShadeMatrixEnum:=32;
          else

          end if;

        elseif ModuleRow == 4 then
          if ModuleColumn == 1 then 
            ShadeMatrixEnum:=41;
          elseif ModuleColumn == 2 then
            ShadeMatrixEnum:=42;
          else

          end if;

        elseif ModuleRow == 5 then
          if ModuleColumn == 1 then 
            ShadeMatrixEnum:=51;
          elseif ModuleColumn == 2 then
            ShadeMatrixEnum:=52;
          else

          end if;

        elseif ModuleRow == 6 then
          if ModuleColumn == 1 then 
            ShadeMatrixEnum:=61;
          elseif ModuleColumn == 2 then
            ShadeMatrixEnum:=62;
          else

          end if;
        else

        end if;
      else
        if ModuleRow == 1 then 
          if ModuleColumn == 1 then 
            ShadeMatrixEnum:=11;
          elseif ModuleColumn == 2 then
            ShadeMatrixEnum:=12;

          elseif ModuleColumn == NumOfStacks - 1 then
            ShadeMatrixEnum:=18;

          elseif ModuleColumn == NumOfStacks then
            ShadeMatrixEnum:=19;
          else
            ShadeMatrixEnum:=15;
          end if;
        elseif ModuleRow == 2 then
          if ModuleColumn == 1 then 
            ShadeMatrixEnum:=21;
          elseif ModuleColumn == 2 then
            ShadeMatrixEnum:=22;

          elseif ModuleColumn == NumOfStacks - 1 then
            ShadeMatrixEnum:=28;

          elseif ModuleColumn == NumOfStacks then
            ShadeMatrixEnum:=29;
          else
            ShadeMatrixEnum:=25;
          end if;

        elseif ModuleRow == StackHeight - 1 then
          if ModuleColumn == 1 then 
            ShadeMatrixEnum:=81;
          elseif ModuleColumn == 2 then
            ShadeMatrixEnum:=82;

          elseif ModuleColumn == NumOfStacks - 1 then
            ShadeMatrixEnum:=88;

          elseif ModuleColumn == NumOfStacks then
            ShadeMatrixEnum:=89;
          else
            ShadeMatrixEnum:=85;
          end if;

        elseif ModuleRow == StackHeight then
          if ModuleColumn == 1 then 
            ShadeMatrixEnum:=91;
          elseif ModuleColumn == 2 then
            ShadeMatrixEnum:=92;

          elseif ModuleColumn == NumOfStacks - 1 then
            ShadeMatrixEnum:=98;

          elseif ModuleColumn == NumOfStacks then
            ShadeMatrixEnum:=99;
          else
            ShadeMatrixEnum:=95;
          end if;
        else
          ShadeMatrixEnum:=55;
        end if;
      end if;
      annotation(Icon(coordinateSystem(extent = {{-60,-60},{60,60}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-60,-60},{60,60}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Rectangle(origin = {0,0}, extent = {{-60,60},{60,-60}})}));
    end chooseShadeMatrix;
    model chooseFractExposedLUTPosition "based on a module's position in an ICSF array, choose it's position in the 5x5 array of 'shading' types. Outputs a 2D vector somewhere in the space of [1:5 1:5]"
      //
      //extends ICSolar.Parameters;
      //
      //______________________________________________________________________________
      Modelica.Blocks.Interfaces.IntegerInput ModuleRow "Module Row" annotation(Placement(visible = true, transformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.IntegerInput ModuleCol "Module Column" annotation(Placement(visible = true, transformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.IntegerInput ArrayRows "Rows in Array" annotation(Placement(visible = true, transformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.IntegerInput ArrayCols "Columns in Array" annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      //
      //______________________________________________________________________________
      output Modelica.Blocks.Interfaces.IntegerOutput FractExposedTypeRow "Enumeration of FractExposed Row" annotation(Placement(visible = true, transformation(origin = {110,10}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,10}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      output Modelica.Blocks.Interfaces.IntegerOutput FractExposedTypeCol "Enumeration of FractExposed Column" annotation(Placement(visible = true, transformation(origin = {110,-10}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-10}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      //
      //______________________________________________________________________________
    algorithm
      //
      //this first case is a robustness measure, solving an out-of-bounds condition
      if ModuleCol > ArrayCols then 
        FractExposedTypeCol:=3;
      elseif ModuleCol < 2 then
        FractExposedTypeCol:=1;

      elseif ModuleCol < 3 then
        FractExposedTypeCol:=2;

      elseif ModuleCol > ArrayCols - 1 then
        FractExposedTypeCol:=5;

      elseif ModuleCol > ArrayCols - 2 then
        FractExposedTypeCol:=4;
      else
        FractExposedTypeCol:=3;
      end if;
      //
      //this first case is a robustness measure, solving an out-of-bounds condition
      if ModuleRow > ArrayRows then 
        FractExposedTypeRow:=3;
      elseif ModuleRow < 2 then
        FractExposedTypeRow:=1;

      elseif ModuleRow < 3 then
        FractExposedTypeRow:=2;

      elseif ModuleRow > ArrayRows - 1 then
        FractExposedTypeRow:=5;

      elseif ModuleRow > ArrayRows - 2 then
        FractExposedTypeRow:=4;
      else
        FractExposedTypeRow:=3;
      end if;
      //##############################################################################
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Rectangle(origin = {0,0}, extent = {{-100,100},{100,-100}})}), Documentation(info = "<html>
<p>
This didn't work with equations, so shifted over to algortihm. There was a div/0 problem if your mod or col was the last possible mod or col, which I get on a basic level. 

OK, I see now that my logic is delivering, somehow, an output of 0 if the mod or col is trying to choose the last row or column. 

So was it necessary to take the parameter designations off the integer inputs?

Evidently yes. still sorting that one out, but let's not get distracted.
</p>
</html>"));
    end chooseFractExposedLUTPosition;
    model ICS_Module_Twelve "This model contains all the components and equations that simulate one module of Integrated Concentrating Solar"
      extends ICSolar.Parameters;
      parameter Modelica.SIunits.Length LensWidth = 0.25019 "Width of Fresnel Lens, meters";
      parameter Modelica.SIunits.Length CellWidth = 0.01 "Width of the PV cell, meters";
      Real measured_eGen_on = eGen_on.y[modNum];
      //Stores only column related to module of interests
      //  parameter String FresMat = "PMMA" "'PMMA' or 'Silicon on Glass', use the exact spellings provided";
      //  parameter Real FNum = 0.85 "FNum determines the lens transmittance based on concentrating";
      //  Integer FMatNum "Integer used to pipe the material to other models";
      // Adding in temperature outputs for truing-up model (5.3.15)_kP
      Real Qgen_mod = abs(flowport_b1.H_flow) - flowport_a1.H_flow;
      Modelica.Blocks.Sources.CombiTimeTable eGen_on(tableOnFile = true, fileName = Path + Date + "EgenIO.txt", tableName = "EgenIO", nout = 12, columns = {2,3,4,5,6,7,8,9,10,11,12,13}, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint);
      // Imports the entire eGen matri
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1(medium = mediumHTF) "Outflow port of the thermal fluid (to Parent)" annotation(Placement(visible = true, transformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1(medium = mediumHTF) "Inflow port of the thermal fluid (from Parent)" annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in "Ambient temperature of the cavity into Module model for use in the heat receiver" annotation(Placement(visible = true, transformation(origin = {-100,78}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,78}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ICSolar.Receiver.moduleReceiver modulereceiver1 "Heat Receiver to calculate the heat transfer between heat gen and heat transfered to thermal fluid" annotation(Placement(visible = true, transformation(origin = {65,-5}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      ICSolar.Module.ICS_LensLosses ics_lenslosses1 annotation(Placement(visible = true, transformation(origin = {-60,-2}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      ICSolar.Module.ICS_PVPerformance ics_pvperformance1 annotation(Placement(visible = true, transformation(origin = {0,0}, extent = {{-16.25,-16.25},{16.25,16.25}}, rotation = 0)));
      Modelica.Blocks.Math.Add add annotation(Placement(transformation(extent = {{36,32},{46,42}})));
      Modelica.Blocks.Interfaces.RealOutput Power_out "Electrical generation outflow (to Parent)" annotation(Placement(visible = true, transformation(origin = {100,54}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayPitch "pass pitch to module" annotation(Placement(visible = true, transformation(origin = {-100,30}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      input Modelica.Blocks.Interfaces.RealInput Power_in "electrical power in from previous module or GND" annotation(Placement(visible = true, transformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "DNI into the Module" annotation(Placement(visible = true, transformation(origin = {-100,18}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayYaw "pass yaw to module" annotation(Placement(visible = true, transformation(origin = {-100,50}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ICSolar.Shading_Twelve shading_twelve1 annotation(Placement(visible = true, transformation(origin = {-60,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.IntegerInput modNum annotation(Placement(visible = true, transformation(origin = {-100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-80,-80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      connect(modNum,shading_twelve1.ShadingTable);
      connect(shading_twelve1.DNI_out,ics_lenslosses1.DNI_in) annotation(Line(points = {{-50,42},{-43.6957,42},{-43.6957,14.205},{-83.377,14.205},{-83.377,6.94808},{-75.3481,6.94808},{-75.3481,6.94808}}, color = {0,0,127}));
      connect(shading_twelve1.arrayPitch,arrayPitch) annotation(Line(points = {{-70,40},{-78.59050000000001,40},{-78.59050000000001,30.4172},{-95.8836,30.4172},{-95.8836,30.4172}}, color = {0,0,127}));
      connect(shading_twelve1.arrayYaw,arrayYaw) annotation(Line(points = {{-70,44},{-77.9729,44},{-77.9729,49.4086},{-96.038,49.4086},{-96.038,49.4086}}, color = {0,0,127}));
      connect(shading_twelve1.DNI_in,DNI) annotation(Line(points = {{-70,48},{-85.693,48},{-85.693,17.6018},{-95.72920000000001,17.6018},{-95.72920000000001,17.6018}}, color = {0,0,127}));
      connect(Power_in,add.u1) annotation(Line(points = {{-100,60},{-28,60},{-28,40},{35,40}}, color = {0,0,127}));
      connect(modulereceiver1.flowport_b1,flowport_b1) annotation(Line(points = {{80,5.71429},{86.535,5.71429},{86.535,-40.2154},{99.4614,-40.2154},{99.4614,-40.2154}}, color = {255,0,0}));
      connect(TAmb_in,modulereceiver1.TAmb_in) annotation(Line(points = {{-100,78},{-2.90276,78},{-2.90276,13.0624},{50,13.0624},{50,6.78571}}));
      connect(ics_pvperformance1.ThermalGen,modulereceiver1.ThermalGen) annotation(Line(points = {{16.25,-7.3125},{45.38,-7.3125},{45.38,6.04915},{50,6.04915},{50,-0.714286}}));
      connect(ics_lenslosses1.ConcentrationFactor,ics_pvperformance1.ConcentrationFactor) annotation(Line(points = {{-45,-11},{-39.3195,-11},{-39.3195,-9.82987},{-16.25,-9.82987},{-16.25,-9.75}}));
      connect(ics_lenslosses1.DNI_out,ics_pvperformance1.DNI_in) annotation(Line(points = {{-45,4},{-34.4045,4},{-34.4045,0.378072},{-16.25,0.378072},{-16.25,0}}));
      connect(modulereceiver1.flowport_a1,flowport_a1) "Connect pump flow the heat receiver" annotation(Line(points = {{62,10},{39.4366,10},{39.4366,-40.1408},{-100,-40.1408},{-100,-40}}));
      connect(measured_eGen_on,ics_pvperformance1.PV_on);
      //  end if;
      //  if FresMat == "PMMA" then
      //    FMatNum = 1;
      //  elseif FresMat == "Silicon on Glass" then
      //    FMatNum = 2;
      //  else
      //  end if;
      //  ics_lens1.FMat = FMatNum "Connects FMatNum calculated in Module to Lens FMat input";
      ics_lenslosses1.LensWidth = LensWidth "Connects LensWidth defined in Module to Lens LensWidth";
      ics_lenslosses1.CellWidth = CellWidth "Connect CellWidth defined in Module to CellWidth in Lens";
      // ics_pvperformance1.CellWidth = CellWidth "Connect CellWidth defined in Module to CellWidth in PVPerformance for EIPC calc on Cell";
      // ics_lens1.FNum = FNum "Connects the FNumber defined in Module to FNum in Lens for concentration and transmission equations";
      connect(ics_pvperformance1.ElectricalGen,add.u2) annotation(Line(points = {{16.25,6.5},{16.25,31.25},{35,31.25},{35,34}}, color = {0,0,127}, smooth = Smooth.None));
      connect(add.y,Power_out) annotation(Line(points = {{46.5,37},{69.25,37},{69.25,54},{100,54}}, color = {0,0,127}, smooth = Smooth.None));
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Text(origin = {-1.41,9.98}, extent = {{-67.14,46.6},{67.14,-46.6}}, textString = "Module")}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
    end ICS_Module_Twelve;
  end Module;
  package Receiver "Package of all the necessary components to create an Integrated Concentrating Solar simulation"
    extends Modelica.Icons.Package;
    model moduleReceiver
      extends ICSolar.Parameters;
      Real temp_flowport_a = water_Block_HX1.flowport_a1.H_flow / (water_Block_HX1.flowport_a1.m_flow * mediumHTF.cp);
      Real temp_flowport_b = abs(water_Block_HX1.flowport_b1.H_flow / (flowport_a1.m_flow * mediumHTF.cp));
      ICSolar.Receiver.subClasses.receiverInternalEnergy receiverInternalEnergy1 annotation(Placement(visible = true, transformation(origin = {-158.447,-48.4473}, extent = {{-23.4473,-23.4473},{23.4473,23.4473}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1(medium = mediumHTF) annotation(Placement(visible = true, transformation(origin = {200,60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {200,100}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in annotation(Placement(visible = true, transformation(origin = {-200,170}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-200,170}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermalGen annotation(Placement(visible = true, transformation(origin = {-200,-10}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-200,100}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1(medium = mediumHTF) annotation(Placement(visible = true, transformation(origin = {-200,40}, extent = {{-10,-10},{10,10}}, rotation = -90), iconTransformation(origin = {-40,200}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ICSolar.Receiver.subClasses.Water_Block_HX water_Block_HX1 annotation(Placement(visible = true, transformation(origin = {0,0}, extent = {{-33.4646,-33.4646},{33.4646,33.4646}}, rotation = 0)));
      ICSolar.Receiver.subClasses.Tubing_Losses tubing_Losses1(Tubing(medium = mediumHTF, m = 0.0023, T0 = T_HTF_start, T0fixed = true, V_flowLaminar(displayUnit = "l/min") = 4.1666666666667e-006, dpLaminar(displayUnit = "kPa") = 1000, V_flowNominal(displayUnit = "l/min") = 0.00041666666666667, dpNominal(displayUnit = "kPa") = 100000, h_g = 0.3)) annotation(Placement(visible = true, transformation(origin = {100,0}, extent = {{-31.4355,-31.4355},{31.4355,31.4355}}, rotation = 0)));
    equation
      connect(tubing_Losses1.flowport_b1,flowport_b1) annotation(Line(points = {{131.435,0},{137.358,0},{137.358,58.1132},{200,58.1132},{200,60}}));
      connect(TAmb_in,tubing_Losses1.port_a) annotation(Line(points = {{-200,170},{123.541,170},{123.541,-23.164},{92.2496,-22.0048},{132.064,-22.0048}}));
      connect(water_Block_HX1.flowport_b1,tubing_Losses1.flowport_a1) annotation(Line(points = {{34.1339,-1.33858},{16.7742,-1.33858},{16.7742,-0.860215},{30.5376,0},{68.5645,0}}, color = {255,0,0}));
      connect(TAmb_in,water_Block_HX1.heatLoss_to_ambient) annotation(Line(points = {{-200,170},{-140,170},{-33.4646,3.4646},{-33.4646,0}}, color = {191,0,0}));
      connect(flowport_a1,water_Block_HX1.flowport_a1) annotation(Line(points = {{-200,40},{-130,40},{-130,13.3858},{-33.4646,13.3858}}, color = {255,0,0}));
      connect(receiverInternalEnergy1.port_b,water_Block_HX1.heatCap_waterBlock) annotation(Line(points = {{-135,-34.3789},{-85,-34.3789},{-85,-25},{-61.9292,-26.7717},{-33.4646,-26.7717}}, color = {191,0,0}));
      connect(ThermalGen,water_Block_HX1.energyFrom_CCA) annotation(Line(points = {{-200,-10},{-119.049,-10},{-119.049,-9.75},{-61.929,-13.3858},{-33.4646,-13.3858}}));
      annotation(Diagram(coordinateSystem(extent = {{-200,-80},{200,200}}, preserveAspectRatio = false, initialScale = 0.1, grid = {10,10}), graphics = {Text(origin = {12.5,110}, fillPattern = FillPattern.Solid, extent = {{-42.5,-5},{42.5,5}}, textString = "Bring the Ambient Sources and pump Outside the Class ", fontName = "Arial")}), Icon(coordinateSystem(extent = {{-200,-80},{200,200}}, preserveAspectRatio = false, initialScale = 0.1, grid = {10,10}), graphics = {Text(origin = {3.12,117.49}, extent = {{-133.92,40.92},{133.92,-40.92}}, textString = "Heat"),Text(origin = {9.854509999999999,16.9292}, extent = {{-154.79,56.03},{154.79,-56.03}}, textString = "Receiver")}));
    end moduleReceiver;
    package subClasses "Contains the subClasses for receiver"
      extends Modelica.Icons.Package;
      connector Egen_port
        Modelica.SIunits.Power p "Power in Watts at the port" annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Polygon(points = {{100,100},{-100,100},{-100,-100},{100,-100},{100,100}}, lineColor = {0,0,0}, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Text(extent = {{-150,-90},{150,-150}}, lineColor = {0,0,0}, fillColor = {0,0,0}, fillPattern = FillPattern.Solid, textString = "%name"),Polygon(points = {{70,70},{-70,70},{-70,-70},{70,-70},{70,70}}, lineColor = {255,255,255}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid)}), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Polygon(points = {{100,100},{-100,100},{-100,-100},{100,-100},{100,100}}, lineColor = {0,0,0}, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Polygon(points = {{70,70},{-70,70},{-70,-70},{70,-70},{70,70}}, lineColor = {255,255,255}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid)}));
      end Egen_port;
      class receiverInternalEnergy
        extends ICSolar.Parameters;
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation(Placement(visible = true, transformation(origin = {100,60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatcapacitor1(C = HeatCap_Receiver) "60 J/K is calculated in spreadsheet in 1-DOCS\\calculators ...thermal mass or heat capacity of receiver.xlsx" annotation(Placement(visible = true, transformation(origin = {-20,0}, extent = {{-10,10},{10,-10}}, rotation = 0)));
      equation
        connect(heatcapacitor1.port,port_b) annotation(Line(points = {{-20,10},{-20.023,10},{-20.023,60.5293},{100,60.5293},{100,60}}));
      end receiverInternalEnergy;
      class CCA_energyBalance
        Modelica.Blocks.Interfaces.RealInput wattsIn_perCell annotation(Placement(visible = true, transformation(origin = {-100,60}, extent = {{-15,-15},{15,15}}, rotation = 0), iconTransformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput PV_eff annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-15,-15},{15,15}}, rotation = 0), iconTransformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation(Placement(visible = true, transformation(origin = {100,-40}, extent = {{-15,-15},{15,15}}, rotation = 0), iconTransformation(origin = {100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealOutput Power_out annotation(Placement(visible = true, transformation(origin = {100,60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      equation
        Power_out = wattsIn_perCell * PV_eff;
        port_b.Q_flow = -wattsIn_perCell * (1 - PV_eff);
      end CCA_energyBalance;
      class Water_Block_HX
        extends ICSolar.Parameters;
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1(medium = mediumHTF) annotation(Placement(visible = true, transformation(origin = {100.0,40.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {102.0,-4.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1(medium = mediumHTF) annotation(Placement(visible = true, transformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalconductor1(G = Cond_RecToEnv) annotation(Placement(visible = true, transformation(origin = {20,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.Convection convection1 annotation(Placement(visible = true, transformation(origin = {60,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a energyFrom_CCA annotation(Placement(visible = true, transformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCap_waterBlock annotation(Placement(visible = true, transformation(origin = {-100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatLoss_to_ambient annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalcollector1 annotation(Placement(visible = true, transformation(origin = {-20,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.FluidHeatFlow.Components.HeatedPipe heatedpipe1(h_g = 0, T0 = T_HTF_start, medium = mediumHTF, T(start = T_HTF_start), pressureDrop(fixed = false), T0fixed = true, m = 0.003, dpNominal(displayUnit = "kPa") = 62270, V_flowLaminar(displayUnit = "l/min") = 1.6666666666667e-006, dpLaminar(displayUnit = "kPa") = 14690, V_flowNominal(displayUnit = "l/min") = 3.995e-006) annotation(Placement(visible = true, transformation(origin = {-20,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalresistor_waterblock(R = Resistivity_WaterPlate) annotation(Placement(visible = true, transformation(origin = {-20,20}, extent = {{-10,-10},{10,10}}, rotation = 90)));
        Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalresistor_celltoreceiver(R = Resistivity_Cell) annotation(Placement(visible = true, transformation(origin = {-60,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        //
        //______________________________________________________________________________
      equation
        connect(thermalconductor1.port_a,thermalcollector1.port_a[3]) annotation(Line(points = {{10,0},{-20.029,0},{-20.029,-10.1597},{-20.029,-10.1597}}));
        connect(thermalresistor_waterblock.port_a,thermalcollector1.port_a[2]) annotation(Line(points = {{-20,10},{-20,-9.5791},{-19.4485,-9.5791},{-19.4485,-9.5791}}));
        connect(heatedpipe1.heatPort,thermalresistor_waterblock.port_b) annotation(Line(points = {{-20,50},{-19.7388,50},{-19.7388,30.1887},{-19.7388,30.1887}}));
        connect(thermalresistor_celltoreceiver.port_b,thermalcollector1.port_a[1]) annotation(Line(points = {{-50,0},{-19.7388,0},{-19.7388,-9.86938},{-19.7388,-9.86938}}));
        connect(energyFrom_CCA,thermalresistor_celltoreceiver.port_a) annotation(Line(points = {{-100,0},{-69.95650000000001,0},{-69.95650000000001,-0.290276},{-69.95650000000001,-0.290276}}));
        connect(heatedpipe1.flowPort_b,flowport_b1) annotation(Line(points = {{-10,60},{31.3498,60},{31.3498,40.3483},{98.98399999999999,40.3483},{98.98399999999999,40.3483}}));
        connect(flowport_a1,heatedpipe1.flowPort_a) annotation(Line(points = {{-100,40},{-62.6996,40},{-62.6996,59.7968},{-29.8984,59.7968},{-29.8984,59.7968}}));
        connect(thermalresistor_waterblock.port_a,thermalcollector1.port_a[2]) annotation(Line(points = {{-20,10},{-20,-9.5791},{-20,-9.5791},{-20,-10}}));
        connect(thermalresistor_waterblock.port_b,heatedpipe1.heatPort) annotation(Line(points = {{-20,30},{-20,49.6372},{-20,50},{-20,50}}));
        connect(heatCap_waterBlock,thermalcollector1.port_b) annotation(Line(points = {{-100,-80},{-19.7929,-80},{-20,-10},{-20,-30}}));
        connect(heatLoss_to_ambient,convection1.fluid) annotation(Line(points = {{-100,-40},{84.4649,-40},{84.4649,0},{70,0}}));
        connect(thermalconductor1.port_b,convection1.solid) annotation(Line(points = {{30,0},{50,0}}));
        connect(Conv_Receiver,convection1.Gc) "Connects the Conv_Receiver from ICSolar.Parameter to the input for the convection coeffient of convection1";
        annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
      end Water_Block_HX;
      class Tubing_Losses
        extends ICSolar.Parameters;
        Modelica.Thermal.FluidHeatFlow.Components.HeatedPipe Tubing(medium = mediumHTF, V_flowLaminar = OneBranchFlow, V_flowNominal = 1e-005, h_g = 0, m = 0.0025, T0 = T_HTF_start, T0fixed = true, dpLaminar = 0.45, dpNominal = 10) annotation(Placement(visible = true, transformation(origin = {-80,0}, extent = {{-10,-10},{10,10}}, rotation = 90)));
        Modelica.Thermal.HeatTransfer.Components.Convection convection1 annotation(Placement(visible = true, transformation(origin = {80.0,0.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.Convection convection2 annotation(Placement(visible = true, transformation(origin = {-40,0}, extent = {{10,-10},{-10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a(T(start = T_HTF_start)) annotation(Placement(visible = true, transformation(origin = {100.0,-60.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {102.0,-70.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1(medium = mediumHTF) annotation(Placement(visible = true, transformation(origin = {-80,80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1(medium = mediumHTF) annotation(Placement(visible = true, transformation(origin = {-80.0,-80.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {-100.0,0.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor Conduction_Insulation(G = Cond_Insulation) "Thermal conductivity of Tubing Insulation, from ICSolar.Parameter" annotation(Placement(visible = true, transformation(origin = {40,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor Conduction_Tube(G = Cond_Tube) "Thermal conductivity of the silicone tubing, from ICSolar.Parameter" annotation(Placement(visible = true, transformation(origin = {0,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      equation
        connect(convection2.solid,Conduction_Tube.port_a) annotation(Line(points = {{-30,0},{-9.920629999999999,0},{-10,0}}));
        connect(Conduction_Tube.port_b,Conduction_Insulation.port_a) annotation(Line(points = {{10,0},{30.5556,0},{30,0}}));
        connect(Conduction_Insulation.port_b,convection1.solid) annotation(Line(points = {{50,0},{70.4365,0},{70.4365,0.1984},{70,0}}));
        connect(convection1.fluid,port_a) annotation(Line(visible = true, points = {{90.0,0.0},{97.8175,0.0},{97.8175,-43.8492},{87.5,-43.8492},{87.5,-60.9127},{98.61109999999999,-60.9127},{100.0,-60.0}}));
        connect(flowport_a1,Tubing.flowPort_a) annotation(Line(visible = true, points = {{-80.0,-80.0},{-79.9603,-80.0},{-79.9603,-10.3175},{-80.0,-10.0}}));
        connect(flowport_b1,Tubing.flowPort_b) annotation(Line(points = {{-80,80},{-79.9615,80},{-79.9615,10},{-80,10}}));
        connect(Tubing.heatPort,convection2.fluid) annotation(Line(points = {{-70,-6.12303e-016},{-70,0},{-50,0}}));
        connect(Conv_WaterTube,convection2.Gc);
        connect(Conv_InsulationAir,convection1.Gc);
        annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
      end Tubing_Losses;
    end subClasses;
  end Receiver;
  model Parameters "Inputs for the ICSF model"
    ///////////////////////
    //////// PATH /////////
    ///////////////////////
    parameter String Date = "20150323\\";
    //parameter String Date = "20150319\\";
    //parameter String Date = "20150220\\";
    //need to change path here to compile, also where path_2 shows up:
    // C:\Users\Kenton\Documents\GitHub\RPI_CASE_ICS_Modelica
    parameter String Path = "C:\\Users\\kenton.phillips\\Documents\\GitHub\\RPI_CASE_ICS_Modelica\\";
    //   parameter String Path = "C:\\Users\\Kenton\\Documents\\GitHub\\RPI_CASE_ICS_Modelica\\";
    //parameter String Path = "C:\\Users\\Nick\\Documents\\GitHub\\RPI_CASE_ICS_Modelica\\";
    //    parameter String Path = "C:\\Users\\Nicholas.Novelli\\Documents\\GitHub\\RPI_CASE_ICS_Modelica\\";
    //________________________________
    //////// MODEL OPERATION /////////
    //--------------------------------
    parameter Boolean isStudioExperiment = true "True if this run is referring to the gen8 studio experiment. For now, just search through the code for the variable name and flip things where necessary";
    //////////////////////////////////
    ///// BUILDING CONFIGURATION /////
    //////////////////////////////////
    parameter Real BuildingOrientation = 40 * 3.14159 / 180 "Radians, 0 being south";
    parameter Real BuildingLatitude = 40.71 * Modelica.Constants.pi / 180 "Latitude (radians)";
    parameter Real ArrayTilt = 0 "Radians, 0 being wall";
    ////////////////////////
    ///// ARRAY SIZING /////
    ////////////////////////
    parameter Integer StackHeight = 6 "Number of Modules per stack";
    parameter Integer NumOfStacks = 2 "Number of stacks, controls the .Stack object";
    parameter Integer NumOfModules = StackHeight * NumOfStacks "ModulesPerStack * NumOfStacks Number of modules being simulated. Will be replaced with a calculation based on wall area in the future.";
    // 11 in. height       13.5 in. width
    parameter Real stackSpacing = 0.3429 "distance between stacks (m)";
    parameter Real moduleSpacing = 0.2794 "distance between modules (m)";
    parameter Real GlassArea_perMod = stackSpacing * moduleSpacing "Glass Area exposed to either the interior or exterior. Could be replaced later with wall area";
    parameter Real GlassArea = GlassArea_perMod * NumOfModules;
    parameter Real CavityVolume = GlassArea * 0.5 "Volume of cavity for air calculations";
    //
    ////////////////////////////////
    ///// OPTICAL EFFICIENCIES /////
    ////////////////////////////////
    //Using Schlick's approximation to get glazing transmittance
    //  Real x_lite = 6 "thickness of lite (mm) (isStudioExperiment=false)";
    Real x_lite = 3 "thickness of lite (mm). for studio =3. for projected =6 (isStudioExperiment=true)";
    Real n_lites = 1 "number of lites in glazing unit. for Studio =2. for projected =1 (isStudioExperiment=false)";
    //Real n_lites = 2 "number of lites in glazing unit (isStudioExperiment=true)";
    parameter Real R_sfc = 1e-005 "surface soiling coefficient. if isStudioExperiment=true then 0.030 else .00001 (don't like to use zero, generally)";
    parameter Real c_disp = 0.0075 "coeff. dispersion. for Ultrawhite =0.0075. for studio = 0.0221(isStudioExperiment = false)";
    //deprecated for the material/geometry-based Trans_glazinglosses equation that now resides within glazinglosses component.
    //    parameter Real Trans_glazinglosses = 0.74 "Transmittance of outter glazing losses (single glass layer). Good glass: Guardian Ultraclear 6mm: 0.87. For our studio IGUs, measured 0.71. But give it 0.74, because we measured at ~28degrees, which will increase absorptance losses.";
    //still need to do something about this:
    parameter Real Trans_glazinglosses_eta = 0.86;
    // parameter Real OpticalEfficiency = 0.57 "The optical efficiency of the concentrating lens and optics prior to the photovoltaic cell";
    parameter Real OpticalEfficiency = 0.5649999999999999;
    // parameter Real OpticalEfficiency = 0.886;
    //parameter Real Exp_Observed = 0.215 "observed electrical efficiency of ICSFg8";
    //parameter Real Exp_nom_tweak = 0.364 * OpticalEfficiency "matching the observed to modeled data, compensating for temperature 'unknown'. 0.364 matches the Nov25-13 data well when eta_observed is 0.215. set same as eta_obs for full-strength output.";
    //
    ///////////////////////
    ////// PV ON/OFF  /////
    ///////////////////////
    //parameter Integer PV_on[6] = {1,0,0,1,1,0};  <------ Chaning to dynamic boolean
    //parameter boolean PV_on = 1;
    ////////////////////////
    ///// TEMPERATURES /////
    ////////////////////////
    parameter Real Temp_Indoor = 24 + 273.15 "Interior building zone temperature (Kelvin)";
    parameter Modelica.SIunits.Temperature TAmb(displayUnit = "degK") = 293.15 "Ambient temperature";
    parameter Real T_HTF_start = 346.0;
    //330;
    ///////////////////////
    ////// ATMOSPHERE /////
    ///////////////////////
    parameter Modelica.SIunits.Pressure PAmb(displayUnit = "PA") = 101325 "Ambient pressure";
    /////////////////
    ///// FLUID /////
    /////////////////
    parameter Modelica.Thermal.FluidHeatFlow.Media.Medium mediumHTF = Modelica.Thermal.FluidHeatFlow.Media.Water() "Water" annotation(choicesAllMatching = true);
    parameter Real OneBranchFlow = 1.63533e-006;
    //parameter Real cp_h2o = 4177;
    //////////////////////////////////////
    ///// HEAT TRANSFER COEFFICIENTS /////
    //////////////////////////////////////
    parameter Real Resistivity_WaterBlock = 5050.0 * OneBranchFlow ^ (-0.773) "Thermal resisitivity of the water block heat exchanger";
    parameter Real Resistivity_Cell = 0.22 "The thermal heat resistivity of the photovoltaic cell";
    //?Why doesn't this if structure work here? for now, swap things manually
    //if isStudioExperiment == true then
    parameter Real Resistivity_WaterPlate = 0.8 "Thermal resisitivity of the water plate heat exchanger, experiment";
    //else
    //  parameter Real Resistivity_WaterPlate = 5.05e3 * OneBranchFlow ^ (-0.773) "Thermal resisitivity of the water block heat exchanger, projected";
    //end if;
    //
    //
    parameter Real Cond_RecToEnv = adj_2 * 0.083 "This is a thermal conductivity to determine the amount of heat lost to the environment from the receiver";
    //parameter Real Conv_Receiver = 0.0534;
    parameter Real Conv_Receiver = adj_2 * 5;
    // 0.07 "Convection Heat Transfer of Receiver to air h(=10)*A(=0.004m2)";
    //parameter Real Conv_Receiver = 0.0618321 "Convection Heat Transfer of Receiver to air h(=10)*A(=0.004m2)";
    parameter Real adj = 0.25;
    parameter Real adj_2 = 0.7;
    // adjustment to keep the temperatures the same, but change the overall heat loss
    parameter Real factor_1 = 10 * adj;
    parameter Real Conv_WaterTube = factor_1 * 3.66 * 0.58 / (2 * 0.003175) * 2 * Modelica.Constants.pi * 0.003175 * 0.3 "Convection Heat Transfer of Water to Piping = h*SurfArea = Nu(=3.66) * kofWater / Diameter * Surface Area";
    parameter Real factor_2 = 110 * adj;
    parameter Real Conv_InsulationAir = factor_2 * 3.66 * 0.023 / (2 * (0.003175 + 0.0015 + 0.09525)) * 2 * Modelica.Constants.pi * (0.003175 + 0.0015 + 0.01905) * 0.3 "Convection Heat Transfer of Piping to Air Nu(=3.66) * kofAir / Diameter * Surface Area";
    parameter Real factor_3 = 0.3 * adj;
    parameter Real Cond_Insulation = factor_3 * 1 / (Modelica.Math.log(14.2 / 4.675) / (2 * Modelica.Constants.pi * 0.037 * 0.3) * 2 * Modelica.Constants.pi * (0.003175 + 0.0015 + 0.01905) * 0.3) "Thermal conductivity of Tubing Insulation: ln((23.55e-3)/(4.5e-3))/(2*pi*0.037*0.3)";
    parameter Real factor_4 = 0.05 * adj;
    parameter Real Cond_Tube = factor_4 * 1 / (Modelica.Math.log(4.675 / 3.175) / (2 * Modelica.Constants.pi * 0.145 * 0.3) * 2 * Modelica.Constants.pi * (0.003175 + 0.0015) * 0.3) "Thermal conductivity of the silicone tubing: 1/(ln(4.5e-3/3e-3)/(2*pi*0.145*0.3))";
    parameter Real HeatCap_Receiver = 60;
    //30;
    annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), experiment(StartTime = 47130, StopTime = 58120, Tolerance = 1e-006, Interval = 10), Documentation(info = "<html>
                                                                                                                                                                            Don't forget to:<br/>
                                                                                                                                                                            fix the shading matrices path in <code>Envelope.ICS_SelfShading</code>.<br/> </html>", revisions = "<html>
                                                                                                                                                                            <ul>
                                                                                                                                                                            <li>
                                                                                                                                                                            Jan2015, by Justin Shultz:<br/>
                                                                                                                                                                            First implementation.<br/>
                                                                                                                                                                            </li>
                                                                                                                                                                            </ul>
                                                                                                                                                                            </html>"));
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
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port annotation(Placement(transformation(origin = {0,-100}, extent = {{-10,-10},{10,10}}, rotation = 90)));
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
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics = {Text(extent = {{-150,110},{150,70}}, textString = "%name", lineColor = {0,0,255}),Polygon(points = {{0,67},{-20,63},{-40,57},{-52,43},{-58,35},{-68,25},{-72,13},{-76,-1},{-78,-15},{-76,-31},{-76,-43},{-76,-53},{-70,-65},{-64,-73},{-48,-77},{-30,-83},{-18,-83},{-2,-85},{8,-89},{22,-89},{32,-87},{42,-81},{54,-75},{56,-73},{66,-61},{68,-53},{70,-51},{72,-35},{76,-21},{78,-13},{78,3},{74,15},{66,25},{54,33},{44,41},{36,57},{26,65},{0,67}}, lineColor = {160,160,164}, fillColor = {192,192,192}, fillPattern = FillPattern.Solid),Polygon(points = {{-58,35},{-68,25},{-72,13},{-76,-1},{-78,-15},{-76,-31},{-76,-43},{-76,-53},{-70,-65},{-64,-73},{-48,-77},{-30,-83},{-18,-83},{-2,-85},{8,-89},{22,-89},{32,-87},{42,-81},{54,-75},{42,-77},{40,-77},{30,-79},{20,-81},{18,-81},{10,-81},{2,-77},{-12,-73},{-22,-73},{-30,-71},{-40,-65},{-50,-55},{-56,-43},{-58,-35},{-58,-25},{-60,-13},{-60,-5},{-60,7},{-58,17},{-56,19},{-52,27},{-48,35},{-44,45},{-40,57},{-58,35}}, lineColor = {0,0,0}, fillColor = {160,160,164}, fillPattern = FillPattern.Solid),Text(extent = {{-69,7},{71,-24}}, lineColor = {0,0,0}, textString = "%C")}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics = {Polygon(points = {{0,67},{-20,63},{-40,57},{-52,43},{-58,35},{-68,25},{-72,13},{-76,-1},{-78,-15},{-76,-31},{-76,-43},{-76,-53},{-70,-65},{-64,-73},{-48,-77},{-30,-83},{-18,-83},{-2,-85},{8,-89},{22,-89},{32,-87},{42,-81},{54,-75},{56,-73},{66,-61},{68,-53},{70,-51},{72,-35},{76,-21},{78,-13},{78,3},{74,15},{66,25},{54,33},{44,41},{36,57},{26,65},{0,67}}, lineColor = {160,160,164}, fillColor = {192,192,192}, fillPattern = FillPattern.Solid),Polygon(points = {{-58,35},{-68,25},{-72,13},{-76,-1},{-78,-15},{-76,-31},{-76,-43},{-76,-53},{-70,-65},{-64,-73},{-48,-77},{-30,-83},{-18,-83},{-2,-85},{8,-89},{22,-89},{32,-87},{42,-81},{54,-75},{42,-77},{40,-77},{30,-79},{20,-81},{18,-81},{10,-81},{2,-77},{-12,-73},{-22,-73},{-30,-71},{-40,-65},{-50,-55},{-56,-43},{-58,-35},{-58,-25},{-60,-13},{-60,-5},{-60,7},{-58,17},{-56,19},{-52,27},{-48,35},{-44,45},{-40,57},{-58,35}}, lineColor = {0,0,0}, fillColor = {160,160,164}, fillPattern = FillPattern.Solid),Ellipse(extent = {{-6,-1},{6,-12}}, lineColor = {255,0,0}, fillColor = {191,0,0}, fillPattern = FillPattern.Solid),Text(extent = {{11,13},{50,-25}}, lineColor = {0,0,0}, textString = "T"),Line(points = {{0,-12},{0,-96}}, color = {255,0,0})}), Documentation(info = "<HTML>
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
    input Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a baseline_enthalpy annotation(Placement(visible = true, transformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    input Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a generated_enthalpy annotation(Placement(visible = true, transformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    output Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b enthalpy_power annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  equation
    generated_enthalpy = if generated_enthalpy < 0 then -generated_enthalpy else generated_enthalpy;
    baseline_enthalpy = if baseline_enthalpy < 0 then -baseline_enthalpy else baseline_enthalpy;
    enthalpy_power = generated_enthalpy - baseline_enthalpy;
    annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2,2}), graphics));
  end EnthalpyDifferential;
  model ICS_Skeleton_wStorage "This model calculates the electrical and thermal generation of ICSolar. This model is used as a skeleton piece to hold together the other models until it is packages as an FMU."
    parameter Real FLensWidth = 0.25019 "Lens width";
    parameter Real CellWidth = 0.01 "PV Cell width";
    parameter Modelica.SIunits.Pressure PAmb(displayUnit = "PA") = 101325 "Ambient pressure";
    ICSolar.ICS_Context ics_context1 annotation(Placement(visible = true, transformation(origin = {-80,40}, extent = {{-25,-25},{25,25}}, rotation = 0)));
    ICSolar.Envelope.ICS_EnvelopeCassette ics_envelopecassette1 annotation(Placement(visible = true, transformation(origin = {0,40}, extent = {{-25,-25},{25,25}}, rotation = 0)));
    Modelica.Thermal.FluidHeatFlow.Components.HeatedPipe heatedPipe(m = 50, T0 = T_HTF_start, T0fixed = true, h_g = -1, V_flowLaminar = 8e-006, dpLaminar = 10000.0, V_flowNominal = 0.0008, dpNominal = 1000000.0, frictionLoss = 1) annotation(Placement(visible = true, transformation(origin = {60,-18}, extent = {{10,-10},{-10,10}}, rotation = 90)));
    Modelica.Thermal.FluidHeatFlow.Sources.PressureIncrease pressureIncrease(medium = mediumHTF, m = 0.1, constantPressureIncrease(displayUnit = "kPa") = 100000) annotation(Placement(transformation(extent = {{-66,-22},{-46,-2}})));
    Modelica.Thermal.FluidHeatFlow.Sources.AbsolutePressure absolutepressure1(p = 1000) annotation(Placement(visible = true, transformation(origin = {-40,-80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatcapacitor1(C = 4000) annotation(Placement(visible = true, transformation(origin = {80,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  equation
    connect(heatcapacitor1.port,heatedPipe.heatPort) annotation(Line(points = {{80,30},{80.0478,30},{80.0478,-18.399},{70.2509,-18.399},{70.2509,-18.399}}, color = {191,0,0}));
    connect(absolutepressure1.flowPort,pressureIncrease.flowPort_a) annotation(Line(points = {{-50,-80},{-81.00360000000001,-80},{-81.00360000000001,-11.9474},{-65.9498,-11.9474},{-65.9498,-11.9474}}, color = {255,0,0}));
    connect(ics_envelopecassette1.flowport_b,heatedPipe.flowPort_a) annotation(Line(points = {{25,40},{32,40},{60,40},{60,-8}}, color = {255,0,0}));
    connect(ics_context1.DNI,ics_envelopecassette1.DNI) annotation(Line(points = {{-55,25},{-24.1966,25},{-25,25}}));
    connect(ics_context1.AOI,ics_envelopecassette1.AOI) annotation(Line(points = {{-55,30},{-24.9527,30},{-25,30}}));
    connect(ics_context1.SunAzi,ics_envelopecassette1.SunAzi) annotation(Line(points = {{-55,35},{-24.9527,35},{-25,35}}));
    connect(ics_context1.SunAlt,ics_envelopecassette1.SunAlt) annotation(Line(points = {{-55,40},{-24.5747,40},{-25,40}}));
    connect(ics_context1.SurfOrientation_out,ics_envelopecassette1.SurfaceOrientation) annotation(Line(points = {{-55,45},{-25.7089,45},{-25,45}}));
    connect(ics_context1.SurfTilt_out,ics_envelopecassette1.SurfaceTilt) annotation(Line(points = {{-55,50},{-25.7089,50},{-25,50}}));
    connect(ics_context1.TDryBul,ics_envelopecassette1.TAmb_in) annotation(Line(points = {{-55,55},{-25.3308,55},{-25,55}}));
    connect(ics_envelopecassette1.flowport_a,pressureIncrease.flowPort_b) annotation(Line(points = {{-23.75,18.75},{-23.75,-12},{-46,-12}}, color = {255,0,0}, smooth = Smooth.None));
    connect(heatedPipe.flowPort_b,pressureIncrease.flowPort_a) annotation(Line(points = {{60,-28},{60,-46},{-92,-46},{-92,-12},{-66,-12}}, color = {255,0,0}, smooth = Smooth.None));
    annotation(experiment(StartTime = 16588800, StopTime = 16675200, Tolerance = 1e-006, Interval = 9.866390000000001), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
  end ICS_Skeleton_wStorage;
  model ICS_Skeleton_wStorage_woutICS "This model calculates the electrical and thermal generation of ICSolar. This model is used as a skeleton piece to hold together the other models until it is packages as an FMU."
    parameter Real FLensWidth = 0.25019 "Lens width";
    parameter Real CellWidth = 0.01 "PV Cell width";
    parameter Modelica.SIunits.Pressure PAmb(displayUnit = "PA") = 101325 "Ambient pressure";
    Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow Pump(medium = mediumHTF, m = 0.1, T0 = T_HTF_start, useVolumeFlowInput = false, constantVolumeFlow(displayUnit = "m3/s") = 2e-006) "Fluid pump for thermal fluid" annotation(Placement(visible = true, transformation(origin = {-40,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Thermal.FluidHeatFlow.Components.HeatedPipe heatedPipe(m = 50, T0fixed = true, V_flowLaminar(displayUnit = "l/min") = 1.6666666666667e-005, V_flowNominal(displayUnit = "l/min") = 0.00016666666666667, frictionLoss = 1, dpLaminar(displayUnit = "kPa") = 100000, dpNominal(displayUnit = "kPa") = 1000000, T0 = T_HTF_start, h_g = 1) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 90, origin = {58,-18})));
    HeatCapacitorPCMLike00 heatCapacitorPCMLike00_1 annotation(Placement(transformation(extent = {{66,32},{86,52}})));
  equation
    connect(heatedPipe.flowPort_b,Pump.flowPort_a) annotation(Line(points = {{58,-8},{60,-8},{60,4},{-82,4},{-82,-20},{-50,-20}}, color = {255,0,0}, smooth = Smooth.None));
    connect(Pump.flowPort_b,heatedPipe.flowPort_a) annotation(Line(points = {{-30,-20},{-14,-20},{-14,-54},{58,-54},{58,-28}}, color = {255,0,0}, smooth = Smooth.None));
    connect(heatedPipe.heatPort,heatCapacitorPCMLike00_1.port) annotation(Line(points = {{68,-18},{74,-18},{74,14},{76,14},{76,32}}, color = {191,0,0}, smooth = Smooth.None));
    annotation(experiment(StartTime = 16588800, StopTime = 16675200, Tolerance = 1e-006, Interval = 9.866390000000001), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
  end ICS_Skeleton_wStorage_woutICS;
  model ambientSink
    extends Modelica.Thermal.FluidHeatFlow.Sources.Ambient;
    annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
  end ambientSink;
  model measured_data "a container for the measured data vectors needed to simulate the experimental ICSF g8"
    extends ICSolar.Parameters;
    Modelica.Blocks.Sources.CombiTimeTable eGen_on(tableOnFile = true, fileName = Path + "20150323\\EgenIO.txt", tableName = "EgenIO", nout = 12, columns = {2,3,4,5,6,7,8,9,10,11,12}, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint);
    //  Modelica.Thermal.FluidHeatFlow.Sources.Ambient SSource(medium = mediumHTF, useTemperatureInput = true, constantAmbientPressure = 101325, constantAmbientTemperature = TAmb) "Thermal fluid source" annotation(Placement(visible = true, transformation(origin = {40, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  end measured_data;
  model Shading_Twelve "reduce DNI by factor according to shading"
    //extends ICSolar.Parameters;
    extends ICSolar.ShadingLUT0;
    extends ICSolar.shadingImport;
    Modelica.Blocks.Interfaces.RealOutput DNI_out "DNI after shading factor multiplication" annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Math.Product product1 "Multiplication of DNI and shading factor" annotation(Placement(visible = true, transformation(origin = {20,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.IntegerInput ShadingTable annotation(Placement(visible = true, transformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    //for picking different shading matrices:
    //Modelica.Blocks.Tables.CombiTable2D Shading_matrix_2(tableOnFile = true, fileName = "C:\\Users\\kenton.phillips\\Documents\\GitHub\\RPI_CASE_ICS_Modelica\\shading_matrices\\" + String(ShadingTable) + ".txt", tableName = "shading_matrix") annotation(Placement(visible = true, transformation(origin = {-40, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput arrayPitch "pitch (up/down) angle of 2axis tracking array (rads)" annotation(Placement(visible = true, transformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput arrayYaw "yaw (left/right) angle of tracking array (in radians)" annotation(Placement(visible = true, transformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput DNI_in "DNI in before shading factor multiplication" annotation(Placement(visible = true, transformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  equation
    // BRUTE FORCE IMPORT
    connect(arrayPitch,modShadingLUT_1.u1);
    connect(arrayYaw,modShadingLUT_1.u2);
    connect(arrayPitch,modShadingLUT_2.u1);
    connect(arrayYaw,modShadingLUT_2.u2);
    connect(arrayPitch,modShadingLUT_3.u1);
    connect(arrayYaw,modShadingLUT_3.u2);
    connect(arrayPitch,modShadingLUT_4.u1);
    connect(arrayYaw,modShadingLUT_4.u2);
    connect(arrayPitch,modShadingLUT_5.u1);
    connect(arrayYaw,modShadingLUT_5.u2);
    connect(arrayPitch,modShadingLUT_6.u1);
    connect(arrayYaw,modShadingLUT_6.u2);
    connect(arrayPitch,modShadingLUT_7.u1);
    connect(arrayYaw,modShadingLUT_7.u2);
    connect(arrayPitch,modShadingLUT_8.u1);
    connect(arrayYaw,modShadingLUT_8.u2);
    connect(arrayPitch,modShadingLUT_9.u1);
    connect(arrayYaw,modShadingLUT_9.u2);
    connect(arrayPitch,modShadingLUT_10.u1);
    connect(arrayYaw,modShadingLUT_10.u2);
    connect(arrayPitch,modShadingLUT_11.u1);
    connect(arrayYaw,modShadingLUT_11.u2);
    connect(arrayPitch,modShadingLUT_12.u1);
    connect(arrayYaw,modShadingLUT_12.u2);
    if ShadingTable == 1 then
      product1.u2 = modShadingLUT_1.y;
    elseif ShadingTable == 2 then
      product1.u2 = modShadingLUT_2.y;
    elseif ShadingTable == 3 then
      product1.u2 = modShadingLUT_3.y;
    elseif ShadingTable == 4 then
      product1.u2 = modShadingLUT_4.y;
    elseif ShadingTable == 5 then
      product1.u2 = modShadingLUT_5.y;
    elseif ShadingTable == 6 then
      product1.u2 = modShadingLUT_6.y;
    elseif ShadingTable == 7 then
      product1.u2 = modShadingLUT_7.y;
    elseif ShadingTable == 8 then
      product1.u2 = modShadingLUT_8.y;
    elseif ShadingTable == 9 then
      product1.u2 = modShadingLUT_9.y;
    elseif ShadingTable == 10 then
      product1.u2 = modShadingLUT_10.y;
    elseif ShadingTable == 11 then
      product1.u2 = modShadingLUT_11.y;
    else
      product1.u2 = modShadingLUT_12.y;
    end if;
    //product1.u2 = if Shading_matrix.y < 0 then 0 else Shading_matrix.y;
    connect(product1.y,DNI_out) "DNI after multiplication connected to output of model" annotation(Line(points = {{31,40},{58.5909,40},{58.5909,19.7775},{100,19.7775},{100,20}}));
    connect(DNI_in,product1.u1) "Model input DNI connecting to product" annotation(Line(points = {{-100,80},{-36.3412,80},{-36.3412,45.9827},{8,45.9827},{8,46}}));
    connect(arrayYaw,Shading_matrix.u2);
    connect(arrayPitch,Shading_matrix.u1);
    annotation(Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Text(origin = {-4.59,2.51}, extent = {{-72.63,35.36},{72.63,-35.36}}, textString = "Self Shading"),Rectangle(origin = {0,0}, extent = {{-100,100},{100,-100}})}));
  end Shading_Twelve;
  model ShadingLUT0
    Modelica.Blocks.Tables.CombiTable2D Shading_matrix(smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments, table = [0,-3.1415926,-1.04719,-0.959927,-0.872667,-0.785397,-0.6981270000000001,-0.610867,-0.523597,-0.436327,-0.349067,-0.261797,-0.174837,-0.08726730000000001,0,0.08726730000000001,0.174837,0.261797,0.349067,0.436327,0.523597,0.610867,0.6981270000000001,0.785397,0.872667,0.959927,1.04719,3.1415926;-0.872665,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;-0.785398,0,0,0.515733288,0.582273933,0.644111335,0.700774874,0.751833306,0.796898047,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.796898047,0.751833306,0.700774874,0.644111335,0.582273933,0.515733288,0,0;-0.698132,0,0,0.558719885,0.630806722,0.697798298,0.759184768,0.814498944,0.86331985,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.86331985,0.814498944,0.759184768,0.697798298,0.630806722,0.558719885,0,0;-0.610865,0,0,0.5974542859999999,0.674538691,0.746174596,0.811816808,0.870965752,0.923171268,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.923171268,0.870965752,0.811816808,0.746174596,0.674538691,0.5974542859999999,0,0;-0.523599,0,0,0.6316417,0.713137013,0.788872054,0.8582704330000001,0.920803986,0.975996795,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.975996795,0.920803986,0.8582704330000001,0.788872054,0.713137013,0.6316417,0,0;-0.436332,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;-0.349066,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;-0.261799,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;-0.174533,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;-0.087266,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;0,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;0.087266,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;0.174533,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;0.261799,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;0.349066,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;0.436332,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;0.523599,0,0,0.6316417,0.713137013,0.788872054,0.8582704330000001,0.920803986,0.975996795,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.975996795,0.920803986,0.8582704330000001,0.788872054,0.713137013,0.6316417,0,0;0.610865,0,0,0.5974542859999999,0.674538691,0.746174596,0.811816808,0.870965752,0.923171268,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.923171268,0.870965752,0.811816808,0.746174596,0.674538691,0.5974542859999999,0,0;0.698132,0,0,0.558719885,0.630806722,0.697798298,0.759184768,0.814498944,0.86331985,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.86331985,0.814498944,0.759184768,0.697798298,0.630806722,0.558719885,0,0;0.785398,0,0,0.515733288,0.582273933,0.644111335,0.700774874,0.751833306,0.796898047,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.796898047,0.751833306,0.700774874,0.644111335,0.582273933,0.515733288,0,0;0.872665,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) annotation(Placement(visible = true, transformation(origin = {0,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    //(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, columns = {2}, table = [0, 27
    annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {1,1})));
  end ShadingLUT0;
  model shadingImport
    extends ICSolar.Parameters;
    Modelica.Blocks.Tables.CombiTable2D modShadingLUT_1(tableOnFile = true, fileName = Path + "\\shading_matrices\\" + "1" + ".txt", tableName = "shading_matrix", smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments);
    Modelica.Blocks.Tables.CombiTable2D modShadingLUT_2(tableOnFile = true, fileName = Path + "\\shading_matrices\\" + "2" + ".txt", tableName = "shading_matrix", smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments);
    Modelica.Blocks.Tables.CombiTable2D modShadingLUT_3(tableOnFile = true, fileName = Path + "\\shading_matrices\\" + "3" + ".txt", tableName = "shading_matrix", smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments);
    Modelica.Blocks.Tables.CombiTable2D modShadingLUT_4(tableOnFile = true, fileName = Path + "\\shading_matrices\\" + "4" + ".txt", tableName = "shading_matrix", smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments);
    Modelica.Blocks.Tables.CombiTable2D modShadingLUT_5(tableOnFile = true, fileName = Path + "\\shading_matrices\\" + "5" + ".txt", tableName = "shading_matrix", smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments);
    Modelica.Blocks.Tables.CombiTable2D modShadingLUT_6(tableOnFile = true, fileName = Path + "\\shading_matrices\\" + "6" + ".txt", tableName = "shading_matrix", smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments);
    Modelica.Blocks.Tables.CombiTable2D modShadingLUT_7(tableOnFile = true, fileName = Path + "\\shading_matrices\\" + "7" + ".txt", tableName = "shading_matrix", smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments);
    Modelica.Blocks.Tables.CombiTable2D modShadingLUT_8(tableOnFile = true, fileName = Path + "\\shading_matrices\\" + "8" + ".txt", tableName = "shading_matrix", smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments);
    Modelica.Blocks.Tables.CombiTable2D modShadingLUT_9(tableOnFile = true, fileName = Path + "\\shading_matrices\\" + "9" + ".txt", tableName = "shading_matrix", smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments);
    Modelica.Blocks.Tables.CombiTable2D modShadingLUT_10(tableOnFile = true, fileName = Path + "\\shading_matrices\\" + "10" + ".txt", tableName = "shading_matrix", smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments);
    Modelica.Blocks.Tables.CombiTable2D modShadingLUT_11(tableOnFile = true, fileName = Path + "\\shading_matrices\\" + "11" + ".txt", tableName = "shading_matrix", smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments);
    Modelica.Blocks.Tables.CombiTable2D modShadingLUT_12(tableOnFile = true, fileName = Path + "\\shading_matrices\\" + "12" + ".txt", tableName = "shading_matrix", smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments);
  end shadingImport;
  model Water_rhovT "Water medium with rho as a variable of input parameter T"
    extends Modelica.Thermal.FluidHeatFlow.Media.Medium(cp = 4177, cv = 4177, lamda = 0.615, nue = 8e-007);
    //rho=995.6,
    parameter Modelica.SIunits.Temperature T = 300 "Temperature of water";
    //to do...
    //refer to an external combitable (LUT) with rho V T data
    ////could just build in the combitable here -
    //that increases memory allocation but speeds up compiling, right?
    //assign rho to the value from LUT
    //go about your business
    annotation(Documentation(info = "<html>
                                        Medium: properties of water
                                        </html>"));
  end Water_rhovT;
  model testPalette
    //##############################################################################
    //##############################################################################
    Modelica.Blocks.Sources.IntegerConstant ModRow(k = 1) annotation(Placement(visible = true, transformation(origin = {-60,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Sources.IntegerConstant ModCol(k = 15) annotation(Placement(visible = true, transformation(origin = {-60,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Sources.IntegerConstant ArrRows(k = 10) annotation(Placement(visible = true, transformation(origin = {-60,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Sources.IntegerConstant ArrCols(k = 16) annotation(Placement(visible = true, transformation(origin = {-60,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    //##############################################################################
    //##############################################################################
    output Modelica.Blocks.Interfaces.IntegerOutput FractExposedTypeRow "Enumeration of FractExposed Row" annotation(Placement(visible = true, transformation(origin = {110,10}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,10}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    output Modelica.Blocks.Interfaces.IntegerOutput FractExposedTypeCol "Enumeration of FractExposed Column" annotation(Placement(visible = true, transformation(origin = {110,-10}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-10}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    output Modelica.Blocks.Interfaces.IntegerOutput FractExposedTypeRow2 "Enumeration of FractExposed Row" annotation(Placement(visible = true, transformation(origin = {110,10}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,10}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    output Modelica.Blocks.Interfaces.IntegerOutput FractExposedTypeCol2 "Enumeration of FractExposed Column" annotation(Placement(visible = true, transformation(origin = {110,-10}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-10}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    //
    //______________________________________________________________________________
    ICSolar.Module.chooseFractExposedLUTPosition choosefractexposedlutposition1 annotation(Placement(visible = true, transformation(origin = {5,-25}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  equation
    connect(ArrCols.y,choosefractexposedlutposition1.ArrayCols) annotation(Line(points = {{-49,-60},{-47.8261,-60},{-47.8261,-34.2995},{-10.628,-34.2995},{-10.628,-34.2995}}, color = {255,127,0}));
    connect(ArrRows.y,choosefractexposedlutposition1.ArrayRows) annotation(Line(points = {{-49,-20},{-46.6184,-20},{-46.6184,-28.5024},{-11.5942,-28.5024},{-11.5942,-28.5024}}, color = {255,127,0}));
    connect(ModCol.y,choosefractexposedlutposition1.ModuleCol) annotation(Line(points = {{-49,20},{-42.5121,20},{-42.5121,-22.7053},{-9.42029,-22.7053},{-9.42029,-22.7053}}, color = {255,127,0}));
    connect(ModRow.y,choosefractexposedlutposition1.ModuleRow) annotation(Line(points = {{-49,60},{-42.029,60},{-42.029,-16.1836},{-9.42029,-16.1836},{-9.42029,-16.1836}}, color = {255,127,0}));
    connect(choosefractexposedlutposition1.FractExposedTypeCol,FractExposedTypeCol) annotation(Line(points = {{20,-26.5},{42.9675,-26.5},{42.9675,-10.2009},{102.628,-10.2009},{102.628,-10.2009}}, color = {255,127,0}));
    connect(choosefractexposedlutposition1.FractExposedTypeRow,FractExposedTypeRow) annotation(Line(points = {{20,-23.5},{34.6213,-23.5},{34.6213,9.273569999999999},{102.318,9.273569999999999},{102.318,9.273569999999999}}, color = {255,127,0}));
    (FractExposedTypeRow2,FractExposedTypeCol2) = ShadingPalette(2, 16, 10, 16);
    //  connect(ArrayCols.y, choosefractexposedlutposition2.ArrayCols) annotation(Line(points = {{-49, -60}, {-35.5487, -60}, {-35.5487, 26.2751}, {-10.2009, 26.2751}, {-10.2009, 26.2751}}, color = {255, 127, 0}));
    //  connect(ArrayRows.y, choosefractexposedlutposition2.ArrayRows) annotation(Line(points = {{-49, -20}, {-41.1128, -20}, {-41.1128, 31.8393}, {-10.2009, 31.8393}, {-10.2009, 31.8393}}, color = {255, 127, 0}));
    //  connect(ModuleCol.y, choosefractexposedlutposition2.ModuleCol) annotation(Line(points = {{-49, 20}, {-44.204, 20}, {-44.204, 37.7125}, {-11.1283, 37.7125}, {-11.1283, 37.7125}}, color = {255, 127, 0}));
    //  connect(ModuleRow.y, choosefractexposedlutposition2.ModuleRow) annotation(Line(points = {{-49, 60}, {-44.204, 60}, {-44.204, 43.8949}, {-10.2009, 43.8949}, {-10.2009, 43.8949}}, color = {255, 127, 0}));
    //##############################################################################
    annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {1,1})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {0.5,0.5})));
  end testPalette;
  function ShadingPalette
    input Integer ModuleRow;
    input Integer ModuleCol;
    input Integer ArrayRows;
    input Integer ArrayCols;
    output Integer FractExposedTypeRow;
    output Integer FractExposedTypeCol;
  algorithm
    //
    //this first case is a robustness measure, solving an out-of-bounds condition
    if ModuleCol > ArrayCols then 
      FractExposedTypeCol:=3;
    elseif ModuleCol < 2 then
      FractExposedTypeCol:=1;

    elseif ModuleCol < 3 then
      FractExposedTypeCol:=2;

    elseif ModuleCol > ArrayCols - 1 then
      FractExposedTypeCol:=5;

    elseif ModuleCol > ArrayCols - 2 then
      FractExposedTypeCol:=4;
    else
      FractExposedTypeCol:=3;
    end if;
    //
    //this first case is a robustness measure, solving an out-of-bounds condition
    if ModuleRow > ArrayRows then 
      FractExposedTypeRow:=3;
    elseif ModuleRow < 2 then
      FractExposedTypeRow:=1;

    elseif ModuleRow < 3 then
      FractExposedTypeRow:=2;

    elseif ModuleRow > ArrayRows - 1 then
      FractExposedTypeRow:=5;

    elseif ModuleRow > ArrayRows - 2 then
      FractExposedTypeRow:=4;
    else
      FractExposedTypeRow:=3;
    end if;
    //##############################################################################
    annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
  end ShadingPalette;
  annotation(uses(Modelica(version = "3.2.1"), Buildings(version = "1.6")), experiment(StartTime = 7137000.0, StopTime = 7141200.0, Tolerance = 1e-006, Interval = 60));
end ICSolar;