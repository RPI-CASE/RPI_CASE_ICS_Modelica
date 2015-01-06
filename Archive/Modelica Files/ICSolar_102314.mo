package ICSolar "Package of all the necessary components to create an Integrated Concentrating Solar simulation"
  extends Modelica.Icons.Package;
  model ICS_Skeleton "This model calculates the electrical and thermal generation of ICSolar. This model is used as a skeleton piece to hold together the other models until it is packages as an FMU."
    parameter Real FLensWidth = 0.25019 "Lens width";
    parameter Real CellWidth = 0.01 "PV Cell width";
    parameter Modelica.SIunits.Pressure PAmb(displayUnit = "PA") = 101325 "Ambient pressure";
    Modelica.Thermal.FluidHeatFlow.Sources.Ambient Source(constantAmbientPressure = PAmb, constantAmbientTemperature = 298, medium = Modelica.Thermal.FluidHeatFlow.Media.Water()) "Thermal fluid source" annotation(Placement(visible = true, transformation(origin = {-80,-20}, extent = {{-10,-10},{10,10}}, rotation = 180)));
    Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow Pump(constantVolumeFlow = 2e-006, m = 0, medium = Modelica.Thermal.FluidHeatFlow.Media.Water(), T0 = 293) "Fluid pump for thermal fluid" annotation(Placement(visible = true, transformation(origin = {-40,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Thermal.FluidHeatFlow.Sources.Ambient Sink(constantAmbientPressure = PAmb, constantAmbientTemperature = 298, medium = Modelica.Thermal.FluidHeatFlow.Media.Water()) "Thermal fluid sink, will be replaced with a tank later" annotation(Placement(visible = true, transformation(origin = {60,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    ICSolar.ICS_Context ics_context1 annotation(Placement(visible = true, transformation(origin = {-80,40}, extent = {{-25,-25},{25,25}}, rotation = 0)));
    ICSolar.Envelope.ICS_EnvelopeCassette ics_envelopecassette1 annotation(Placement(visible = true, transformation(origin = {0,40}, extent = {{-25,-25},{25,25}}, rotation = 0)));
  equation
    connect(ics_envelopecassette1.flowport_b,Sink.flowPort) annotation(Line(points = {{25,25},{41.2098,25},{41.2098,0.378072},{50,0.378072},{50,0}}));
    connect(Pump.flowPort_b,ics_envelopecassette1.flowport_a) annotation(Line(points = {{-30,-20},{-28.3554,-20},{-28.3554,19.6597},{-23.75,19.6597},{-23.75,18.75}}));
    connect(ics_context1.DNI,ics_envelopecassette1.DNI) annotation(Line(points = {{-55,25},{-24.1966,25},{-25,25}}));
    connect(ics_context1.AOI,ics_envelopecassette1.AOI) annotation(Line(points = {{-55,30},{-24.9527,30},{-25,30}}));
    connect(ics_context1.SunAzi,ics_envelopecassette1.SunAzi) annotation(Line(points = {{-55,35},{-24.9527,35},{-25,35}}));
    connect(ics_context1.SunAlt,ics_envelopecassette1.SunAlt) annotation(Line(points = {{-55,40},{-24.5747,40},{-25,40}}));
    connect(ics_context1.SurfOrientation_out,ics_envelopecassette1.SurfaceOrientation) annotation(Line(points = {{-55,45},{-25.7089,45},{-25,45}}));
    connect(ics_context1.SurfTilt_out,ics_envelopecassette1.SurfaceTilt) annotation(Line(points = {{-55,50},{-25.7089,50},{-25,50}}));
    connect(ics_context1.TDryBul,ics_envelopecassette1.TAmb_in) annotation(Line(points = {{-55,55},{-25.3308,55},{-25,55}}));
    connect(Source.flowPort,Pump.flowPort_a) "connects fluid source to pump" annotation(Line(points = {{-70,-20},{-49.7653,-20},{-50,-20}}));
    annotation(experiment(StartTime = 0, StopTime = 31540000.0, Tolerance = 1e-006, Interval = 3601.69));
  end ICS_Skeleton;
  model ICS_Context "This model provides the pieces necessary to set up the context to run the simulation, in FMU practice this will be cut out and provided from the EnergyPlus file"
    parameter Real Lat = 40.71 * Modelica.Constants.pi / 180 "Latitude";
    parameter Real SurfOrientation = 0 "Surface orientation: Change 'S' to 'W','E', or 'N' for other orientations";
    parameter Real SurfTilt = 0 "0 wall, pi/2 roof";
    Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam = "modelica://Buildings/Resources/weatherdata/USA_NY_New.York-Central.Park.725033_TMY3.mos", pAtmSou = Buildings.BoundaryConditions.Types.DataSource.Parameter, TDryBul(displayUnit = "K"), TDewPoi(displayUnit = "K"), totSkyCovSou = Buildings.BoundaryConditions.Types.DataSource.Parameter, opaSkyCovSou = Buildings.BoundaryConditions.Types.DataSource.Parameter, totSkyCov = 0.01, opaSkyCov = 0.01) "Weather data reader for New York Central Park" annotation(Placement(visible = true, transformation(origin = {-40,20}, extent = {{-20,-20},{20,20}}, rotation = 0)));
    Buildings.BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTil(til = SurfTilt, azi = SurfOrientation, lat = Lat) "Irradiance on tilted surface" annotation(Placement(visible = true, transformation(origin = {20,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b TDryBul "Dry bulb temperature" annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
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
  equation
    connect(SurfOrientation,SurfOrientation_out) "Connects Surface Orientation Parameter to Surface Orientation Output";
    connect(SurfTilt,SurfTilt_out) "Connects Surface Tilt Parameter to Surface Tilt Output";
    connect(weatherBus.HDirNor,DNI) "Connects Hourly Direct Normal Irradiance from the weather file to the DNI output of context";
    connect(TOutside.port,TDryBul) "Connects the prescribed heat model to the Dry Bulb heat port outlet" annotation(Line(points = {{70,20},{97.8229,20},{97.8229,20},{100,20}}));
    connect(weatherBus.TDryBul,TOutside.T) "Connects the weather file Dry Bult to the TOutside prescribed temperature model" annotation(Line(points = {{20,20},{47.0247,20},{47.0247,20},{48,20}}));
    connect(weatherBus,HDirTil.weaBus) "Connects the weather bus to the irradiance based on wall tilt calculation model (HDirTil)" annotation(Line(points = {{20,20},{19.7388,20},{19.7388,-17.4165},{-3.48331,-17.4165},{-3.48331,-40.0581},{10,-40.0581},{10,-40}}));
    connect(HDirTil.inc,AOI) "Connects incident angle to angle of incidence out" annotation(Line(points = {{31,-44},{45.5733,-44},{45.5733,-40.0581},{100,-40.0581},{100,-40}}));
    connect(weatherBus.solTim,solHouAng.solTim) "Connects solar time to solar hour angle model" annotation(Line(points = {{20,20},{19.7388,20},{19.7388,-17.4165},{-63.5704,-17.4165},{-63.5704,-79.8258},{-52,-79.8258},{-52,-80}}));
    connect(weatherBus.cloTim,decAng.nDay) "Calculates clock time to day number" annotation(Line(points = {{20,20},{19.7388,20},{19.7388,-17.4165},{-63.5704,-17.4165},{-63.5704,-40.0581},{-52,-40.0581},{-52,-40}}));
    connect(weaDat.weaBus,weatherBus) "Connects weather data to weather bus" annotation(Line(points = {{-20,20},{20.6096,20},{20,20}}));
    //Uses the decAng and solHouAng to calculate the Declication and Solar Hour angles
    SunAlt = Modelica.Math.asin(Modelica.Math.sin(Lat) * Modelica.Math.sin(decAng.decAng) + Modelica.Math.cos(Lat) * Modelica.Math.cos(decAng.decAng) * Modelica.Math.cos(solHouAng.solHouAng));
    // SurfAlt = SunAlt - SurfTilt;
    SunAzi = Modelica.Math.asin(Modelica.Math.cos(decAng.decAng) * Modelica.Math.sin(solHouAng.solHouAng) / Modelica.Math.cos(SunAlt));
    // SurfAzi = SunAzi - SurfOrientation;
    annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
  end ICS_Context;
  package Envelope "Package of all the Envelope components to create an Integrated Concentrating Solar simulation"
    extends Modelica.Icons.Package;
    model ICS_EnvelopeCassette "This model in the Envelope Cassette (Double-Skin Facade) that houses the ICSolar Stack and Modules. This presents a building envelope"
      parameter Real StackHeight = 6.0 "Number of Modules in a stack, currently not used";
      parameter Real NumStacks = 4.0 "Number of stacks in an envelope, currently not used";
      parameter Modelica.SIunits.Area ArrayArea = 1 "Area of the array";
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b "Thermal fluid outflow port, after heat exchange" annotation(Placement(visible = true, transformation(origin = {100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in "Ambient cavity temperature" annotation(Placement(visible = true, transformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a "Thermal fluid inflow port, before heat exchange" annotation(Placement(visible = true, transformation(origin = {-100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-95,-85}, extent = {{-5,-5},{5,5}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput Power_Electric "Electric power generated" annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      // Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b Power_Heat "Heat power generated" annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "DNI from weather file" annotation(Placement(visible = true, transformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput AOI "Angle of incidence" annotation(Placement(visible = true, transformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SunAlt "Altitude of the sun " annotation(Placement(visible = true, transformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SunAzi "Azimuth of the sun " annotation(Placement(visible = true, transformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfaceOrientation annotation(Placement(visible = true, transformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfaceTilt annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ICSolar.Envelope.ICS_GlazingLosses ics_glazinglosses1 annotation(Placement(visible = true, transformation(origin = {-55,55}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      ICSolar.Envelope.ICS_SelfShading ics_selfshading1 annotation(Placement(visible = true, transformation(origin = {-20,0}, extent = {{-17.5,-17.5},{17.5,17.5}}, rotation = 0)));
      ICSolar.Stack.ICS_Stack ics_stack1 annotation(Placement(visible = true, transformation(origin = {40,0}, extent = {{-25,-25},{25,25}}, rotation = 0)));
    equation
      // Power_Heat = EnthalpyDifferential(baseline_enthalpy = flowport_a, generated_enthalpy = ics_stack1.flowport_b1);
      connect(flowport_a,ics_stack1.flowport_a1) annotation(Line(points = {{-100,-80},{3.78072,-80},{3.78072,-15.5009},{15,-15.5009},{15,-15}}));
      connect(ics_selfshading1.DNI_out,ics_stack1.DNI) annotation(Line(points = {{-2.5,3.5},{6.04915,3.5},{6.04915,-4.53686},{15,-4.53686},{15,-5}}));
      connect(TAmb_in,ics_stack1.TAmb_in) annotation(Line(points = {{-100,80},{-1.13422,80},{-1.13422,17.0132},{15,17.0132},{15,20}}));
      connect(ics_stack1.flowport_b1,flowport_b) annotation(Line(points = {{65,0},{80.1512,0},{80.1512,-22.3062},{100,-22.3062},{100,-20}}));
      connect(ics_stack1.Power_out,Power_Electric) annotation(Line(points = {{65,10},{80.9074,10},{80.9074,18.9036},{100,18.9036},{100,20}}));
      connect(SurfaceTilt,ics_selfshading1.SurfTilt) annotation(Line(points = {{-100,-40},{-45.5285,-40},{-45.5285,-14.0921},{-37.5,-14.0921},{-37.5,-14}}));
      connect(SurfaceOrientation,ics_selfshading1.SurfOrientation) annotation(Line(points = {{-100,-20},{-57.7236,-20},{-57.7236,-6.50407},{-37.5,-6.50407},{-37.5,-7}}));
      connect(SunAzi,ics_selfshading1.SunAzi) annotation(Line(points = {{-100,0},{-37.9404,0},{-37.5,0}}));
      connect(SunAlt,ics_selfshading1.SunAlt) annotation(Line(points = {{-100,20},{-57.1816,20},{-57.1816,6.77507},{-37.5,6.77507},{-37.5,7}}));
      connect(ics_glazinglosses1.SurfDirNor,ics_selfshading1.DNI_in) annotation(Line(points = {{-40,58},{-32.7913,58},{-32.7913,33.6043},{-50.1355,33.6043},{-50.1355,14.0921},{-37.5,14.0921},{-37.5,14}}));
      connect(AOI,ics_glazinglosses1.AOI) annotation(Line(points = {{-100,40},{-83.1978,40},{-83.1978,45.7995},{-70,45.7995},{-70,46}}));
      connect(DNI,ics_glazinglosses1.DNI) annotation(Line(points = {{-100,60},{-75.88079999999999,60},{-75.88079999999999,63.9566},{-70,63.9566},{-70,64}}));
      ics_stack1.StackHeight = StackHeight "linking variables of stack heigh";
      connect(TAmb_in,ics_stack1.TAmb_in) "Piping ambient temperature into the stack";
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Text(origin = {14.1802,-9.07422}, extent = {{-81.85129999999999,57.4687},{64.45999999999999,-43.48}}, textString = "Envelope")}));
    end ICS_EnvelopeCassette;
    model ICS_GlazingLosses "This model calculates the transmittance of a single glass layer and discounts the DNI by the absorption and reflection"
      Modelica.Blocks.Interfaces.RealOutput SurfDirNor "Surface direct normal solar irradiance" annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput AOI "Angle of incidence" annotation(Placement(visible = true, transformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "Direct normal irradiance" annotation(Placement(visible = true, transformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      SurfDirNor = DNI * ((-1.094 * AOI ^ 6) + 3.992 * AOI ^ 5 - 5.733 * AOI ^ 4 + 3.868 * AOI ^ 3 - 1.22 * AOI ^ 2 + 0.15 * AOI + 0.956) "Fresenl Reflection losses from Polyfit where P_Tranmitted(AOI)";
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Text(origin = {-2.81,1.48}, extent = {{-67.01000000000001,33.14},{67.01000000000001,-33.14}}, textString = "Glazing Losses")}));
    end ICS_GlazingLosses;
    model ICS_SelfShading "This model multiplies the DNI in by a shaded factor determined from the solar altitude and azimuth"
      Modelica.Blocks.Interfaces.RealOutput DNI_out "DNI after shading factor multiplication" annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Tables.CombiTable2D Shading(table = [0,-3.1415926,-1.04719,-0.959927,-0.872667,-0.785397,-0.6981270000000001,-0.610867,-0.523597,-0.436327,-0.349067,-0.261797,-0.174837,-0.08726730000000001,0,0.08726730000000001,0.174837,0.261797,0.349067,0.436327,0.523597,0.610867,0.6981270000000001,0.785397,0.872667,0.959927,1.04719,3.1415926;-0.872665,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;-0.785398,0,0,0.515733288,0.582273933,0.644111335,0.700774874,0.751833306,0.796898047,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.796898047,0.751833306,0.700774874,0.644111335,0.582273933,0.515733288,0,0;-0.698132,0,0,0.558719885,0.630806722,0.697798298,0.759184768,0.814498944,0.86331985,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.86331985,0.814498944,0.759184768,0.697798298,0.630806722,0.558719885,0,0;-0.610865,0,0,0.5974542859999999,0.674538691,0.746174596,0.811816808,0.870965752,0.923171268,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.923171268,0.870965752,0.811816808,0.746174596,0.674538691,0.5974542859999999,0,0;-0.523599,0,0,0.6316417,0.713137013,0.788872054,0.8582704330000001,0.920803986,0.975996795,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.975996795,0.920803986,0.8582704330000001,0.788872054,0.713137013,0.6316417,0,0;-0.436332,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;-0.349066,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;-0.261799,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;-0.174533,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;-0.087266,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;0,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;0.087266,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;0.174533,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;0.261799,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;0.349066,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;0.436332,0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0,0;0.523599,0,0,0.6316417,0.713137013,0.788872054,0.8582704330000001,0.920803986,0.975996795,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.975996795,0.920803986,0.8582704330000001,0.788872054,0.713137013,0.6316417,0,0;0.610865,0,0,0.5974542859999999,0.674538691,0.746174596,0.811816808,0.870965752,0.923171268,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.923171268,0.870965752,0.811816808,0.746174596,0.674538691,0.5974542859999999,0,0;0.698132,0,0,0.558719885,0.630806722,0.697798298,0.759184768,0.814498944,0.86331985,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.86331985,0.814498944,0.759184768,0.697798298,0.630806722,0.558719885,0,0;0.785398,0,0,0.515733288,0.582273933,0.644111335,0.700774874,0.751833306,0.796898047,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.796898047,0.751833306,0.700774874,0.644111335,0.582273933,0.515733288,0,0;0.872665,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) "Shading factors based on altitude and azimuth" annotation(Placement(visible = true, transformation(origin = {-20,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI_in "DNI in before shading factor multiplication" annotation(Placement(visible = true, transformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Math.Product product1 "Multiplication of DNI and shading factor" annotation(Placement(visible = true, transformation(origin = {20,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ICSolar.Envelope.RotationMatrixForSphericalCood rotationmatrixforsphericalcood1 annotation(Placement(visible = true, transformation(origin = {-60,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SunAzi "Solar azimuth" annotation(Placement(visible = true, transformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfTilt annotation(Placement(visible = true, transformation(origin = {-100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SunAlt "Solar altitude" annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfOrientation annotation(Placement(visible = true, transformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      product1.u2 = if Shading.y < 0 then 0 else Shading.y;
      connect(rotationmatrixforsphericalcood1.SurfYaw,Shading.u2) annotation(Line(points = {{-50,-34},{-45.283,-34},{-45.283,-46.1538},{-32,-46.1538},{-32,-46}}));
      connect(rotationmatrixforsphericalcood1.SurfPitch,Shading.u1) annotation(Line(points = {{-50,-44},{-43.2511,-44},{-43.2511,-34.2525},{-32,-34.2525},{-32,-34}}));
      connect(SurfTilt,rotationmatrixforsphericalcood1.SurfaceTilt) annotation(Line(points = {{-100,-80},{-75.60980000000001,-80},{-75.60980000000001,-46.3415},{-70,-46.3415},{-70,-46}}));
      connect(SurfOrientation,rotationmatrixforsphericalcood1.SurfaceOrientation) annotation(Line(points = {{-100,-60},{-78.8618,-60},{-78.8618,-42.0054},{-70,-42.0054},{-70,-42}}));
      connect(SunAlt,rotationmatrixforsphericalcood1.SunAlt) annotation(Line(points = {{-100,-40},{-78.8618,-40},{-78.8618,-37.9404},{-70,-37.9404},{-70,-38}}));
      connect(SunAzi,rotationmatrixforsphericalcood1.SunAzi) annotation(Line(points = {{-100,-20},{-76.6938,-20},{-76.6938,-33.8753},{-70,-33.8753},{-70,-34}}));
      connect(product1.y,DNI_out) "DNI after multiplication connected to output of model" annotation(Line(points = {{31,40},{58.5909,40},{58.5909,19.7775},{100,19.7775},{100,20}}));
      //connect(Shading.y,product1.u2) "Shading factor connecting to product" annotation(Line(points = {{-9,-40},{-0.741656,-40},{-0.741656,33.869},{8,33.869},{8,34}}));
      connect(DNI_in,product1.u1) "Model input DNI connecting to product" annotation(Line(points = {{-100,80},{-36.3412,80},{-36.3412,45.9827},{8,45.9827},{8,46}}));
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Text(origin = {-4.59,2.51}, extent = {{-72.63,35.36},{72.63,-35.36}}, textString = "Self Shading")}));
    end ICS_SelfShading;
    class RotationMatrixForSphericalCood "This models changes the reference frame from the Solar Altitude / Aizmuth to the surface yaw and pitch angles based on building orientatino and surface tilt"
      // parameter Real RollAng = 0;  Not included in current model verison
      Modelica.Blocks.Interfaces.RealOutput SurfYaw annotation(Placement(visible = true, transformation(origin = {100,60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,60}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput SurfPitch annotation(Placement(visible = true, transformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-40}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SunAzi annotation(Placement(visible = true, transformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,60}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      // Construction of Spherical to Cartesain Matrix
      Real theta = SunAlt;
      Real phi = SunAzi;
      Real PitchAng = SurfaceTilt "Tilt back from Vertical Position";
      Real YawAng = SurfaceOrientation "Zero is direct SOUTH";
      // Spherical to Cartesian with +Y North and +X East
      Real vSphToCart[3,1] = [-1 * Modelica.Math.cos(theta) * Modelica.Math.cos(phi);-1 * Modelica.Math.cos(theta) * Modelica.Math.cos(phi);Modelica.Math.sin(theta)];
      // Result of Cartesian to Spherical
      Real vCartToSph[3,1];
      // Rotation around X-axis --> PitchAng
      Real Rx[3,3] = [1,0,0;0,Modelica.Math.cos(PitchAng),-1 * Modelica.Math.sin(PitchAng);0,Modelica.Math.sin(PitchAng),Modelica.Math.cos(PitchAng)];
      // Rotation around Y-axis --> RollAng
      // Real Ry[3,3] = [Modelica.Math.cos(PitchAng),0,Modelica.Math.sin(PitchAng);0,1,0;-1 * Modelica.Math.sin(PitchAng),0,Modelica.Math.cos(PitchAng)];
      // Rotation around the Z-axis --> YawAng
      Real Rz[3,3] = [Modelica.Math.cos(YawAng),-1 * Modelica.Math.sin(YawAng),0;Modelica.Math.sin(YawAng),Modelica.Math.cos(YawAng),0;0,0,1];
      Modelica.Blocks.Interfaces.RealInput SunAlt annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,20}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfaceOrientation annotation(Placement(visible = true, transformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-20}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfaceTilt annotation(Placement(visible = true, transformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-60}, extent = {{-15,-15},{15,15}}, rotation = 0)));
    equation
      vCartToSph = Rx * Rz * vSphToCart;
      SurfYaw = Modelica.Math.atan(vCartToSph[1,1] / vCartToSph[2,1]);
      SurfPitch = Modelica.Math.asin(vCartToSph[3,1]);
      annotation(Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Text(origin = {16.0156,3.67356}, extent = {{-101.49,60.28},{73.98,-63.83}}, textString = "Transform Matrix")}));
    end RotationMatrixForSphericalCood;
    function EnthalpyDifferential
      input Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a baseline_enthalpy annotation(Placement(visible = true, transformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      input Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a generated_enthalpy annotation(Placement(visible = true, transformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      output Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b enthalpy_power annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Math.Abs abs_baseline annotation(Placement(visible = true, transformation(origin = {-60,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Math.Abs abs_generated annotation(Placement(visible = true, transformation(origin = {-60,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      enthalpy_power = abs_generated.y - abs_baseline.y;
      connect(generated_enthalpy,abs2.u) annotation(Line(points = {{-100,-20},{-73.0047,-20},{-73.0047,-19.9531},{-73.0047,-19.9531}}));
      connect(baseline_enthalpy,abs1.u) annotation(Line(points = {{-100,60},{-72.77,60},{-72.77,60.0939},{-72.77,60.0939}}));
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
    end EnthalpyDifferential;
  end Envelope;
  package Stack "Package of all the necessary components to create an Integrated Concentrating Solar simulation"
    extends Modelica.Icons.Package;
    model ICS_Stack "This model represents an individual Integrated Concentrating Solar Stack"
      Modelica.Blocks.Interfaces.RealInput StackHeight "Might be used later to multiply Modules" annotation(Placement(visible = true, transformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "DNI in from Envelope (Parent)" annotation(Placement(visible = true, transformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1 "Thermal fluid inflow port" annotation(Placement(visible = true, transformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1 "Thermal fluid outflow port" annotation(Placement(visible = true, transformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in "Ambient temperature of the cavity" annotation(Placement(visible = true, transformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput Power_out "Electrical power generated" annotation(Placement(visible = true, transformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ICSolar.Module.ICS_Module ics_module1 annotation(Placement(visible = true, transformation(origin = {0,20}, extent = {{-25,-25},{25,25}}, rotation = 0)));
    equation
      connect(ics_module1.flowport_b1,flowport_b1) annotation(Line(points = {{25,10},{72.9679,10},{72.9679,0.756144},{100,0.756144},{100,0}}));
      connect(ics_module1.Power_out,Power_out) annotation(Line(points = {{25,30},{73.1267,30},{73.1267,40.5633},{100,40.5633},{100,40}}));
      connect(flowport_a1,ics_module1.flowport_a1) annotation(Line(points = {{-100,-60},{-32.8922,-60},{-32.8922,10.2079},{-25,10.2079},{-25,10}}));
      connect(DNI,ics_module1.DNI) annotation(Line(points = {{-100,-20},{-46.1248,-20},{-46.1248,25.7089},{-25,25.7089},{-25,25}}));
      connect(TAmb_in,ics_module1.TAmb_in) annotation(Line(points = {{-100,60},{-34.0265,60},{-34.0265,39.3195},{-25,39.3195},{-25,40}}));
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Text(origin = {0.95,5.29}, extent = {{-61.06,40.08},{61.06,-40.08}}, textString = "Stack")}));
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
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1 "Outflow port of the thermal fluid (to Parent)" annotation(Placement(visible = true, transformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1 "Inflow port of the thermal fluid (from Parent)" annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "DNI into the Module" annotation(Placement(visible = true, transformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in "Ambient temperature of the cavity into Module model for use in the heat receiver" annotation(Placement(visible = true, transformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ICSolar.Receiver.moduleReceiver modulereceiver1 "Heat Receiver to calculate the heat transfer between heat gen and heat transfered to thermal fluid" annotation(Placement(visible = true, transformation(origin = {65,-5}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput Power_out "Electrical generation outflow (to Parent)" annotation(Placement(visible = true, transformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ICSolar.Module.ICS_LensLosses ics_lenslosses1 annotation(Placement(visible = true, transformation(origin = {-60,-2}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      ICSolar.Module.ICS_PVPerformance ics_pvperformance1 annotation(Placement(visible = true, transformation(origin = {0,0}, extent = {{-16.25,-16.25},{16.25,16.25}}, rotation = 0)));
    equation
      connect(ics_pvperformance1.ElectricalGen,Power_out) annotation(Line(points = {{16.25,6.5},{33.9773,6.5},{33.9773,39.3195},{100,39.3195},{100,40}}));
      connect(ics_pvperformance1.ThermalGen,modulereceiver1.ThermalGen) annotation(Line(points = {{16.25,-7.3125},{45.38,-7.3125},{45.38,6.04915},{50,6.04915},{50,-0.714286}}));
      connect(ics_lenslosses1.ConcentrationFactor,ics_pvperformance1.ConcentrationFactor) annotation(Line(points = {{-45,-11},{-39.3195,-11},{-39.3195,-9.82987},{-16.25,-9.82987},{-16.25,-9.75}}));
      connect(ics_lenslosses1.DNI_out,ics_pvperformance1.DNI_in) annotation(Line(points = {{-45,4},{-34.4045,4},{-34.4045,0.378072},{-16.25,0.378072},{-16.25,0}}));
      connect(DNI,ics_lenslosses1.DNI_in) annotation(Line(points = {{-100,20},{-75,20},{-75,-2}}));
      connect(modulereceiver1.flowport_a1,flowport_a1) "Connect pump flow the heat receiver" annotation(Line(points = {{62,10},{39.4366,10},{39.4366,-40.1408},{-100,-40.1408},{-100,-40}}));
      connect(TAmb_in,modulereceiver1.TAmb_in) "Connect Ambient temperature from Context to the HeatReceivers calculations" annotation(Line(points = {{-100,80},{25.7277,80},{25.7277,0.08450000000000001},{50,0.08450000000000001},{50,6.78571}}));
      connect(modulereceiver1.flowport_b1,flowport_b1) "Connect HeatReceiver fluid flow out to the flowport outlet of Module" annotation(Line(points = {{80,-0.714286},{87.08920000000001,-0.714286},{87.08920000000001,-39.2019},{100,-39.2019},{100,-40}}));
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
      Modelica.Blocks.Interfaces.RealInput CellWidth "Width of the PV Cell" annotation(Placement(visible = false, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Real CellEfficiency = 0.36436 + (52.5 - ThermalGen.T) * 0.0005004 + (ConcentrationFactor - 627.5) * 1.9965e-006 "Equation to determine the PVEfficiency from the ConcentrationFactor and Cell Temperature";
      Real EIPC "Energy In Per Cell";
      Modelica.Blocks.Interfaces.RealInput ConcentrationFactor "Used to represent 'suns' for the calculation of PVEfficiency" annotation(Placement(visible = true, transformation(origin = {-100,-60}, extent = {{-25,-25},{25,25}}, rotation = 0), iconTransformation(origin = {-100,-60}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput ElectricalGen "Real output for piping the generated electrical energy out" annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-25,-25},{25,25}}, rotation = 0), iconTransformation(origin = {100,40}, extent = {{-25,-25},{25,25}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b ThermalGen "Output heat port to pipe the generated heat out and to the heat receiver" annotation(Placement(visible = true, transformation(origin = {100,-60}, extent = {{-15,-15},{15,15}}, rotation = 0), iconTransformation(origin = {100,-45}, extent = {{-25,-25},{25,25}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI_in "DNI in from the Lens model (include Concentration)" annotation(Placement(visible = true, transformation(origin = {-100,20}, extent = {{-25,-25},{25,25}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-15,-15},{15,15}}, rotation = 0)));
    equation
      EIPC = DNI_in * CellWidth ^ 2 "Energy In Per Cell, used to calculate maximum energy on the cell";
      ElectricalGen = EIPC * CellEfficiency "Electrical energy conversion";
      ThermalGen.Q_flow = -EIPC * (1 - CellEfficiency) "Energy left over after electrical gen is converted to heat";
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Text(origin = {-3.11195,-3.79298}, extent = {{-63.55,45.8},{63.55,-45.8}}, textString = "PV Performance")}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
    end ICS_PVPerformance;
    model ICS_LensLosses "This model does the concentrating lens calculations: transmission losses and concentration. DNI_out is the DNI after concentration"
      parameter Real Eff_Optic = 0.882;
      Modelica.Blocks.Interfaces.RealInput DNI_in annotation(Placement(visible = true, transformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput LensWidth annotation(Placement(visible = false, transformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput CellWidth annotation(Placement(visible = false, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput DNI_out annotation(Placement(visible = true, transformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput ConcentrationFactor = LensWidth ^ 2 / CellWidth ^ 2 annotation(Placement(visible = true, transformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      DNI_out = DNI_in * Eff_Optic * ConcentrationFactor;
      annotation(Documentation(info = "<HTML>
<p><b> Tramission losses associated with the lens / optic elements. Ratio of power on the cell to power on the entry aperture.</b></p>

<p>Optical efficiency from LBI Benitez <b>High performance Fresnel-based photovoltaic concentrator</b> where Eff_Opt(F#). Assuming anti-reflective coating on secondary optic element (SOE), current Gen8 module design Eff_Opt(0.84) = 88.2%</p> 

<b>More Information:</b>
<p> The F-number for a Fresnal-Köhler lens is the ratio of the distance between cell and Fresenel lens to the diagonal measurement of the front lens. The concentrator optical efficiency is defined as the ratio of power on the cell to the power on the entry aperture when the sun is exactly on-axis.</p>
</HTML>"), Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Text(origin = {0.694127,36.2079}, extent = {{-72.52,54.46},{72.52,-54.46}}, textString = "Lens Losses")}));
    end ICS_LensLosses;
  end Module;
  package Receiver "Package of all the necessary components to create an Integrated Concentrating Solar simulation"
    extends Modelica.Icons.Package;
    model moduleReceiver
      parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium = Modelica.Thermal.FluidHeatFlow.Media.Water() "Water" annotation(choicesAllMatching = true);
      parameter Modelica.SIunits.Pressure PAmb(displayUnit = "PA") = 101325 "Ambient pressure";
      parameter Modelica.SIunits.Temperature TAmb(displayUnit = "degK") = 293.15 "Ambient temperature";
      ICSolar.Receiver.subClasses.receiverInternalEnergy receiverInternalEnergy1 annotation(Placement(visible = true, transformation(origin = {-158.447,-48.4473}, extent = {{-23.4473,-23.4473},{23.4473,23.4473}}, rotation = 0)));
      ICSolar.Receiver.subClasses.Water_Block_HX water_Block_HX1 annotation(Placement(visible = true, transformation(origin = {-28.4646,3.4646}, extent = {{-33.4646,-33.4646},{33.4646,33.4646}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput Input_heatLossTube_1 annotation(Placement(visible = true, transformation(origin = {22.5,42.5}, extent = {{-12.5,-12.5},{12.5,12.5}}, rotation = 0), iconTransformation(origin = {-200,-10}, extent = {{-20.0,-20.0},{20.0,20.0}}, rotation = 0)));
      ICSolar.Receiver.subClasses.Tubing_Losses tubing_Losses1(Tubing(medium = medium, m = 0.0023, T0 = 298.15, V_flowLaminar(displayUnit = "l/min") = 4.1666666666667e-006, dpLaminar(displayUnit = "kPa") = 1000, V_flowNominal(displayUnit = "l/min") = 0.00041666666666667, dpNominal(displayUnit = "kPa") = 100000, h_g = 0.3)) annotation(Placement(visible = true, transformation(origin = {61.4355,-1.4355}, extent = {{-31.4355,-31.4355},{31.4355,31.4355}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambientTemperature_2(T = TAmb) annotation(Placement(visible = true, transformation(origin = {190,-16.6949}, extent = {{10.0,-10.0},{-10.0,10.0}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput Input_heatLossTube_2 annotation(Placement(visible = true, transformation(origin = {60,42.5}, extent = {{-12.5,-12.5},{12.5,12.5}}, rotation = 0), iconTransformation(origin = {-200,-50}, extent = {{-20,-20},{20,20}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1 annotation(Placement(visible = true, transformation(origin = {200,60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {200,100}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in annotation(Placement(visible = true, transformation(origin = {-200,170}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-200,170}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput Input_waterBlock_1 annotation(Placement(visible = true, transformation(origin = {-200,97.5}, extent = {{-17.5,-17.5},{17.5,17.5}}, rotation = 0), iconTransformation(origin = {-200,30}, extent = {{-20,-20},{20,20}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermalGen annotation(Placement(visible = true, transformation(origin = {-200,-10}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-200,100}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1 annotation(Placement(visible = true, transformation(origin = {-200,40}, extent = {{-10,-10},{10,10}}, rotation = -90), iconTransformation(origin = {-40,200}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      connect(tubing_Losses1.flowport_b1,flowport_b1) annotation(Line(points = {{92.871,-1.4355},{137.358,-1.4355},{137.358,58.1132},{200,58.1132},{200,60}}));
      connect(ThermalGen,water_Block_HX1.energyFrom_CCA) annotation(Line(points = {{-200,-10},{-119.049,-10},{-119.049,-9.753500000000001},{-61.9292,-9.753500000000001},{-61.9292,-9.921239999999999}}));
      connect(receiverInternalEnergy1.port_b,water_Block_HX1.heatCap_waterBlock) annotation(Line(visible = true, origin = {-79.7717,-20.413}, points = {{-55.228,-13.9659},{-5.2283,-13.9659},{-5.2283,-4.587},{17.8425,-4.587},{17.8425,-2.89408}}, color = {191,0,0}));
      connect(Input_heatLossTube_2,tubing_Losses1.input_Convection_1) annotation(Line(visible = true, origin = {75.3643,39}, points = {{-15.3643,3.5},{4.6357,3.5},{4.6357,1},{3.04637,1},{3.04637,-9}}, color = {0,0,127}));
      connect(Input_heatLossTube_1,tubing_Losses1.input_Convection_2) annotation(Line(visible = true, origin = {40.7871,39}, points = {{-18.2871,3.5},{4.2129,3.5},{4.2129,1},{4.93065,1},{4.93065,-9}}, color = {0,0,127}));
      connect(water_Block_HX1.flowport_b1,tubing_Losses1.flowport_a1) annotation(Line(visible = true, origin = {21.1339,-0.3516}, points = {{-15.4646,2.47762},{-1.1339,2.47762},{-1.1339,-1.9357},{8.866099999999999,-1.9357},{8.866099999999999,-1.0839}}, color = {255,0,0}));
      connect(tubing_Losses1.port_a,ambientTemperature_2.port) annotation(Line(visible = true, origin = {104.881,-25}, points = {{-11.3813,1.55965},{5.1188,1.55965},{5.1188,8.305099999999999},{75.119,8.305099999999999}}, color = {191,0,0}));
      connect(Input_waterBlock_1,water_Block_HX1.Gc_Receiver) annotation(Line(points = {{-200,97.5},{-100,97.5},{-100,30.2363},{-61.9292,30.2363}}, color = {0,0,127}, smooth = Smooth.None));
      connect(flowport_a1,water_Block_HX1.flowport_a1) annotation(Line(points = {{-200,40},{-130,40},{-130,16.8504},{-61.9292,16.8504}}, color = {255,0,0}, smooth = Smooth.None));
      connect(TAmb_in,water_Block_HX1.heatLoss_to_ambient) annotation(Line(points = {{-200,170},{-140,170},{-140,3.4646},{-61.9292,3.4646}}, color = {191,0,0}, smooth = Smooth.None));
      annotation(Diagram(coordinateSystem(extent = {{-200,-80},{200,200}}, preserveAspectRatio = false, initialScale = 0.1, grid = {10,10}), graphics = {Text(origin = {12.5,110}, fillPattern = FillPattern.Solid, extent = {{-42.5,-5},{42.5,5}}, textString = "Bring the Ambient Sources and pump Outside the Class ", fontName = "Arial")}), Icon(coordinateSystem(extent = {{-200,-80},{200,200}}, preserveAspectRatio = false, initialScale = 0.1, grid = {10,10}), graphics = {Text(origin = {-176.897,44.8507}, fillPattern = FillPattern.Solid, extent = {{-21.0405,-8.383100000000001},{21.0405,8.383100000000001}}, textString = "Gc_Reveiver", fontName = "Arial"),Text(origin = {-171.755,4.4444}, fillPattern = FillPattern.Solid, extent = {{-28.2454,-4.4444},{28.2454,4.4444}}, textString = "Gc_Water-Tube", fontName = "Arial"),Text(origin = {-173.964,-36.4781}, fillPattern = FillPattern.Solid, extent = {{-26.0359,-3.5219},{26.0359,3.5219}}, textString = "Gc_Insulation-Air", fontName = "Arial"),Text(origin = {3.12,117.49}, extent = {{-133.92,40.92},{133.92,-40.92}}, textString = "Heat"),Text(origin = {9.854509999999999,16.9292}, extent = {{-154.79,56.03},{154.79,-56.03}}, textString = "Receiver")}));
    end moduleReceiver;
    package subClasses "Contains the subClasses for receiver"
      extends Modelica.Icons.Package;
      connector Egen_port
        Modelica.SIunits.Power p "Power in Watts at the port" annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Polygon(points = {{100,100},{-100,100},{-100,-100},{100,-100},{100,100}}, lineColor = {0,0,0}, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Text(extent = {{-150,-90},{150,-150}}, lineColor = {0,0,0}, fillColor = {0,0,0}, fillPattern = FillPattern.Solid, textString = "%name"),Polygon(points = {{70,70},{-70,70},{-70,-70},{70,-70},{70,70}}, lineColor = {255,255,255}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid)}), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Polygon(points = {{100,100},{-100,100},{-100,-100},{100,-100},{100,100}}, lineColor = {0,0,0}, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Polygon(points = {{70,70},{-70,70},{-70,-70},{70,-70},{70,70}}, lineColor = {255,255,255}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid)}));
      end Egen_port;
      class receiverInternalEnergy
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation(Placement(visible = true, transformation(origin = {100,60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatcapacitor1(C = 60) "60 J/K is calculated in spreadsheet in 1-DOCS\\calculators ...thermal mass or heat capacity of receiver.xlsx" annotation(Placement(visible = true, transformation(origin = {-20,0}, extent = {{-10,10},{10,-10}}, rotation = 0)));
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
        parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium = Modelica.Thermal.FluidHeatFlow.Media.Water() "Water" annotation(choicesAllMatching = true);
        parameter Modelica.SIunits.Temperature TAmb(displayUnit = "degK") = 293.15 "Ambient temperature";
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1(medium = medium) annotation(Placement(visible = true, transformation(origin = {100.0,40.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {102.0,-4.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput Gc_Receiver annotation(Placement(visible = true, transformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1(medium = medium) annotation(Placement(visible = true, transformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.FluidHeatFlow.Components.HeatedPipe heatedpipe1(h_g = 0, T0 = TAmb, medium = medium, T(start = TAmb), pressureDrop(fixed = false), T0fixed = false, m = 0.003, dpNominal(displayUnit = "kPa") = 62270, V_flowLaminar(displayUnit = "l/min") = 1.6666666666667e-006, dpLaminar(displayUnit = "kPa") = 14690, V_flowNominal(displayUnit = "l/min") = 3.995e-006) annotation(Placement(visible = true, transformation(origin = {-20,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalconductor1(G = 0.037 * 0.0381) annotation(Placement(visible = true, transformation(origin = {20,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.Convection convection1 annotation(Placement(visible = true, transformation(origin = {60,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a energyFrom_CCA annotation(Placement(visible = true, transformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalcollector1 annotation(Placement(visible = true, transformation(origin = {-20,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCap_waterBlock annotation(Placement(visible = true, transformation(origin = {-100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatLoss_to_ambient annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      equation
        connect(heatedpipe1.flowPort_b,flowport_b1) annotation(Line(visible = true, points = {{-10.0,40.0},{102.579,40.0},{102.579,39.4841},{100.0,40.0}}));
        connect(heatLoss_to_ambient,convection1.fluid) annotation(Line(points = {{-100,-40},{84.4649,-40},{84.4649,0},{70,0}}));
        connect(heatCap_waterBlock,thermalcollector1.port_b) annotation(Line(points = {{-100,-80},{-19.7929,-80},{-19.7929,-10},{-20,-10}}));
        connect(energyFrom_CCA,thermalcollector1.port_a[1]) annotation(Line(points = {{-100,0},{-82.1634,0},{-82.1634,10.817},{-19.3326,10.817},{-19.3326,10.6667},{-20,10.6667}}));
        connect(heatedpipe1.heatPort,thermalcollector1.port_a[2]) annotation(Line(points = {{-20,30},{-20.0397,30},{-20,-9.920629999999999},{-20,10}}));
        connect(thermalcollector1.port_a[3],thermalconductor1.port_a) annotation(Line(points = {{-20,9.33333},{-6.74603,9.33333},{-6.74603,-0.198413},{10,-0.198413},{10,0}}));
        connect(Gc_Receiver,convection1.Gc) annotation(Line(points = {{-100,80},{57.3413,80},{57.3413,10.119},{60,10.119},{60,10}}));
        connect(flowport_a1,heatedpipe1.flowPort_a) annotation(Line(points = {{-100,40},{-30.1587,40},{-30,40}}));
        connect(thermalconductor1.port_b,convection1.solid) annotation(Line(points = {{30,0},{50,0}}));
        annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
      end Water_Block_HX;
      class Tubing_Losses
        parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium = Modelica.Thermal.FluidHeatFlow.Media.Water() "Water" annotation(choicesAllMatching = true);
        Modelica.Thermal.FluidHeatFlow.Components.HeatedPipe Tubing(medium = medium, V_flowLaminar = 1e-006, V_flowNominal = 1e-005, h_g = 0, m = 0.0025, T0 = 293, dpLaminar = 0.45, dpNominal = 10) annotation(Placement(visible = true, transformation(origin = {-80,0}, extent = {{-10,-10},{10,10}}, rotation = 90)));
        Modelica.Thermal.HeatTransfer.Components.Convection convection1 annotation(Placement(visible = true, transformation(origin = {80.0,0.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor Conduction_Insulation(G = 0.037 * 0.0381) annotation(Placement(visible = true, transformation(origin = {40,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor Conduction_Tube(G = 0.145 * 0.0015) annotation(Placement(visible = true, transformation(origin = {0,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.Convection convection2 annotation(Placement(visible = true, transformation(origin = {-40,0}, extent = {{10,-10},{-10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a(T(start = 293)) annotation(Placement(visible = true, transformation(origin = {100.0,-60.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {102.0,-70.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput input_Convection_2 annotation(Placement(visible = true, transformation(origin = {-60.0,60.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {-50.0,100.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput input_Convection_1 annotation(Placement(visible = true, transformation(origin = {60.0,60.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {54.0,100.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1(medium = medium) annotation(Placement(visible = true, transformation(origin = {-80,80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1(medium = medium) annotation(Placement(visible = true, transformation(origin = {-80.0,-80.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {-100.0,0.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
      equation
        connect(input_Convection_1,convection1.Gc) annotation(Line(visible = true, points = {{60.0,60.0},{80.3571,60.0},{80.3571,10.3175},{80.0,10.0}}));
        connect(input_Convection_2,convection2.Gc) annotation(Line(visible = true, points = {{-60.0,60.0},{-39.881,60.0},{-39.881,10.9127},{-40.0,10.0}}));
        connect(convection1.fluid,port_a) annotation(Line(visible = true, points = {{90.0,0.0},{97.8175,0.0},{97.8175,-43.8492},{87.5,-43.8492},{87.5,-60.9127},{98.61109999999999,-60.9127},{100.0,-60.0}}));
        connect(Conduction_Insulation.port_b,convection1.solid) annotation(Line(visible = true, points = {{50.0,0.0},{70.4365,0.0},{70.4365,0.1984},{70.0,0.0}}));
        connect(flowport_a1,Tubing.flowPort_a) annotation(Line(visible = true, points = {{-80.0,-80.0},{-79.9603,-80.0},{-79.9603,-10.3175},{-80.0,-10.0}}));
        connect(flowport_b1,Tubing.flowPort_b) annotation(Line(points = {{-80,80},{-79.9615,80},{-79.9615,10},{-80,10}}));
        connect(Conduction_Tube.port_b,Conduction_Insulation.port_a) annotation(Line(points = {{10,0},{30.5556,0},{30,0}}));
        connect(convection2.solid,Conduction_Tube.port_a) annotation(Line(points = {{-30,0},{-9.920629999999999,0},{-10,0}}));
        connect(Tubing.heatPort,convection2.fluid) annotation(Line(points = {{-70,-6.12303e-016},{-70,0},{-50,0}}));
        annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
      end Tubing_Losses;
    end subClasses;
  end Receiver;
  model Parameters
    parameter Real SystemsFlow = 2e-006;
    Real HeatSinkResistivity = 0.0282 * SystemsFlow ^ (-0.773);
    annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
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
    Modelica.Blocks.Math.Abs abs_baseline annotation(Placement(visible = true, transformation(origin = {-60,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Math.Abs abs_generated annotation(Placement(visible = true, transformation(origin = {-60,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  equation
    enthalpy_power = abs_generated.y - abs_baseline.y;
    connect(generated_enthalpy,abs2.u) annotation(Line(points = {{-100,-20},{-73.0047,-20},{-73.0047,-19.9531},{-73.0047,-19.9531}}));
    connect(baseline_enthalpy,abs1.u) annotation(Line(points = {{-100,60},{-72.77,60},{-72.77,60.0939},{-72.77,60.0939}}));
    annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
  end EnthalpyDifferential;
  annotation(uses(Modelica(version = "3.2.1")));
end ICSolar;