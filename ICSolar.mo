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
    Real measured_T_s2CPVa = IC_Data_all.y[21];
    Real measured_T_s2CPVb = IC_Data_all.y[22];
    Real measured_yaw = IC_Data_all.y[23];
    Real measured_pitch = IC_Data_all.y[24];
    // Processed Data
    Real measured_T_drop_jumper = measured_T_s2m6in - measured_T_s3m1out;
    // Uncertainity Qualification
    Real UQ_measured_Egen_upper = measured_Egen + 0.73;
    Real UQ_measured_Egen_lower = measured_Egen - 0.73;
    Real UQ_measured_T_HTFout_upper = measured_T_HTFout + 2.2;
    Real UQ_measured_T_HTFout_lower = measured_T_HTFout - 2.2;
    // Ambient / Cavity Temp
    Modelica.Blocks.Sources.CombiTimeTable T_cav_in(tableOnFile = true, fileName = Path + "20150323\\T_Cav_data.txt", tableName = "T_Cav");
    Real measured_T_amb = measured_T_cavAvg;
    //  Real measured_T_amb = T_cav_in.y[1];
    /////////////////////////////
    ///  Energy / Exergy Var. ///
    /////////////////////////////
    //work in the measured flow rate vector here
    Real temp_flowport_a = ics_envelopecassette1.flowport_a.H_flow / (measured_vFlow * mediumHTF.rho * mediumHTF.cp);
    Real temp_flowport_b = abs(ics_envelopecassette1.flowport_b.H_flow / (measured_vFlow * mediumHTF.rho * mediumHTF.cp));
    Real Q_arrayTotal = abs(ics_envelopecassette1.flowport_b.H_flow) - ics_envelopecassette1.flowport_a.H_flow;
    Real Egen_arrayTotal = ics_envelopecassette1.Power_Electric;
    // Area of modules is assumed to be 0.3^2
    Real eta_Q = Q_arrayTotal / (measured_DNI * GlassArea);
    Real eta_E = ics_envelopecassette1.Power_Electric / (measured_DNI * GlassArea);
    // m_dot*cp*(1 - Tamb/T2)
    Real Ex_carnot_arrayTotal = Q_arrayTotal * (1 - TAmb / temp_flowport_b);
    // m_dot*cp*(T2 - T1 - Tamb*ln(T2/T1))
    // note "log" in OMedit is the natural log.  "log10" is log base 10 in OM
    Real Ex_arrayTotal = ics_envelopecassette1.flowport_a.m_flow * mediumHTF.cp * (temp_flowport_b - temp_flowport_a - TAmb * log(temp_flowport_b / temp_flowport_a)) + ics_envelopecassette1.Power_Electric;
    //epsilon = the Exergenic efficiency (~93% for sunlight)
    Real Ex_epsilon = Ex_arrayTotal / (measured_DNI * GlassArea * 0.93);
    ////////////////////////
    /// Init. Components ///
    ////////////////////////
    // IC Comp.
    ICSolar.ICS_Context ics_context1(SurfOrientation = 40 * 2 * Modelica.Constants.pi / 360) annotation(Placement(visible = true, transformation(origin = {-180, 40}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
    ICSolar.Envelope.ICS_EnvelopeCassette_Twelve ics_envelopecassette1 annotation(Placement(visible = true, transformation(origin = {20, 40}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
    // Fluid Comp.
    Modelica.Thermal.FluidHeatFlow.Sources.Ambient Source(medium = mediumHTF, useTemperatureInput = false, constantAmbientPressure = 101325, constantAmbientTemperature = TAmb) "Thermal fluid source" annotation(Placement(visible = true, transformation(origin = {-60, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow Pump(constantVolumeFlow = OneBranchFlow, m = 0.01, medium = mediumHTF, T0 = TAmb, T0fixed = false, useVolumeFlowInput = false) "Fluid pump for thermal fluid" annotation(Placement(visible = true, transformation(origin = {-20, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.FluidHeatFlow.Sources.Ambient Sink(medium = mediumHTF, constantAmbientPressure = 101325, constantAmbientTemperature = TAmb) "Thermal fluid sink, will be replaced with a tank later" annotation(Placement(visible = true, transformation(origin = {80, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant inletTempConst(k = inletTemp) annotation(Placement(visible = true, transformation(origin = {-160, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant PumpFlowRate(k = AllBranchesFlow) annotation(Placement(visible = true, transformation(origin = {-160, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable IC_Data_all(tableOnFile = true, fileName = Path + "20150323\\measuredData20150323r1.txt", tableName = "DNI_THTFin_vdot", nout = 24, columns = {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25}) annotation(Placement(visible = true, transformation(origin = {-120, -80}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  equation
    connect(inletTempConst.y, Source.ambientTemperature) annotation(Line(points = {{-149, -40}, {-95.2639, -40}, {-95.2639, -33.0176}, {-70.3654, -33.0176}, {-70.3654, -33.0176}}, color = {0, 0, 127}));
    connect(PumpFlowRate.y, Pump.volumeFlow) annotation(Line(points = {{-149, 0}, {-19.7564, 0}, {-19.7564, -29.77}, {-19.7564, -29.77}}, color = {0, 0, 127}));
    connect(inletTempConst.y, Source.ambientTemperature) annotation(Line(points = {{-149, -40}, {-104.736, -40}, {-104.736, -33.5589}, {-70.3654, -33.5589}, {-70.3654, -33.5589}}, color = {0, 0, 127}));
    //set the HTF temperature according to measured data
    //set flow rate according to measured data
    connect(Source.flowPort, Pump.flowPort_a) annotation(Line(points = {{-50, -40}, {-37.8122, -39.5049}, {-30, -40}}));
    connect(Pump.flowPort_b, ics_envelopecassette1.flowport_a) annotation(Line(points = {{-10, -40}, {-8.167590000000001, -39.5049}, {-4.3554, 17.6597}, {6.25, 18.75}, {-3.75, 18.75}}));
    //connect outlet of cassette
    connect(ics_envelopecassette1.flowport_b, Sink.flowPort) annotation(Line(points = {{45, 40}, {60.0812, 40}, {60.0812, -20.2977}, {70, -20.2977}, {70, -20}}, color = {255, 0, 0}));
    //connect weatherdata variables
    connect(ics_context1.AOI, ics_envelopecassette1.AOI) annotation(Line(points = {{-155, 30}, {-5, 30}}));
    connect(ics_context1.SunAzi, ics_envelopecassette1.SunAzi) annotation(Line(points = {{-155, 35}, {-5, 35}}));
    connect(ics_context1.SunAlt, ics_envelopecassette1.SunAlt) annotation(Line(points = {{-155, 40}, {-5, 40}}));
    connect(ics_context1.SurfOrientation_out, ics_envelopecassette1.SurfaceOrientation) annotation(Line(points = {{-155, 45}, {-5, 45}}));
    connect(ics_context1.SurfTilt_out, ics_envelopecassette1.SurfaceTilt) annotation(Line(points = {{-155, 50}, {-5, 50}}));
    connect(ics_context1.TDryBul, ics_envelopecassette1.TAmb_in) annotation(Line(points = {{-155, 55}, {-5, 55}}));
    connect(ics_context1.DNI, ics_envelopecassette1.DNI) annotation(Line(points = {{-155, 25}, {-5, 25}}, color = {0, 0, 127}));
    //connect measured data for DNI and cavity temperature to cassette (kept as Reals)
    connect(measured_DNI, ics_envelopecassette1.DNI_measured);
    //connect(measured_T_cavAvg, ics_envelopecassette1.Tcav_measured);
    //experiment(StartTime = 7137000.0, StopTime = 7141200.0, Tolerance = 1e-006, Interval = 100));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -100}, {200, 100}}), graphics), experiment(StartTime = 0, StopTime = 3.1536e+06, Tolerance = 1e-06, Interval = 3600));
  end ICS_Skeleton;

  model ICS_Context "This model provides the pieces necessary to set up the context to run the simulation, in FMU practice this will be cut out and provided from the EnergyPlus file"
    extends ICSolar.Parameters;
    parameter Real Lat = BuildingLatitude "Latitude";
    parameter Real SurfOrientation = BuildingOrientation "Surface orientation: Change 'S' to 'W','E', or 'N' for other orientations";
    parameter Real SurfTilt = ArrayTilt "Tilt of the ICSolar array";
    Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam = "modelica://ICSolar/weatherdata/USA_NY_New.York-Central.Park.725033_TMY3.mos", pAtmSou = Buildings.BoundaryConditions.Types.DataSource.Parameter, TDryBul(displayUnit = "K"), TDewPoi(displayUnit = "K"), totSkyCovSou = Buildings.BoundaryConditions.Types.DataSource.Parameter, opaSkyCovSou = Buildings.BoundaryConditions.Types.DataSource.Parameter, totSkyCov = 0.01, opaSkyCov = 0.01) "Weather data reader for New York Central Park" annotation(Placement(visible = true, transformation(origin = {-40, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
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
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b TDryBul "Dry bulb temperature" annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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
    connect(TOutside.port, TDryBul) annotation(Line(points = {{70, 20}, {97.8229, 0}, {100, 0}}));
    connect(weatherBus.HDirNor, DNI) "Connects Hourly Direct Normal Irradiance from the weather file to the DNI output of context";
    connect(SurfOrientation, SurfOrientation_out) "Connects Surface Orientation Parameter to Surface Orientation Output";
    connect(SurfTilt, SurfTilt_out) "Connects Surface Tilt Parameter to Surface Tilt Output";
    connect(weatherBus.TDryBul, TOutside.T) "Connects the weather file Dry Bult to the TOutside prescribed temperature model" annotation(Line(points = {{20, 20}, {47.0247, 20}, {48, 20}}));
    // connect(weatherBus, HDirTil.weaBus) "Connects the weather bus to the irradiance based on wall tilt calculation model (HDirTil)" annotation(Line(points = {{20, 20}, {19.7388, 20}, {19.7388, -17.4165}, {-3.48331, -17.4165}, {-3.48331, -40.0581}, {10, -40.0581}, {10, -40}}));
    // connect(HDirTil.inc, AOI) "Connects incident angle to angle of incidence out" annotation(Line(points = {{31, -44}, {45.5733, -44}, {45.5733, -40.0581}, {100, -40.0581}, {100, -40}}));
    connect(weatherBus.solTim, solHouAng.solTim) "Connects solar time to solar hour angle model" annotation(Line(points = {{20, 20}, {19.7388, 20}, {19.7388, -17.4165}, {-63.5704, -17.4165}, {-63.5704, -79.8258}, {-52, -79.8258}, {-52, -80}}));
    connect(weatherBus.cloTim, decAng.nDay) "Calculates clock time to day number" annotation(Line(points = {{20, 20}, {19.7388, 20}, {19.7388, -17.4165}, {-63.5704, -17.4165}, {-63.5704, -40.0581}, {-52, -40.0581}, {-52, -40}}));
    connect(weaDat.weaBus, weatherBus) "Connects weather data to weather bus" annotation(Line(points = {{-20, 20}, {20.6096, 20}, {20, 20}}));
    //Uses the decAng and solHouAng to calculate the Declination and Solar Hour angles
    SunAlt = Modelica.Math.asin(Modelica.Math.sin(Lat) * Modelica.Math.sin(decAng.decAng) + Modelica.Math.cos(Lat) * Modelica.Math.cos(decAng.decAng) * Modelica.Math.cos(solHouAng.solHouAng));
    //Eq 1.6.6 Solar Engineering of Thermal Processes - Duff & Beckman
    SunAzi = sign(Modelica.Math.sin(solHouAng.solHouAng)) * abs(Modelica.Math.acos((Modelica.Math.cos(abs(Modelica.Constants.pi / 2 - SunAlt)) * Modelica.Math.sin(Lat) - Modelica.Math.sin(decAng.decAng)) / (Modelica.Math.cos(Lat) * Modelica.Math.sin(abs(Modelica.Constants.pi / 2 - SunAlt)))));
    //Eq 1.6.2 Solar Engineering of Thermal Processes - Duff & Beckman
    // Ask about the origin of this AOI when we can get AOI from HDirTil component.
    AOI = Modelica.Math.acos(del_s * phi_s * bet_c - del_s * phi_c * bet_s * gam_c + del_c * phi_c * bet_c * omg_c + del_c * phi_s * bet_s * gam_c * omg_c + del_c * bet_s * gam_s * omg_s);
    annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), experiment(StartTime = 7084800, StopTime = 7171200, Tolerance = 1e-006, Interval = 864));
  end ICS_Context;

  package Envelope "Package of all the Envelope components to create an Integrated Concentrating Solar simulation"
    extends Modelica.Icons.Package;

    model ICS_EnvelopeCassette "This model in the Envelope Cassette (Double-Skin Facade) that houses the ICSolar Stack and Modules. This presents a building envelope"
      extends ICSolar.Parameters;
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in "Ambient cavity temperature" annotation(Placement(visible = true, transformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a(medium = mediumHTF) "Thermal fluid inflow port, before heat exchange" annotation(Placement(visible = true, transformation(origin = {-100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-95, -85}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "DNI from weather file" annotation(Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput AOI "Angle of incidence" annotation(Placement(visible = true, transformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SunAlt "Altitude of the sun " annotation(Placement(visible = true, transformation(origin = {-100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SunAzi "Azimuth of the sun " annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfaceOrientation annotation(Placement(visible = true, transformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfaceTilt annotation(Placement(visible = true, transformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput Power_Electric "Electric power generated" annotation(Placement(visible = true, transformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b(medium = mediumHTF) "Thermal fluid outflow port, after heat exchange" annotation(Placement(visible = true, transformation(origin = {100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      // Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b Power_Heat "Heat power generated" annotation(Placement(visible = true, transformation(origin = {100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      // Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort generated_enthalpy "Placeholder to make" annotation(Placement(visible = false));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature T_indoors(T = Temp_Indoor) annotation(Placement(visible = true, transformation(origin = {-20, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      ICSolar.Envelope.CavityHeatBalance cavityheatbalance1 annotation(Placement(visible = true, transformation(origin = {20, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      // ICSolar.Envelope.ICS_GlazingLosses glazingLossesInner(Trans_glaz = 0.76) annotation(Placement(visible = true, transformation(origin = {60, -60}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      ICSolar.Envelope.ICS_GlazingLosses glazingLossesOuter annotation(Placement(visible = true, transformation(origin = {-60, 60}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      ICSolar.Envelope.RotationMatrixForSphericalCood rotationmatrixforsphericalcood1 annotation(Placement(visible = true, transformation(origin = {-60, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      // Modelica.Blocks.Interfaces.RealOutput DNI_toIndoors "the DNI that slips past the modules and gets through the interior-side glazing" annotation(Placement(visible = true, transformation(origin = {100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      // ICSolar.Envelope.DNIReduction_AreaFraction dnireduction_areafraction1 annotation(Placement(visible = true, transformation(origin = {-20, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      constant Real GND = 0 "Ground input for stack power flow, Real";
      //  constant Modelica.Blocks.Sources.Constant GND(k = 0) "a zero source for the Real electrical input" annotation(Placement(visible = true, transformation(origin = {-20, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      ICSolar.Stack.ICS_Stack ics_stack1 annotation(Placement(visible = true, transformation(origin = {40, 0}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
      ICSolar.Stack.ICS_Stack2 ics_stack2 annotation(Placement(visible = true, transformation(origin = {40, -60}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
      Modelica.Blocks.Sources.CombiTimeTable DNI_measured(tableOnFile = true, fileName = Path + "20150323\\ICSFdata_DLS.txt", tableName = "DNI_THTFin_vdot", nout = 2, columns = {2});
    equation
      //  pre-stacks
      //DNI into cavity
      connect(DNI, glazingLossesOuter.DNI) annotation(Line(points = {{-100, 60}, {-75, 60}, {-75, 64}, {-70, 69}, {-75, 69}}));
      connect(AOI, glazingLossesOuter.AOI) annotation(Line(points = {{-100, 40}, {-84, 40}, {-84, 45}, {-70, 51}, {-75, 51}}));
      connect(SunAlt, rotationmatrixforsphericalcood1.SunAlt) annotation(Line(points = {{-100, 20}, {-81.46339999999999, 20}, {-81.2162, -16.5426}, {-69.75279999999999, -16.445}, {-70, -16}}, color = {0, 0, 127}));
      connect(SunAzi, rotationmatrixforsphericalcood1.SunAzi) annotation(Line(points = {{-100, 0}, {-87.0732, 0}, {-86.82599999999999, -11.9084}, {-69.75279999999999, -12.445}, {-70, -12}}, color = {0, 0, 127}));
      connect(SurfaceOrientation, rotationmatrixforsphericalcood1.SurfaceOrientation) annotation(Line(points = {{-100, -20}, {-83.9024, -20}, {-83.65519999999999, -20.2011}, {-69.75279999999999, -20.445}, {-70, -20}}, color = {0, 0, 127}));
      connect(SurfaceTilt, rotationmatrixforsphericalcood1.SurfaceTilt) annotation(Line(points = {{-100, -40}, {-85.60980000000001, -40}, {-85.3626, -24.5913}, {-69.75279999999999, -24.445}, {-70, -24}}, color = {0, 0, 127}));
      //how much self-shading
      //thermal balance
      connect(T_indoors.port, cavityheatbalance1.Interior) annotation(Line(points = {{-10, 60}, {-1.48368, 60}, {-1.48368, 55.7864}, {10, 55.7864}, {10, 56}}));
      connect(TAmb_in, cavityheatbalance1.Exterior) annotation(Line(points = {{-100, 80}, {5.04451, 80}, {5.04451, 65.8754}, {10, 66}, {10, 66}}));
      //prep the stacks inputs:
      ics_stack1.Power_in = 0;
      connect(ics_stack2.Power_in, ics_stack1.Power_out);
      connect(ics_stack2.Power_out, Power_Electric);
      connect(rotationmatrixforsphericalcood1.arrayYaw, ics_stack1.arrayYaw);
      connect(rotationmatrixforsphericalcood1.arrayPitch, ics_stack1.arrayPitch);
      connect(rotationmatrixforsphericalcood1.arrayYaw, ics_stack2.arrayYaw);
      connect(rotationmatrixforsphericalcood1.arrayPitch, ics_stack2.arrayPitch);
      //  connect(glazingLossesOuter.SurfDirNor, ics_stack1.DNI);
      // connect(glazingLossesOuter.SurfDirNor, ics_stack2.DNI);
      connect(DNI_measured.y[1], ics_stack2.DNI);
      connect(DNI_measured.y[1], ics_stack1.DNI);
      connect(ics_stack1.flowport_a1, flowport_a);
      connect(ics_stack1.flowport_b1, ics_stack2.flowport_a1);
      connect(ics_stack2.flowport_b1, flowport_b);
      connect(ics_stack1.TAmb_in, cavityheatbalance1.ICS_Heat);
      connect(ics_stack2.TAmb_in, cavityheatbalance1.ICS_Heat);
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
      Modelica.Blocks.Interfaces.RealOutput Trans_glaz_transient "momentary transmittance of exterior glazing" annotation(Placement(visible = true, transformation(origin = {100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput SurfDirNor "Surface direct normal solar irradiance" annotation(Placement(visible = true, transformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput AOI "Angle of incidence" annotation(Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "Direct normal irradiance" annotation(Placement(visible = true, transformation(origin = {-100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {-2.81, 1.48}, extent = {{-67, 33.14}, {67, -33.14}}, textString = "Glazing Losses")}), experiment(StartTime = 1, StopTime = 31536000.0, Tolerance = 1e-006, Interval = 3600));
    end ICS_GlazingLosses;

    model ICS_SelfShading "This model multiplies the DNI in by a shaded factor determined from the solar altitude and azimuth"
      Modelica.Blocks.Interfaces.RealOutput DNI_out "DNI after shading factor multiplication" annotation(Placement(visible = true, transformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI_in "DNI in before shading factor multiplication" annotation(Placement(visible = true, transformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Product product1 "Multiplication of DNI and shading factor" annotation(Placement(visible = true, transformation(origin = {20, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayPitch "pitch (up/down) angle of 2axis tracking array (rads)" annotation(Placement(visible = true, transformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayYaw "yaw (left/right) angle of tracking array (in radians)" annotation(Placement(visible = true, transformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Tables.CombiTable2D Shading(table = [0, -3.1415926, -1.04719, -0.959927, -0.872667, -0.785397, -0.6981270000000001, -0.610867, -0.523597, -0.436327, -0.349067, -0.261797, -0.174837, -0.08726730000000001, 0, 0.08726730000000001, 0.174837, 0.261797, 0.349067, 0.436327, 0.523597, 0.610867, 0.6981270000000001, 0.785397, 0.872667, 0.959927, 1.04719, 3.1415926; -0.872665, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0; -0.785398, 0, 0, 0.515733288, 0.582273933, 0.644111335, 0.700774874, 0.751833306, 0.796898047, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.796898047, 0.751833306, 0.700774874, 0.644111335, 0.582273933, 0.515733288, 0, 0; -0.698132, 0, 0, 0.558719885, 0.630806722, 0.697798298, 0.759184768, 0.814498944, 0.86331985, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.86331985, 0.814498944, 0.759184768, 0.697798298, 0.630806722, 0.558719885, 0, 0; -0.610865, 0, 0, 0.5974542859999999, 0.674538691, 0.746174596, 0.811816808, 0.870965752, 0.923171268, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.923171268, 0.870965752, 0.811816808, 0.746174596, 0.674538691, 0.5974542859999999, 0, 0; -0.523599, 0, 0, 0.6316417, 0.713137013, 0.788872054, 0.8582704330000001, 0.920803986, 0.975996795, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.975996795, 0.920803986, 0.8582704330000001, 0.788872054, 0.713137013, 0.6316417, 0, 0; -0.436332, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; -0.349066, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; -0.261799, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; -0.174533, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; -0.087266, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; 0, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; 0.087266, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; 0.174533, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; 0.261799, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; 0.349066, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; 0.436332, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; 0.523599, 0, 0, 0.6316417, 0.713137013, 0.788872054, 0.8582704330000001, 0.920803986, 0.975996795, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.975996795, 0.920803986, 0.8582704330000001, 0.788872054, 0.713137013, 0.6316417, 0, 0; 0.610865, 0, 0, 0.5974542859999999, 0.674538691, 0.746174596, 0.811816808, 0.870965752, 0.923171268, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.923171268, 0.870965752, 0.811816808, 0.746174596, 0.674538691, 0.5974542859999999, 0, 0; 0.698132, 0, 0, 0.558719885, 0.630806722, 0.697798298, 0.759184768, 0.814498944, 0.86331985, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.86331985, 0.814498944, 0.759184768, 0.697798298, 0.630806722, 0.558719885, 0, 0; 0.785398, 0, 0, 0.515733288, 0.582273933, 0.644111335, 0.700774874, 0.751833306, 0.796898047, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.796898047, 0.751833306, 0.700774874, 0.644111335, 0.582273933, 0.515733288, 0, 0; 0.872665, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]) "Shading factors based on altitude and azimuth" annotation(Placement(visible = true, transformation(origin = {-40, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(arrayYaw, Shading.u2) annotation(Line(points = {{-100, -40}, {-88.2927, -40}, {-88.2927, -45.3659}, {-32, -46}, {-52, -46}}, color = {0, 0, 127}));
      connect(arrayPitch, Shading.u1) annotation(Line(points = {{-100, -20}, {-84.39019999999999, -20}, {-84.39019999999999, -32.6829}, {-32, -34}, {-52, -34}}, color = {0, 0, 127}));
      //  connect(DNI_transmitted_table.y, DNI_transmitted) annotation(Line(points = {{-9, 0}, {33.7415, 0}, {33.7415, -20.1361}, {93.0612, -20.1361}, {93.0612, -20.1361}}, color = {0, 0, 127}));
      //  connect(rotationmatrixforsphericalcood1.SurfYaw, DNI_transmitted_table.u2) annotation(Line(points = {{-50, -34}, {-45.1701, -34}, {-45.1701, -5.71429}, {-33.7415, -5.71429}, {-33.7415, -5.71429}}, color = {0, 0, 127}));
      //  connect(rotationmatrixforsphericalcood1.SurfPitch, DNI_transmitted_table.u1) annotation(Line(points = {{-50, -44}, {-42.7211, -44}, {-42.7211, 6.80272}, {-33.4694, 6.80272}, {-33.4694, 6.80272}}, color = {0, 0, 127}));
      product1.u2 = if Shading.y < 0 then 0 else Shading.y;
      connect(product1.y, DNI_out) "DNI after multiplication connected to output of model" annotation(Line(points = {{31, 40}, {58.5909, 40}, {58.5909, 19.7775}, {100, 19.7775}, {100, 20}}));
      //connect(Shading.y,product1.u2) "Shading factor connecting to product" annotation(Line(points = {{-9,-40},{-0.741656,-40},{-0.741656,33.869},{8,33.869},{8,34}}));
      connect(DNI_in, product1.u1) "Model input DNI connecting to product" annotation(Line(points = {{-100, 80}, {-36.3412, 80}, {-36.3412, 45.9827}, {8, 45.9827}, {8, 46}}));
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {-4.59, 2.51}, extent = {{-72.63, 35.36}, {72.63, -35.36}}, textString = "Self Shading")}));
    end ICS_SelfShading;

    class RotationMatrixForSphericalCood "This models changes the reference frame from the Solar Altitude / Aizmuth to the surface yaw and pitch angles based on building orientatino and surface tilt"
      // parameter Real RollAng = 0;  Not included in current model verison
      Modelica.Blocks.Interfaces.RealOutput arrayYaw annotation(Placement(visible = true, transformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 60}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput arrayPitch annotation(Placement(visible = true, transformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -40}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
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
      arrayPitch = Modelica.Constants.pi / 2 - Modelica.Math.acos(vCartToSph[3, 1]);
      arrayYaw = (-1 * Modelica.Math.atan(vCartToSph[2, 1] / vCartToSph[1, 1])) - sign(vCartToSph[1, 1]) * Modelica.Constants.pi / 2;
      annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {16.0156, 3.67356}, extent = {{-101.49, 60.28}, {73.98, -63.83}}, textString = "Transform Matrix")}), experiment(StartTime = 0, StopTime = 86400, Tolerance = 0.001, Interval = 86.5731));
    end RotationMatrixForSphericalCood;

    model CavityHeatBalance
      extends ICSolar.Parameters;
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor Conduction_Exterior(G = 5.3 * GlassArea) "Lumped Thermal Conduction between Exterior and Cavity" annotation(Placement(visible = true, transformation(origin = {-40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Interior annotation(Placement(visible = true, transformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Exterior annotation(Placement(visible = true, transformation(origin = {-100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor CavityHeatCapacity(C = 2.072 * 1000) "Includes Air and ICS Components to add to the Heat Capacity of the Cavity" annotation(Placement(visible = true, transformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor Conduction_Interior(G = 1.7 * GlassArea) "Conduction Heat Transfer between Cavity and Interior" annotation(Placement(visible = true, transformation(origin = {40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b ICS_Heat annotation(Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(Conduction_Interior.port_a, Interior) annotation(Line(points = {{50, 20}, {101.78, 20}, {101.78, 20.4748}, {101.78, 20.4748}}));
      connect(ICS_Heat, CavityHeatCapacity.port) annotation(Line(points = {{0, -100}, {0.593472, -100}, {0.593472, 29.9703}, {0.593472, 29.9703}}));
      connect(Conduction_Interior.port_b, CavityHeatCapacity.port) annotation(Line(points = {{30, 20}, {0.296736, 20}, {0.296736, 29.3769}, {0.296736, 29.3769}}));
      connect(Conduction_Exterior.port_b, CavityHeatCapacity.port) annotation(Line(points = {{-30, 20}, {0.296736, 20}, {0.296736, 30.5638}, {0.296736, 30.5638}}));
      connect(Exterior, Conduction_Exterior.port_a) annotation(Line(points = {{-100, 20}, {-50.1484, 20}, {-50.1484, 20.4748}, {-50.1484, 20.4748}}));
      annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {2.37855, 61.2725}, extent = {{-50.45, 33.98}, {50.45, -33.98}}, textString = "Cavity"), Text(origin = {0.742849, 12.7626}, extent = {{-52.37, 30.56}, {52.37, -30.56}}, textString = "Heat"), Text(origin = {2.22528, -43.7642}, extent = {{-61.28, 22.7}, {61.28, -22.7}}, textString = "Balance")}));
    end CavityHeatBalance;

    model DNIReduction_AreaFraction "Outputs area-based fraction of DNI that enters cassette but is not intercepted by modules, due to array geometry/transient orientation."
      Modelica.Blocks.Interfaces.RealOutput DNI_out "DNI after area fraction reduction" annotation(Placement(visible = true, transformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI_in "DNI before area fraction reduction" annotation(Placement(visible = true, transformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Product product1 "Multiplication of DNI area fraction" annotation(Placement(visible = true, transformation(origin = {20, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayPitch "pitch (up/down) angle of 2axis tracking array (rads)" annotation(Placement(visible = true, transformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayYaw "yaw (left/right) angle of tracking array (in radians)" annotation(Placement(visible = true, transformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Tables.CombiTable2D AreaFraction(table = [0.0, -1.5708, -0.41888, -0.40143, -0.38397, -0.36652, -0.34907, -0.33161, -0.31416, -0.29671, -0.27925, -0.2618, -0.24435, -0.22689, -0.20944, -0.19199, -0.17453, -0.15708, -0.13963, -0.12217, -0.10472, -0.08727, -0.06981, -0.05236, -0.03491, -0.01745, 0.0, 0.01745, 0.03491, 0.05236, 0.06981, 0.08727, 0.10472, 0.12217, 0.13963, 0.15708, 0.17453, 0.19199, 0.20944, 0.22689, 0.24435, 0.2618, 0.27925, 0.29671, 0.31416, 0.33161, 0.34907, 0.36652, 0.38397, 0.40143, 0.41888, 1.5708; -1.5708, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 0.01043, 0.02084, 0.03126, 0.04168, 0.05209, 0.06251, 0.07292999999999999, 0.08334, 0.09376, 0.10418, 0.11459, 0.12501, 0.13543, 0.14584, 0.15626, 0.16668, 0.15626, 0.14584, 0.13543, 0.12501, 0.11459, 0.10418, 0.09376, 0.08334, 0.07292999999999999, 0.06251, 0.05209, 0.04168, 0.03126, 0.02084, 0.01043, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005; -0.61087, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 0.01043, 0.02084, 0.03126, 0.04168, 0.05209, 0.06251, 0.07292999999999999, 0.08334, 0.09376, 0.10418, 0.11459, 0.12501, 0.13543, 0.14584, 0.15626, 0.16668, 0.15626, 0.14584, 0.13543, 0.12501, 0.11459, 0.10418, 0.09376, 0.08334, 0.07292999999999999, 0.06251, 0.05209, 0.04168, 0.03126, 0.02084, 0.01043, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005; -0.59341, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 0.01043, 0.02084, 0.03126, 0.04168, 0.05209, 0.06251, 0.07292999999999999, 0.08334, 0.09376, 0.10418, 0.11459, 0.12501, 0.13543, 0.14584, 0.15626, 0.16668, 0.15626, 0.14584, 0.13543, 0.12501, 0.11459, 0.10418, 0.09376, 0.08334, 0.07292999999999999, 0.06251, 0.05209, 0.04168, 0.03126, 0.02084, 0.01043, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005; -0.57596, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 0.01043, 0.02084, 0.03126, 0.04168, 0.05209, 0.06251, 0.07292999999999999, 0.08334, 0.09376, 0.10418, 0.11459, 0.12501, 0.13543, 0.14584, 0.15626, 0.16668, 0.15626, 0.14584, 0.13543, 0.12501, 0.11459, 0.10418, 0.09376, 0.08334, 0.07292999999999999, 0.06251, 0.05209, 0.04168, 0.03126, 0.02084, 0.01043, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005; -0.55851, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 0.01043, 0.02084, 0.03126, 0.04168, 0.05209, 0.06251, 0.07292999999999999, 0.08334, 0.09376, 0.10418, 0.11459, 0.12501, 0.13543, 0.14584, 0.15626, 0.16668, 0.15626, 0.14584, 0.13543, 0.12501, 0.11459, 0.10418, 0.09376, 0.08334, 0.07292999999999999, 0.06251, 0.05209, 0.04168, 0.03126, 0.02084, 0.01043, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005; -0.54105, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 0.01043, 0.02084, 0.03126, 0.04168, 0.05209, 0.06251, 0.07292999999999999, 0.08334, 0.09376, 0.10418, 0.11459, 0.12501, 0.13543, 0.14584, 0.15626, 0.16668, 0.15626, 0.14584, 0.13543, 0.12501, 0.11459, 0.10418, 0.09376, 0.08334, 0.07292999999999999, 0.06251, 0.05209, 0.04168, 0.03126, 0.02084, 0.01043, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005; -0.5236, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 0.01043, 0.02084, 0.03126, 0.04168, 0.05209, 0.06251, 0.07292999999999999, 0.08334, 0.09376, 0.10418, 0.11459, 0.12501, 0.13543, 0.14584, 0.15626, 0.16668, 0.15626, 0.14584, 0.13543, 0.12501, 0.11459, 0.10418, 0.09376, 0.08334, 0.07292999999999999, 0.06251, 0.05209, 0.04168, 0.03126, 0.02084, 0.01043, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005; -0.50615, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 0.01043, 0.02084, 0.03126, 0.04168, 0.05209, 0.06251, 0.07292999999999999, 0.08334, 0.09376, 0.10418, 0.11459, 0.12501, 0.13543, 0.14584, 0.15626, 0.16668, 0.15626, 0.14584, 0.13543, 0.12501, 0.11459, 0.10418, 0.09376, 0.08334, 0.07292999999999999, 0.06251, 0.05209, 0.04168, 0.03126, 0.02084, 0.01043, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005; -0.48869, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 0.01043, 0.02084, 0.03126, 0.04168, 0.05209, 0.06251, 0.07292999999999999, 0.08334, 0.09376, 0.10418, 0.11459, 0.12501, 0.13543, 0.14584, 0.15626, 0.16668, 0.15626, 0.14584, 0.13543, 0.12501, 0.11459, 0.10418, 0.09376, 0.08334, 0.07292999999999999, 0.06251, 0.05209, 0.04168, 0.03126, 0.02084, 0.01043, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005; -0.47124, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 0.01043, 0.02084, 0.03126, 0.04168, 0.05209, 0.06251, 0.07292999999999999, 0.08334, 0.09376, 0.10418, 0.11459, 0.12501, 0.13543, 0.14584, 0.15626, 0.16668, 0.15626, 0.14584, 0.13543, 0.12501, 0.11459, 0.10418, 0.09376, 0.08334, 0.07292999999999999, 0.06251, 0.05209, 0.04168, 0.03126, 0.02084, 0.01043, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005; -0.45379, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 0.01043, 0.02084, 0.03126, 0.04168, 0.05209, 0.06251, 0.07292999999999999, 0.08334, 0.09376, 0.10418, 0.11459, 0.12501, 0.13543, 0.14584, 0.15626, 0.16668, 0.15626, 0.14584, 0.13543, 0.12501, 0.11459, 0.10418, 0.09376, 0.08334, 0.07292999999999999, 0.06251, 0.05209, 0.04168, 0.03126, 0.02084, 0.01043, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005; -0.43633, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 0.01043, 0.02084, 0.03126, 0.04168, 0.05209, 0.06251, 0.07292999999999999, 0.08334, 0.09376, 0.10418, 0.11459, 0.12501, 0.13543, 0.14584, 0.15626, 0.16668, 0.15626, 0.14584, 0.13543, 0.12501, 0.11459, 0.10418, 0.09376, 0.08334, 0.07292999999999999, 0.06251, 0.05209, 0.04168, 0.03126, 0.02084, 0.01043, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005; -0.41888, 0.00523, 0.00523, 0.00523, 0.00523, 0.00523, 0.00523, 0.00523, 0.00523, 0.00523, 0.00523, 0.01559, 0.02595, 0.03631, 0.04668, 0.05704, 0.0674, 0.07776, 0.08813, 0.09848999999999999, 0.10885, 0.11921, 0.12958, 0.13994, 0.1503, 0.16066, 0.17102, 0.16066, 0.1503, 0.13994, 0.12958, 0.11921, 0.10885, 0.09848999999999999, 0.08813, 0.07776, 0.0674, 0.05704, 0.04668, 0.03631, 0.02595, 0.01559, 0.00523, 0.00523, 0.00523, 0.00523, 0.00523, 0.00523, 0.00523, 0.00523, 0.00523, 0.00523; -0.40143, 0.01044, 0.01044, 0.01044, 0.01044, 0.01044, 0.01044, 0.01044, 0.01044, 0.01044, 0.01044, 0.02075, 0.03106, 0.04137, 0.05168, 0.06198, 0.07228999999999999, 0.08260000000000001, 0.09291000000000001, 0.10322, 0.11352, 0.12383, 0.13414, 0.14445, 0.15476, 0.16506, 0.17537, 0.16506, 0.15476, 0.14445, 0.13414, 0.12383, 0.11352, 0.10322, 0.09291000000000001, 0.08260000000000001, 0.07228999999999999, 0.06198, 0.05168, 0.04137, 0.03106, 0.02075, 0.01044, 0.01044, 0.01044, 0.01044, 0.01044, 0.01044, 0.01044, 0.01044, 0.01044, 0.01044; -0.38397, 0.01566, 0.01566, 0.01566, 0.01566, 0.01566, 0.01566, 0.01566, 0.01566, 0.01566, 0.01566, 0.02592, 0.03617, 0.04642, 0.05668, 0.06693, 0.07718, 0.08744, 0.09769, 0.10794, 0.1182, 0.12845, 0.13871, 0.14896, 0.15921, 0.16947, 0.17972, 0.16947, 0.15921, 0.14896, 0.13871, 0.12845, 0.1182, 0.10794, 0.09769, 0.08744, 0.07718, 0.06693, 0.05668, 0.04642, 0.03617, 0.02592, 0.01566, 0.01566, 0.01566, 0.01566, 0.01566, 0.01566, 0.01566, 0.01566, 0.01566, 0.01566; -0.36652, 0.02088, 0.02088, 0.02088, 0.02088, 0.02088, 0.02088, 0.02088, 0.02088, 0.02088, 0.02088, 0.03108, 0.04128, 0.05148, 0.06168, 0.07188, 0.08208, 0.09227, 0.10247, 0.11267, 0.12287, 0.13307, 0.14327, 0.15347, 0.16367, 0.17387, 0.18407, 0.17387, 0.16367, 0.15347, 0.14327, 0.13307, 0.12287, 0.11267, 0.10247, 0.09227, 0.08208, 0.07188, 0.06168, 0.05148, 0.04128, 0.03108, 0.02088, 0.02088, 0.02088, 0.02088, 0.02088, 0.02088, 0.02088, 0.02088, 0.02088, 0.02088; -0.34907, 0.0261, 0.0261, 0.0261, 0.0261, 0.0261, 0.0261, 0.0261, 0.0261, 0.0261, 0.0261, 0.03624, 0.04639, 0.05653, 0.06668, 0.07682, 0.08697000000000001, 0.09711, 0.10726, 0.1174, 0.12755, 0.13769, 0.14784, 0.15798, 0.16813, 0.17827, 0.18842, 0.17827, 0.16813, 0.15798, 0.14784, 0.13769, 0.12755, 0.1174, 0.10726, 0.09711, 0.08697000000000001, 0.07682, 0.06668, 0.05653, 0.04639, 0.03624, 0.0261, 0.0261, 0.0261, 0.0261, 0.0261, 0.0261, 0.0261, 0.0261, 0.0261, 0.0261; -0.33161, 0.03131, 0.03131, 0.03131, 0.03131, 0.03131, 0.03131, 0.03131, 0.03131, 0.03131, 0.03131, 0.0414, 0.0515, 0.06159, 0.07167999999999999, 0.08177, 0.09186, 0.10195, 0.11204, 0.12213, 0.13222, 0.14231, 0.1524, 0.16249, 0.17258, 0.18267, 0.19276, 0.18267, 0.17258, 0.16249, 0.1524, 0.14231, 0.13222, 0.12213, 0.11204, 0.10195, 0.09186, 0.08177, 0.07167999999999999, 0.06159, 0.0515, 0.0414, 0.03131, 0.03131, 0.03131, 0.03131, 0.03131, 0.03131, 0.03131, 0.03131, 0.03131, 0.03131; -0.31416, 0.03653, 0.03653, 0.03653, 0.03653, 0.03653, 0.03653, 0.03653, 0.03653, 0.03653, 0.03653, 0.04657, 0.0566, 0.06664, 0.07668, 0.08671, 0.09675, 0.10679, 0.11682, 0.12686, 0.13689, 0.14693, 0.15697, 0.167, 0.17704, 0.18708, 0.19711, 0.18708, 0.17704, 0.167, 0.15697, 0.14693, 0.13689, 0.12686, 0.11682, 0.10679, 0.09675, 0.08671, 0.07668, 0.06664, 0.0566, 0.04657, 0.03653, 0.03653, 0.03653, 0.03653, 0.03653, 0.03653, 0.03653, 0.03653, 0.03653, 0.03653; -0.29671, 0.04175, 0.04175, 0.04175, 0.04175, 0.04175, 0.04175, 0.04175, 0.04175, 0.04175, 0.04175, 0.05173, 0.06171, 0.07169, 0.08168, 0.09166000000000001, 0.10164, 0.11162, 0.1216, 0.13159, 0.14157, 0.15155, 0.16153, 0.17151, 0.1815, 0.19148, 0.20146, 0.19148, 0.1815, 0.17151, 0.16153, 0.15155, 0.14157, 0.13159, 0.1216, 0.11162, 0.10164, 0.09166000000000001, 0.08168, 0.07169, 0.06171, 0.05173, 0.04175, 0.04175, 0.04175, 0.04175, 0.04175, 0.04175, 0.04175, 0.04175, 0.04175, 0.04175; -0.27925, 0.04697, 0.04697, 0.04697, 0.04697, 0.04697, 0.04697, 0.04697, 0.04697, 0.04697, 0.04697, 0.05689, 0.06682, 0.07675, 0.08667999999999999, 0.09660000000000001, 0.10653, 0.11646, 0.12639, 0.13631, 0.14624, 0.15617, 0.1661, 0.17602, 0.18595, 0.19588, 0.20581, 0.19588, 0.18595, 0.17602, 0.1661, 0.15617, 0.14624, 0.13631, 0.12639, 0.11646, 0.10653, 0.09660000000000001, 0.08667999999999999, 0.07675, 0.06682, 0.05689, 0.04697, 0.04697, 0.04697, 0.04697, 0.04697, 0.04697, 0.04697, 0.04697, 0.04697, 0.04697; -0.2618, 0.05218, 0.05218, 0.05218, 0.05218, 0.05218, 0.05218, 0.05218, 0.05218, 0.05218, 0.05218, 0.06206, 0.07192999999999999, 0.0818, 0.09168, 0.10155, 0.11142, 0.1213, 0.13117, 0.14104, 0.15092, 0.16079, 0.17066, 0.18054, 0.19041, 0.20028, 0.21015, 0.20028, 0.19041, 0.18054, 0.17066, 0.16079, 0.15092, 0.14104, 0.13117, 0.1213, 0.11142, 0.10155, 0.09168, 0.0818, 0.07192999999999999, 0.06206, 0.05218, 0.05218, 0.05218, 0.05218, 0.05218, 0.05218, 0.05218, 0.05218, 0.05218, 0.05218; -0.24435, 0.0574, 0.0574, 0.0574, 0.0574, 0.0574, 0.0574, 0.0574, 0.0574, 0.0574, 0.0574, 0.06722, 0.07704, 0.08686000000000001, 0.09668, 0.1065, 0.11631, 0.12613, 0.13595, 0.14577, 0.15559, 0.16541, 0.17523, 0.18505, 0.19487, 0.20468, 0.2145, 0.20468, 0.19487, 0.18505, 0.17523, 0.16541, 0.15559, 0.14577, 0.13595, 0.12613, 0.11631, 0.1065, 0.09668, 0.08686000000000001, 0.07704, 0.06722, 0.0574, 0.0574, 0.0574, 0.0574, 0.0574, 0.0574, 0.0574, 0.0574, 0.0574, 0.0574; -0.22689, 0.06262, 0.06262, 0.06262, 0.06262, 0.06262, 0.06262, 0.06262, 0.06262, 0.06262, 0.06262, 0.07238, 0.08215, 0.09191000000000001, 0.10168, 0.11144, 0.12121, 0.13097, 0.14073, 0.1505, 0.16026, 0.17003, 0.17979, 0.18956, 0.19932, 0.20909, 0.21885, 0.20909, 0.19932, 0.18956, 0.17979, 0.17003, 0.16026, 0.1505, 0.14073, 0.13097, 0.12121, 0.11144, 0.10168, 0.09191000000000001, 0.08215, 0.07238, 0.06262, 0.06262, 0.06262, 0.06262, 0.06262, 0.06262, 0.06262, 0.06262, 0.06262, 0.06262; -0.20944, 0.06784, 0.06784, 0.06784, 0.06784, 0.06784, 0.06784, 0.06784, 0.06784, 0.06784, 0.06784, 0.07754999999999999, 0.08726, 0.09697, 0.10668, 0.11639, 0.1261, 0.13581, 0.14552, 0.15523, 0.16494, 0.17465, 0.18436, 0.19407, 0.20378, 0.21349, 0.2232, 0.21349, 0.20378, 0.19407, 0.18436, 0.17465, 0.16494, 0.15523, 0.14552, 0.13581, 0.1261, 0.11639, 0.10668, 0.09697, 0.08726, 0.07754999999999999, 0.06784, 0.06784, 0.06784, 0.06784, 0.06784, 0.06784, 0.06784, 0.06784, 0.06784, 0.06784; -0.19199, 0.07305, 0.07305, 0.07305, 0.07305, 0.07305, 0.07305, 0.07305, 0.07305, 0.07305, 0.07305, 0.08271000000000001, 0.09236999999999999, 0.10202, 0.11168, 0.12133, 0.13099, 0.14064, 0.1503, 0.15996, 0.16961, 0.17927, 0.18892, 0.19858, 0.20823, 0.21789, 0.22755, 0.21789, 0.20823, 0.19858, 0.18892, 0.17927, 0.16961, 0.15996, 0.1503, 0.14064, 0.13099, 0.12133, 0.11168, 0.10202, 0.09236999999999999, 0.08271000000000001, 0.07305, 0.07305, 0.07305, 0.07305, 0.07305, 0.07305, 0.07305, 0.07305, 0.07305, 0.07305; -0.17453, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.08787, 0.09747, 0.10708, 0.11668, 0.12628, 0.13588, 0.14548, 0.15508, 0.16468, 0.17429, 0.18389, 0.19349, 0.20309, 0.21269, 0.22229, 0.23189, 0.22229, 0.21269, 0.20309, 0.19349, 0.18389, 0.17429, 0.16468, 0.15508, 0.14548, 0.13588, 0.12628, 0.11668, 0.10708, 0.09747, 0.08787, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001; -0.15708, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.09304, 0.10258, 0.11213, 0.12168, 0.13122, 0.14077, 0.15032, 0.15987, 0.16941, 0.17896, 0.18851, 0.19805, 0.2076, 0.21715, 0.22669, 0.23624, 0.22669, 0.21715, 0.2076, 0.19805, 0.18851, 0.17896, 0.16941, 0.15987, 0.15032, 0.14077, 0.13122, 0.12168, 0.11213, 0.10258, 0.09304, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999; -0.13963, 0.08871, 0.08871, 0.08871, 0.08871, 0.08871, 0.08871, 0.08871, 0.08871, 0.08871, 0.08871, 0.0982, 0.10769, 0.11718, 0.12668, 0.13617, 0.14566, 0.15515, 0.16465, 0.17414, 0.18363, 0.19313, 0.20262, 0.21211, 0.2216, 0.2311, 0.24059, 0.2311, 0.2216, 0.21211, 0.20262, 0.19313, 0.18363, 0.17414, 0.16465, 0.15515, 0.14566, 0.13617, 0.12668, 0.11718, 0.10769, 0.0982, 0.08871, 0.08871, 0.08871, 0.08871, 0.08871, 0.08871, 0.08871, 0.08871, 0.08871, 0.08871; -0.12217, 0.09392, 0.09392, 0.09392, 0.09392, 0.09392, 0.09392, 0.09392, 0.09392, 0.09392, 0.09392, 0.10336, 0.1128, 0.12224, 0.13168, 0.14112, 0.15055, 0.15999, 0.16943, 0.17887, 0.18831, 0.19775, 0.20718, 0.21662, 0.22606, 0.2355, 0.24494, 0.2355, 0.22606, 0.21662, 0.20718, 0.19775, 0.18831, 0.17887, 0.16943, 0.15999, 0.15055, 0.14112, 0.13168, 0.12224, 0.1128, 0.10336, 0.09392, 0.09392, 0.09392, 0.09392, 0.09392, 0.09392, 0.09392, 0.09392, 0.09392, 0.09392; -0.10472, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.10852, 0.11791, 0.12729, 0.13668, 0.14606, 0.15544, 0.16483, 0.17421, 0.1836, 0.19298, 0.20237, 0.21175, 0.22113, 0.23052, 0.2399, 0.24929, 0.2399, 0.23052, 0.22113, 0.21175, 0.20237, 0.19298, 0.1836, 0.17421, 0.16483, 0.15544, 0.14606, 0.13668, 0.12729, 0.11791, 0.10852, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001; -0.08727, 0.10436, 0.10436, 0.10436, 0.10436, 0.10436, 0.10436, 0.10436, 0.10436, 0.10436, 0.10436, 0.11369, 0.12302, 0.13235, 0.14168, 0.15101, 0.16034, 0.16967, 0.179, 0.18833, 0.19765, 0.20698, 0.21631, 0.22564, 0.23497, 0.2443, 0.25363, 0.2443, 0.23497, 0.22564, 0.21631, 0.20698, 0.19765, 0.18833, 0.179, 0.16967, 0.16034, 0.15101, 0.14168, 0.13235, 0.12302, 0.11369, 0.10436, 0.10436, 0.10436, 0.10436, 0.10436, 0.10436, 0.10436, 0.10436, 0.10436, 0.10436; -0.06981, 0.10958, 0.10958, 0.10958, 0.10958, 0.10958, 0.10958, 0.10958, 0.10958, 0.10958, 0.10958, 0.11885, 0.12813, 0.1374, 0.14668, 0.15595, 0.16523, 0.1745, 0.18378, 0.19305, 0.20233, 0.2116, 0.22088, 0.23015, 0.23943, 0.24871, 0.25798, 0.24871, 0.23943, 0.23015, 0.22088, 0.2116, 0.20233, 0.19305, 0.18378, 0.1745, 0.16523, 0.15595, 0.14668, 0.1374, 0.12813, 0.11885, 0.10958, 0.10958, 0.10958, 0.10958, 0.10958, 0.10958, 0.10958, 0.10958, 0.10958, 0.10958; -0.05236, 0.11479, 0.11479, 0.11479, 0.11479, 0.11479, 0.11479, 0.11479, 0.11479, 0.11479, 0.11479, 0.12401, 0.13323, 0.14246, 0.15168, 0.1609, 0.17012, 0.17934, 0.18856, 0.19778, 0.207, 0.21622, 0.22544, 0.23467, 0.24389, 0.25311, 0.26233, 0.25311, 0.24389, 0.23467, 0.22544, 0.21622, 0.207, 0.19778, 0.18856, 0.17934, 0.17012, 0.1609, 0.15168, 0.14246, 0.13323, 0.12401, 0.11479, 0.11479, 0.11479, 0.11479, 0.11479, 0.11479, 0.11479, 0.11479, 0.11479, 0.11479; -0.03491, 0.12001, 0.12001, 0.12001, 0.12001, 0.12001, 0.12001, 0.12001, 0.12001, 0.12001, 0.12001, 0.12918, 0.13834, 0.14751, 0.15668, 0.16584, 0.17501, 0.18418, 0.19334, 0.20251, 0.21168, 0.22084, 0.23001, 0.23918, 0.24834, 0.25751, 0.26668, 0.25751, 0.24834, 0.23918, 0.23001, 0.22084, 0.21168, 0.20251, 0.19334, 0.18418, 0.17501, 0.16584, 0.15668, 0.14751, 0.13834, 0.12918, 0.12001, 0.12001, 0.12001, 0.12001, 0.12001, 0.12001, 0.12001, 0.12001, 0.12001, 0.12001; -0.01745, 0.12523, 0.12523, 0.12523, 0.12523, 0.12523, 0.12523, 0.12523, 0.12523, 0.12523, 0.12523, 0.13434, 0.14345, 0.15256, 0.16168, 0.17079, 0.1799, 0.18901, 0.19813, 0.20724, 0.21635, 0.22546, 0.23458, 0.24369, 0.2528, 0.26191, 0.27102, 0.26191, 0.2528, 0.24369, 0.23458, 0.22546, 0.21635, 0.20724, 0.19813, 0.18901, 0.1799, 0.17079, 0.16168, 0.15256, 0.14345, 0.13434, 0.12523, 0.12523, 0.12523, 0.12523, 0.12523, 0.12523, 0.12523, 0.12523, 0.12523, 0.12523; 0.0, 0.13044, 0.13044, 0.13044, 0.13044, 0.13044, 0.13044, 0.13044, 0.13044, 0.13044, 0.13044, 0.1395, 0.14856, 0.15762, 0.16668, 0.17573, 0.18479, 0.19385, 0.20291, 0.21197, 0.22102, 0.23008, 0.23914, 0.2482, 0.25726, 0.26631, 0.27537, 0.26631, 0.25726, 0.2482, 0.23914, 0.23008, 0.22102, 0.21197, 0.20291, 0.19385, 0.18479, 0.17573, 0.16668, 0.15762, 0.14856, 0.1395, 0.13044, 0.13044, 0.13044, 0.13044, 0.13044, 0.13044, 0.13044, 0.13044, 0.13044, 0.13044; 0.01745, 0.12523, 0.12523, 0.12523, 0.12523, 0.12523, 0.12523, 0.12523, 0.12523, 0.12523, 0.12523, 0.13434, 0.14345, 0.15256, 0.16168, 0.17079, 0.1799, 0.18901, 0.19813, 0.20724, 0.21635, 0.22546, 0.23458, 0.24369, 0.2528, 0.26191, 0.27102, 0.26191, 0.2528, 0.24369, 0.23458, 0.22546, 0.21635, 0.20724, 0.19813, 0.18901, 0.1799, 0.17079, 0.16168, 0.15256, 0.14345, 0.13434, 0.12523, 0.12523, 0.12523, 0.12523, 0.12523, 0.12523, 0.12523, 0.12523, 0.12523, 0.12523; 0.03491, 0.12001, 0.12001, 0.12001, 0.12001, 0.12001, 0.12001, 0.12001, 0.12001, 0.12001, 0.12001, 0.12918, 0.13834, 0.14751, 0.15668, 0.16584, 0.17501, 0.18418, 0.19334, 0.20251, 0.21168, 0.22084, 0.23001, 0.23918, 0.24834, 0.25751, 0.26668, 0.25751, 0.24834, 0.23918, 0.23001, 0.22084, 0.21168, 0.20251, 0.19334, 0.18418, 0.17501, 0.16584, 0.15668, 0.14751, 0.13834, 0.12918, 0.12001, 0.12001, 0.12001, 0.12001, 0.12001, 0.12001, 0.12001, 0.12001, 0.12001, 0.12001; 0.05236, 0.11479, 0.11479, 0.11479, 0.11479, 0.11479, 0.11479, 0.11479, 0.11479, 0.11479, 0.11479, 0.12401, 0.13323, 0.14246, 0.15168, 0.1609, 0.17012, 0.17934, 0.18856, 0.19778, 0.207, 0.21622, 0.22544, 0.23467, 0.24389, 0.25311, 0.26233, 0.25311, 0.24389, 0.23467, 0.22544, 0.21622, 0.207, 0.19778, 0.18856, 0.17934, 0.17012, 0.1609, 0.15168, 0.14246, 0.13323, 0.12401, 0.11479, 0.11479, 0.11479, 0.11479, 0.11479, 0.11479, 0.11479, 0.11479, 0.11479, 0.11479; 0.06981, 0.10958, 0.10958, 0.10958, 0.10958, 0.10958, 0.10958, 0.10958, 0.10958, 0.10958, 0.10958, 0.11885, 0.12813, 0.1374, 0.14668, 0.15595, 0.16523, 0.1745, 0.18378, 0.19305, 0.20233, 0.2116, 0.22088, 0.23015, 0.23943, 0.24871, 0.25798, 0.24871, 0.23943, 0.23015, 0.22088, 0.2116, 0.20233, 0.19305, 0.18378, 0.1745, 0.16523, 0.15595, 0.14668, 0.1374, 0.12813, 0.11885, 0.10958, 0.10958, 0.10958, 0.10958, 0.10958, 0.10958, 0.10958, 0.10958, 0.10958, 0.10958; 0.08727, 0.10436, 0.10436, 0.10436, 0.10436, 0.10436, 0.10436, 0.10436, 0.10436, 0.10436, 0.10436, 0.11369, 0.12302, 0.13235, 0.14168, 0.15101, 0.16034, 0.16967, 0.179, 0.18833, 0.19765, 0.20698, 0.21631, 0.22564, 0.23497, 0.2443, 0.25363, 0.2443, 0.23497, 0.22564, 0.21631, 0.20698, 0.19765, 0.18833, 0.179, 0.16967, 0.16034, 0.15101, 0.14168, 0.13235, 0.12302, 0.11369, 0.10436, 0.10436, 0.10436, 0.10436, 0.10436, 0.10436, 0.10436, 0.10436, 0.10436, 0.10436; 0.10472, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.10852, 0.11791, 0.12729, 0.13668, 0.14606, 0.15544, 0.16483, 0.17421, 0.1836, 0.19298, 0.20237, 0.21175, 0.22113, 0.23052, 0.2399, 0.24929, 0.2399, 0.23052, 0.22113, 0.21175, 0.20237, 0.19298, 0.1836, 0.17421, 0.16483, 0.15544, 0.14606, 0.13668, 0.12729, 0.11791, 0.10852, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001, 0.09914000000000001; 0.12217, 0.09392, 0.09392, 0.09392, 0.09392, 0.09392, 0.09392, 0.09392, 0.09392, 0.09392, 0.09392, 0.10336, 0.1128, 0.12224, 0.13168, 0.14112, 0.15055, 0.15999, 0.16943, 0.17887, 0.18831, 0.19775, 0.20718, 0.21662, 0.22606, 0.2355, 0.24494, 0.2355, 0.22606, 0.21662, 0.20718, 0.19775, 0.18831, 0.17887, 0.16943, 0.15999, 0.15055, 0.14112, 0.13168, 0.12224, 0.1128, 0.10336, 0.09392, 0.09392, 0.09392, 0.09392, 0.09392, 0.09392, 0.09392, 0.09392, 0.09392, 0.09392; 0.13963, 0.08871, 0.08871, 0.08871, 0.08871, 0.08871, 0.08871, 0.08871, 0.08871, 0.08871, 0.08871, 0.0982, 0.10769, 0.11718, 0.12668, 0.13617, 0.14566, 0.15515, 0.16465, 0.17414, 0.18363, 0.19313, 0.20262, 0.21211, 0.2216, 0.2311, 0.24059, 0.2311, 0.2216, 0.21211, 0.20262, 0.19313, 0.18363, 0.17414, 0.16465, 0.15515, 0.14566, 0.13617, 0.12668, 0.11718, 0.10769, 0.0982, 0.08871, 0.08871, 0.08871, 0.08871, 0.08871, 0.08871, 0.08871, 0.08871, 0.08871, 0.08871; 0.15708, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.09304, 0.10258, 0.11213, 0.12168, 0.13122, 0.14077, 0.15032, 0.15987, 0.16941, 0.17896, 0.18851, 0.19805, 0.2076, 0.21715, 0.22669, 0.23624, 0.22669, 0.21715, 0.2076, 0.19805, 0.18851, 0.17896, 0.16941, 0.15987, 0.15032, 0.14077, 0.13122, 0.12168, 0.11213, 0.10258, 0.09304, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999, 0.08348999999999999; 0.17453, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.08787, 0.09747, 0.10708, 0.11668, 0.12628, 0.13588, 0.14548, 0.15508, 0.16468, 0.17429, 0.18389, 0.19349, 0.20309, 0.21269, 0.22229, 0.23189, 0.22229, 0.21269, 0.20309, 0.19349, 0.18389, 0.17429, 0.16468, 0.15508, 0.14548, 0.13588, 0.12628, 0.11668, 0.10708, 0.09747, 0.08787, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001, 0.07827000000000001; 0.19199, 0.07305, 0.07305, 0.07305, 0.07305, 0.07305, 0.07305, 0.07305, 0.07305, 0.07305, 0.07305, 0.08271000000000001, 0.09236999999999999, 0.10202, 0.11168, 0.12133, 0.13099, 0.14064, 0.1503, 0.15996, 0.16961, 0.17927, 0.18892, 0.19858, 0.20823, 0.21789, 0.22755, 0.21789, 0.20823, 0.19858, 0.18892, 0.17927, 0.16961, 0.15996, 0.1503, 0.14064, 0.13099, 0.12133, 0.11168, 0.10202, 0.09236999999999999, 0.08271000000000001, 0.07305, 0.07305, 0.07305, 0.07305, 0.07305, 0.07305, 0.07305, 0.07305, 0.07305, 0.07305; 0.20944, 0.06784, 0.06784, 0.06784, 0.06784, 0.06784, 0.06784, 0.06784, 0.06784, 0.06784, 0.06784, 0.07754999999999999, 0.08726, 0.09697, 0.10668, 0.11639, 0.1261, 0.13581, 0.14552, 0.15523, 0.16494, 0.17465, 0.18436, 0.19407, 0.20378, 0.21349, 0.2232, 0.21349, 0.20378, 0.19407, 0.18436, 0.17465, 0.16494, 0.15523, 0.14552, 0.13581, 0.1261, 0.11639, 0.10668, 0.09697, 0.08726, 0.07754999999999999, 0.06784, 0.06784, 0.06784, 0.06784, 0.06784, 0.06784, 0.06784, 0.06784, 0.06784, 0.06784; 0.22689, 0.06262, 0.06262, 0.06262, 0.06262, 0.06262, 0.06262, 0.06262, 0.06262, 0.06262, 0.06262, 0.07238, 0.08215, 0.09191000000000001, 0.10168, 0.11144, 0.12121, 0.13097, 0.14073, 0.1505, 0.16026, 0.17003, 0.17979, 0.18956, 0.19932, 0.20909, 0.21885, 0.20909, 0.19932, 0.18956, 0.17979, 0.17003, 0.16026, 0.1505, 0.14073, 0.13097, 0.12121, 0.11144, 0.10168, 0.09191000000000001, 0.08215, 0.07238, 0.06262, 0.06262, 0.06262, 0.06262, 0.06262, 0.06262, 0.06262, 0.06262, 0.06262, 0.06262; 0.24435, 0.0574, 0.0574, 0.0574, 0.0574, 0.0574, 0.0574, 0.0574, 0.0574, 0.0574, 0.0574, 0.06722, 0.07704, 0.08686000000000001, 0.09668, 0.1065, 0.11631, 0.12613, 0.13595, 0.14577, 0.15559, 0.16541, 0.17523, 0.18505, 0.19487, 0.20468, 0.2145, 0.20468, 0.19487, 0.18505, 0.17523, 0.16541, 0.15559, 0.14577, 0.13595, 0.12613, 0.11631, 0.1065, 0.09668, 0.08686000000000001, 0.07704, 0.06722, 0.0574, 0.0574, 0.0574, 0.0574, 0.0574, 0.0574, 0.0574, 0.0574, 0.0574, 0.0574; 0.2618, 0.05218, 0.05218, 0.05218, 0.05218, 0.05218, 0.05218, 0.05218, 0.05218, 0.05218, 0.05218, 0.06206, 0.07192999999999999, 0.0818, 0.09168, 0.10155, 0.11142, 0.1213, 0.13117, 0.14104, 0.15092, 0.16079, 0.17066, 0.18054, 0.19041, 0.20028, 0.21015, 0.20028, 0.19041, 0.18054, 0.17066, 0.16079, 0.15092, 0.14104, 0.13117, 0.1213, 0.11142, 0.10155, 0.09168, 0.0818, 0.07192999999999999, 0.06206, 0.05218, 0.05218, 0.05218, 0.05218, 0.05218, 0.05218, 0.05218, 0.05218, 0.05218, 0.05218; 0.27925, 0.04697, 0.04697, 0.04697, 0.04697, 0.04697, 0.04697, 0.04697, 0.04697, 0.04697, 0.04697, 0.05689, 0.06682, 0.07675, 0.08667999999999999, 0.09660000000000001, 0.10653, 0.11646, 0.12639, 0.13631, 0.14624, 0.15617, 0.1661, 0.17602, 0.18595, 0.19588, 0.20581, 0.19588, 0.18595, 0.17602, 0.1661, 0.15617, 0.14624, 0.13631, 0.12639, 0.11646, 0.10653, 0.09660000000000001, 0.08667999999999999, 0.07675, 0.06682, 0.05689, 0.04697, 0.04697, 0.04697, 0.04697, 0.04697, 0.04697, 0.04697, 0.04697, 0.04697, 0.04697; 0.29671, 0.04175, 0.04175, 0.04175, 0.04175, 0.04175, 0.04175, 0.04175, 0.04175, 0.04175, 0.04175, 0.05173, 0.06171, 0.07169, 0.08168, 0.09166000000000001, 0.10164, 0.11162, 0.1216, 0.13159, 0.14157, 0.15155, 0.16153, 0.17151, 0.1815, 0.19148, 0.20146, 0.19148, 0.1815, 0.17151, 0.16153, 0.15155, 0.14157, 0.13159, 0.1216, 0.11162, 0.10164, 0.09166000000000001, 0.08168, 0.07169, 0.06171, 0.05173, 0.04175, 0.04175, 0.04175, 0.04175, 0.04175, 0.04175, 0.04175, 0.04175, 0.04175, 0.04175; 0.31416, 0.03653, 0.03653, 0.03653, 0.03653, 0.03653, 0.03653, 0.03653, 0.03653, 0.03653, 0.03653, 0.04657, 0.0566, 0.06664, 0.07668, 0.08671, 0.09675, 0.10679, 0.11682, 0.12686, 0.13689, 0.14693, 0.15697, 0.167, 0.17704, 0.18708, 0.19711, 0.18708, 0.17704, 0.167, 0.15697, 0.14693, 0.13689, 0.12686, 0.11682, 0.10679, 0.09675, 0.08671, 0.07668, 0.06664, 0.0566, 0.04657, 0.03653, 0.03653, 0.03653, 0.03653, 0.03653, 0.03653, 0.03653, 0.03653, 0.03653, 0.03653; 0.33161, 0.03131, 0.03131, 0.03131, 0.03131, 0.03131, 0.03131, 0.03131, 0.03131, 0.03131, 0.03131, 0.0414, 0.0515, 0.06159, 0.07167999999999999, 0.08177, 0.09186, 0.10195, 0.11204, 0.12213, 0.13222, 0.14231, 0.1524, 0.16249, 0.17258, 0.18267, 0.19276, 0.18267, 0.17258, 0.16249, 0.1524, 0.14231, 0.13222, 0.12213, 0.11204, 0.10195, 0.09186, 0.08177, 0.07167999999999999, 0.06159, 0.0515, 0.0414, 0.03131, 0.03131, 0.03131, 0.03131, 0.03131, 0.03131, 0.03131, 0.03131, 0.03131, 0.03131; 0.34907, 0.0261, 0.0261, 0.0261, 0.0261, 0.0261, 0.0261, 0.0261, 0.0261, 0.0261, 0.0261, 0.03624, 0.04639, 0.05653, 0.06668, 0.07682, 0.08697000000000001, 0.09711, 0.10726, 0.1174, 0.12755, 0.13769, 0.14784, 0.15798, 0.16813, 0.17827, 0.18842, 0.17827, 0.16813, 0.15798, 0.14784, 0.13769, 0.12755, 0.1174, 0.10726, 0.09711, 0.08697000000000001, 0.07682, 0.06668, 0.05653, 0.04639, 0.03624, 0.0261, 0.0261, 0.0261, 0.0261, 0.0261, 0.0261, 0.0261, 0.0261, 0.0261, 0.0261; 0.36652, 0.02088, 0.02088, 0.02088, 0.02088, 0.02088, 0.02088, 0.02088, 0.02088, 0.02088, 0.02088, 0.03108, 0.04128, 0.05148, 0.06168, 0.07188, 0.08208, 0.09227, 0.10247, 0.11267, 0.12287, 0.13307, 0.14327, 0.15347, 0.16367, 0.17387, 0.18407, 0.17387, 0.16367, 0.15347, 0.14327, 0.13307, 0.12287, 0.11267, 0.10247, 0.09227, 0.08208, 0.07188, 0.06168, 0.05148, 0.04128, 0.03108, 0.02088, 0.02088, 0.02088, 0.02088, 0.02088, 0.02088, 0.02088, 0.02088, 0.02088, 0.02088; 0.38397, 0.01566, 0.01566, 0.01566, 0.01566, 0.01566, 0.01566, 0.01566, 0.01566, 0.01566, 0.01566, 0.02592, 0.03617, 0.04642, 0.05668, 0.06693, 0.07718, 0.08744, 0.09769, 0.10794, 0.1182, 0.12845, 0.13871, 0.14896, 0.15921, 0.16947, 0.17972, 0.16947, 0.15921, 0.14896, 0.13871, 0.12845, 0.1182, 0.10794, 0.09769, 0.08744, 0.07718, 0.06693, 0.05668, 0.04642, 0.03617, 0.02592, 0.01566, 0.01566, 0.01566, 0.01566, 0.01566, 0.01566, 0.01566, 0.01566, 0.01566, 0.01566; 0.40143, 0.01044, 0.01044, 0.01044, 0.01044, 0.01044, 0.01044, 0.01044, 0.01044, 0.01044, 0.01044, 0.02075, 0.03106, 0.04137, 0.05168, 0.06198, 0.07228999999999999, 0.08260000000000001, 0.09291000000000001, 0.10322, 0.11352, 0.12383, 0.13414, 0.14445, 0.15476, 0.16506, 0.17537, 0.16506, 0.15476, 0.14445, 0.13414, 0.12383, 0.11352, 0.10322, 0.09291000000000001, 0.08260000000000001, 0.07228999999999999, 0.06198, 0.05168, 0.04137, 0.03106, 0.02075, 0.01044, 0.01044, 0.01044, 0.01044, 0.01044, 0.01044, 0.01044, 0.01044, 0.01044, 0.01044; 0.41888, 0.00523, 0.00523, 0.00523, 0.00523, 0.00523, 0.00523, 0.00523, 0.00523, 0.00523, 0.00523, 0.01559, 0.02595, 0.03631, 0.04668, 0.05704, 0.0674, 0.07776, 0.08813, 0.09848999999999999, 0.10885, 0.11921, 0.12958, 0.13994, 0.1503, 0.16066, 0.17102, 0.16066, 0.1503, 0.13994, 0.12958, 0.11921, 0.10885, 0.09848999999999999, 0.08813, 0.07776, 0.0674, 0.05704, 0.04668, 0.03631, 0.02595, 0.01559, 0.00523, 0.00523, 0.00523, 0.00523, 0.00523, 0.00523, 0.00523, 0.00523, 0.00523, 0.00523; 0.43633, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 0.01043, 0.02084, 0.03126, 0.04168, 0.05209, 0.06251, 0.07292999999999999, 0.08334, 0.09376, 0.10418, 0.11459, 0.12501, 0.13543, 0.14584, 0.15626, 0.16668, 0.15626, 0.14584, 0.13543, 0.12501, 0.11459, 0.10418, 0.09376, 0.08334, 0.07292999999999999, 0.06251, 0.05209, 0.04168, 0.03126, 0.02084, 0.01043, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005; 0.45379, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 0.01043, 0.02084, 0.03126, 0.04168, 0.05209, 0.06251, 0.07292999999999999, 0.08334, 0.09376, 0.10418, 0.11459, 0.12501, 0.13543, 0.14584, 0.15626, 0.16668, 0.15626, 0.14584, 0.13543, 0.12501, 0.11459, 0.10418, 0.09376, 0.08334, 0.07292999999999999, 0.06251, 0.05209, 0.04168, 0.03126, 0.02084, 0.01043, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005; 0.47124, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 0.01043, 0.02084, 0.03126, 0.04168, 0.05209, 0.06251, 0.07292999999999999, 0.08334, 0.09376, 0.10418, 0.11459, 0.12501, 0.13543, 0.14584, 0.15626, 0.16668, 0.15626, 0.14584, 0.13543, 0.12501, 0.11459, 0.10418, 0.09376, 0.08334, 0.07292999999999999, 0.06251, 0.05209, 0.04168, 0.03126, 0.02084, 0.01043, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005; 0.48869, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 0.01043, 0.02084, 0.03126, 0.04168, 0.05209, 0.06251, 0.07292999999999999, 0.08334, 0.09376, 0.10418, 0.11459, 0.12501, 0.13543, 0.14584, 0.15626, 0.16668, 0.15626, 0.14584, 0.13543, 0.12501, 0.11459, 0.10418, 0.09376, 0.08334, 0.07292999999999999, 0.06251, 0.05209, 0.04168, 0.03126, 0.02084, 0.01043, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005; 0.50615, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 0.01043, 0.02084, 0.03126, 0.04168, 0.05209, 0.06251, 0.07292999999999999, 0.08334, 0.09376, 0.10418, 0.11459, 0.12501, 0.13543, 0.14584, 0.15626, 0.16668, 0.15626, 0.14584, 0.13543, 0.12501, 0.11459, 0.10418, 0.09376, 0.08334, 0.07292999999999999, 0.06251, 0.05209, 0.04168, 0.03126, 0.02084, 0.01043, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005; 0.5236, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 0.01043, 0.02084, 0.03126, 0.04168, 0.05209, 0.06251, 0.07292999999999999, 0.08334, 0.09376, 0.10418, 0.11459, 0.12501, 0.13543, 0.14584, 0.15626, 0.16668, 0.15626, 0.14584, 0.13543, 0.12501, 0.11459, 0.10418, 0.09376, 0.08334, 0.07292999999999999, 0.06251, 0.05209, 0.04168, 0.03126, 0.02084, 0.01043, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005; 0.54105, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 0.01043, 0.02084, 0.03126, 0.04168, 0.05209, 0.06251, 0.07292999999999999, 0.08334, 0.09376, 0.10418, 0.11459, 0.12501, 0.13543, 0.14584, 0.15626, 0.16668, 0.15626, 0.14584, 0.13543, 0.12501, 0.11459, 0.10418, 0.09376, 0.08334, 0.07292999999999999, 0.06251, 0.05209, 0.04168, 0.03126, 0.02084, 0.01043, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005; 0.55851, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 0.01043, 0.02084, 0.03126, 0.04168, 0.05209, 0.06251, 0.07292999999999999, 0.08334, 0.09376, 0.10418, 0.11459, 0.12501, 0.13543, 0.14584, 0.15626, 0.16668, 0.15626, 0.14584, 0.13543, 0.12501, 0.11459, 0.10418, 0.09376, 0.08334, 0.07292999999999999, 0.06251, 0.05209, 0.04168, 0.03126, 0.02084, 0.01043, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005; 0.57596, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 0.01043, 0.02084, 0.03126, 0.04168, 0.05209, 0.06251, 0.07292999999999999, 0.08334, 0.09376, 0.10418, 0.11459, 0.12501, 0.13543, 0.14584, 0.15626, 0.16668, 0.15626, 0.14584, 0.13543, 0.12501, 0.11459, 0.10418, 0.09376, 0.08334, 0.07292999999999999, 0.06251, 0.05209, 0.04168, 0.03126, 0.02084, 0.01043, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005; 0.59341, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 0.01043, 0.02084, 0.03126, 0.04168, 0.05209, 0.06251, 0.07292999999999999, 0.08334, 0.09376, 0.10418, 0.11459, 0.12501, 0.13543, 0.14584, 0.15626, 0.16668, 0.15626, 0.14584, 0.13543, 0.12501, 0.11459, 0.10418, 0.09376, 0.08334, 0.07292999999999999, 0.06251, 0.05209, 0.04168, 0.03126, 0.02084, 0.01043, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005; 0.61087, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 0.01043, 0.02084, 0.03126, 0.04168, 0.05209, 0.06251, 0.07292999999999999, 0.08334, 0.09376, 0.10418, 0.11459, 0.12501, 0.13543, 0.14584, 0.15626, 0.16668, 0.15626, 0.14584, 0.13543, 0.12501, 0.11459, 0.10418, 0.09376, 0.08334, 0.07292999999999999, 0.06251, 0.05209, 0.04168, 0.03126, 0.02084, 0.01043, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005; 1.5708, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 0.01043, 0.02084, 0.03126, 0.04168, 0.05209, 0.06251, 0.07292999999999999, 0.08334, 0.09376, 0.10418, 0.11459, 0.12501, 0.13543, 0.14584, 0.15626, 0.16668, 0.15626, 0.14584, 0.13543, 0.12501, 0.11459, 0.10418, 0.09376, 0.08334, 0.07292999999999999, 0.06251, 0.05209, 0.04168, 0.03126, 0.02084, 0.01043, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005, 1e-005]) "AreaFraction factors based on altitude and azimuth. bottoms out before 0 to avoid div by zero errors" annotation(Placement(visible = true, transformation(origin = {-40, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(AreaFraction.y, product1.u2) annotation(Line(points = {{-29, -40}, {-15.5102, -40}, {-15.5102, 34.5578}, {7.89116, 34.5578}, {7.89116, 34.5578}}, color = {0, 0, 127}));
      connect(arrayPitch, AreaFraction.u1) annotation(Line(points = {{-100, -20}, {-84.39019999999999, -20}, {-84.39019999999999, -32.6829}, {-32, -34}, {-52, -34}}, color = {0, 0, 127}));
      connect(arrayYaw, AreaFraction.u2) annotation(Line(points = {{-100, -40}, {-88.2927, -40}, {-88.2927, -45.3659}, {-32, -46}, {-52, -46}}, color = {0, 0, 127}));
      //  product1.u2 = if AreaFraction.y < 0 then 0 else AreaFraction.y;
      connect(product1.y, DNI_out) "DNI after multiplication connected to output of model" annotation(Line(points = {{31, 40}, {58.5909, 40}, {58.5909, 19.7775}, {100, 19.7775}, {100, 20}}));
      connect(DNI_in, product1.u1) "Model input DNI connecting to product" annotation(Line(points = {{-100, 80}, {-36.3412, 80}, {-36.3412, 45.9827}, {8, 45.9827}, {8, 46}}));
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {-4.59, 2.51}, extent = {{-72.63, 35.36}, {72.63, -35.36}}, textString = "DNI x Area Fraction")}));
    end DNIReduction_AreaFraction;

    model ICS_EnvelopeCassette_Twelve "This model in the Envelope Cassette (Double-Skin Facade) that houses the ICSolar Stack and Modules. This presents a building envelope"
      extends ICSolar.Parameters;
      /// Redundant but here to true model
      //  Modelica.Blocks.Sources.CombiTimeTable IC_Data_all(tableOnFile = true, fileName = Path + "20150323\\ICSFdata_DLS.txt", tableName = "DNI_THTFin_vdot", nout = 3, columns = {2, 3, 4}) annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      Integer stackNum_1 = 1;
      Integer stackNum_2 = 2;
      //
      //______________________________________________________________________________
      Modelica.Blocks.Interfaces.RealInput AOI "Angle of incidence" annotation(Placement(visible = true, transformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SunAlt "Altitude of the sun " annotation(Placement(visible = true, transformation(origin = {-100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SunAzi "Azimuth of the sun " annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfaceOrientation annotation(Placement(visible = true, transformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfaceTilt annotation(Placement(visible = true, transformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      //
      //______________________________________________________________________________
      Modelica.Blocks.Interfaces.RealOutput Power_Electric "Electric power generated" annotation(Placement(visible = true, transformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a(medium = mediumHTF) "Thermal fluid inflow port, before heat exchange" annotation(Placement(visible = true, transformation(origin = {-100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-95, -85}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b(medium = mediumHTF) "Thermal fluid outflow port, after heat exchange" annotation(Placement(visible = true, transformation(origin = {100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature T_indoors(T = Temp_Indoor) annotation(Placement(visible = true, transformation(origin = {-20, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      ICSolar.Envelope.CavityHeatBalance cavityheatbalance1 annotation(Placement(visible = true, transformation(origin = {20, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      ICSolar.Envelope.ICS_GlazingLosses glazingLossesOuter annotation(Placement(visible = true, transformation(origin = {-60, 60}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      ICSolar.Envelope.RotationMatrixForSphericalCood rotationmatrixforsphericalcood1 annotation(Placement(visible = true, transformation(origin = {-60, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      constant Real GND = 0 annotation(Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
      ICSolar.Stack.ICS_Stack_Twelve ics_stack[NumOfStacks] annotation(Placement(visible = true, transformation(origin = {40, 0}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI_measured "DNI from data file" annotation(Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "DNI from weather file" annotation(Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in "Ambient cavity temperature" annotation(Placement(visible = true, transformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalconductor[NumOfStacks](each G = 0.2) annotation(Placement(visible = true, transformation(origin = {80, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Components.HeatedPipe Tubing[NumOfStacks](medium = mediumHTF, V_flowLaminar = OneBranchFlow, V_flowNominal = 1e-005, h_g = 0, m = 0.0025, T0 = T_HTF_start, dpLaminar = 0.45, dpNominal = 10) annotation(Placement(visible = true, transformation(origin = {40, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      //
      //______________________________________________________________________________
    equation
      // Create the number of parallel stacks
      ics_stack[1].Power_in = 0;
      for i in 1:NumOfStacks loop
        connect(glazingLossesOuter.SurfDirNor, ics_stack[i].DNI);
        connect(ics_stack[i].flowport_a1, flowport_a);
        ics_stack[i].stackNum = i;
        connect(rotationmatrixforsphericalcood1.arrayYaw, ics_stack[i].arrayYaw);
        connect(rotationmatrixforsphericalcood1.arrayPitch, ics_stack[i].arrayPitch);
        connect(ics_stack[i].TAmb_in, cavityheatbalance1.ICS_Heat);
        connect(ics_stack[i].flowport_b1, Tubing[i].flowPort_a);
        connect(Tubing[i].flowPort_b, flowport_b);
        connect(Tubing[i].heatPort, thermalconductor[i].port_a);
        connect(thermalconductor[i].port_b, cavityheatbalance1.ICS_Heat);
      end for;
      for i in 1:NumOfStacks - 1 loop
        connect(ics_stack[i].Power_out, ics_stack[i + 1].Power_in);
      end for;
      connect(ics_stack[NumOfStacks].Power_out, Power_Electric);
      connect(TAmb_in, cavityheatbalance1.Exterior) annotation(Line(points = {{-100, 80}, {5.04451, 80}, {5.04451, 65.8754}, {10, 66}, {10, 66}}));
      connect(DNI, glazingLossesOuter.DNI) annotation(Line(points = {{-100, 60}, {-75, 60}, {-75, 64}, {-70, 69}, {-75, 69}}));
      //_______________________________________________________________________________
      //pre-stacks
      //DNI into cavity
      connect(AOI, glazingLossesOuter.AOI) annotation(Line(points = {{-100, 40}, {-84, 40}, {-84, 45}, {-70, 51}, {-75, 51}}));
      connect(SunAlt, rotationmatrixforsphericalcood1.SunAlt) annotation(Line(points = {{-100, 20}, {-81.46339999999999, 20}, {-81.2162, -16.5426}, {-69.75279999999999, -16.445}, {-70, -16}}, color = {0, 0, 127}));
      connect(SunAzi, rotationmatrixforsphericalcood1.SunAzi) annotation(Line(points = {{-100, 0}, {-87.0732, 0}, {-86.82599999999999, -11.9084}, {-69.75279999999999, -12.445}, {-70, -12}}, color = {0, 0, 127}));
      connect(SurfaceOrientation, rotationmatrixforsphericalcood1.SurfaceOrientation) annotation(Line(points = {{-100, -20}, {-83.9024, -20}, {-83.65519999999999, -20.2011}, {-69.75279999999999, -20.445}, {-70, -20}}, color = {0, 0, 127}));
      connect(SurfaceTilt, rotationmatrixforsphericalcood1.SurfaceTilt) annotation(Line(points = {{-100, -40}, {-85.60980000000001, -40}, {-85.3626, -24.5913}, {-69.75279999999999, -24.445}, {-70, -24}}, color = {0, 0, 127}));
      //_______________________________________________________________________________
      //thermal balance
      connect(T_indoors.port, cavityheatbalance1.Interior) annotation(Line(points = {{-10, 60}, {-1.48368, 60}, {-1.48368, 55.7864}, {10, 55.7864}, {10, 56}}));
    end ICS_EnvelopeCassette_Twelve;
  end Envelope;

  package Stack "Package of all the necessary components to create an Integrated Concentrating Solar simulation"
    extends Modelica.Icons.Package;

    model ICS_Stack "This model represents an individual Integrated Concentrating Solar Stack"
      extends ICSolar.Parameters;
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1(medium = mediumHTF) "Thermal fluid outflow port" annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in "Ambient temperature of the cavity" annotation(Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      output Modelica.Blocks.Interfaces.RealOutput Power_out "Electrical power generated" annotation(Placement(visible = true, transformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1(medium = mediumHTF) "Thermal fluid inflow port" annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      input Modelica.Blocks.Interfaces.RealInput Power_in(start = 0) "Power input to stack from (GND?)" annotation(Placement(visible = true, transformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "DNI in from Envelope (Parent)" annotation(Placement(visible = true, transformation(origin = {-100, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayYaw annotation(Placement(visible = true, transformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayPitch annotation(Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Module.ICS_Module iCS_Module[StackHeight] annotation(Placement(visible = true, transformation(origin = {25.75, 36.25}, extent = {{-18.25, -16.25}, {18.25, 16.25}}, rotation = 0)));
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
        connect(iCS_Module[i].flowport_b1, iCS_Module[i + 1].flowport_a1);
        connect(iCS_Module[i].Power_out, iCS_Module[i + 1].Power_in);
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
        connect(iCS_Module[i].TAmb_in, TAmb_in);
      end for;
      connect(iCS_Module[1].flowport_a1, flowport_a1);
      connect(iCS_Module[StackHeight].flowport_b1, flowport_b1);
      connect(iCS_Module[1].Power_in, Power_in);
      connect(iCS_Module[StackHeight].Power_out, Power_out);
      //Manual connection of shading matrixes and products
      //Module1
      product11.u2 = if Shading11.y < 0 then 0 else Shading11.y;
      connect(product11.y, iCS_Module[1].DNI) "DNI after multiplication connected to output of model";
      connect(DNI, product11.u1) "Model input DNI connecting to product";
      connect(arrayYaw, Shading11.u2);
      connect(arrayPitch, Shading11.u1);
      //Module2
      product21.u2 = if Shading21.y < 0 then 0 else Shading21.y;
      connect(product21.y, iCS_Module[2].DNI) "DNI after multiplication connected to output of model";
      connect(DNI, product21.u1) "Model input DNI connecting to product";
      connect(arrayYaw, Shading21.u2);
      connect(arrayPitch, Shading21.u1);
      //Module3
      product31.u2 = if Shading31.y < 0 then 0 else Shading31.y;
      connect(product31.y, iCS_Module[3].DNI) "DNI after multiplication connected to output of model";
      connect(DNI, product31.u1) "Model input DNI connecting to product";
      connect(arrayYaw, Shading31.u2);
      connect(arrayPitch, Shading31.u1);
      //Module4
      product41.u2 = if Shading41.y < 0 then 0 else Shading41.y;
      connect(product41.y, iCS_Module[4].DNI) "DNI after multiplication connected to output of model";
      connect(DNI, product41.u1) "Model input DNI connecting to product";
      connect(arrayYaw, Shading41.u2);
      connect(arrayPitch, Shading41.u1);
      //Module5
      product51.u2 = if Shading51.y < 0 then 0 else Shading51.y;
      connect(product51.y, iCS_Module[5].DNI) "DNI after multiplication connected to output of model";
      connect(DNI, product51.u1) "Model input DNI connecting to product";
      connect(arrayYaw, Shading51.u2);
      connect(arrayPitch, Shading51.u1);
      //Module6
      product61.u2 = if Shading61.y < 0 then 0 else Shading61.y;
      connect(product61.y, iCS_Module[6].DNI) "DNI after multiplication connected to output of model";
      connect(DNI, product61.u1) "Model input DNI connecting to product";
      connect(arrayYaw, Shading61.u2);
      connect(arrayPitch, Shading61.u1);
      annotation(Placement(transformation(extent = {{-10, 64}, {10, 84}})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.VerticalCylinder, fillColor = {215, 215, 215}), Text(origin = {0.95, 5.29}, extent = {{-61.06, 40.08}, {61.06, -40.08}}, textString = "Stack"), Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0})}), experiment(StartTime = 0, StopTime = 315360, Tolerance = 1e-006, Interval = 3710.12), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {0, -0.288066}, extent = {{-100, 100}, {100, -100}})}));
    end ICS_Stack;

    model ICS_Stack2 "This model represents an individual Integrated Concentrating Solar Stack"
      extends ICSolar.Parameters;
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1(medium = mediumHTF) "Thermal fluid outflow port" annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in "Ambient temperature of the cavity" annotation(Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      output Modelica.Blocks.Interfaces.RealOutput Power_out "Electrical power generated" annotation(Placement(visible = true, transformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1(medium = mediumHTF) "Thermal fluid inflow port" annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      input Modelica.Blocks.Interfaces.RealInput Power_in(start = 0) "Power input to stack from (GND?)" annotation(Placement(visible = true, transformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "DNI in from Envelope (Parent)" annotation(Placement(visible = true, transformation(origin = {-100, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayYaw annotation(Placement(visible = true, transformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayPitch annotation(Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Module.ICS_Module iCS_Module[StackHeight] annotation(Placement(visible = true, transformation(origin = {25.75, 36.25}, extent = {{-18.25, -16.25}, {18.25, 16.25}}, rotation = 0)));
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
        connect(iCS_Module[i].flowport_b1, iCS_Module[i + 1].flowport_a1);
        connect(iCS_Module[i].Power_out, iCS_Module[i + 1].Power_in);
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
        connect(iCS_Module[i].TAmb_in, TAmb_in);
      end for;
      connect(iCS_Module[1].flowport_a1, flowport_a1);
      connect(iCS_Module[StackHeight].flowport_b1, flowport_b1);
      connect(iCS_Module[1].Power_in, Power_in);
      connect(iCS_Module[StackHeight].Power_out, Power_out);
      //Manual connection of shading matrixes and products
      //Module1
      product1.u2 = if Shading12.y < 0 then 0 else Shading12.y;
      connect(product1.y, iCS_Module[1].DNI) "DNI after multiplication connected to output of model";
      connect(DNI, product1.u1) "Model input DNI connecting to product";
      connect(arrayYaw, Shading12.u2);
      connect(arrayPitch, Shading12.u1);
      //Module2
      product2.u2 = if Shading22.y < 0 then 0 else Shading22.y;
      connect(product2.y, iCS_Module[2].DNI) "DNI after multiplication connected to output of model";
      connect(DNI, product2.u1) "Model input DNI connecting to product";
      connect(arrayYaw, Shading22.u2);
      connect(arrayPitch, Shading22.u1);
      //Module3
      product3.u2 = if Shading32.y < 0 then 0 else Shading32.y;
      connect(product3.y, iCS_Module[3].DNI) "DNI after multiplication connected to output of model";
      connect(DNI, product3.u1) "Model input DNI connecting to product";
      connect(arrayYaw, Shading32.u2);
      connect(arrayPitch, Shading32.u1);
      //Module4
      product4.u2 = if Shading42.y < 0 then 0 else Shading42.y;
      connect(product4.y, iCS_Module[4].DNI) "DNI after multiplication connected to output of model";
      connect(DNI, product4.u1) "Model input DNI connecting to product";
      connect(arrayYaw, Shading42.u2);
      connect(arrayPitch, Shading42.u1);
      //Module5
      product5.u2 = if Shading52.y < 0 then 0 else Shading52.y;
      connect(product5.y, iCS_Module[5].DNI) "DNI after multiplication connected to output of model";
      connect(DNI, product5.u1) "Model input DNI connecting to product";
      connect(arrayYaw, Shading52.u2);
      connect(arrayPitch, Shading52.u1);
      //Module6
      product6.u2 = if Shading62.y < 0 then 0 else Shading62.y;
      connect(product6.y, iCS_Module[6].DNI) "DNI after multiplication connected to output of model";
      connect(DNI, product6.u1) "Model input DNI connecting to product";
      connect(arrayYaw, Shading62.u2);
      connect(arrayPitch, Shading62.u1);
      annotation(Placement(transformation(extent = {{-10, 64}, {10, 84}})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.VerticalCylinder, fillColor = {215, 215, 215}), Text(origin = {0.95, 5.29}, extent = {{-61.06, 40.08}, {61.06, -40.08}}, textString = "Stack"), Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0})}), experiment(StartTime = 0, StopTime = 315360, Tolerance = 1e-006, Interval = 3710.12), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {0, -0.288066}, extent = {{-100, 100}, {100, -100}})}));
    end ICS_Stack2;

    model Shading
      Modelica.Blocks.Interfaces.RealOutput DNI_out "DNI after shading factor multiplication" annotation(Placement(visible = true, transformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Product product1 "Multiplication of DNI and shading factor" annotation(Placement(visible = true, transformation(origin = {20, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      parameter Modelica.Blocks.Interfaces.IntegerInput ShadingTable annotation(Placement(visible = true, transformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      //for picking different shading matrices:
      //  final parameter String ShadingName = String(ShadingTable);
      Modelica.Blocks.Tables.CombiTable2D Shading_matrix(tableOnFile = true, fileName = "modelica://ICSolar/ShadingTable2014.txt", tableName = ShadingName) annotation(Placement(visible = true, transformation(origin = {-40, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayPitch "pitch (up/down) angle of 2axis tracking array (rads)" annotation(Placement(visible = true, transformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayYaw "yaw (left/right) angle of tracking array (in radians)" annotation(Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI_in "DNI in before shading factor multiplication" annotation(Placement(visible = true, transformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      product1.u2 = if Shading_matrix.y < 0 then 0 else Shading_matrix.y;
      connect(product1.y, DNI_out) "DNI after multiplication connected to output of model" annotation(Line(points = {{31, 40}, {58.5909, 40}, {58.5909, 19.7775}, {100, 19.7775}, {100, 20}}));
      connect(DNI_in, product1.u1) "Model input DNI connecting to product" annotation(Line(points = {{-100, 80}, {-36.3412, 80}, {-36.3412, 45.9827}, {8, 45.9827}, {8, 46}}));
      connect(arrayYaw, Shading_matrix.u2);
      connect(arrayPitch, Shading_matrix.u1);
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {-4.59, 2.51}, extent = {{-72.63, 35.36}, {72.63, -35.36}}, textString = "Self Shading")}), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
    end Shading;

    model ICS_Stack_Twelve "This model represents an individual Integrated Concentrating Solar Stack"
      extends ICSolar.Parameters;
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1(medium = mediumHTF) "Thermal fluid outflow port" annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      output Modelica.Blocks.Interfaces.RealOutput Power_out "Electrical power generated" annotation(Placement(visible = true, transformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1(medium = mediumHTF) "Thermal fluid inflow port" annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      input Modelica.Blocks.Interfaces.RealInput Power_in(start = 0) "Power input to stack from (GND?)" annotation(Placement(visible = true, transformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "DNI in from Envelope (Parent)" annotation(Placement(visible = true, transformation(origin = {-100, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayYaw annotation(Placement(visible = true, transformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayPitch annotation(Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      //  Modelica.Blocks.Tables.CombiTable2D Shading11(tableOnFile = true, fileName = "modelica://ICSolar/ShadingTable2014.txt", tableName = "ShadingTable2014");
      ICSolar.Module.ICS_Module_Twelve ICS_Module_Twelve_1[StackHeight] annotation(Placement(visible = true, transformation(origin = {-60, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.IntegerInput stackNum annotation(Placement(visible = true, transformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in "Ambient temperature of the cavity" annotation(Placement(visible = true, transformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      //make the connections between modules: electrical and flow
      //  for i in 1:StackHeight - 1 loop
      //  connect(ICS_Module_Twelve_1[i].flowport_b1,ICS_Module_Twelve_1[i + 1].flowport_a1);
      //  connect(ICS_Module_Twelve_1[i].Power_out,ICS_Module_Twelve_1[i + 1].Power_in);
      for i in 1:StackHeight - 1 loop
        connect(ICS_Module_Twelve_1[StackHeight + 1 - i].flowport_b1, ICS_Module_Twelve_1[StackHeight - i].flowport_a1);
        connect(ICS_Module_Twelve_1[StackHeight + 1 - i].Power_out, ICS_Module_Twelve_1[StackHeight - i].Power_in);
      end for;
      //make the connections between modules and the world: DNI, T_ambient, pitch, yaw
      for i in 1:StackHeight loop
        connect(ICS_Module_Twelve_1[i].DNI, DNI);
        connect(ICS_Module_Twelve_1[i].arrayPitch, arrayPitch);
        connect(ICS_Module_Twelve_1[i].arrayYaw, arrayYaw);
        connect(ICS_Module_Twelve_1[i].TAmb_in, TAmb_in);
        ICS_Module_Twelve_1[StackHeight + 1 - i].modNum = i;
        ICS_Module_Twelve_1[StackHeight + 1 - i].stackNum = stackNum;
        //i + (stackNum - 1) * StackHeight;
      end for;
      ///////////Legacy from reversed plumbing
      //connect the inlets and outlets of the stack
      //  connect(ICS_Module_Twelve_1[1].flowport_a1,flowport_a1);
      //  connect(ICS_Module_Twelve_1[StackHeight].flowport_b1,flowport_b1);
      //  connect(ICS_Module_Twelve_1[1].Power_in,Power_in);
      //  connect(ICS_Module_Twelve_1[StackHeight].Power_out,Power_out);
      connect(ICS_Module_Twelve_1[StackHeight].flowport_a1, flowport_a1);
      connect(ICS_Module_Twelve_1[1].flowport_b1, flowport_b1);
      connect(ICS_Module_Twelve_1[StackHeight].Power_in, Power_in);
      connect(ICS_Module_Twelve_1[1].Power_out, Power_out);
      //annotation
      annotation(Placement(transformation(extent = {{-10, 64}, {10, 84}})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.VerticalCylinder, fillColor = {215, 215, 215}), Text(origin = {0.95, 5.29}, extent = {{-61.06, 40.08}, {61.06, -40.08}}, textString = "Stack"), Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0})}), experiment(StartTime = 0, StopTime = 315360, Tolerance = 1e-006, Interval = 3710.12), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {0, -0.288066}, extent = {{-100, 100}, {100, -100}})}));
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
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1(medium = mediumHTF) "Outflow port of the thermal fluid (to Parent)" annotation(Placement(visible = true, transformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1(medium = mediumHTF) "Inflow port of the thermal fluid (from Parent)" annotation(Placement(visible = true, transformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "DNI into the Module" annotation(Placement(visible = true, transformation(origin = {-100, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in "Ambient temperature of the cavity into Module model for use in the heat receiver" annotation(Placement(visible = true, transformation(origin = {-100, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      input Modelica.Blocks.Interfaces.RealInput Power_in "electrical power in from previous module or GND" annotation(Placement(visible = true, transformation(origin = {-100, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput Power_out "Electrical generation outflow (to Parent)" annotation(Placement(visible = true, transformation(origin = {100, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      ICSolar.Module.ICS_LensLosses ics_lenslosses1 annotation(Placement(visible = true, transformation(origin = {-60, -2}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      ICSolar.Module.ICS_PVPerformance ics_pvperformance1 annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-16.25, -16.25}, {16.25, 16.25}}, rotation = 0)));
      Modelica.Blocks.Math.Add add annotation(Placement(transformation(extent = {{36, 32}, {46, 42}})));
      ICSolar.Receiver.moduleReceiver modulereceiver1 "Heat Receiver to calculate the heat transfer between heat gen and heat transfered to thermal fluid" annotation(Placement(visible = true, transformation(origin = {60, 0}, extent = {{-15, -8.57144}, {15, 21.4286}}, rotation = 0)));
    equation
      connect(modulereceiver1.flowport_b1, flowport_b1) annotation(Line(points = {{75, 10.7143}, {86.535, 10.7143}, {86.535, -40.2154}, {99.4614, -40.2154}, {99.4614, -40.2154}}, color = {255, 0, 0}));
      connect(TAmb_in, modulereceiver1.TAmb_in) annotation(Line(points = {{-100, 78}, {-2.90276, 78}, {-2.90276, 13.0624}, {50, 18.2143}, {45, 18.2143}}));
      connect(ics_pvperformance1.ThermalGen, modulereceiver1.ThermalGen) annotation(Line(points = {{16.25, -7.3125}, {45.38, -7.3125}, {45.38, 6.04915}, {50, 10.7143}, {45, 10.7143}}));
      connect(modulereceiver1.flowport_a1, flowport_a1) annotation(Line(points = {{57, 21.4286}, {39.4366, 21.4286}, {39.4366, -40.1408}, {-100, -40.1408}, {-100, -40}}));
      connect(ics_lenslosses1.ConcentrationFactor, ics_pvperformance1.ConcentrationFactor) annotation(Line(points = {{-45, -11}, {-39.3195, -11}, {-39.3195, -9.82987}, {-16.25, -9.82987}, {-16.25, -9.75}}));
      connect(ics_lenslosses1.DNI_out, ics_pvperformance1.DNI_in) annotation(Line(points = {{-45, 4}, {-34.4045, 4}, {-34.4045, 0.378072}, {-16.25, 0.378072}, {-16.25, 0}}));
      connect(DNI, ics_lenslosses1.DNI_in) annotation(Line(points = {{-100, 18}, {-75, 18}, {-75, 7}}));
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
      connect(Power_in, add.u1) annotation(Line(points = {{-100, 46}, {-28, 46}, {-28, 40}, {35, 40}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(ics_pvperformance1.ElectricalGen, add.u2) annotation(Line(points = {{16.25, 6.5}, {16.25, 31.25}, {35, 31.25}, {35, 34}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(add.y, Power_out) annotation(Line(points = {{46.5, 37}, {69.25, 37}, {69.25, 54}, {100, 54}}, color = {0, 0, 127}, smooth = Smooth.None));
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
      Modelica.Blocks.Interfaces.RealOutput ElectricalGen "Real output for piping the generated electrical energy out" annotation(Placement(visible = true, transformation(origin = {100, 20}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {100, 40}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b ThermalGen "Output heat port to pipe the generated heat out and to the heat receiver" annotation(Placement(visible = true, transformation(origin = {100, -60}, extent = {{-15, -15}, {15, 15}}, rotation = 0), iconTransformation(origin = {100, -45}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
      //Modelica.Blocks.Interfaces.IntegerInput modNum annotation(Placement(visible = true, transformation(origin = {-100,80}, extent = {{-25,-25},{25,25}}, rotation = 0), iconTransformation(origin = {-80,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput ConcentrationFactor "Used to represent 'suns's for the calculation of PVEfficiency" annotation(Placement(visible = true, transformation(origin = {-100, -40}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI_in "DNI in from the Lens model (include Concentration)" annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      //##############################################################################
      Modelica.Blocks.Interfaces.RealInput PV_on annotation(Placement(visible = true, transformation(origin = {-100, 40}, extent = {{-25, -25}, {25, 25}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
    equation
      EIPC = DNI_in * CellWidth ^ 2 "Energy In Per Cell, used to calculate maximum energy on the cell";
      ElectricalGen = EIPC * CellEfficiency * PV_on "Electrical energy conversion";
      ThermalGen.Q_flow = -1 * (EIPC - ElectricalGen);
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {-3.11195, -3.79298}, extent = {{-63.55, 45.8}, {63.55, -45.8}}, textString = "PV Performance")}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
    end ICS_PVPerformance;

    model ICS_LensLosses "This model does the concentrating lens calculations: transmission losses and concentration. DNI_out is the DNI after concentration"
      extends ICSolar.Parameters;
      parameter Real Eff_Optic = OpticalEfficiency "Optical efficiency of the concentrating lens and optical device before the photovoltaic cell, value comes from ICSolar.Parameter";
      Modelica.Blocks.Interfaces.RealInput LensWidth annotation(Placement(visible = false, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput CellWidth annotation(Placement(visible = false, transformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput DNI_out annotation(Placement(visible = true, transformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput ConcentrationFactor = LensWidth ^ 2 / CellWidth ^ 2 annotation(Placement(visible = true, transformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI_in annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      DNI_out = DNI_in * Eff_Optic * ConcentrationFactor;
      annotation(Documentation(info = "<HTML>
                                                                                                                                                                                       <p><b> Tramission losses associated with the lens / optic elements. Ratio of power on the cell to power on the entry aperture.</b></p>

                                                                                                                                                                                       <p>Optical efficiency from LBI Benitez <b>High performance Fresnel-based photovoltaic concentrator</b> where Eff_Opt(F#). Assuming anti-reflective coating on secondary optic element (SOE), current Gen8 module design Eff_Opt(0.84) = 88.2%</p> 

                                                                                                                                                                                       <b>More Information:</b>
                                                                                                                                                                                       <p> The F-number for a Fresnal-Köhler lens is the ratio of the distance between cell and Fresenel lens to the diagonal measurement of the front lens. The concentrator optical efficiency is defined as the ratio of power on the cell to the power on the entry aperture when the sun is exactly on-axis.</p>
                                                                                                                                                                                       </HTML>"), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {0.694127, 36.2079}, extent = {{-72.52, 54.46}, {72.52, -54.46}}, textString = "Lens Losses")}));
    end ICS_LensLosses;

    model chooseShadeMatrix "based on a module's position in an array, choose it's shading matrix. Two modes of operation, based on the value of the isStudioExperiment boolean flag in Parameters"
      //  extends ICSolar.Envelope.ICS_EnvelopeCassette;
      //  extends ICSolar.Stack.ICS_Stack;
      extends ICSolar.Parameters;
      //  input String TestOutString (start = "initttt");
      output Modelica.Blocks.Interfaces.IntegerOutput ShadeMatrixEnum "Enumeration of shading matrix" annotation(Placement(visible = true, transformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      parameter Modelica.Blocks.Interfaces.IntegerInput ModuleColumn "Module Column" annotation(Placement(visible = true, transformation(origin = {-60, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      parameter Modelica.Blocks.Interfaces.IntegerInput ModuleRow "Module Row" annotation(Placement(visible = true, transformation(origin = {-60, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    algorithm
      //step through the rows outer and columns inner, assigning shadeMatrix enumeration
      if isStudioExperiment then
        if ModuleRow == 1 then
          if ModuleColumn == 1 then
            ShadeMatrixEnum := 11;
          elseif ModuleColumn == 2 then
            ShadeMatrixEnum := 12;
          end if;
        elseif ModuleRow == 2 then
          if ModuleColumn == 1 then
            ShadeMatrixEnum := 21;
          elseif ModuleColumn == 2 then
            ShadeMatrixEnum := 22;
          end if;
        elseif ModuleRow == 3 then
          if ModuleColumn == 1 then
            ShadeMatrixEnum := 31;
          elseif ModuleColumn == 2 then
            ShadeMatrixEnum := 32;
          end if;
        elseif ModuleRow == 4 then
          if ModuleColumn == 1 then
            ShadeMatrixEnum := 41;
          elseif ModuleColumn == 2 then
            ShadeMatrixEnum := 42;
          end if;
        elseif ModuleRow == 5 then
          if ModuleColumn == 1 then
            ShadeMatrixEnum := 51;
          elseif ModuleColumn == 2 then
            ShadeMatrixEnum := 52;
          end if;
        elseif ModuleRow == 6 then
          if ModuleColumn == 1 then
            ShadeMatrixEnum := 61;
          elseif ModuleColumn == 2 then
            ShadeMatrixEnum := 62;
          end if;
        end if;
      else
        if ModuleRow == 1 then
          if ModuleColumn == 1 then
            ShadeMatrixEnum := 11;
          elseif ModuleColumn == 2 then
            ShadeMatrixEnum := 12;
          elseif ModuleColumn == NumOfStacks - 1 then
            ShadeMatrixEnum := 18;
          elseif ModuleColumn == NumOfStacks then
            ShadeMatrixEnum := 19;
          else
            ShadeMatrixEnum := 15;
          end if;
        elseif ModuleRow == 2 then
          if ModuleColumn == 1 then
            ShadeMatrixEnum := 21;
          elseif ModuleColumn == 2 then
            ShadeMatrixEnum := 22;
          elseif ModuleColumn == NumOfStacks - 1 then
            ShadeMatrixEnum := 28;
          elseif ModuleColumn == NumOfStacks then
            ShadeMatrixEnum := 29;
          else
            ShadeMatrixEnum := 25;
          end if;
        elseif ModuleRow == StackHeight - 1 then
          if ModuleColumn == 1 then
            ShadeMatrixEnum := 81;
          elseif ModuleColumn == 2 then
            ShadeMatrixEnum := 82;
          elseif ModuleColumn == NumOfStacks - 1 then
            ShadeMatrixEnum := 88;
          elseif ModuleColumn == NumOfStacks then
            ShadeMatrixEnum := 89;
          else
            ShadeMatrixEnum := 85;
          end if;
        elseif ModuleRow == StackHeight then
          if ModuleColumn == 1 then
            ShadeMatrixEnum := 91;
          elseif ModuleColumn == 2 then
            ShadeMatrixEnum := 92;
          elseif ModuleColumn == NumOfStacks - 1 then
            ShadeMatrixEnum := 98;
          elseif ModuleColumn == NumOfStacks then
            ShadeMatrixEnum := 99;
          else
            ShadeMatrixEnum := 95;
          end if;
        else
          ShadeMatrixEnum := 55;
        end if;
      end if;
      annotation(Icon(coordinateSystem(extent = {{-60, -60}, {60, 60}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-60, -60}, {60, 60}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {0, 0}, extent = {{-60, 60}, {60, -60}})}));
    end chooseShadeMatrix;

    model chooseFractExposedLUTPosition "based on a module's position in an ICSF array, choose it's position in the 5x5 array of 'shading' types. Outputs a 2D vector somewhere in the space of [1:5 1:5]"
      extends ICSolar.Parameters;
      //
      //extends ICSolar.Parameters;
      //
      //______________________________________________________________________________
      Modelica.Blocks.Interfaces.IntegerInput ModuleRow "Module Row" annotation(Placement(visible = true, transformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.IntegerInput ModuleCol "Module Column" annotation(Placement(visible = true, transformation(origin = {-100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Integer ArrayRows = StackHeight "Rows in Array" annotation(Placement(visible = true, transformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Integer ArrayCols = NumOfStacks "Columns in Array" annotation(Placement(visible = true, transformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      //
      //______________________________________________________________________________
      //
      //______________________________________________________________________________
      output Modelica.Blocks.Interfaces.IntegerOutput FractExposedTypeCol "Enumeration of FractExposed Column" annotation(Placement(visible = true, transformation(origin = {110, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      output Modelica.Blocks.Interfaces.IntegerOutput FractExposedTypeRow "Enumeration of FractExposed Row" annotation(Placement(visible = true, transformation(origin = {110, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    algorithm
      //
      //this first case is a robustness measure, solving an out-of-bounds condition
      if ModuleCol > ArrayCols then
        FractExposedTypeCol := 3;
      elseif ModuleCol < 2 then
        FractExposedTypeCol := 1;
      elseif ModuleCol < 3 then
        FractExposedTypeCol := 2;
      elseif ModuleCol > ArrayCols - 1 then
        FractExposedTypeCol := 5;
      elseif ModuleCol > ArrayCols - 2 then
        FractExposedTypeCol := 4;
      else
        FractExposedTypeCol := 3;
      end if;
      //
      //this first case is a robustness measure, solving an out-of-bounds condition
      if ModuleRow > ArrayRows then
        FractExposedTypeRow := 3;
      elseif ModuleRow < 2 then
        FractExposedTypeRow := 1;
      elseif ModuleRow < 3 then
        FractExposedTypeRow := 2;
      elseif ModuleRow > ArrayRows - 1 then
        FractExposedTypeRow := 5;
      elseif ModuleRow > ArrayRows - 2 then
        FractExposedTypeRow := 4;
      else
        FractExposedTypeRow := 3;
      end if;
      //##############################################################################
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {0, 0}, extent = {{-100, 100}, {100, -100}})}), Documentation(info = "<html>
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
      Modelica.SIunits.Length LensWidth = 0.25019 "Width of Fresnel Lens, meters";
      Modelica.SIunits.Length CellWidth = 0.01 "Width of the PV cell, meters";
      Real measured_eGen_on = eGen_on.y[modNum];
      //Stores only column related to module of interests
      //  parameter String FresMat = "PMMA" "'PMMA' or 'Silicon on Glass', use the exact spellings provided";
      //  parameter Real FNum = 0.85 "FNum determines the lens transmittance based on concentrating";
      //  Integer FMatNum "Integer used to pipe the material to other models";
      // Adding in temperature outputs for truing-up model (5.3.15)_kP
      Modelica.Blocks.Sources.CombiTimeTable eGen_on(tableOnFile = true, fileName = Path + "EgenIO.txt", tableName = "EgenIO", nout = 12, columns = {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13}, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint);
      // Imports the entire eGen matri
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1(medium = mediumHTF) "Outflow port of the thermal fluid (to Parent)" annotation(Placement(visible = true, transformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1(medium = mediumHTF) "Inflow port of the thermal fluid (from Parent)" annotation(Placement(visible = true, transformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in "Ambient temperature of the cavity into Module model for use in the heat receiver" annotation(Placement(visible = true, transformation(origin = {-100, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      ICSolar.Receiver.moduleReceiver modulereceiver1 "Heat Receiver to calculate the heat transfer between heat gen and heat transfered to thermal fluid" annotation(Placement(visible = true, transformation(origin = {65, -5}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      ICSolar.Module.ICS_LensLosses ics_lenslosses1 annotation(Placement(visible = true, transformation(origin = {-60, -2}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
      ICSolar.Module.ICS_PVPerformance ics_pvperformance1 annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-16.25, -16.25}, {16.25, 16.25}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput Power_out "Electrical generation outflow (to Parent)" annotation(Placement(visible = true, transformation(origin = {100, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayPitch "pass pitch to module" annotation(Placement(visible = true, transformation(origin = {-100, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput Power_in "electrical power in from previous module or GND" annotation(Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput arrayYaw "pass yaw to module" annotation(Placement(visible = true, transformation(origin = {-100, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.IntegerInput stackNum annotation(Placement(visible = true, transformation(origin = {-100, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "DNI into the Module" annotation(Placement(visible = true, transformation(origin = {-100, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.IntegerInput modNum annotation(Placement(visible = true, transformation(origin = {-100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Add add annotation(Placement(visible = true, transformation(origin = {40, 40}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      ICSolar.ShadingFraction_Function shadingfraction_function1 annotation(Placement(visible = true, transformation(origin = {-60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Product shadeProduct annotation(Placement(visible = true, transformation(origin = {-20, 40}, extent = {{-8.125, -8.125}, {8.125, 8.125}}, rotation = 0)));
      ICSolar.Module.chooseFractExposedLUTPosition choosefractexposedlutposition1 annotation(Placement(visible = true, transformation(origin = {-60, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(choosefractexposedlutposition1.ModuleCol, stackNum);
      connect(choosefractexposedlutposition1.ModuleRow, modNum);
      connect(choosefractexposedlutposition1.FractExposedTypeCol, shadingfraction_function1.colType) annotation(Line(points = {{-50, -81}, {-35.9946, -81}, {-35.9946, -17.0501}, {-83.3559, -17.0501}, {-83.3559, 39.5129}, {-70.9066, 39.5129}, {-70.9066, 39.5129}, {-70.9066, 39.5129}}, color = {255, 127, 0}));
      connect(choosefractexposedlutposition1.FractExposedTypeRow, shadingfraction_function1.rowType) annotation(Line(points = {{-50, -79}, {-38.7009, -79}, {-38.7009, -18.4032}, {-85.2503, -18.4032}, {-85.2503, 43.843}, {-71.1773, 43.843}, {-71.1773, 43.843}}, color = {255, 127, 0}));
      connect(arrayYaw, shadingfraction_function1.arrayYaw) annotation(Line(points = {{-100, 50}, {-77.9432, 50}, {-77.9432, 31.6644}, {-70.9066, 31.6644}, {-70.9066, 31.6644}}, color = {0, 0, 127}));
      connect(arrayPitch, shadingfraction_function1.arrayPitch) annotation(Line(points = {{-100, 30}, {-81.4614, 30}, {-81.4614, 35.724}, {-71.1773, 35.724}, {-71.1773, 35.724}}, color = {0, 0, 127}));
      connect(shadeProduct.u2, shadingfraction_function1.SOLAR_frac) annotation(Line(points = {{-50, 40}, {-42.2192, 40}, {-42.2192, 34.1001}, {-30.8525, 34.1001}, {-30.8525, 34.1001}}, color = {0, 0, 127}));
      connect(shadeProduct.u1, DNI) annotation(Line(points = {{-100, 18}, {-37.3478, 18}, {-37.3478, 44.3843}, {-30.8525, 44.3843}, {-30.8525, 44.3843}}, color = {0, 0, 127}));
      connect(shadeProduct.y, ics_lenslosses1.DNI_in) annotation(Line(points = {{-11.0625, 40}, {-6.7659, 40}, {-6.7659, 14.3437}, {-82.8146, 14.3437}, {-82.8146, 6.49526}, {-75.5074, 6.49526}, {-75.5074, 6.49526}}, color = {0, 0, 127}));
      ics_lenslosses1.LensWidth = LensWidth "Connects LensWidth defined in Module to Lens LensWidth";
      ics_lenslosses1.CellWidth = CellWidth "Connect CellWidth defined in Module to CellWidth in Lens";
      connect(ics_lenslosses1.ConcentrationFactor, ics_pvperformance1.ConcentrationFactor) annotation(Line(points = {{-45, -11}, {-39.3195, -11}, {-39.3195, -9.82987}, {-16.25, -9.82987}, {-16.25, -9.75}}));
      connect(ics_lenslosses1.DNI_out, ics_pvperformance1.DNI_in) annotation(Line(points = {{-45, 4}, {-34.4045, 4}, {-34.4045, 0.378072}, {-16.25, 0.378072}, {-16.25, 0}}));
      connect(ics_pvperformance1.ThermalGen, modulereceiver1.ThermalGen) annotation(Line(points = {{16.25, -7.3125}, {45.38, -7.3125}, {45.38, 6.04915}, {50, 6.04915}, {50, -0.714286}}));
      connect(ics_pvperformance1.ElectricalGen, add.u2) annotation(Line(points = {{16.25, 6.5}, {16.25, 31.25}, {34, 31.25}, {34, 37}}, color = {0, 0, 127}));
      connect(Power_in, add.u1) annotation(Line(points = {{-100, 60}, {-28, 60}, {34, 40}, {34, 43}}, color = {0, 0, 127}));
      connect(add.y, Power_out) annotation(Line(points = {{45.5, 40}, {69.25, 40}, {69.25, 54}, {100, 54}}, color = {0, 0, 127}));
      connect(modulereceiver1.flowport_b1, flowport_b1) annotation(Line(points = {{80, 5.71429}, {86.535, 5.71429}, {86.535, -40.2154}, {99.4614, -40.2154}, {99.4614, -40.2154}}, color = {255, 0, 0}));
      connect(modulereceiver1.TAmb_in, TAmb_in) annotation(Line(points = {{-100, 78}, {-2.90276, 78}, {-2.90276, 13.0624}, {50, 13.0624}, {50, 6.78571}}));
      connect(modulereceiver1.flowport_a1, flowport_a1) "Connect pump flow the heat receiver" annotation(Line(points = {{62, 10}, {39.4366, 10}, {39.4366, -40.1408}, {-100, -40.1408}, {-100, -40}}));
      connect(measured_eGen_on, ics_pvperformance1.PV_on);
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {-1.41, 9.98}, extent = {{-67.14, 46.6}, {67.14, -46.6}}, textString = "Module")}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
    end ICS_Module_Twelve;
  end Module;

  package Receiver "Package of all the necessary components to create an Integrated Concentrating Solar simulation"
    extends Modelica.Icons.Package;

    model moduleReceiver
      extends ICSolar.Parameters;
      Real temp_flowport_a = water_Block_HX1.flowport_a1.H_flow / (water_Block_HX1.flowport_a1.m_flow * mediumHTF.cp);
      Real temp_flowport_b = abs(water_Block_HX1.flowport_b1.H_flow / (flowport_a1.m_flow * mediumHTF.cp));
      ICSolar.Receiver.subClasses.receiverInternalEnergy receiverInternalEnergy1 annotation(Placement(visible = true, transformation(origin = {-158.447, -48.4473}, extent = {{-23.4473, -23.4473}, {23.4473, 23.4473}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1(medium = mediumHTF) annotation(Placement(visible = true, transformation(origin = {200, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {200, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in annotation(Placement(visible = true, transformation(origin = {-200, 170}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-200, 170}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermalGen annotation(Placement(visible = true, transformation(origin = {-200, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-200, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1(medium = mediumHTF) annotation(Placement(visible = true, transformation(origin = {-200, 40}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-40, 200}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      ICSolar.Receiver.subClasses.Water_Block_HX water_Block_HX1 annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-33.4646, -33.4646}, {33.4646, 33.4646}}, rotation = 0)));
      ICSolar.Receiver.subClasses.Tubing_Losses tubing_Losses1(Tubing(medium = mediumHTF, m = 0.0023, T0 = 298.15, V_flowLaminar(displayUnit = "l/min") = 4.1666666666667e-006, dpLaminar(displayUnit = "kPa") = 1000, V_flowNominal(displayUnit = "l/min") = 0.00041666666666667, dpNominal(displayUnit = "kPa") = 100000, h_g = 0.3)) annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-31.4355, -31.4355}, {31.4355, 31.4355}}, rotation = 0)));
    equation
      connect(tubing_Losses1.flowport_b1, flowport_b1) annotation(Line(points = {{131.435, 0}, {137.358, 0}, {137.358, 58.1132}, {200, 58.1132}, {200, 60}}));
      connect(TAmb_in, tubing_Losses1.port_a) annotation(Line(points = {{-200, 170}, {123.541, 170}, {123.541, -23.164}, {92.2496, -22.0048}, {132.064, -22.0048}}));
      connect(water_Block_HX1.flowport_b1, tubing_Losses1.flowport_a1) annotation(Line(points = {{34.1339, -1.33858}, {16.7742, -1.33858}, {16.7742, -0.860215}, {30.5376, 0}, {68.5645, 0}}, color = {255, 0, 0}));
      connect(TAmb_in, water_Block_HX1.heatLoss_to_ambient) annotation(Line(points = {{-200, 170}, {-140, 170}, {-33.4646, 3.4646}, {-33.4646, 0}}, color = {191, 0, 0}));
      connect(flowport_a1, water_Block_HX1.flowport_a1) annotation(Line(points = {{-200, 40}, {-130, 40}, {-130, 13.3858}, {-33.4646, 13.3858}}, color = {255, 0, 0}));
      connect(receiverInternalEnergy1.port_b, water_Block_HX1.heatCap_waterBlock) annotation(Line(points = {{-135, -34.3789}, {-85, -34.3789}, {-85, -25}, {-61.9292, -26.7717}, {-33.4646, -26.7717}}, color = {191, 0, 0}));
      connect(ThermalGen, water_Block_HX1.energyFrom_CCA) annotation(Line(points = {{-200, -10}, {-119.049, -10}, {-119.049, -9.75}, {-61.929, -13.3858}, {-33.4646, -13.3858}}));
      annotation(Diagram(coordinateSystem(extent = {{-200, -80}, {200, 200}}, preserveAspectRatio = false, initialScale = 0.1, grid = {10, 10}), graphics = {Text(origin = {12.5, 110}, fillPattern = FillPattern.Solid, extent = {{-42.5, -5}, {42.5, 5}}, textString = "Bring the Ambient Sources and pump Outside the Class ", fontName = "Arial")}), Icon(coordinateSystem(extent = {{-200, -80}, {200, 200}}, preserveAspectRatio = false, initialScale = 0.1, grid = {10, 10}), graphics = {Text(origin = {3.12, 117.49}, extent = {{-133.92, 40.92}, {133.92, -40.92}}, textString = "Heat"), Text(origin = {9.854509999999999, 16.9292}, extent = {{-154.79, 56.03}, {154.79, -56.03}}, textString = "Receiver")}));
    end moduleReceiver;

    package subClasses "Contains the subClasses for receiver"
      extends Modelica.Icons.Package;

      connector Egen_port
        Modelica.SIunits.Power p "Power in Watts at the port" annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(points = {{100, 100}, {-100, 100}, {-100, -100}, {100, -100}, {100, 100}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Text(extent = {{-150, -90}, {150, -150}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid, textString = "%name"), Polygon(points = {{70, 70}, {-70, 70}, {-70, -70}, {70, -70}, {70, 70}}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid)}), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(points = {{100, 100}, {-100, 100}, {-100, -100}, {100, -100}, {100, 100}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{70, 70}, {-70, 70}, {-70, -70}, {70, -70}, {70, 70}}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid)}));
      end Egen_port;

      class receiverInternalEnergy
        extends ICSolar.Parameters;
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation(Placement(visible = true, transformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatcapacitor1(C = HeatCap_Receiver) "60 J/K is calculated in spreadsheet in 1-DOCS\\calculators ...thermal mass or heat capacity of receiver.xlsx" annotation(Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
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
        extends ICSolar.Parameters;
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1(medium = mediumHTF) annotation(Placement(visible = true, transformation(origin = {100.0, 40.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0), iconTransformation(origin = {102.0, -4.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1(medium = mediumHTF) annotation(Placement(visible = true, transformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalconductor1(G = Cond_RecToEnv) annotation(Placement(visible = true, transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.Convection convection1 annotation(Placement(visible = true, transformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a energyFrom_CCA annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCap_waterBlock annotation(Placement(visible = true, transformation(origin = {-100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatLoss_to_ambient annotation(Placement(visible = true, transformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalcollector1 annotation(Placement(visible = true, transformation(origin = {-20, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.FluidHeatFlow.Components.HeatedPipe heatedpipe1(h_g = 0, T0 = TAmb, medium = mediumHTF, T(start = TAmb), pressureDrop(fixed = false), T0fixed = false, m = 0.003, dpNominal(displayUnit = "kPa") = 62270, V_flowLaminar(displayUnit = "l/min") = 1.6666666666667e-006, dpLaminar(displayUnit = "kPa") = 14690, V_flowNominal(displayUnit = "l/min") = 3.995e-006) annotation(Placement(visible = true, transformation(origin = {-20, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalresistor_waterblock(R = Resistivity_WaterPlate) annotation(Placement(visible = true, transformation(origin = {-20, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalresistor_celltoreceiver(R = Resistivity_Cell) annotation(Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        //
        //______________________________________________________________________________
      equation
        connect(thermalconductor1.port_a, thermalcollector1.port_a[3]) annotation(Line(points = {{10, 0}, {-20.029, 0}, {-20.029, -10.1597}, {-20.029, -10.1597}}));
        connect(thermalresistor_waterblock.port_a, thermalcollector1.port_a[2]) annotation(Line(points = {{-20, 10}, {-20, -9.5791}, {-19.4485, -9.5791}, {-19.4485, -9.5791}}));
        connect(heatedpipe1.heatPort, thermalresistor_waterblock.port_b) annotation(Line(points = {{-20, 50}, {-19.7388, 50}, {-19.7388, 30.1887}, {-19.7388, 30.1887}}));
        connect(thermalresistor_celltoreceiver.port_b, thermalcollector1.port_a[1]) annotation(Line(points = {{-50, 0}, {-19.7388, 0}, {-19.7388, -9.86938}, {-19.7388, -9.86938}}));
        connect(energyFrom_CCA, thermalresistor_celltoreceiver.port_a) annotation(Line(points = {{-100, 0}, {-69.95650000000001, 0}, {-69.95650000000001, -0.290276}, {-69.95650000000001, -0.290276}}));
        connect(heatedpipe1.flowPort_b, flowport_b1) annotation(Line(points = {{-10, 60}, {31.3498, 60}, {31.3498, 40.3483}, {98.98399999999999, 40.3483}, {98.98399999999999, 40.3483}}));
        connect(flowport_a1, heatedpipe1.flowPort_a) annotation(Line(points = {{-100, 40}, {-62.6996, 40}, {-62.6996, 59.7968}, {-29.8984, 59.7968}, {-29.8984, 59.7968}}));
        connect(thermalresistor_waterblock.port_a, thermalcollector1.port_a[2]) annotation(Line(points = {{-20, 10}, {-20, -9.5791}, {-20, -9.5791}, {-20, -10}}));
        connect(thermalresistor_waterblock.port_b, heatedpipe1.heatPort) annotation(Line(points = {{-20, 30}, {-20, 49.6372}, {-20, 50}, {-20, 50}}));
        connect(heatCap_waterBlock, thermalcollector1.port_b) annotation(Line(points = {{-100, -80}, {-19.7929, -80}, {-20, -10}, {-20, -30}}));
        connect(heatLoss_to_ambient, convection1.fluid) annotation(Line(points = {{-100, -40}, {84.4649, -40}, {84.4649, 0}, {70, 0}}));
        connect(thermalconductor1.port_b, convection1.solid) annotation(Line(points = {{30, 0}, {50, 0}}));
        connect(Conv_Receiver, convection1.Gc) "Connects the Conv_Receiver from ICSolar.Parameter to the input for the convection coeffient of convection1";
        annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
      end Water_Block_HX;

      class Tubing_Losses
        extends ICSolar.Parameters;
        Modelica.Thermal.FluidHeatFlow.Components.HeatedPipe Tubing(medium = mediumHTF, V_flowLaminar = OneBranchFlow, V_flowNominal = 1e-005, h_g = 0, m = 0.0025, T0 = T_HTF_start, dpLaminar = 0.45, dpNominal = 10) annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Modelica.Thermal.HeatTransfer.Components.Convection convection1 annotation(Placement(visible = true, transformation(origin = {80.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.Convection convection2 annotation(Placement(visible = true, transformation(origin = {-40, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a(T(start = 293)) annotation(Placement(visible = true, transformation(origin = {100.0, -60.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0), iconTransformation(origin = {102.0, -70.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1(medium = mediumHTF) annotation(Placement(visible = true, transformation(origin = {-80, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1(medium = mediumHTF) annotation(Placement(visible = true, transformation(origin = {-80.0, -80.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0), iconTransformation(origin = {-100.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor Conduction_Insulation(G = Cond_Insulation) "Thermal conductivity of Tubing Insulation, from ICSolar.Parameter" annotation(Placement(visible = true, transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor Conduction_Tube(G = Cond_Tube) "Thermal conductivity of the silicone tubing, from ICSolar.Parameter" annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(convection2.solid, Conduction_Tube.port_a) annotation(Line(points = {{-30, 0}, {-9.920629999999999, 0}, {-10, 0}}));
        connect(Conduction_Tube.port_b, Conduction_Insulation.port_a) annotation(Line(points = {{10, 0}, {30.5556, 0}, {30, 0}}));
        connect(Conduction_Insulation.port_b, convection1.solid) annotation(Line(points = {{50, 0}, {70.4365, 0}, {70.4365, 0.1984}, {70, 0}}));
        connect(convection1.fluid, port_a) annotation(Line(visible = true, points = {{90.0, 0.0}, {97.8175, 0.0}, {97.8175, -43.8492}, {87.5, -43.8492}, {87.5, -60.9127}, {98.61109999999999, -60.9127}, {100.0, -60.0}}));
        connect(flowport_a1, Tubing.flowPort_a) annotation(Line(visible = true, points = {{-80.0, -80.0}, {-79.9603, -80.0}, {-79.9603, -10.3175}, {-80.0, -10.0}}));
        connect(flowport_b1, Tubing.flowPort_b) annotation(Line(points = {{-80, 80}, {-79.9615, 80}, {-79.9615, 10}, {-80, 10}}));
        connect(Tubing.heatPort, convection2.fluid) annotation(Line(points = {{-70, -6.12303e-016}, {-70, 0}, {-50, 0}}));
        connect(Conv_WaterTube, convection2.Gc);
        connect(Conv_InsulationAir, convection1.Gc);
        annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
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
    //    parameter String Path = "C:\\Users\\kenton.phillips\\Documents\\GitHub\\RPI_CASE_ICS_Modelica\\";
    //   parameter String Path = "C:\\Users\\Kenton\\Documents\\GitHub\\RPI_CASE_ICS_Modelica\\";
    constant String Path = "C:\\Users\\Nick\\Documents\\GitHub\\RPI_CASE_ICS_Modelica\\";
    //parameter String Path = "C:\\Users\\Justin\\Documents\\GitHub\\RPI_CASE_ICS_Modelica\\";
    //    parameter String Path = "C:\\Users\\Nicholas.Novelli\\Documents\\GitHub\\RPI_CASE_ICS_Modelica\\";
    //________________________________
    //////// MODEL OPERATION /////////
    //--------------------------------
    parameter Boolean isStudioExperiment = true "True if this run is referring to the gen8 studio experiment. For now, just search through the code for the variable name and flip things where necessary";
    /*off hand, that's 
                                    numOfStacks
                                    StackHeight
                                    BuildingOrientation
                                    ArrayTilt
                                    [glazing losses stuff]
                                  opticalEfficiency
                                    */
    //////////////////////////////////
    ///// BUILDING CONFIGURATION /////
    //////////////////////////////////
    parameter Real BuildingOrientation = 40 * 3.14159 / 180 "Radians, 0 being south";
    parameter Real BuildingLatitude = 40.71 * Modelica.Constants.pi / 180 "Latitude (radians)";
    parameter Real ArrayTilt = 0 "Radians, 0 being wall";
    ////////////////////////
    ///// ARRAY SIZING /////
    ////////////////////////
    //due to the shading tables, modeling anything smaller than 4x4 is sort of weird. It should work OK tho.
    parameter Integer StackHeight = 3 "Number of Modules per stack";
    parameter Integer NumOfStacks = 3 "Number of stacks, controls the .Stack object";
    parameter Integer NumOfModules = StackHeight * NumOfStacks "ModulesPerStack * NumOfStacks Number of modules being simulated. Will be replaced with a calculation based on wall area in the future.";
    // 11 in. height       13.5 in. width
    parameter Real stackSpacing = 0.3429 "distance between stacks (m)";
    parameter Real moduleSpacing = 0.2794 "distance between modules (m)";
    parameter Real GlassArea_perMod = stackSpacing * moduleSpacing "Glass Area exposed to either the interior or exterior. Could be replaced later with wall area";
    parameter Real GlassArea = GlassArea_perMod * NumOfModules;
    parameter Real CavityVolume = GlassArea * 0.5 "Volume of cavity for air calculations";
    //
    ////////////////////////////////
    ///////  GLAZING LOSSES  ///////
    ////////////////////////////////
    //Using Schlick's approximation to get glazing transmittance
    //  Real x_lite = 6 "thickness of lite (mm) (isStudioExperiment=false)";
    Real x_lite = 3 "thickness of lite (mm). for studio =3. for projected =6 (isStudioExperiment=true)";
    Real n_lites = 1 "number of lites in glazing unit. for Studio =2. for projected =1 (isStudioExperiment=false)";
    //Real n_lites = 2 "number of lites in glazing unit (isStudioExperiment=true)";
    parameter Real R_sfc = 0.00001 "surface soiling coefficient. if isStudioExperiment=true then 0.030 else .00001 (don't like to use zero, generally)";
    parameter Real c_disp = 0.0075 "coeff. dispersion. for Ultrawhite =0.0075. for studio = 0.0221(isStudioExperiment = false)";
    //deprecated for the material/geometry-based Trans_glazinglosses equation that now resides within glazinglosses component.
    //    parameter Real Trans_glazinglosses = 0.74 "Transmittance of outter glazing losses (single glass layer). Good glass: Guardian Ultraclear 6mm: 0.87. For our studio IGUs, measured 0.71. But give it 0.74, because we measured at ~28degrees, which will increase absorptance losses.";
    //still need to do something about this:
    parameter Real Trans_glazinglosses_eta = 0.86;
    // parameter Real OpticalEfficiency = 0.57 "The optical efficiency of the concentrating lens and optics prior to the photovoltaic cell";
    ////////////////////////////////
    ///// OPTICAL EFFICIENCIES /////
    ////////////////////////////////
    //  parameter Real OpticalEfficiency = 0.565 "isStudioExperiment = true";
    parameter Real OpticalEfficiency = 0.886;
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
    parameter Real OneBranchFlow = 1.63533e-006 * NumOfStacks;
    parameter Real AllBranchesFlow = OneBranchFlow * NumOfStacks;
    parameter Real inletTemp = 300;
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
    parameter Real adj = 0.26;
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
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 47130, StopTime = 58120, Tolerance = 1e-006, Interval = 10), Documentation(info = "<html>
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
    Modelica.Thermal.FluidHeatFlow.Components.HeatedPipe heatedPipe(m = 50, T0 = 295.15, T0fixed = true, h_g = -1, V_flowLaminar = 8e-006, dpLaminar = 10000.0, V_flowNominal = 0.0008, dpNominal = 1000000.0, frictionLoss = 1) annotation(Placement(visible = true, transformation(origin = {60, -18}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
    Modelica.Thermal.FluidHeatFlow.Sources.PressureIncrease pressureIncrease(medium = mediumHTF, m = 0.1, constantPressureIncrease(displayUnit = "kPa") = 100000) annotation(Placement(transformation(extent = {{-66, -22}, {-46, -2}})));
    Modelica.Thermal.FluidHeatFlow.Sources.AbsolutePressure absolutepressure1(p = 1000) annotation(Placement(visible = true, transformation(origin = {-40, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatcapacitor1(C = 4000) annotation(Placement(visible = true, transformation(origin = {80, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(heatcapacitor1.port, heatedPipe.heatPort) annotation(Line(points = {{80, 30}, {80.0478, 30}, {80.0478, -18.399}, {70.2509, -18.399}, {70.2509, -18.399}}, color = {191, 0, 0}));
    connect(absolutepressure1.flowPort, pressureIncrease.flowPort_a) annotation(Line(points = {{-50, -80}, {-81.00360000000001, -80}, {-81.00360000000001, -11.9474}, {-65.9498, -11.9474}, {-65.9498, -11.9474}}, color = {255, 0, 0}));
    connect(ics_envelopecassette1.flowport_b, heatedPipe.flowPort_a) annotation(Line(points = {{25, 40}, {32, 40}, {60, 40}, {60, -8}}, color = {255, 0, 0}));
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
    Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow Pump(medium = mediumHTF, m = 0.1, T0 = 293, useVolumeFlowInput = false, constantVolumeFlow(displayUnit = "m3/s") = 2e-006) "Fluid pump for thermal fluid" annotation(Placement(visible = true, transformation(origin = {-40, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.FluidHeatFlow.Components.HeatedPipe heatedPipe(m = 50, T0fixed = true, V_flowLaminar(displayUnit = "l/min") = 1.6666666666667e-005, V_flowNominal(displayUnit = "l/min") = 0.00016666666666667, frictionLoss = 1, dpLaminar(displayUnit = "kPa") = 100000, dpNominal(displayUnit = "kPa") = 1000000, T0 = 295.15, h_g = 1) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {58, -18})));
    HeatCapacitorPCMLike00 heatCapacitorPCMLike00_1 annotation(Placement(transformation(extent = {{66, 32}, {86, 52}})));
  equation
    connect(heatedPipe.flowPort_b, Pump.flowPort_a) annotation(Line(points = {{58, -8}, {60, -8}, {60, 4}, {-82, 4}, {-82, -20}, {-50, -20}}, color = {255, 0, 0}, smooth = Smooth.None));
    connect(Pump.flowPort_b, heatedPipe.flowPort_a) annotation(Line(points = {{-30, -20}, {-14, -20}, {-14, -54}, {58, -54}, {58, -28}}, color = {255, 0, 0}, smooth = Smooth.None));
    connect(heatedPipe.heatPort, heatCapacitorPCMLike00_1.port) annotation(Line(points = {{68, -18}, {74, -18}, {74, 14}, {76, 14}, {76, 32}}, color = {191, 0, 0}, smooth = Smooth.None));
    annotation(experiment(StartTime = 16588800, StopTime = 16675200, Tolerance = 1e-006, Interval = 9.866390000000001), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
  end ICS_Skeleton_wStorage_woutICS;

  model ambientSink
    extends Modelica.Thermal.FluidHeatFlow.Sources.Ambient;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end ambientSink;

  model measured_data "a container for the measured data vectors needed to simulate the experimental ICSF g8"
    extends ICSolar.Parameters;
    Modelica.Blocks.Sources.CombiTimeTable eGen_on(tableOnFile = true, fileName = Path + "20150323\\EgenIO.txt", tableName = "EgenIO", nout = 12, columns = {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint);
    //  Modelica.Thermal.FluidHeatFlow.Sources.Ambient SSource(medium = mediumHTF, useTemperatureInput = true, constantAmbientPressure = 101325, constantAmbientTemperature = TAmb) "Thermal fluid source" annotation(Placement(visible = true, transformation(origin = {40, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  end measured_data;

  model Shading_Twelve "reduce DNI by factor according to shading"
    //extends ICSolar.Parameters;
    extends ICSolar.ShadingLUT0;
    extends ICSolar.shadingImport;
    //String Path_2 = "C:\\Users\\kenton.phillips\\Documents\\GitHub\\RPI_CASE_ICS_Modelica\\";
    Modelica.Blocks.Interfaces.RealOutput DNI_out "DNI after shading factor multiplication" annotation(Placement(visible = true, transformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Product product1 "Multiplication of DNI and shading factor" annotation(Placement(visible = true, transformation(origin = {20, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.IntegerInput ShadingTable annotation(Placement(visible = true, transformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    //for picking different shading matrices:
    //Modelica.Blocks.Tables.CombiTable2D Shading_matrix_2(tableOnFile = true, fileName = "C:\\Users\\kenton.phillips\\Documents\\GitHub\\RPI_CASE_ICS_Modelica\\shading_matrices\\" + String(ShadingTable) + ".txt", tableName = "shading_matrix") annotation(Placement(visible = true, transformation(origin = {-40, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput arrayPitch "pitch (up/down) angle of 2axis tracking array (rads)" annotation(Placement(visible = true, transformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput arrayYaw "yaw (left/right) angle of tracking array (in radians)" annotation(Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput DNI_in "DNI in before shading factor multiplication" annotation(Placement(visible = true, transformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    // BRUTE FORCE IMPORT
    connect(arrayPitch, modShadingLUT_1.u1);
    connect(arrayYaw, modShadingLUT_1.u2);
    connect(arrayPitch, modShadingLUT_2.u1);
    connect(arrayYaw, modShadingLUT_2.u2);
    connect(arrayPitch, modShadingLUT_3.u1);
    connect(arrayYaw, modShadingLUT_3.u2);
    connect(arrayPitch, modShadingLUT_4.u1);
    connect(arrayYaw, modShadingLUT_4.u2);
    connect(arrayPitch, modShadingLUT_5.u1);
    connect(arrayYaw, modShadingLUT_5.u2);
    connect(arrayPitch, modShadingLUT_6.u1);
    connect(arrayYaw, modShadingLUT_6.u2);
    connect(arrayPitch, modShadingLUT_7.u1);
    connect(arrayYaw, modShadingLUT_7.u2);
    connect(arrayPitch, modShadingLUT_8.u1);
    connect(arrayYaw, modShadingLUT_8.u2);
    connect(arrayPitch, modShadingLUT_9.u1);
    connect(arrayYaw, modShadingLUT_9.u2);
    connect(arrayPitch, modShadingLUT_10.u1);
    connect(arrayYaw, modShadingLUT_10.u2);
    connect(arrayPitch, modShadingLUT_11.u1);
    connect(arrayYaw, modShadingLUT_11.u2);
    connect(arrayPitch, modShadingLUT_12.u1);
    connect(arrayYaw, modShadingLUT_12.u2);
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
    connect(product1.y, DNI_out) "DNI after multiplication connected to output of model" annotation(Line(points = {{31, 40}, {58.5909, 40}, {58.5909, 19.7775}, {100, 19.7775}, {100, 20}}));
    connect(DNI_in, product1.u1) "Model input DNI connecting to product" annotation(Line(points = {{-100, 80}, {-36.3412, 80}, {-36.3412, 45.9827}, {8, 45.9827}, {8, 46}}));
    connect(arrayYaw, Shading_matrix.u2);
    connect(arrayPitch, Shading_matrix.u1);
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {-4.59, 2.51}, extent = {{-72.63, 35.36}, {72.63, -35.36}}, textString = "Self Shading"), Rectangle(origin = {0, 0}, extent = {{-100, 100}, {100, -100}})}));
  end Shading_Twelve;

  model ShadingLUT0
    Modelica.Blocks.Tables.CombiTable2D Shading_matrix(smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments, table = [0, -3.1415926, -1.04719, -0.959927, -0.872667, -0.785397, -0.6981270000000001, -0.610867, -0.523597, -0.436327, -0.349067, -0.261797, -0.174837, -0.08726730000000001, 0, 0.08726730000000001, 0.174837, 0.261797, 0.349067, 0.436327, 0.523597, 0.610867, 0.6981270000000001, 0.785397, 0.872667, 0.959927, 1.04719, 3.1415926; -0.872665, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0; -0.785398, 0, 0, 0.515733288, 0.582273933, 0.644111335, 0.700774874, 0.751833306, 0.796898047, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.796898047, 0.751833306, 0.700774874, 0.644111335, 0.582273933, 0.515733288, 0, 0; -0.698132, 0, 0, 0.558719885, 0.630806722, 0.697798298, 0.759184768, 0.814498944, 0.86331985, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.86331985, 0.814498944, 0.759184768, 0.697798298, 0.630806722, 0.558719885, 0, 0; -0.610865, 0, 0, 0.5974542859999999, 0.674538691, 0.746174596, 0.811816808, 0.870965752, 0.923171268, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.923171268, 0.870965752, 0.811816808, 0.746174596, 0.674538691, 0.5974542859999999, 0, 0; -0.523599, 0, 0, 0.6316417, 0.713137013, 0.788872054, 0.8582704330000001, 0.920803986, 0.975996795, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.975996795, 0.920803986, 0.8582704330000001, 0.788872054, 0.713137013, 0.6316417, 0, 0; -0.436332, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; -0.349066, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; -0.261799, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; -0.174533, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; -0.087266, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; 0, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; 0.087266, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; 0.174533, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; 0.261799, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; 0.349066, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; 0.436332, 0, 0, 0.639557866, 0.722074534, 0.798758738, 0.869026865, 0.932344131, 0.988228655, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.988228655, 0.932344131, 0.869026865, 0.798758738, 0.722074534, 0.639557866, 0, 0; 0.523599, 0, 0, 0.6316417, 0.713137013, 0.788872054, 0.8582704330000001, 0.920803986, 0.975996795, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.98762244, 0.975996795, 0.920803986, 0.8582704330000001, 0.788872054, 0.713137013, 0.6316417, 0, 0; 0.610865, 0, 0, 0.5974542859999999, 0.674538691, 0.746174596, 0.811816808, 0.870965752, 0.923171268, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.934167678, 0.923171268, 0.870965752, 0.811816808, 0.746174596, 0.674538691, 0.5974542859999999, 0, 0; 0.698132, 0, 0, 0.558719885, 0.630806722, 0.697798298, 0.759184768, 0.814498944, 0.86331985, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.873603336, 0.86331985, 0.814498944, 0.759184768, 0.697798298, 0.630806722, 0.558719885, 0, 0; 0.785398, 0, 0, 0.515733288, 0.582273933, 0.644111335, 0.700774874, 0.751833306, 0.796898047, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.806390346, 0.796898047, 0.751833306, 0.700774874, 0.644111335, 0.582273933, 0.515733288, 0, 0; 0.872665, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]) annotation(Placement(visible = true, transformation(origin = {0, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    //(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, columns = {2}, table = [0, 27
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {1, 1})));
  end ShadingLUT0;

  model shadingImport
    //   parameter String Path_2 = "C:\\Users\\Kenton\\Documents\\GitHub\\RPI_CASE_ICS_Modelica\\shading_matrices\\";
    //parameter String Path_2 = "C:\\Users\\Justin\\Documents\\GitHub\\RPI_CASE_ICS_Modelica\\shading_matrices\\";
    parameter String Path_2 = "C:\\Users\\Nick\\Documents\\GitHub\\RPI_CASE_ICS_Modelica\\shading_matrices\\";
    //    parameter String Path_2 = "C:\\Users\\Nicholas.Novelli\\Documents\\GitHub\\RPI_CASE_ICS_Modelica\\shading_matrices\\";
    Modelica.Blocks.Tables.CombiTable2D modShadingLUT_1(tableOnFile = true, fileName = Path_2 + "1" + ".txt", tableName = "shading_matrix", smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments);
    Modelica.Blocks.Tables.CombiTable2D modShadingLUT_2(tableOnFile = true, fileName = Path_2 + "2" + ".txt", tableName = "shading_matrix", smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments);
    Modelica.Blocks.Tables.CombiTable2D modShadingLUT_3(tableOnFile = true, fileName = Path_2 + "3" + ".txt", tableName = "shading_matrix", smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments);
    Modelica.Blocks.Tables.CombiTable2D modShadingLUT_4(tableOnFile = true, fileName = Path_2 + "4" + ".txt", tableName = "shading_matrix", smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments);
    Modelica.Blocks.Tables.CombiTable2D modShadingLUT_5(tableOnFile = true, fileName = Path_2 + "5" + ".txt", tableName = "shading_matrix", smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments);
    Modelica.Blocks.Tables.CombiTable2D modShadingLUT_6(tableOnFile = true, fileName = Path_2 + "6" + ".txt", tableName = "shading_matrix", smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments);
    Modelica.Blocks.Tables.CombiTable2D modShadingLUT_7(tableOnFile = true, fileName = Path_2 + "7" + ".txt", tableName = "shading_matrix", smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments);
    Modelica.Blocks.Tables.CombiTable2D modShadingLUT_8(tableOnFile = true, fileName = Path_2 + "8" + ".txt", tableName = "shading_matrix", smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments);
    Modelica.Blocks.Tables.CombiTable2D modShadingLUT_9(tableOnFile = true, fileName = Path_2 + "9" + ".txt", tableName = "shading_matrix", smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments);
    Modelica.Blocks.Tables.CombiTable2D modShadingLUT_10(tableOnFile = true, fileName = Path_2 + "10" + ".txt", tableName = "shading_matrix", smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments);
    Modelica.Blocks.Tables.CombiTable2D modShadingLUT_11(tableOnFile = true, fileName = Path_2 + "11" + ".txt", tableName = "shading_matrix", smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments);
    //here we're using shading LUT 6 in place of the supposed 12, which doesn't exist correctly [[nn]]
    //    Modelica.Blocks.Tables.CombiTable2D modShadingLUT_12(tableOnFile = true, fileName = Path_2 + "12" + ".txt", tableName = "shading_matrix", smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments);
    Modelica.Blocks.Tables.CombiTable2D modShadingLUT_12(tableOnFile = true, fileName = Path_2 + "6" + ".txt", tableName = "shading_matrix", smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments);
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
    Modelica.Blocks.Sources.IntegerConstant ModRow(k = 1) annotation(Placement(visible = true, transformation(origin = {-60, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.IntegerConstant ModCol(k = 15) annotation(Placement(visible = true, transformation(origin = {-60, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.IntegerConstant ArrRows(k = 10) annotation(Placement(visible = true, transformation(origin = {-60, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.IntegerConstant ArrCols(k = 16) annotation(Placement(visible = true, transformation(origin = {-60, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    //##############################################################################
    //##############################################################################
    output Modelica.Blocks.Interfaces.IntegerOutput FractExposedTypeRow "Enumeration of FractExposed Row" annotation(Placement(visible = true, transformation(origin = {110, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    output Modelica.Blocks.Interfaces.IntegerOutput FractExposedTypeCol "Enumeration of FractExposed Column" annotation(Placement(visible = true, transformation(origin = {110, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    //
    //______________________________________________________________________________
    ICSolar.Module.chooseFractExposedLUTPosition choosefractexposedlutposition1 annotation(Placement(visible = true, transformation(origin = {5, -25}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  equation
    //connect(ArrCols.y, choosefractexposedlutposition1.ArrayCols) annotation(Line(points = {{-49, -60}, {-47.8261, -60}, {-47.8261, -34.2995}, {-10.628, -34.2995}, {-10.628, -34.2995}}, color = {255, 127, 0}));
    //connect(ArrRows.y, choosefractexposedlutposition1.ArrayRows) annotation(Line(points = {{-49, -20}, {-46.6184, -20}, {-46.6184, -28.5024}, {-11.5942, -28.5024}, {-11.5942, -28.5024}}, color = {255, 127, 0}));
    connect(ModCol.y, choosefractexposedlutposition1.ModuleCol) annotation(Line(points = {{-49, 20}, {-42.5121, 20}, {-42.5121, -22.7053}, {-9.42029, -22.7053}, {-9.42029, -22.7053}}, color = {255, 127, 0}));
    connect(ModRow.y, choosefractexposedlutposition1.ModuleRow) annotation(Line(points = {{-49, 60}, {-42.029, 60}, {-42.029, -16.1836}, {-9.42029, -16.1836}, {-9.42029, -16.1836}}, color = {255, 127, 0}));
    connect(choosefractexposedlutposition1.FractExposedTypeCol, FractExposedTypeCol) annotation(Line(points = {{20, -26.5}, {42.9675, -26.5}, {42.9675, -10.2009}, {102.628, -10.2009}, {102.628, -10.2009}}, color = {255, 127, 0}));
    connect(choosefractexposedlutposition1.FractExposedTypeRow, FractExposedTypeRow) annotation(Line(points = {{20, -23.5}, {34.6213, -23.5}, {34.6213, 9.27357}, {102.318, 9.27357}, {102.318, 9.27357}}, color = {255, 127, 0}));
    //  connect(ArrayCols.y, choosefractexposedlutposition2.ArrayCols) annotation(Line(points = {{-49, -60}, {-35.5487, -60}, {-35.5487, 26.2751}, {-10.2009, 26.2751}, {-10.2009, 26.2751}}, color = {255, 127, 0}));
    //  connect(ArrayRows.y, choosefractexposedlutposition2.ArrayRows) annotation(Line(points = {{-49, -20}, {-41.1128, -20}, {-41.1128, 31.8393}, {-10.2009, 31.8393}, {-10.2009, 31.8393}}, color = {255, 127, 0}));
    //  connect(ModuleCol.y, choosefractexposedlutposition2.ModuleCol) annotation(Line(points = {{-49, 20}, {-44.204, 20}, {-44.204, 37.7125}, {-11.1283, 37.7125}, {-11.1283, 37.7125}}, color = {255, 127, 0}));
    //  connect(ModuleRow.y, choosefractexposedlutposition2.ModuleRow) annotation(Line(points = {{-49, 60}, {-44.204, 60}, {-44.204, 43.8949}, {-10.2009, 43.8949}, {-10.2009, 43.8949}}, color = {255, 127, 0}));
    //##############################################################################
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {1, 1})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {0.5, 0.5})));
  end testPalette;

  function ShadingPalette
    input Integer ModuleRow;
    input Integer ModuleCol;
    input Integer ArrayRows;
    input Integer ArrayCols;
    output Integer RCType[2];
  protected
    Integer FractExposedTypeRow;
    Integer FractExposedTypeCol;
  algorithm
    //
    //this first case is a robustness measure, solving an out-of-bounds condition
    if ModuleCol > ArrayCols then
      FractExposedTypeCol := 3;
    elseif ModuleCol < 2 then
      FractExposedTypeCol := 1;
    elseif ModuleCol < 3 then
      FractExposedTypeCol := 2;
    elseif ModuleCol > ArrayCols - 1 then
      FractExposedTypeCol := 5;
    elseif ModuleCol > ArrayCols - 2 then
      FractExposedTypeCol := 4;
    else
      FractExposedTypeCol := 3;
    end if;
    //
    //this first case is a robustness measure, solving an out-of-bounds condition
    if ModuleRow > ArrayRows then
      FractExposedTypeRow := 3;
    elseif ModuleRow < 2 then
      FractExposedTypeRow := 1;
    elseif ModuleRow < 3 then
      FractExposedTypeRow := 2;
    elseif ModuleRow > ArrayRows - 1 then
      FractExposedTypeRow := 5;
    elseif ModuleRow > ArrayRows - 2 then
      FractExposedTypeRow := 4;
    else
      FractExposedTypeRow := 3;
    end if;
    RCType[1] := FractExposedTypeRow;
    RCType[2] := FractExposedTypeCol;
    //##############################################################################
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end ShadingPalette;

  function ShadingFraction_Index
    input Integer rowType;
    input Integer colType;
    input Real arrayPitch;
    input Real arrayYaw;
    output Real SFraction_Index;
  protected
    Real Index;
    Real Max_angle = 72 * 3.1416 / 180;
    Real Min_angle = -72 * 3.1416 / 180;
    Real arrayPitch_2;
    Real arrayYaw_2;
  algorithm
    // Condense the 4D LUT to a 1D LUT
    // Assuming the columns in order from the 4d file our; Row, Column, Pitch, Yaw.
    // Add Limits for High and Low input typs
    if arrayPitch > Max_angle then
      arrayPitch_2 := Max_angle;
    elseif arrayPitch < Min_angle then
      arrayPitch_2 := Min_angle;
    else
      arrayPitch_2 := arrayPitch;
    end if;
    if arrayYaw > Max_angle then
      arrayYaw_2 := Max_angle;
    elseif arrayYaw < Min_angle then
      arrayYaw_2 := Min_angle;
    else
      arrayYaw_2 := arrayYaw;
    end if;
    //Find the nearest 3 pi over 180 (nearest 3 degrees)
    arrayPitch_2 := roundn(arrayPitch_2, 3 * 3.1416 / 180);
    arrayYaw_2 := roundn(arrayYaw_2, 3 * 3.1416 / 180);
    //Calculated the Index Number
    Index := (rowType - 1) * (60025 / 5) + (colType - 1) * (60025 / 25) + arrayPitch_2 * (-935.83) + 1175 + arrayYaw_2 * 19.099 + 25 + 1;
    SFraction_Index := round(Index);
  end ShadingFraction_Index;

  function roundn "Round to nearest n"
    input Real r;
    input Real n;
    output Real i;
  algorithm
    if mod(r, n) > n / 2 then
      i := r - mod(r, n) + n;
    elseif mod(r, n) < n / 2 then
      i := r - mod(r, n);
    else
      i := r;
    end if;
  end roundn;

  function round "Round to nearest Integer"
    input Real r;
    output Integer i;
  algorithm
    i := if r > 0 then integer(floor(r + 0.5)) else integer(ceil(r - 0.5));
  end round;

  model ShadingFraction_Function
    // Will need to comment out parameter and use acutal input for the final version.
    // Are currently parameter in order to test
    ///***********************************************************
    // THE PATH FOR THE LUT TXT WILL NEED TO BE DYNAMIC
    //*******************************************************
    /*
                                                                                                                                                                                                                                                                             Modelica.Blocks.Interfaces.IntegerInput rowType annotation(Placement(visible = true, transformation(origin = {-100, 40}, extent = {{-15, -15}, {15, 15}}, rotation = 0), iconTransformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                                                                                                                                                                                                                                                            Modelica.Blocks.Interfaces.IntegerInput colType annotation(Placement(visible = true, transformation(origin = {-100, 80}, extent = {{-15, -15}, {15, 15}}, rotation = 0), iconTransformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                                                                                                                                                                                                                                                            Modelica.Blocks.Interfaces.RealInput arrayYaw annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-15, -15}, {15, 15}}, rotation = 0), iconTransformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                                                                                                                                                                                                                                                            Modelica.Blocks.Interfaces.RealInput arrayPitch annotation(Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-15, -15}, {15, 15}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
                                                                                                                                                                                                                                                                                                                */
    Modelica.Blocks.Interfaces.RealOutput SOLAR_frac annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-15, -15}, {15, 15}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Real index_num = ShadingFraction_Index(rowType, colType, arrayPitch, arrayYaw);
    Modelica.Blocks.Interfaces.RealInput arrayYaw annotation(Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-16.25, -16.25}, {16.25, 16.25}}, rotation = 0), iconTransformation(origin = {-100, -80}, extent = {{-16.25, -16.25}, {16.25, 16.25}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput arrayPitch annotation(Placement(visible = true, transformation(origin = {-100, -20}, extent = {{-16.25, -16.25}, {16.25, 16.25}}, rotation = 0), iconTransformation(origin = {-100, -40}, extent = {{-16.25, -16.25}, {16.25, 16.25}}, rotation = 0)));
    Modelica.Blocks.Interfaces.IntegerInput colType annotation(Placement(visible = true, transformation(origin = {-100, 40}, extent = {{-16.25, -16.25}, {16.25, 16.25}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-16.25, -16.25}, {16.25, 16.25}}, rotation = 0)));
    Modelica.Blocks.Interfaces.IntegerInput rowType annotation(Placement(visible = true, transformation(origin = {-100, 80}, extent = {{-16.25, -16.25}, {16.25, 16.25}}, rotation = 0), iconTransformation(origin = {-100, 40}, extent = {{-16.25, -16.25}, {16.25, 16.25}}, rotation = 0)));
    Modelica.Blocks.Tables.CombiTable1Ds LUT(tableOnFile = true, fileName = ICSolar.Parameters.Path + "4D_LUT\\4DLUT.txt", tableName = "4DLUT") annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  equation
    connect(LUT.y[1], SOLAR_frac) annotation(Line(points = {{16.5, 0}, {90.9337, 0}, {90.9337, -0.811908}, {90.9337, -0.811908}}, color = {0, 0, 127}));
    //connect(index_num, LUT.u);
    LUT.u = index_num;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end ShadingFraction_Function;

  model testShadingFunction
    ICSolar.ShadingFraction_Function shadingfraction_function1 annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.IntegerConstant rowType(k = 3) annotation(Placement(visible = true, transformation(origin = {-80, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.IntegerConstant modType(k = 3) annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant Pitch(k = 0.75) annotation(Placement(visible = true, transformation(origin = {-80, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant Yaw(k = 0) annotation(Placement(visible = true, transformation(origin = {-80, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput ShadingFraction annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(shadingfraction_function1.SOLAR_frac, ShadingFraction) annotation(Line(points = {{10, 0}, {93.0988, 0}, {93.0988, -0.270636}, {93.0988, -0.270636}}, color = {0, 0, 127}));
    connect(Yaw.y, shadingfraction_function1.arrayYaw) annotation(Line(points = {{-69, -80}, {-24.3572, -80}, {-24.3572, -8.11908}, {-10.8254, -8.11908}, {-10.8254, -8.11908}}, color = {0, 0, 127}));
    connect(Pitch.y, shadingfraction_function1.arrayPitch) annotation(Line(points = {{-69, -40}, {-36.8065, -40}, {-36.8065, -3.7889}, {-10.2842, -3.7889}, {-10.2842, -3.7889}}, color = {0, 0, 127}));
    connect(modType.y, shadingfraction_function1.colType) annotation(Line(points = {{-69, 0}, {-10.8254, 0}, {-10.8254, 0}, {-10.8254, 0}}, color = {255, 127, 0}));
    connect(rowType.y, shadingfraction_function1.rowType) annotation(Line(points = {{-69, 40}, {-19.7564, 40}, {-19.7564, 3.51827}, {-11.0961, 3.51827}, {-11.0961, 3.51827}}, color = {255, 127, 0}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end testShadingFunction;

  model testModule
    ICSolar.Module.ICS_Module_Twelve ics_module_twelve1 annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.IntegerConstant modNum(k = 1) annotation(Placement(visible = true, transformation(origin = {-20, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.IntegerConstant stackNum(k = 1) annotation(Placement(visible = true, transformation(origin = {-20, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant arrayYaw(k = 0) annotation(Placement(visible = true, transformation(origin = {-80, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant arrayPitch(k = 0.75) annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant Power_in(k = 0) annotation(Placement(visible = true, transformation(origin = {-80, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant DNI(k = 500) annotation(Placement(visible = true, transformation(origin = {-80, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(visible = true, transformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1 annotation(Placement(visible = true, transformation(origin = {100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow volumeflow1(constantVolumeFlow = 0.0006, m = 1, T0 = 300) annotation(Placement(visible = true, transformation(origin = {-20, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedtemperature1(T = 300) annotation(Placement(visible = true, transformation(origin = {-60, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(fixedtemperature1.port, ics_module_twelve1.TAmb_in) annotation(Line(points = {{-50, 80}, {-33.0176, 80}, {-33.0176, 7.03654}, {-9.7429, 7.03654}, {-9.7429, 7.03654}}, color = {191, 0, 0}));
    connect(stackNum.y, ics_module_twelve1.stackNum) annotation(Line(points = {{-9, -80}, {8.11908, -80}, {8.11908, -15.4263}, {-25.7104, -15.4263}, {-25.7104, -10.2842}, {-11.0961, -10.2842}, {-11.0961, -10.2842}}, color = {255, 127, 0}));
    connect(modNum.y, ics_module_twelve1.modNum) annotation(Line(points = {{-9, -40}, {0, -40}, {0, -18.6739}, {-30.3112, -18.6739}, {-30.3112, -8.11908}, {-10.8254, -8.11908}, {-10.8254, -8.11908}}, color = {255, 127, 0}));
    connect(DNI.y, ics_module_twelve1.DNI) annotation(Line(points = {{-69, -80}, {-48.4438, -80}, {-48.4438, -6.49526}, {-11.0961, -6.49526}, {-11.0961, -6.49526}}, color = {0, 0, 127}));
    connect(Power_in.y, ics_module_twelve1.Power_in) annotation(Line(points = {{-69, -40}, {-54.9391, -40}, {-54.9391, -2.977}, {-10.8254, -2.977}, {-10.8254, -2.977}}, color = {0, 0, 127}));
    connect(arrayPitch.y, ics_module_twelve1.arrayYaw) annotation(Line(points = {{-69, 0}, {-48.4438, 0}, {-48.4438, 2.16509}, {-10.8254, 2.16509}, {-10.8254, 2.16509}}, color = {0, 0, 127}));
    connect(arrayYaw.y, ics_module_twelve1.arrayYaw) annotation(Line(points = {{-69, 40}, {-39.5129, 40}, {-39.5129, 4.05954}, {-10.0135, 4.05954}, {-10.0135, 4.05954}}, color = {0, 0, 127}));
    connect(ics_module_twelve1.Power_out, y) annotation(Line(points = {{10, -2}, {54.1272, -2}, {54.1272, 20.2977}, {93.3694, 20.2977}, {93.3694, 20.2977}}, color = {0, 0, 127}));
    connect(ics_module_twelve1.flowport_b1, flowport_b1) annotation(Line(points = {{10, -4}, {55.4804, -4}, {55.4804, -20.5683}, {102.3, -20.5683}, {102.3, -20.5683}}, color = {255, 0, 0}));
    connect(volumeflow1.flowPort_b, ics_module_twelve1.flowport_a1) annotation(Line(points = {{-10, 40}, {-25.1691, 40}, {-25.1691, -4.05954}, {-10.0135, -4.05954}, {-10.0135, -4.05954}}, color = {255, 0, 0}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end testModule;
  annotation(uses(Modelica(version = "3.2.1"), Buildings(version = "1.6")), experiment(StartTime = 7137000.0, StopTime = 7141200.0, Tolerance = 1e-006, Interval = 60));
end ICSolar;