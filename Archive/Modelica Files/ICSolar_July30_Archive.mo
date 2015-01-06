package ICSolar "Package of all the necessary components to create an Integrated Concentrating Solar simulation"
  extends Modelica.Icons.Package;
  model ICS_Skeleton
    parameter Real FLensWidth = 0.25019;
    parameter Real CellWidth = 0.01;
    parameter Modelica.SIunits.Pressure PAmb(displayUnit = "PA") = 101325 "Ambient pressure";
    ICSolar.ICS_Context ics_context1 annotation(Placement(visible = true, transformation(origin = {-80,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Thermal.FluidHeatFlow.Sources.Ambient Source(constantAmbientPressure = PAmb, constantAmbientTemperature = 293, medium = Modelica.Thermal.FluidHeatFlow.Media.Water()) annotation(Placement(visible = true, transformation(origin = {-80,-20}, extent = {{-10,-10},{10,10}}, rotation = 180)));
    Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow Pump(constantVolumeFlow = 1e-005, m = 1, T0 = 293, medium = Modelica.Thermal.FluidHeatFlow.Media.Water()) annotation(Placement(visible = true, transformation(origin = {-40,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Thermal.FluidHeatFlow.Sources.Ambient Sink(constantAmbientPressure = PAmb, constantAmbientTemperature = 293, medium = Modelica.Thermal.FluidHeatFlow.Media.Water()) annotation(Placement(visible = true, transformation(origin = {60,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    ICSolar.Envelope.ICS_EnvelopeCassette ics_envelopecassette1 annotation(Placement(visible = true, transformation(origin = {0,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  equation
    connect(ics_context1.TDryBul,ics_envelopecassette1.TAmb_in) annotation(Line(points = {{-70,22},{-49.061,22},{-49.061,26.0563},{-10,26.0563},{-10,26}}));
    connect(ics_context1.SurfAzi,ics_envelopecassette1.SurfAzi) annotation(Line(points = {{-70,14},{-38.0282,14},{-38.0282,15.7277},{-10,15.7277},{-10,16}}));
    connect(ics_context1.SurfAlt,ics_envelopecassette1.SurfAlt) annotation(Line(points = {{-70,16},{-40.1408,16},{-40.1408,18.3099},{-10,18.3099},{-10,18}}));
    connect(ics_context1.AOI,ics_envelopecassette1.AOI) annotation(Line(points = {{-70,18},{-41.784,18},{-41.784,20.1878},{-10,20.1878},{-10,20}}));
    connect(ics_envelopecassette1.flowport_b,Sink.flowPort) annotation(Line(points = {{10,14},{27.4648,14},{27.4648,0.234742},{50,0.234742},{50,0}}));
    connect(Pump.flowPort_b,ics_envelopecassette1.flowport_a) annotation(Line(points = {{-30,-20},{-23.0047,-20},{-23.0047,11.2676},{-9.5,11.2676},{-9.5,11.5}}));
    connect(ics_context1.DNI,ics_envelopecassette1.DNI) annotation(Line(points = {{-70,20},{-44.8357,20},{-44.8357,23.9437},{-30.7512,24},{-10,24}}));
    connect(Source.flowPort,Pump.flowPort_a) annotation(Line(points = {{-70,-20},{-49.7653,-20},{-49.7653,-20},{-50,-20}}));
  end ICS_Skeleton;
  model ICS_Context
    parameter Real Lat = 40.71 * Modelica.Constants.pi / 180;
    parameter Real SurfOrientation = Buildings.HeatTransfer.Types.Azimuth.S "Change 'S' to 'W','E', or 'N' for other orientations";
    parameter Real SurfTilt = Buildings.HeatTransfer.Types.Tilt.Ceiling "Change 'Ceiling' to 'Wall' or 'Floor' for other configurations";
    Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam = "modelica://Buildings/Resources/weatherdata/USA_NY_New.York-Central.Park.725033_TMY3.mos", pAtmSou = Buildings.BoundaryConditions.Types.DataSource.Parameter, TDryBul(displayUnit = "K"), TDewPoi(displayUnit = "K"), totSkyCovSou = Buildings.BoundaryConditions.Types.DataSource.Parameter, opaSkyCovSou = Buildings.BoundaryConditions.Types.DataSource.Parameter, totSkyCov = 0.01, opaSkyCov = 0.01) "Weather data reader for New York Central Park" annotation(Placement(visible = true, transformation(origin = {-40,20}, extent = {{-20,-20},{20,20}}, rotation = 0)));
    Buildings.BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTil(til = SurfTilt, azi = SurfOrientation, lat = Lat) annotation(Placement(visible = true, transformation(origin = {20,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b TDryBul annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput DNI annotation(Placement(visible = true, transformation(origin = {100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput AOI annotation(Placement(visible = true, transformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput SurfAlt annotation(Placement(visible = true, transformation(origin = {100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput SurfAzi annotation(Placement(visible = true, transformation(origin = {100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Buildings.BoundaryConditions.SolarGeometry.BaseClasses.Declination decAng annotation(Placement(visible = true, transformation(origin = {-40,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Buildings.BoundaryConditions.SolarGeometry.BaseClasses.SolarHourAngle solHouAng annotation(Placement(visible = true, transformation(origin = {-40,-80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Buildings.BoundaryConditions.WeatherData.Bus weatherBus annotation(Placement(visible = true, transformation(origin = {20,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {20,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Buildings.HeatTransfer.Sources.PrescribedTemperature TOutside annotation(Placement(visible = true, transformation(origin = {60,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput HorDirNor annotation(Placement(visible = true, transformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  equation
    connect(weatherBus.HDirNor,HorDirNor) annotation(Line(points = {{20,20},{19.7775,20},{19.7775,0},{91.7182,0},{91.7182,0}}));
    connect(TOutside.port,TDryBul) annotation(Line(points = {{70,20},{97.8229,20},{97.8229,20},{100,20}}));
    connect(weatherBus.TDryBul,TOutside.T) annotation(Line(points = {{20,20},{47.0247,20},{47.0247,20},{48,20}}));
    connect(weatherBus,HDirTil.weaBus) annotation(Line(points = {{20,20},{19.7388,20},{19.7388,-17.4165},{-3.48331,-17.4165},{-3.48331,-40.0581},{10,-40.0581},{10,-40}}));
    connect(HDirTil.inc,AOI) annotation(Line(points = {{31,-44},{45.5733,-44},{45.5733,-40.0581},{100,-40.0581},{100,-40}}));
    connect(weatherBus.solTim,solHouAng.solTim) annotation(Line(points = {{20,20},{19.7388,20},{19.7388,-17.4165},{-63.5704,-17.4165},{-63.5704,-79.8258},{-52,-79.8258},{-52,-80}}));
    connect(weatherBus.cloTim,decAng.nDay) annotation(Line(points = {{20,20},{19.7388,20},{19.7388,-17.4165},{-63.5704,-17.4165},{-63.5704,-40.0581},{-52,-40.0581},{-52,-40}}));
    connect(weaDat.weaBus,weatherBus) annotation(Line(points = {{-20,20},{20.6096,20},{20,20}}));
    connect(HDirTil.H,DNI) annotation(Line(points = {{31,-40},{38.6067,-40},{38.6067,-19.7388},{100,-19.7388},{100,-20}}));
    //Uses the decAng and solHouAng to calculate the Declication and Solar Hour angles
    SurfAlt = Modelica.Math.asin(Modelica.Math.sin(Lat) * Modelica.Math.sin(decAng.decAng) + Modelica.Math.cos(Lat) * Modelica.Math.cos(decAng.decAng) * Modelica.Math.cos(solHouAng.solHouAng)) - SurfTilt;
    // * 180 / Modelica.Constants.pi;
    SurfAzi = Modelica.Math.asin(Modelica.Math.cos(decAng.decAng) * Modelica.Math.sin(solHouAng.solHouAng) / Modelica.Math.cos(SurfAlt)) - SurfOrientation;
    // * 180 / Modelica.Constants.pi;
    annotation(experiment(StartTime = 0, StopTime = 31554000.0, Tolerance = 1e-006, Interval = 63108));
  end ICS_Context;
  package Envelope "Package of all the Envelope components to create an Integrated Concentrating Solar simulation"
    extends Modelica.Icons.Package;
    model ICS_EnvelopeCassette
      parameter Real StackHeight = 6.0;
      parameter Real NumStacks = 4.0;
      parameter Modelica.SIunits.Area ArrayArea = 1;
      Modelica.Blocks.Interfaces.RealInput AOI annotation(Placement(visible = true, transformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI annotation(Placement(visible = true, transformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ICSolar.Envelope.ICS_GlazingLosses ics_glazinglosses1 annotation(Placement(visible = true, transformation(origin = {-60,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ICSolar.Envelope.ICS_SelfShading ics_selfshading1 annotation(Placement(visible = true, transformation(origin = {-20,20}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      ICSolar.Stack.ICS_Stack ics_stack1 annotation(Placement(visible = true, transformation(origin = {35,-5}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b annotation(Placement(visible = true, transformation(origin = {100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in annotation(Placement(visible = true, transformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a annotation(Placement(visible = true, transformation(origin = {-100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-95,-85}, extent = {{-5,-5},{5,5}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfAlt annotation(Placement(visible = true, transformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfAzi annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput Power_out annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      connect(SurfAzi,ics_selfshading1.SurfAzi) annotation(Line(points = {{-100,-40},{-67.92449999999999,-40},{-67.92449999999999,8.12772},{-35.4136,8.12772},{-35.4136,8.12772}}));
      connect(SurfAlt,ics_selfshading1.SurfAlt) annotation(Line(points = {{-100,-20},{-75.762,-20},{-75.762,14.2235},{-35.7039,14.2235},{-35.7039,14.2235}}));
      ics_stack1.StackHeight = StackHeight;
      connect(ics_stack1.Power_out,Power_out) annotation(Line(points = {{50,1},{62.2066,1},{62.2066,20.1878},{93.4272,20.1878},{93.4272,20.1878}}));
      connect(flowport_a,ics_stack1.flowport_a1) annotation(Line(points = {{-100,-80},{-19.9531,-80},{-19.9531,-13.8498},{20.1878,-13.8498},{20.1878,-13.8498}}));
      connect(ics_stack1.flowport_b1,flowport_b) annotation(Line(points = {{50,-5},{65.49299999999999,-5},{65.49299999999999,-20.1878},{99.5305,-20.1878},{99.5305,-20.1878}}));
      connect(ics_selfshading1.DNI_out,ics_stack1.DNI) annotation(Line(points = {{-5,23},{3.05164,23},{3.05164,-8.215960000000001},{20.1878,-8.215960000000001},{20.1878,-8.215960000000001}}));
      connect(ics_glazinglosses1.HDirNor,ics_selfshading1.DNI_in) annotation(Line(points = {{-50,42},{-44.1315,42},{-44.1315,32.1596},{-35.2113,32.1596},{-35.2113,32.1596}}));
      connect(DNI,ics_glazinglosses1.DNI) annotation(Line(points = {{-100,40},{-70.4225,40},{-70.4225,39.9061},{-70.4225,39.9061}}));
      connect(TAmb_in,ics_stack1.TAmb_in);
      // connect(StackHeight,ics_stack1.StackHeight);
    end ICS_EnvelopeCassette;
    model ICS_GlazingLosses
      Modelica.Blocks.Interfaces.RealOutput HDirNor annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      parameter Real G1Tran = 0.99 "Glazing layer 1 solar transmittance, can be made more accurate later";
      Modelica.Blocks.Math.Product GlazingLoss annotation(Placement(visible = true, transformation(origin = {0,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI annotation(Placement(visible = true, transformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      GlazingLoss.u2 = G1Tran;
      connect(DNI,GlazingLoss.u1) annotation(Line(points = {{-100,20},{-42.3803,20},{-42.3803,26.1248},{-12,26.1248},{-12,26}}));
      connect(GlazingLoss.y,HDirNor) annotation(Line(points = {{11,20},{94.3396,20},{94.3396,19.7388},{94.3396,19.7388}}));
    end ICS_GlazingLosses;
    model ICS_SelfShading
      Modelica.Blocks.Interfaces.RealOutput DNI_out annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Tables.CombiTable2D Shading(table = [0,120,125,130,135,140,145,150,155,160,165,170,175,180,185,190,195,200,205,210,215,220,225,230,235,240;-50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;-45,0,0.515733288,0.582273933,0.644111335,0.700774874,0.751833306,0.796898047,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.796898047,0.751833306,0.700774874,0.644111335,0.582273933,0.515733288,0;-40,0,0.558719885,0.630806722,0.697798298,0.759184768,0.814498944,0.86331985,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.86331985,0.814498944,0.759184768,0.697798298,0.630806722,0.558719885,0;-35,0,0.5974542859999999,0.674538691,0.746174596,0.811816808,0.870965752,0.923171268,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.923171268,0.870965752,0.811816808,0.746174596,0.674538691,0.5974542859999999,0;-30,0,0.6316417,0.713137013,0.788872054,0.8582704330000001,0.920803986,0.975996795,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.975996795,0.920803986,0.8582704330000001,0.788872054,0.713137013,0.6316417,0;-25,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;-20,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;-15,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;-10,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;-5,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;5,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;10,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;15,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;20,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;25,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;30,0,0.6316417,0.713137013,0.788872054,0.8582704330000001,0.920803986,0.975996795,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.975996795,0.920803986,0.8582704330000001,0.788872054,0.713137013,0.6316417,0;35,0,0.5974542859999999,0.674538691,0.746174596,0.811816808,0.870965752,0.923171268,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.923171268,0.870965752,0.811816808,0.746174596,0.674538691,0.5974542859999999,0;40,0,0.558719885,0.630806722,0.697798298,0.759184768,0.814498944,0.86331985,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.86331985,0.814498944,0.759184768,0.697798298,0.630806722,0.558719885,0;45,0,0.515733288,0.582273933,0.644111335,0.700774874,0.751833306,0.796898047,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.796898047,0.751833306,0.700774874,0.644111335,0.582273933,0.515733288,0;50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) annotation(Placement(visible = true, transformation(origin = {-20,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfAlt annotation(Placement(visible = true, transformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfAzi annotation(Placement(visible = true, transformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI_in annotation(Placement(visible = true, transformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Math.Product product1 annotation(Placement(visible = true, transformation(origin = {20,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      connect(product1.y,DNI_out) annotation(Line(points = {{31,40},{58.5909,40},{58.5909,19.7775},{93.2015,19.7775},{93.2015,19.7775}}));
      connect(Shading.y,product1.u2) annotation(Line(points = {{-9,-40},{-0.741656,-40},{-0.741656,33.869},{7.41656,33.869},{7.41656,33.869}}));
      connect(DNI_in,product1.u1) annotation(Line(points = {{-100,80},{-36.3412,80},{-36.3412,45.9827},{6.92213,45.9827},{6.92213,45.9827}}));
      connect(SurfAzi,Shading.u2) annotation(Line(points = {{-100,-60},{-70.53700000000001,-60},{-70.53700000000001,-46.1538},{-33.9623,-46.1538},{-33.9623,-46.1538}}));
      connect(SurfAlt,Shading.u1) annotation(Line(points = {{-100,-20},{-71.9884,-20},{-71.9884,-33.672},{-32.8012,-33.672},{-32.8012,-33.672}}));
    end ICS_SelfShading;
  end Envelope;
  package Stack "Package of all the necessary components to create an Integrated Concentrating Solar simulation"
    extends Modelica.Icons.Package;
    model ICS_Stack "This model represents an individual Integrated Concentrating Solar Stack"
      Modelica.Blocks.Interfaces.RealInput StackHeight annotation(Placement(visible = true, transformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI annotation(Placement(visible = true, transformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ICSolar.Module.ICS_Module ics_module1 annotation(Placement(visible = true, transformation(origin = {0,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1 annotation(Placement(visible = true, transformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1 annotation(Placement(visible = true, transformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in annotation(Placement(visible = true, transformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput Power_out annotation(Placement(visible = true, transformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      connect(ics_module1.Power_out,Power_out) annotation(Line(points = {{10,24},{53.2864,24},{53.2864,40.1408},{92.723,40.1408},{92.723,40.1408}}));
      connect(TAmb_in,ics_module1.TAmb_in) annotation(Line(points = {{-100,60},{-50.7983,60},{-50.7983,27.8665},{-9.86938,27.8665},{-9.86938,27.8665}}));
      connect(ics_module1.flowport_b1,flowport_b1) annotation(Line(points = {{10,16},{39.2019,16},{39.2019,0},{100,0},{100,0}}));
      connect(flowport_a1,ics_module1.flowport_a1) annotation(Line(points = {{-100,-60},{-54.9296,-60},{-54.9296,16.1972},{-9.389670000000001,16.1972},{-9.389670000000001,16.1972}}));
      connect(DNI,ics_module1.DNI) annotation(Line(points = {{-100,-20},{-65.9624,-20},{-65.9624,21.831},{-10.5634,21.831},{-10.5634,21.831}}));
    end ICS_Stack;
  end Stack;
  package Module "Package of all the necessary components to create an Integrated Concentrating Solar simulation"
    extends Modelica.Icons.Package;
    model ICS_Module "This model contains all the components and equations that simulate one module of Integrated Concentrating Solar"
      parameter Modelica.SIunits.Length LensWidth = 0.25019 "Width of Fresnel Lens, meters";
      parameter Modelica.SIunits.Length CellWidth = 0.01 "Width of the PV cell, meters";
      parameter String FresMat = "PMMA" "'PMMA' or 'Silicon on Glass', use the exact spellings provided";
      parameter Real FNum = 0.85;
      Integer FMatNum;
      parameter Real PV_efficiency = 0.35;
      parameter Real Gc_Receiver = 0.75;
      parameter Real Gc_WaterTube = 0.75;
      parameter Real Gc_InsulationAir = 0.75;
      ICSolar.Module.ICS_LensLosses ics_lenslosses1 annotation(Placement(visible = true, transformation(origin = {-60,20}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      ICSolar.Module.ICS_CPVOpticalPerformance ics_cpvopticalperformance1 annotation(Placement(visible = true, transformation(origin = {0,0}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1 annotation(Placement(visible = true, transformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1 annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI annotation(Placement(visible = true, transformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in annotation(Placement(visible = true, transformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ICSolar.Receiver.moduleReceiver modulereceiver1 annotation(Placement(visible = true, transformation(origin = {65,-5}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput Power_out annotation(Placement(visible = true, transformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      if FresMat == "PMMA" then
        FMatNum = 1;
      elseif FresMat == "Silicon on Glass" then
        FMatNum = 2;
      else
      end if;
      connect(TAmb_in,modulereceiver1.TAmb_in) annotation(Line(points = {{-100,80},{18.5776,80},{18.5776,-30.7692},{65.0218,-30.7692},{65.0218,-20.029},{65.0218,-20.029}}));
      connect(modulereceiver1.Power_out,Power_out) annotation(Line(points = {{80,-5},{85.21129999999999,-5},{85.21129999999999,40.3756},{92.723,40.3756},{92.723,40.3756}}));
      connect(flowport_b1,modulereceiver1.flowport_b1) annotation(Line(points = {{100,-40},{79.2453,-40},{79.2453,-22.3512},{79.2453,-22.3512},{79.2453,-22.3512}}));
      connect(flowport_a1,modulereceiver1.flowport_a1) annotation(Line(points = {{-100,-40},{26.9956,-40},{26.9956,19.7388},{65.0218,19.7388},{65.0218,10.1597},{65.0218,10.1597}}));
      connect(ics_cpvopticalperformance1.EIPC_out,modulereceiver1.Input_CCA_1) annotation(Line(points = {{15,3},{35.7039,3},{35.7039,6.96662},{50.2177,6.96662},{50.2177,6.96662}}));
      connect(ics_lenslosses1.DNI_out,ics_cpvopticalperformance1.DNI_in) annotation(Line(points = {{-45,20},{-31.6872,20},{-31.6872,11.9342},{-15.6379,11.9342},{-15.6379,11.9342}}));
      connect(DNI,ics_lenslosses1.DNI_in) annotation(Line(points = {{-100,20},{-75.10290000000001,20},{-75.10290000000001,19.9588},{-75.10290000000001,19.9588}}));
      // connect(FMatNum,ics_cpvopticalperformance1.FMat);
      ics_cpvopticalperformance1.FMat = FMatNum;
      // connect(LensWidth,ics_cpvopticalperformance1.LensWidth);
      ics_cpvopticalperformance1.LensWidth = LensWidth;
      // connect(CellWidth,ics_cpvopticalperformance1.CellWidth);
      ics_cpvopticalperformance1.CellWidth = CellWidth;
      // connect(FNum,ics_cpvopticalperformance1.FNum);
      ics_cpvopticalperformance1.FNum = FNum;
      // connect(PV_efficiency,modulereceiver1.Input_CCA_2);
      modulereceiver1.Input_CCA_2 = PV_efficiency;
      // connect(Gc_Receiver,modulereceiver1.Input_waterBlock_1);
      modulereceiver1.Input_waterBlock_1 = Gc_Receiver;
      // connect(Gc_WaterTube,modulereceiver1.Input_heatLossTube_1);
      modulereceiver1.Input_heatLossTube_1 = Gc_WaterTube;
      // connect(Gc_InsulationAir,modulereceiver1.Input_heatLossTube_2);
      modulereceiver1.Input_heatLossTube_2 = Gc_InsulationAir;
    end ICS_Module;
    model ICS_LensLosses
      parameter Real LensTrans = 0.96;
      Modelica.Blocks.Interfaces.RealOutput DNI_out annotation(Placement(visible = true, transformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI_in annotation(Placement(visible = true, transformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      DNI_out = DNI_in * LensTrans;
    end ICS_LensLosses;
    model ICS_CPVOpticalPerformance "This model calculates the amount of solar energy on the PV cell after concentration"
      Modelica.Blocks.Interfaces.RealInput DNI_in annotation(Placement(visible = true, transformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput FNum annotation(Placement(visible = true, transformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput LensWidth annotation(Placement(visible = true, transformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput CellWidth annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Real Concentration = LensWidth ^ 2 / CellWidth ^ 2;
      Real ModuleDepth = LensWidth * sqrt(2) * FNum;
      Real Fresnel;
      Modelica.Blocks.Interfaces.RealOutput EIPC_out annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.IntegerInput FMat annotation(Placement(visible = true, transformation(origin = {-100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      if FMat == 1 then
        Fresnel = ((-20.833 * FNum ^ 3) - 23.214 * FNum ^ 2 + 106.1 * FNum + 23.207) / 3;
      else
        Fresnel = ((-104.17 * FNum ^ 3) + 171.43 * FNum ^ 2 - 40.744 * FNum + 57.236) / 100;
      end if;
      EIPC_out = DNI_in * CellWidth ^ 2 * Fresnel * Concentration;
    end ICS_CPVOpticalPerformance;
    model ICS_Fresnel
      parameter Real FNO = 0.85 "F-number, Fresnel focus factor";
      parameter String FMat = "PMMA" "Fresnel material, can be PMMA or Silicon on Glass";
      Real FLensWidth = FLensWidth_a;
      Real CellWidth = CellWidth_a;
      Real Fresnel;
      Modelica.Blocks.Interfaces.RealOutput Concentration annotation(Placement(visible = true, transformation(origin = {100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput ModuleDepth annotation(Placement(visible = true, transformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput HDirNor_b annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput HDirNor_a annotation(Placement(visible = true, transformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Math.Product DNI_Fresnel annotation(Placement(visible = true, transformation(origin = {0,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput CellWidth_a annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput FLensWidth_a annotation(Placement(visible = true, transformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      // connect(Fresnel,DNI_Fresnel.u2) annotation(Line(points = {{-29,20},{-23.8026,20},{-23.8026,33.9623},{-11.9013,33.9623},{-11.9013,33.9623}}));
      DNI_Fresnel.u2 = Fresnel;
      connect(HDirNor_a,DNI_Fresnel.u1) annotation(Line(points = {{-100,60},{-50.508,60},{-50.508,45.8636},{-12.4819,45.8636},{-12.4819,45.8636}}));
      connect(DNI_Fresnel.y,HDirNor_b) annotation(Line(points = {{11,40},{94.3396,40},{94.3396,19.7388},{94.3396,19.7388}}));
      if FMat == "PMMA" then
        Fresnel = ((-20.833 * FNO ^ 3) - 23.214 * FNO ^ 2 + 106.1 * FNO + 23.207) / 3;
      elseif FMat == "Silicon on Glass" then
        Fresnel = ((-104.17 * FNO ^ 3) + 171.43 * FNO ^ 2 - 40.744 * FNO + 57.236) / 100;
      else
      end if;
      Concentration = FLensWidth ^ 2 / CellWidth ^ 2;
      ModuleDepth = FLensWidth * sqrt(2) * FNO;
    end ICS_Fresnel;
  end Module;
  package Receiver "Package of all the necessary components to create an Integrated Concentrating Solar simulation"
    extends Modelica.Icons.Package;
    model moduleReceiver
      parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium = Modelica.Thermal.FluidHeatFlow.Media.Water() "Water" annotation(choicesAllMatching = true);
      parameter Modelica.SIunits.Pressure PAmb(displayUnit = "PA") = 101325 "Ambient pressure";
      parameter Modelica.SIunits.Temperature TAmb(displayUnit = "degK") = 293.15 "Ambient temperature";
      ICSolar.Receiver.subClasses.CCA_energyBalance CCA_energyBalance1 annotation(Placement(visible = true, transformation(origin = {-87.5,62.5}, extent = {{-32.5,-32.5},{32.5,32.5}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput Input_CCA_1 "DNI_to_CCA" annotation(Placement(visible = true, transformation(origin = {-155.0,80.0}, extent = {{-20.0,-20.0},{20.0,20.0}}, rotation = 0), iconTransformation(origin = {-100.0,80.0}, extent = {{-20.0,-20.0},{20.0,20.0}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput Input_CCA_2 annotation(Placement(visible = true, transformation(origin = {-155.0,46.5777}, extent = {{-20.0,-20.0},{20.0,20.0}}, rotation = 0), iconTransformation(origin = {-100.0,40.0}, extent = {{-20.0,-20.0},{20.0,20.0}}, rotation = 0)));
      ICSolar.Receiver.subClasses.receiverInternalEnergy receiverInternalEnergy1 annotation(Placement(visible = true, transformation(origin = {-128.4473,-88.4473}, extent = {{-23.4473,-23.4473},{23.4473,23.4473}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput Input_waterBlock_1 annotation(Placement(visible = true, transformation(origin = {-90.0,-22.5}, extent = {{-17.5,-17.5},{17.5,17.5}}, rotation = 0), iconTransformation(origin = {-100.0,-0.0}, extent = {{-20.0,-20.0},{20.0,20.0}}, rotation = 0)));
      ICSolar.Receiver.subClasses.Water_Block_HX water_Block_HX1 annotation(Placement(visible = true, transformation(origin = {-28.4646,-56.5354}, extent = {{-33.4646,-33.4646},{33.4646,33.4646}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput Input_heatLossTube_1 annotation(Placement(visible = true, transformation(origin = {22.5,-17.5}, extent = {{-12.5,-12.5},{12.5,12.5}}, rotation = 0), iconTransformation(origin = {-100.0,-40.0}, extent = {{-20.0,-20.0},{20.0,20.0}}, rotation = 0)));
      ICSolar.Receiver.subClasses.Tubing_Losses tubing_Losses1 annotation(Placement(visible = true, transformation(origin = {61.4355,-61.4355}, extent = {{-31.4355,-31.4355},{31.4355,31.4355}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambientTemperature_2(T = TAmb) annotation(Placement(visible = true, transformation(origin = {130.0,-86.6949}, extent = {{10.0,-10.0},{-10.0,10.0}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput Input_heatLossTube_2 annotation(Placement(visible = true, transformation(origin = {60,-17.5}, extent = {{-12.5,-12.5},{12.5,12.5}}, rotation = 0), iconTransformation(origin = {-100,-80}, extent = {{-20,-20},{20,20}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1 annotation(Placement(visible = true, transformation(origin = {0,100}, extent = {{-10,-10},{10,10}}, rotation = -90), iconTransformation(origin = {0,100}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1 annotation(Placement(visible = true, transformation(origin = {0,-100}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-100}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in annotation(Placement(visible = true, transformation(origin = {-50,-100}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {0,-100}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput Power_out annotation(Placement(visible = true, transformation(origin = {150,50}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      connect(CCA_energyBalance1.Power_out,Power_out) annotation(Line(points = {{-55,82},{86.7606,82},{86.7606,50.0352},{143.451,50.0352},{143.451,50.0352}}));
      connect(TAmb_in,water_Block_HX1.heatLoss_to_ambient) annotation(Line(points = {{-50,-100},{-81.3788,-100},{-81.3788,-56.6909},{-61.9292,-56.6909},{-61.9292,-56.5354}}, color = {170,0,0}));
      connect(tubing_Losses1.flowport_b1,flowport_b1) annotation(Line(points = {{92.871,-61.4355},{103.275,-61.4355},{103.275,-100.07},{0,-100.07},{0,-100}}, color = {170,0,0}));
      connect(flowport_a1,water_Block_HX1.flowport_a1) annotation(Line(points = {{0,100},{0,1.97183},{-71.2324,1.97183},{-71.2324,-43.3803},{-61.9292,-43.3803},{-61.9292,-43.1496}}, color = {170,0,0}));
      connect(receiverInternalEnergy1.port_b,water_Block_HX1.heatCap_waterBlock) annotation(Line(visible = true, origin = {-79.7717,-80.413}, points = {{-25.2283,6.0341},{-5.2283,6.0341},{-5.2283,-4.587},{17.8424,-4.587},{17.8425,-2.8941}}, color = {191,0,0}));
      connect(Input_heatLossTube_2,tubing_Losses1.input_Convection_1) annotation(Line(visible = true, origin = {75.3643,-21.0}, points = {{-15.3643,3.5},{4.6357,3.5},{4.6357,1.0},{3.0464,1.0},{3.0464,-9.0}}, color = {0,0,127}));
      connect(Input_heatLossTube_1,tubing_Losses1.input_Convection_2) annotation(Line(visible = true, origin = {40.7871,-21.0}, points = {{-18.2871,3.5},{4.2129,3.5},{4.2129,1.0},{4.9307,1.0},{4.9307,-9.0}}, color = {0,0,127}));
      connect(Input_CCA_2,CCA_energyBalance1.PV_eff) annotation(Line(visible = true, origin = {-130.25,44.7888}, points = {{-24.75,1.7889},{7.25,1.7889},{7.25,-1.7888},{10.25,-1.7888}}, color = {0,0,127}));
      connect(water_Block_HX1.Gc_Receiver,Input_waterBlock_1) annotation(Line(visible = true, origin = {-76.38590000000001,-25.4454}, points = {{14.4566,-4.3183},{6.3859,-4.3183},{6.3859,2.8456},{-13.6141,2.8456},{-13.6141,2.9454}}, color = {0,0,127}));
      connect(water_Block_HX1.flowport_b1,tubing_Losses1.flowport_a1) annotation(Line(visible = true, origin = {21.1339,-60.3516}, points = {{-15.4646,2.4777},{-1.1339,2.4777},{-1.1339,-1.9357},{8.866099999999999,-1.9357},{8.866099999999999,-1.0839}}, color = {255,0,0}));
      connect(tubing_Losses1.port_a,ambientTemperature_2.port) annotation(Line(visible = true, origin = {104.8812,-85.0}, points = {{-11.3814,1.5596},{5.1188,1.6272},{5.1188,-1.6272},{15.1188,-1.6949}}, color = {191,0,0}));
      connect(Input_CCA_1,CCA_energyBalance1.wattsIn_perCell) annotation(Line(visible = true, origin = {-130.25,81.0}, points = {{-24.75,-1.0},{7.25,-1.0},{7.25,1.0},{10.25,1.0}}, color = {0,0,127}));
      connect(CCA_energyBalance1.port_b,water_Block_HX1.energyFrom_CCA) annotation(Line(visible = true, origin = {-66.39570000000001,-14.002}, points = {{11.3957,57.002},{18.44,57.002},{18.44,26.9556},{-28.6043,26.9556},{-28.6043,-55.998},{4.4665,-55.998},{4.4665,-55.9192}}, color = {191,0,0}));
      annotation(Icon(coordinateSystem(extent = {{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10,10}), graphics = {Text(visible = true, origin = {-79.5498,94.24420000000001}, fillPattern = FillPattern.Solid, extent = {{-19.5498,-5.7558},{19.5498,5.7558}}, textString = "DNI per CCA", fontName = "Arial"),Text(visible = true, origin = {-89.9954,52.2939}, fillPattern = FillPattern.Solid, extent = {{-9.9954,-4.0809},{9.9954,4.0809}}, textString = "PV Eff", fontName = "Arial"),Text(visible = true, origin = {-76.89700000000001,14.8507}, fillPattern = FillPattern.Solid, extent = {{-21.0405,-8.383100000000001},{21.0405,8.383100000000001}}, textString = "Gc_Reveiver", fontName = "Arial"),Text(visible = true, origin = {-71.7546,-25.5556}, fillPattern = FillPattern.Solid, extent = {{-28.2454,-4.4444},{28.2454,4.4444}}, textString = "Gc_Water-Tube", fontName = "Arial"),Text(visible = true, origin = {-73.9641,-66.4781}, fillPattern = FillPattern.Solid, extent = {{-26.0359,-3.5219},{26.0359,3.5219}}, textString = "Gc_Insulation-Air", fontName = "Arial")}), Diagram(coordinateSystem(extent = {{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5,5}), graphics = {Text(visible = true, origin = {12.5,50.0}, fillPattern = FillPattern.Solid, extent = {{-42.5,-5.0},{42.5,5.0}}, textString = "Bring the Ambient Sources and pump Outside the Class ", fontName = "Arial")}));
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