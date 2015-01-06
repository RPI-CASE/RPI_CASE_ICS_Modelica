package ICSolar "Package of all the necessary components to create an Integrated Concentrating Solar simulation"
  extends Modelica.Icons.Package;
  model ICS_Skeleton "This model calculates the electrical and thermal generation of ICSolar. This model is used as a skeleton piece to hold together the other models until it is packages as an FMU."
    parameter Real FLensWidth = 0.25019 "Lens width";
    parameter Real CellWidth = 0.01 "PV Cell width";
    parameter Modelica.SIunits.Pressure PAmb(displayUnit = "PA") = 101325 "Ambient pressure";
    ICSolar.ICS_Context ics_context1 "Weather data and building orientation model" annotation(Placement(visible = true, transformation(origin = {-80,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Thermal.FluidHeatFlow.Sources.Ambient Source(constantAmbientPressure = PAmb, constantAmbientTemperature = 293, medium = Modelica.Thermal.FluidHeatFlow.Media.Water()) "Thermal fluid source" annotation(Placement(visible = true, transformation(origin = {-80,-20}, extent = {{-10,-10},{10,10}}, rotation = 180)));
    Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow Pump(constantVolumeFlow = 1e-005, m = 1, T0 = 293, medium = Modelica.Thermal.FluidHeatFlow.Media.Water()) "Fluid pump for thermal fluid" annotation(Placement(visible = true, transformation(origin = {-40,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Thermal.FluidHeatFlow.Sources.Ambient Sink(constantAmbientPressure = PAmb, constantAmbientTemperature = 293, medium = Modelica.Thermal.FluidHeatFlow.Media.Water()) "Thermal fluid sink, will be replaced with a tank later" annotation(Placement(visible = true, transformation(origin = {60,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    ICSolar.Envelope.ICS_EnvelopeCassette ics_envelopecassette1 "Building envelope that houses ICSolar" annotation(Placement(visible = true, transformation(origin = {0,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  equation
    connect(ics_context1.TDryBul,ics_envelopecassette1.TAmb_in) "Connects the dry bult temperature from the weather file to the ambient temperature of the caviety" annotation(Line(points = {{-70,22},{-49.061,22},{-49.061,26.0563},{-10,26.0563},{-10,26}}));
    connect(ics_context1.SurfOrientation_out,ics_envelopecassette1.SurfaceOrientation) "connects surface azimuth on a install surface" annotation(Line(points = {{-70,14},{-38.0282,14},{-38.0282,15.7277},{-10,15.7277},{-10,16}}));
    connect(ics_context1.SurfTilt,ics_envelopecassette1.SurfaceTilt) "connects surface tilt on the installed surface" annotation(Line(points = {{-70,16},{-40.1408,16},{-40.1408,18.3099},{-10,18.3099},{-10,18}}));
    connect(ics_context1.AOI,ics_envelopecassette1.AOI) "Connects Angle of Incidence on the installed surface" annotation(Line(points = {{-70,18},{-41.784,18},{-41.784,20.1878},{-10,20.1878},{-10,20}}));
    connect(ics_envelopecassette1.flowport_b,Sink.flowPort) "Connects system outflow to fluid sink" annotation(Line(points = {{10,14},{27.4648,14},{27.4648,0.234742},{50,0.234742},{50,0}}));
    connect(Pump.flowPort_b,ics_envelopecassette1.flowport_a) "Connects pump to system's fluid inflow" annotation(Line(points = {{-30,-20},{-23.0047,-20},{-23.0047,11.2676},{-9.5,11.2676},{-9.5,11.5}}));
    connect(ics_context1.DNI,ics_envelopecassette1.DNI) "connects DNI from weather file to envelope" annotation(Line(points = {{-70,20},{-44.8357,20},{-44.8357,23.9437},{-30.7512,24},{-10,24}}));
    connect(Source.flowPort,Pump.flowPort_a) "connects fluid source to pump" annotation(Line(points = {{-70,-20},{-49.7653,-20},{-49.7653,-20},{-50,-20}}));
    annotation(experiment(StartTime = 0, StopTime = 31540000.0, Tolerance = 1e-006, Interval = 3600.46));
    connect(ics_context1.SunAzi,ics_envelopecassette1.SunAzi) "Connects the sun's azimuth" annotation(Line(points = {{-55,35},{-24.9527,35},{-24.9527,35.5388},{-24.9527,35.5388}}));
    connect(ics_context1.SunAlt,ics_envelopecassette1.SunAlt) "Connects the sun's altitude" annotation(Line(points = {{-55,40},{-24.5747,40},{-24.5747,39.6975},{-24.5747,39.6975}}));
  end ICS_Skeleton;
  model ICS_Context "This model provides the pieces necessary to set up the context to run the simulation, in FMU practice this will be cut out and provided from the EnergyPlus file"
    parameter Real Lat = 40.71 * Modelica.Constants.pi / 180 "Latitude";
    parameter Real SurfOrientation = Buildings.HeatTransfer.Types.Azimuth.S "Surface orientation: Change 'S' to 'W','E', or 'N' for other orientations";
    parameter Real SurfTilt = Buildings.HeatTransfer.Types.Tilt.Wall "Surface tilt: Change 'Ceiling' to 'Wall' or 'Floor' for other configurations";
    Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam = "modelica://Buildings/Resources/weatherdata/USA_NY_New.York-Central.Park.725033_TMY3.mos", pAtmSou = Buildings.BoundaryConditions.Types.DataSource.Parameter, TDryBul(displayUnit = "K"), TDewPoi(displayUnit = "K"), totSkyCovSou = Buildings.BoundaryConditions.Types.DataSource.Parameter, opaSkyCovSou = Buildings.BoundaryConditions.Types.DataSource.Parameter, totSkyCov = 0.01, opaSkyCov = 0.01) "Weather data reader for New York Central Park" annotation(Placement(visible = true, transformation(origin = {-40,20}, extent = {{-20,-20},{20,20}}, rotation = 0)));
    Buildings.BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTil(til = SurfTilt, azi = SurfOrientation, lat = Lat) "Irradiance on tilted surface" annotation(Placement(visible = true, transformation(origin = {20,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b TDryBul "Dry bulb temperature" annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput DNI "Direct normal irradiance" annotation(Placement(visible = true, transformation(origin = {100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput AOI "Angle of incidence" annotation(Placement(visible = true, transformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput SurfTilt_out "Solar altitude in relation to the tilt of the surface" annotation(Placement(visible = true, transformation(origin = {100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput SurfOrientation_out "Solar azimuth in relation to the oriention of the surface" annotation(Placement(visible = true, transformation(origin = {100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput SunAzi "Solar azimuth";
    Modelica.Blocks.Interfaces.RealOutput SunAlt "Solar altitude";
    Buildings.BoundaryConditions.SolarGeometry.BaseClasses.Declination decAng "Solar declination (seasonal offset)" annotation(Placement(visible = true, transformation(origin = {-40,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Buildings.BoundaryConditions.SolarGeometry.BaseClasses.SolarHourAngle solHouAng "Solar hour angle" annotation(Placement(visible = true, transformation(origin = {-40,-80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Buildings.BoundaryConditions.WeatherData.Bus weatherBus "Connector to put variables from the weather file" annotation(Placement(visible = true, transformation(origin = {20,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {20,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Buildings.HeatTransfer.Sources.PrescribedTemperature TOutside "Outside temperature" annotation(Placement(visible = true, transformation(origin = {60,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  equation
    SurfOrientation_out = SurfOrientation "Connects Surface Orientation Parameter to Surface Orientation Output";
    SurfTilt_out = SurfTilt "Connects Surface Tilt Parameter to Surface Tilt Output";
    connect(weatherBus.HDirNor,DNI) "Connects Hourly Direct Normal Irradiance from the weather file to the DNI output of context";
    connect(TOutside.port,TDryBul) "Connects the prescribed heat model to the Dry Bulb heat port outlet" annotation(Line(points = {{70,20},{97.8229,20},{97.8229,20},{100,20}}));
    connect(weatherBus.TDryBul,TOutside.T) "Connects the weather file Dry Bult to the TOutside prescribed temperature model" annotation(Line(points = {{20,20},{47.0247,20},{47.0247,20},{48,20}}));
    connect(weatherBus,HDirTil.weaBus) "Connects the weather bus to the irradiance based on wall tilt calculation model (HDirTil)" annotation(Line(points = {{20,20},{19.7388,20},{19.7388,-17.4165},{-3.48331,-17.4165},{-3.48331,-40.0581},{10,-40.0581},{10,-40}}));
    connect(HDirTil.inc,AOI) "Connects incident angle to angle of incidence out" annotation(Line(points = {{31,-44},{45.5733,-44},{45.5733,-40.0581},{100,-40.0581},{100,-40}}));
    connect(weatherBus.solTim,solHouAng.solTim) "Connects solar time to solar hour angle model" annotation(Line(points = {{20,20},{19.7388,20},{19.7388,-17.4165},{-63.5704,-17.4165},{-63.5704,-79.8258},{-52,-79.8258},{-52,-80}}));
    connect(weatherBus.cloTim,decAng.nDay) "Calculates clock time to day number" annotation(Line(points = {{20,20},{19.7388,20},{19.7388,-17.4165},{-63.5704,-17.4165},{-63.5704,-40.0581},{-52,-40.0581},{-52,-40}}));
    connect(weaDat.weaBus,weatherBus) "Connects weather data to weather bus" annotation(Line(points = {{-20,20},{20.6096,20},{20,20}}));
    SunAlt = Modelica.Math.asin(Modelica.Math.sin(Lat) * Modelica.Math.sin(decAng.decAng) + Modelica.Math.cos(Lat) * Modelica.Math.cos(decAng.decAng) * Modelica.Math.cos(solHouAng.solHouAng));
    // SurfAlt = SunAlt - SurfTilt;
    SunAzi = Modelica.Math.asin(Modelica.Math.cos(decAng.decAng) * Modelica.Math.sin(solHouAng.solHouAng) / Modelica.Math.cos(SunAlt));
    // SurfAzi = SunAzi - SurfOrientation;
  end ICS_Context;
  package Envelope "Package of all the Envelope components to create an Integrated Concentrating Solar simulation"
    extends Modelica.Icons.Package;
    model ICS_EnvelopeCassette "This model in the Envelope Cassette (Double-Skin Facade) that houses the ICSolar Stack and Modules. This presents a building envelope"
      parameter Real StackHeight = 6.0 "Number of Modules in a stack, currently not used";
      parameter Real NumStacks = 4.0 "Number of stacks in an envelope, currently not used";
      parameter Modelica.SIunits.Area ArrayArea = 1 "Area of the array";
      Modelica.Blocks.Interfaces.RealInput AOI "Angle of incidence" annotation(Placement(visible = true, transformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "DNI from weather file" annotation(Placement(visible = true, transformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ICSolar.Envelope.ICS_SelfShading ics_selfshading1 "Module overlap (shading) model" annotation(Placement(visible = true, transformation(origin = {-20,20}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b "Thermal fluid outflow port, after heat exchange" annotation(Placement(visible = true, transformation(origin = {100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in "Ambient cavity temperature" annotation(Placement(visible = true, transformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a "Thermal fluid inflow port, before heat exchange" annotation(Placement(visible = true, transformation(origin = {-100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-95,-85}, extent = {{-5,-5},{5,5}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfTilt "Altitude of the sun in relation to the surface" annotation(Placement(visible = true, transformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfaceOrientation "Azimuth of the sun in relation to the surface" annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SunAlt "Altitude of the sun " annotation(Placement(visible = true, transformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SunAzi "Azimuth of the sun " annotation(Placement(visible = true, transformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput Power_out "Electric power generated" annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ICSolar.Stack.ICS_Stack ics_stack1 "ICSolar Stack, contains Module" annotation(Placement(visible = true, transformation(origin = {40,0}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      ICSolar.Envelope.ICS_GlazingLosses ics_glazinglosses1 "Determines transmitted DNI through first glazing layer" annotation(Placement(visible = true, transformation(origin = {-60,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      connect(flowport_a,ics_stack1.flowport_a1) "Thermal fluid inflow to stack inflow" annotation(Line(points = {{-100,-80},{-23.4742,-80},{-23.4742,-9.389670000000001},{25.1174,-9.389670000000001},{25.1174,-9.389670000000001}}));
      connect(ics_selfshading1.DNI_out,ics_stack1.DNI) "DNI after shading to stack DNI in" annotation(Line(points = {{-5,23},{8.450699999999999,23},{8.450699999999999,-2.8169},{24.6479,-2.8169},{24.6479,-2.8169}}));
      connect(ics_glazinglosses1.SurfDirNor,ics_selfshading1.DNI_in) "DNI after transmission losses to selfshading inlet" annotation(Line(points = {{-50,42},{-46.0299,42},{-46.0299,32.2209},{-35.2129,32.2209},{-35.2129,32.2209}}));
      connect(AOI,ics_glazinglosses1.AOI) "Angle of Incidence piped to glazinglosses" annotation(Line(points = {{-100,0},{-86.53619999999999,0},{-86.53619999999999,33.6018},{-69.7353,33.6018},{-69.7353,33.6018}}));
      connect(DNI,ics_glazinglosses1.DNI) "DNI before glazing losses, piped to glazing losses model" annotation(Line(points = {{-100,40},{-79.17149999999999,40},{-79.17149999999999,46.0299},{-69.7353,46.0299},{-69.7353,46.0299}}));
      connect(ics_stack1.flowport_b1,flowport_b) "Thermal fluid outflow, after heat exchange" annotation(Line(points = {{55,0},{65.49299999999999,0},{65.49299999999999,-20.1878},{99.5305,-20.1878},{99.5305,-20.1878}}));
      connect(ics_stack1.Power_out,Power_out) "Electrical power piped out" annotation(Line(points = {{55,6},{62.2066,6},{62.2066,20.1878},{93.4272,20.1878},{93.4272,20.1878}}));
      connect(SurfOrientation,ics_selfshading1.SurfOrientation) "Piping solar azimuth to selfshading for calculations" annotation(Line(points = {{-100,-40},{-67.92449999999999,-40},{-67.92449999999999,8.12772},{-35.4136,8.12772},{-35.4136,8.12772}}));
      connect(SurfTilt,ics_selfshading1.SurfTilt) "Piping solar altitude to selfshading for calculations" annotation(Line(points = {{-100,-20},{-75.762,-20},{-75.762,14.2235},{-35.7039,14.2235},{-35.7039,14.2235}}));
      ics_stack1.StackHeight = StackHeight "linking variables of stack heigh";
      connect(TAmb_in,ics_stack1.TAmb_in) "Piping ambient temperature into the stack";
      connect(SunAzi,ics_selfshading1.SunAzi) annotation(Line(points = {{-100,0},{-37.9404,0},{-37.9404,0},{-37.9404,0}}));
      connect(SunAlt,ics_selfshading1.SunAlt) annotation(Line(points = {{-100,20},{-57.1816,20},{-57.1816,6.77507},{-37.6694,6.77507},{-37.6694,6.77507}}));
    end ICS_EnvelopeCassette;
    model ICS_GlazingLosses "This model calculates the transmittance of a single glass layer and discounts the DNI by the absorption and reflection"
      // Optical Efficiency from LBI Benitez paper where Eff_Opt(F#) ->	Eff_Opt(0.84) = 88.2%
      parameter Real Eff_Optic = 0.882;
      Modelica.Blocks.Interfaces.RealOutput SurfDirNor "Surface direct normal solar irradiance" annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput AOI "Angle of incidence" annotation(Placement(visible = true, transformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "Direct normal irradiance" annotation(Placement(visible = true, transformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      SurfDirNor = DNI * Eff_Optic * ((-1.094 * AOI ^ 6) + 3.992 * AOI ^ 5 - 5.733 * AOI ^ 4 + 3.868 * AOI ^ 3 - 1.22 * AOI ^ 2 + 0.15 * AOI + 0.956) "Fresenl Reflection losses from Polyfit where P_Tranmitted(AOI)";
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
    end ICS_GlazingLosses;
    model ICS_SelfShading "This model multiplies the DNI in by a shaded factor determined from the solar altitude and azimuth"
      Modelica.Blocks.Interfaces.RealOutput DNI_out "DNI after shading factor multiplication" annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Tables.CombiTable2D Shading(table = [0,120,125,130,135,140,145,150,155,160,165,170,175,180,185,190,195,200,205,210,215,220,225,230,235,240;-50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;-45,0,0.515733288,0.582273933,0.644111335,0.700774874,0.751833306,0.796898047,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.796898047,0.751833306,0.700774874,0.644111335,0.582273933,0.515733288,0;-40,0,0.558719885,0.630806722,0.697798298,0.759184768,0.814498944,0.86331985,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.86331985,0.814498944,0.759184768,0.697798298,0.630806722,0.558719885,0;-35,0,0.5974542859999999,0.674538691,0.746174596,0.811816808,0.870965752,0.923171268,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.923171268,0.870965752,0.811816808,0.746174596,0.674538691,0.5974542859999999,0;-30,0,0.6316417,0.713137013,0.788872054,0.8582704330000001,0.920803986,0.975996795,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.975996795,0.920803986,0.8582704330000001,0.788872054,0.713137013,0.6316417,0;-25,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;-20,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;-15,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;-10,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;-5,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;5,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;10,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;15,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;20,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;25,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;30,0,0.6316417,0.713137013,0.788872054,0.8582704330000001,0.920803986,0.975996795,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.975996795,0.920803986,0.8582704330000001,0.788872054,0.713137013,0.6316417,0;35,0,0.5974542859999999,0.674538691,0.746174596,0.811816808,0.870965752,0.923171268,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.923171268,0.870965752,0.811816808,0.746174596,0.674538691,0.5974542859999999,0;40,0,0.558719885,0.630806722,0.697798298,0.759184768,0.814498944,0.86331985,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.86331985,0.814498944,0.759184768,0.697798298,0.630806722,0.558719885,0;45,0,0.515733288,0.582273933,0.644111335,0.700774874,0.751833306,0.796898047,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.796898047,0.751833306,0.700774874,0.644111335,0.582273933,0.515733288,0;50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) "Shading factors based on altitude and azimuth" annotation(Placement(visible = true, transformation(origin = {-20,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfAlt "Solar altitude in relation to surface pitch" annotation(Placement(visible = true, transformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfAzi "Solar azimuth in relation to surface yaw" annotation(Placement(visible = true, transformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI_in "DNI in before shading factor multiplication" annotation(Placement(visible = true, transformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Math.Product product1 "Multiplication of DNI and shading factor" annotation(Placement(visible = true, transformation(origin = {20,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      connect(product1.y,DNI_out) "DNI after multiplication connected to output of model" annotation(Line(points = {{31,40},{58.5909,40},{58.5909,19.7775},{93.2015,19.7775},{93.2015,19.7775}}));
      connect(Shading.y,product1.u2) "Shading factor connecting to product" annotation(Line(points = {{-9,-40},{-0.741656,-40},{-0.741656,33.869},{7.41656,33.869},{7.41656,33.869}}));
      connect(DNI_in,product1.u1) "Model input DNI connecting to product" annotation(Line(points = {{-100,80},{-36.3412,80},{-36.3412,45.9827},{6.92213,45.9827},{6.92213,45.9827}}));
      connect(SurfAzi,Shading.u2) "Connecting azimuth to shading table" annotation(Line(points = {{-100,-60},{-70.53700000000001,-60},{-70.53700000000001,-46.1538},{-33.9623,-46.1538},{-33.9623,-46.1538}}));
      connect(SurfAlt,Shading.u1) "Connecting altitude to shading table" annotation(Line(points = {{-100,-20},{-71.9884,-20},{-71.9884,-33.672},{-32.8012,-33.672},{-32.8012,-33.672}}));
    end ICS_SelfShading;
  end Envelope;
  package Stack "Package of all the necessary components to create an Integrated Concentrating Solar simulation"
    extends Modelica.Icons.Package;
    model ICS_Stack "This model represents an individual Integrated Concentrating Solar Stack"
      Modelica.Blocks.Interfaces.RealInput StackHeight "Might be used later to multiply Modules" annotation(Placement(visible = true, transformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "DNI in from Envelope (Parent)" annotation(Placement(visible = true, transformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ICSolar.Module.ICS_Module ics_module1 "One ICSolar Module (Child)" annotation(Placement(visible = true, transformation(origin = {0,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1 "Thermal fluid inflow port" annotation(Placement(visible = true, transformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1 "Thermal fluid outflow port" annotation(Placement(visible = true, transformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in "Ambient temperature of the cavity" annotation(Placement(visible = true, transformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput Power_out "Electrical power generated" annotation(Placement(visible = true, transformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      connect(ics_module1.Power_out,Power_out) "Piping electrical power generated at the PV cell out to the stack" annotation(Line(points = {{10,24},{53.2864,24},{53.2864,40.1408},{92.723,40.1408},{92.723,40.1408}}));
      connect(TAmb_in,ics_module1.TAmb_in) "Piping the cavity temperature into Module for use in heat exchange with the Heat Receiver model" annotation(Line(points = {{-100,60},{-50.7983,60},{-50.7983,27.8665},{-9.86938,27.8665},{-9.86938,27.8665}}));
      connect(ics_module1.flowport_b1,flowport_b1) "Thermal fluid outflow after heat exchange" annotation(Line(points = {{10,16},{39.2019,16},{39.2019,0},{100,0},{100,0}}));
      connect(flowport_a1,ics_module1.flowport_a1) "Thermal fluid inflow before heat exchange" annotation(Line(points = {{-100,-60},{-54.9296,-60},{-54.9296,16.1972},{-9.389670000000001,16.1972},{-9.389670000000001,16.1972}}));
      connect(DNI,ics_module1.DNI) "DNI from Envelope into Module for use in generation calculations" annotation(Line(points = {{-100,-20},{-65.9624,-20},{-65.9624,21.831},{-10.5634,21.831},{-10.5634,21.831}}));
    end ICS_Stack;
  end Stack;
  package Module "Package of all the necessary components to create an Integrated Concentrating Solar simulation"
    extends Modelica.Icons.Package;
    model ICS_Module "This model contains all the components and equations that simulate one module of Integrated Concentrating Solar"
      parameter Modelica.SIunits.Length LensWidth = 0.25019 "Width of Fresnel Lens, meters";
      parameter Modelica.SIunits.Length CellWidth = 0.01 "Width of the PV cell, meters";
      parameter String FresMat = "PMMA" "'PMMA' or 'Silicon on Glass', use the exact spellings provided";
      parameter Real FNum = 0.85 "FNum determines the lens transmittance based on concentrating";
      Integer FMatNum "Integer used to pipe the material to other models";
      parameter Real Gc_Receiver = 0.75 "Thermal conductance of the heat receiver";
      parameter Real Gc_WaterTube = 0.75 "Thermal conductance of the Water Tubing";
      parameter Real Gc_InsulationAir = 0.75 "Thermal conductance of the Insulation Air";
      ICSolar.Module.ICS_PVPerformance ics_pvperformance1 "Model to calculate the electrical and thermal generation" annotation(Placement(visible = true, transformation(origin = {0,0}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1 "Outflow port of the thermal fluid (to Parent)" annotation(Placement(visible = true, transformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1 "Inflow port of the thermal fluid (from Parent)" annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI "DNI into the Module" annotation(Placement(visible = true, transformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in "Ambient temperature of the cavity into Module model for use in the heat receiver" annotation(Placement(visible = true, transformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ICSolar.Receiver.moduleReceiver modulereceiver1 "Heat Receiver to calculate the heat transfer between heat gen and heat transfered to thermal fluid" annotation(Placement(visible = true, transformation(origin = {65,-5}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput Power_out "Electrical generation outflow (to Parent)" annotation(Placement(visible = true, transformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ICSolar.Module.ICS_Lens ics_lens1 "Lens Transmittance and Concentration" annotation(Placement(visible = true, transformation(origin = {-55,15}, extent = {{-15,-15},{15,15}}, rotation = 0)));
    equation
      connect(modulereceiver1.flowport_a1,flowport_a1) "Connect pump flow the heat receiver" annotation(Line(points = {{62,16.4286},{39.4366,16.4286},{39.4366,-40.1408},{-100,-40.1408},{-100,-40.1408}}));
      connect(ics_pvperformance1.ThermalGen,modulereceiver1.ThermalGen) "Connect thermal generation at the PV cell to the heat input into heat receiver" annotation(Line(points = {{15,-9},{34.9765,-9},{34.9765,5.86854},{50.2347,5.86854},{50.2347,5.86854}}));
      connect(TAmb_in,modulereceiver1.TAmb_in) "Connect Ambient temperature from Context to the HeatReceivers calculations" annotation(Line(points = {{-100,80},{15.7277,80},{15.7277,14.0845},{50,14.0845},{50,14.0845}}));
      connect(modulereceiver1.flowport_b1,flowport_b1) "Connect HeatReceiver fluid flow out to the flowport outlet of Module" annotation(Line(points = {{80,5.71429},{87.08920000000001,5.71429},{87.08920000000001,-39.2019},{100.469,-39.2019},{100.469,-39.2019}}));
      connect(ics_pvperformance1.ElectricalGen,Power_out) "Connect PVPerformance electrical gen to Module output" annotation(Line(points = {{15,0},{29.8122,0},{29.8122,40.3756},{100,40.3756},{100,40}}));
      connect(ics_pvperformance1.ConcentrationFactor,ics_lens1.ConcentrationFactor) "Connects Lens concentratingfactor to PVPerformance concentratingfactor to calculate PVEfficiency in PVPerformance" annotation(Line(points = {{-15,-6},{-28.6385,-6},{-28.6385,15.0235},{-40,15.0235},{-40,15}}));
      connect(ics_lens1.DNI_out,ics_pvperformance1.DNI_in) "Connects DNI after Lens losses and concentrating to the input of PVPerformance" annotation(Line(points = {{-40,21},{-25.1174,21},{-25.1174,11.7371},{-15,11.7371},{-15,12}}));
      connect(DNI,ics_lens1.DNI_in) "Connect DNI into Module to DNI_in of Lens" annotation(Line(points = {{-100,20},{-83.33329999999999,20},{-83.33329999999999,15.0235},{-70,15.0235},{-70,15}}));
      if FresMat == "PMMA" then
        FMatNum = 1;
      elseif FresMat == "Silicon on Glass" then
        FMatNum = 2;
      else
      end if;
      ics_lens1.FMat = FMatNum "Connects FMatNum calculated in Module to Lens FMat input";
      ics_lens1.LensWidth = LensWidth "Connects LensWidth defined in Module to Lens LensWidth";
      ics_lens1.CellWidth = CellWidth "Connect CellWidth defined in Module to CellWidth in Lens";
      ics_pvperformance1.CellWidth = CellWidth "Connect CellWidth defined in Module to CellWidth in PVPerformance for EIPC calc on Cell";
      ics_lens1.FNum = FNum "Connects the FNumber defined in Module to FNum in Lens for concentration and transmission equations";
      modulereceiver1.Input_waterBlock_1 = Gc_Receiver "connect(Gc_Receiver,modulereceiver1.Input_waterBlock_1)";
      modulereceiver1.Input_heatLossTube_1 = Gc_WaterTube "connect(Gc_WaterTube,modulereceiver1.Input_heatLossTube_1)";
      modulereceiver1.Input_heatLossTube_2 = Gc_InsulationAir "connect(Gc_InsulationAir,modulereceiver1.Input_heatLossTube_2)";
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
      Modelica.Blocks.Interfaces.RealInput DNI_in "DNI in from the Lens model (include Concentration)" annotation(Placement(visible = true, transformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput CellWidth "Width of the PV Cell" annotation(Placement(visible = false, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput ConcentrationFactor "Used to represent 'suns' for the calculation of PVEfficiency" annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      parameter Real CellEfficiency = 0.35 "Equation to determine the PVEfficiency from the ConcentrationFactor";
      Real EIPC "Energy In Per Cell";
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b ThermalGen "Output heat port to pipe the generated heat out and to the heat receiver" annotation(Placement(visible = true, transformation(origin = {100,-40}, extent = {{-15,-15},{15,15}}, rotation = 0), iconTransformation(origin = {100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput ElectricalGen "Real output for piping the generated electrical energy out" annotation(Placement(visible = true, transformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      EIPC = DNI_in * CellWidth ^ 2 "Energy In Per Cell, used to calculate maximum energy on the cell";
      ElectricalGen = EIPC * CellEfficiency "Electrical energy conversion";
      ThermalGen.Q_flow = -EIPC * (1 - CellEfficiency) "Energy left over after electrical gen is converted to heat";
    end ICS_PVPerformance;
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
      ICSolar.Receiver.subClasses.Tubing_Losses tubing_Losses1 annotation(Placement(visible = true, transformation(origin = {61.4355,-1.4355}, extent = {{-31.4355,-31.4355},{31.4355,31.4355}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambientTemperature_2(T = TAmb) annotation(Placement(visible = true, transformation(origin = {190,-16.6949}, extent = {{10.0,-10.0},{-10.0,10.0}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput Input_heatLossTube_2 annotation(Placement(visible = true, transformation(origin = {60,42.5}, extent = {{-12.5,-12.5},{12.5,12.5}}, rotation = 0), iconTransformation(origin = {-200,-50}, extent = {{-20,-20},{20,20}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1 annotation(Placement(visible = true, transformation(origin = {200,60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {200,100}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in annotation(Placement(visible = true, transformation(origin = {-200,170}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-200,170}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput Input_waterBlock_1 annotation(Placement(visible = true, transformation(origin = {-200,97.5}, extent = {{-17.5,-17.5},{17.5,17.5}}, rotation = 0), iconTransformation(origin = {-200,30}, extent = {{-20,-20},{20,20}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermalGen annotation(Placement(visible = true, transformation(origin = {-200,-10}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-200,100}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1 annotation(Placement(visible = true, transformation(origin = {-200,40}, extent = {{-10,-10},{10,10}}, rotation = -90), iconTransformation(origin = {-40,200}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      connect(tubing_Losses1.flowport_b1,flowport_b1) annotation(Line(points = {{92.871,-1.4355},{137.358,-1.4355},{137.358,58.1132},{200.348,58.1132},{200.348,58.1132}}));
      connect(ThermalGen,water_Block_HX1.energyFrom_CCA) annotation(Line(points = {{-200,-10},{-119.049,-10},{-119.049,-9.753500000000001},{-61.9292,-9.753500000000001},{-61.9292,-9.921239999999999}}));
      connect(receiverInternalEnergy1.port_b,water_Block_HX1.heatCap_waterBlock) annotation(Line(visible = true, origin = {-79.7717,-20.413}, points = {{-55.228,-13.9659},{-5.2283,-13.9659},{-5.2283,-4.587},{17.8425,-4.587},{17.8425,-2.89408}}, color = {191,0,0}));
      connect(Input_heatLossTube_2,tubing_Losses1.input_Convection_1) annotation(Line(visible = true, origin = {75.3643,39}, points = {{-15.3643,3.5},{4.6357,3.5},{4.6357,1},{3.04637,1},{3.04637,-9}}, color = {0,0,127}));
      connect(Input_heatLossTube_1,tubing_Losses1.input_Convection_2) annotation(Line(visible = true, origin = {40.7871,39}, points = {{-18.2871,3.5},{4.2129,3.5},{4.2129,1},{4.93065,1},{4.93065,-9}}, color = {0,0,127}));
      connect(water_Block_HX1.flowport_b1,tubing_Losses1.flowport_a1) annotation(Line(visible = true, origin = {21.1339,-0.3516}, points = {{-15.4646,2.47762},{-1.1339,2.47762},{-1.1339,-1.9357},{8.866099999999999,-1.9357},{8.866099999999999,-1.0839}}, color = {255,0,0}));
      connect(tubing_Losses1.port_a,ambientTemperature_2.port) annotation(Line(visible = true, origin = {104.881,-25}, points = {{-11.3813,1.55965},{5.1188,1.55965},{5.1188,8.305099999999999},{75.119,8.305099999999999}}, color = {191,0,0}));
      connect(Input_waterBlock_1,water_Block_HX1.Gc_Receiver) annotation(Line(points = {{-200,97.5},{-100,97.5},{-100,30.2363},{-61.9292,30.2363}}, color = {0,0,127}, smooth = Smooth.None));
      connect(flowport_a1,water_Block_HX1.flowport_a1) annotation(Line(points = {{-200,40},{-130,40},{-130,16.8504},{-61.9292,16.8504}}, color = {255,0,0}, smooth = Smooth.None));
      connect(TAmb_in,water_Block_HX1.heatLoss_to_ambient) annotation(Line(points = {{-200,170},{-140,170},{-140,3.4646},{-61.9292,3.4646}}, color = {191,0,0}, smooth = Smooth.None));
      annotation(Icon(coordinateSystem(extent = {{-200,-80},{200,200}}, preserveAspectRatio = false, initialScale = 0.1, grid = {10,10}), graphics = {Text(origin = {-176.897,44.8507}, fillPattern = FillPattern.Solid, extent = {{-21.0405,-8.383100000000001},{21.0405,8.383100000000001}}, textString = "Gc_Reveiver", fontName = "Arial"),Text(origin = {-171.755,4.4444}, fillPattern = FillPattern.Solid, extent = {{-28.2454,-4.4444},{28.2454,4.4444}}, textString = "Gc_Water-Tube", fontName = "Arial"),Text(origin = {-173.964,-36.4781}, fillPattern = FillPattern.Solid, extent = {{-26.0359,-3.5219},{26.0359,3.5219}}, textString = "Gc_Insulation-Air", fontName = "Arial")}), Diagram(coordinateSystem(extent = {{-200,-80},{200,200}}, preserveAspectRatio = false, initialScale = 0.1, grid = {10,10}), graphics = {Text(origin = {12.5,110}, fillPattern = FillPattern.Solid, extent = {{-42.5,-5},{42.5,5}}, textString = "Bring the Ambient Sources and pump Outside the Class ", fontName = "Arial")}));
    end moduleReceiver;
    package subClasses "Contains the subClasses for receiver"
      extends Modelica.Icons.Package;
      connector Egen_port
        Modelica.SIunits.Power p "Power in Watts at the port" annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Polygon(points = {{100,100},{-100,100},{-100,-100},{100,-100},{100,100}}, lineColor = {0,0,0}, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Text(extent = {{-150,-90},{150,-150}}, lineColor = {0,0,0}, fillColor = {0,0,0}, fillPattern = FillPattern.Solid, textString = "%name"),Polygon(points = {{70,70},{-70,70},{-70,-70},{70,-70},{70,70}}, lineColor = {255,255,255}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid)}), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Polygon(points = {{100,100},{-100,100},{-100,-100},{100,-100},{100,100}}, lineColor = {0,0,0}, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Polygon(points = {{70,70},{-70,70},{-70,-70},{70,-70},{70,70}}, lineColor = {255,255,255}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid)}));
      end Egen_port;
      class receiverInternalEnergy
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation(Placement(visible = true, transformation(origin = {100,60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatcapacitor1(C = 2000) annotation(Placement(visible = true, transformation(origin = {-20,0}, extent = {{-10,10},{10,-10}}, rotation = 0)));
      equation
        connect(heatcapacitor1.port,port_b) annotation(Line(points = {{-20,10},{-20.023,10},{-20.023,60.5293},{100.115,60.5293},{100.115,60.5293}}));
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
        Modelica.Thermal.FluidHeatFlow.Components.HeatedPipe heatedpipe1(h_g = 0, m = 1, T0 = TAmb, medium = medium, V_flowLaminar = 1e-006, dpLaminar = 0.45, V_flowNominal = 1e-005, dpNominal = 10, T(start = TAmb), pressureDrop(fixed = false)) annotation(Placement(visible = true, transformation(origin = {-20,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalconductor1(G = 0.004) annotation(Placement(visible = true, transformation(origin = {20,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.Convection convection1 annotation(Placement(visible = true, transformation(origin = {60,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a energyFrom_CCA annotation(Placement(visible = true, transformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalcollector1 annotation(Placement(visible = true, transformation(origin = {-20,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCap_waterBlock annotation(Placement(visible = true, transformation(origin = {-100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatLoss_to_ambient annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      equation
        connect(heatedpipe1.flowPort_b,flowport_b1) annotation(Line(visible = true, points = {{-10.0,40.0},{102.579,40.0},{102.579,39.4841},{100.0,40.0}}));
        connect(heatLoss_to_ambient,convection1.fluid) annotation(Line(points = {{-100,-40},{84.4649,-40},{84.4649,0},{70.4258,0},{70.4258,0}}));
        connect(heatCap_waterBlock,thermalcollector1.port_b) annotation(Line(points = {{-100,-80},{-19.7929,-80},{-19.7929,-9.66628},{-19.7929,-9.66628}}));
        connect(energyFrom_CCA,thermalcollector1.port_a[1]) annotation(Line(points = {{-100,0},{-82.1634,0},{-82.1634,10.817},{-19.3326,10.817},{-19.3326,9.896430000000001},{-19.3326,9.896430000000001}}));
        connect(heatedpipe1.heatPort,thermalcollector1.port_a[2]) annotation(Line(points = {{-20,30},{-20.0397,30},{-20,-9.920629999999999},{-20,10}}));
        connect(thermalcollector1.port_a[3],thermalconductor1.port_a) annotation(Line(points = {{-20,10},{-6.74603,10},{-6.74603,-0.198413},{10.7143,-0.198413},{10.7143,-0.198413}}));
        connect(Gc_Receiver,convection1.Gc) annotation(Line(points = {{-100,80},{57.3413,80},{57.3413,10.119},{59.7222,10.119},{59.7222,10.119}}));
        connect(flowport_a1,heatedpipe1.flowPort_a) annotation(Line(points = {{-100,40},{-30.1587,40},{-30.1587,40.0794},{-30.1587,40.0794}}));
        connect(thermalconductor1.port_b,convection1.solid) annotation(Line(points = {{30,0},{50,0},{50,0.198413},{50,0.198413}}));
      end Water_Block_HX;
      class Tubing_Losses
        parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium = Modelica.Thermal.FluidHeatFlow.Media.Water() "Water" annotation(choicesAllMatching = true);
        Modelica.Thermal.FluidHeatFlow.Components.HeatedPipe Tubing(medium = medium, dpLaminar = 0.45, dpNominal = 10, T0 = 293, m = 0.02, V_flowLaminar = 1e-006, V_flowNominal = 1e-005, h_g = 0) annotation(Placement(visible = true, transformation(origin = {-80,0}, extent = {{-10,-10},{10,10}}, rotation = 90)));
        Modelica.Thermal.HeatTransfer.Components.Convection convection1 annotation(Placement(visible = true, transformation(origin = {80.0,0.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor Conduction_Insulation(G = 0.1) annotation(Placement(visible = true, transformation(origin = {40,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor Conduction_Tube(G = 0.1) annotation(Placement(visible = true, transformation(origin = {0,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
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
        connect(flowport_b1,Tubing.flowPort_b) annotation(Line(points = {{-80,80},{-79.9615,80},{-79.9615,9.826589999999999},{-79.9615,9.826589999999999}}));
        connect(Conduction_Tube.port_b,Conduction_Insulation.port_a) annotation(Line(points = {{10,0},{30.5556,0},{30.5556,0},{30.5556,0}}));
        connect(convection2.solid,Conduction_Tube.port_a) annotation(Line(points = {{-30,0},{-9.920629999999999,0},{-9.920629999999999,0.595238},{-9.920629999999999,0.595238}}));
        connect(Tubing.heatPort,convection2.fluid) annotation(Line(points = {{-70,-6.12303e-016},{-70,0},{-49.0079,0},{-49.0079,0}}));
      end Tubing_Losses;
    end subClasses;
  end Receiver;
  annotation(uses(Modelica(version = "3.2.1")));
end ICSolar;