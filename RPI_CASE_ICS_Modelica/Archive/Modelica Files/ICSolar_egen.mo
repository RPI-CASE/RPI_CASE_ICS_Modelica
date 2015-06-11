package ICSolar "Package of all the necessary components to create an Integrated Concentrating Solar simulation"
  extends Modelica.Icons.Package;
  model ICS_Skeleton
    parameter Real FLensWidth = 0.25019;
    parameter Real CellWidth = 0.01;
    parameter Real HSpace;
    parameter Real VSpace;
    parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium = Modelica.Thermal.FluidHeatFlow.Media.Water() "Water" annotation(choicesAllMatching = true);
    parameter Modelica.SIunits.Pressure PAmb(displayUnit = "PA") = 101325 "Ambient pressure";
    ICSolar.ICS_Context ics_context1 annotation(Placement(visible = true, transformation(origin = {-80,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Thermal.FluidHeatFlow.Sources.Ambient Source annotation(Placement(visible = true, transformation(origin = {-80,-20}, extent = {{-10,-10},{10,10}}, rotation = 180)));
    Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow Pump annotation(Placement(visible = true, transformation(origin = {-40,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Thermal.FluidHeatFlow.Sources.Ambient Sink annotation(Placement(visible = true, transformation(origin = {60,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    ICSolar.Envelope.ICS_EnvelopeCassette ics_envelopecassette1 annotation(Placement(visible = true, transformation(origin = {0,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  equation
    connect(ics_context1.TDryBul,ics_envelopecassette1.TAmb_in) annotation(Line(points = {{-70,22},{-49.061,22},{-49.061,26.0563},{-9.624409999999999,26.0563},{-9.624409999999999,26.0563}}));
    connect(ics_context1.SurfAzi,ics_envelopecassette1.SurfAzi) annotation(Line(points = {{-70,14},{-38.0282,14},{-38.0282,15.7277},{-10.3286,15.7277},{-10.3286,15.7277}}));
    connect(ics_context1.SurfAlt,ics_envelopecassette1.SurfAlt) annotation(Line(points = {{-70,16},{-40.1408,16},{-40.1408,18.3099},{-10.0939,18.3099},{-10.0939,18.3099}}));
    connect(ics_context1.AOI,ics_envelopecassette1.AOI) annotation(Line(points = {{-70,18},{-41.784,18},{-41.784,20.1878},{-10.0939,20.1878},{-10.0939,20.1878}}));
    connect(ics_envelopecassette1.flowport_b,Sink.flowPort) annotation(Line(points = {{10,14},{27.4648,14},{27.4648,0.234742},{50,0.234742},{50,0.234742}}));
    connect(Pump.flowPort_b,ics_envelopecassette1.flowport_a) annotation(Line(points = {{-30,-20},{-23.0047,-20},{-23.0047,11.2676},{-10.0939,11.2676},{-10.0939,11.2676}}));
    connect(ics_context1.DNI,ics_envelopecassette1.DNI) annotation(Line(points = {{-70,20},{-44.8357,20},{-44.8357,23.9437},{-30.7512,24},{-10,24}}));
    connect(Source.flowPort,Pump.flowPort_a) annotation(Line(points = {{-70,-20},{-49.7653,-20},{-49.7653,-19.7183},{-49.7653,-19.7183}}));
  end ICS_Skeleton;
  model ICS_Context
    Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam = "modelica://Buildings/Resources/weatherdata/USA_NY_New.York-Central.Park.725033_TMY3.mos") "Weather data reader for New York Central Park" annotation(Placement(visible = true, transformation(origin = {-40,20}, extent = {{-20,-20},{20,20}}, rotation = 0)));
    parameter Real BuildingOrientation;
    parameter Real WallTilt;
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TOut annotation(Placement(visible = true, transformation(origin = {60,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation(Placement(visible = true, transformation(origin = {20,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {20,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Buildings.BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTil(til = Buildings.HeatTransfer.Types.Tilt.Wall, azi = 3.14, lat = 0.6457718232378999) annotation(Placement(visible = true, transformation(origin = {20,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Buildings.BoundaryConditions.SolarGeometry.BaseClasses.WallSolarAzimuth wallSolAzi annotation(Placement(visible = true, transformation(origin = {20,-80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b TDryBul annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput DNI annotation(Placement(visible = true, transformation(origin = {100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput AOI annotation(Placement(visible = true, transformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput SurfAlt annotation(Placement(visible = true, transformation(origin = {100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput SurfAzi annotation(Placement(visible = true, transformation(origin = {100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  equation
    connect(TOut.port,TDryBul) annotation(Line(points = {{70,20},{100.469,20},{100.469,19.7183},{100.469,19.7183}}));
    connect(weaBus.TDryBul,TOut.T) annotation(Line(points = {{20,20},{46.9484,20},{46.9484,19.4836},{46.9484,19.4836}}));
    connect(wallSolAzi.verAzi,SurfAzi) annotation(Line(points = {{31,-80},{92.9577,-80},{92.9577,-80.2817},{92.9577,-80.2817}}));
    connect(weaBus.alt,SurfAlt) annotation(Line(points = {{-20,20},{-3.52113,20},{-3.52113,-60.0939},{92.9577,-60.0939},{92.9577,-60.0939}}));
    connect(HDirTil.inc,AOI) annotation(Line(points = {{31,-44},{64.78870000000001,-44},{64.78870000000001,-39.9061},{93.4272,-39.9061},{93.4272,-39.9061}}));
    connect(HDirTil.H,DNI) annotation(Line(points = {{31,-40},{58.9202,-40},{58.9202,-19.4836},{93.8967,-19.4836},{93.8967,-19.4836}}));
    connect(weaBus.alt,wallSolAzi.alt) annotation(Line(points = {{-20,20},{-7.66378,20},{-7.66378,-75.40170000000001},{7.41656,-75.40170000000001},{7.41656,-75.40170000000001}}));
    connect(HDirTil.inc,wallSolAzi.incAng) annotation(Line(points = {{31,-44},{41.78,-44},{41.78,-58.5909},{-22.0025,-58.5909},{-22.0025,-84.79600000000001},{8,-84.79600000000001},{8,-84.8}}));
    connect(weaDat.weaBus,HDirTil.weaBus) annotation(Line(points = {{-20,20},{0,20},{0,-40.0581},{30,-40},{10,-40}}));
    connect(weaDat.weaBus,weaBus) annotation(Line(points = {{-20,20},{20.3193,20},{20.3193,20},{20,20}}));
  end ICS_Context;
  package Envelope "Package of all the Envelope components to create an Integrated Concentrating Solar simulation"
    extends Modelica.Icons.Package;
    model ICS_EnvelopeCassette
      parameter Integer StackHeight = 6;
      parameter Integer NumStacks = 4;
      // parameter Modelica.SIunits.Length VSpace = 0.2794;
      //  parameter Modelica.SIunits.Length HSpace = 0.2794;
      parameter Modelica.SIunits.Area ArrayArea = 1;
      Modelica.Blocks.Interfaces.RealInput AOI annotation(Placement(visible = true, transformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI annotation(Placement(visible = true, transformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ICSolar.Receiver.subClasses.Egen_port Current annotation(Placement(visible = true, transformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ICSolar.Envelope.ICS_GlazingLosses ics_glazinglosses1 annotation(Placement(visible = true, transformation(origin = {-60,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ICSolar.Envelope.ICS_SelfShading ics_selfshading1 annotation(Placement(visible = true, transformation(origin = {-20,20}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      ICSolar.Stack.ICS_Stack ics_stack1 annotation(Placement(visible = true, transformation(origin = {35,-5}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b annotation(Placement(visible = true, transformation(origin = {100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in annotation(Placement(visible = true, transformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a annotation(Placement(visible = true, transformation(origin = {-100,-80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-95,-85}, extent = {{-5,-5},{5,5}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfAlt annotation(Placement(visible = true, transformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput SurfAzi annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Real SurfAlt_deg = 180.0 / Modelica.Constants.pi * SurfAlt;
      Real SurfAzi_deg = 180.0 / Modelica.Constants.pi * SurfAzi;
    equation
      connect(SurfAzi_deg,ics_selfshading1.SurfAzi) annotation(Line(points = {{-100,-40},{-67.1362,-40},{-67.1362,7.74648},{-35.6808,7.74648},{-35.6808,7.74648}}));
      connect(SurfAlt_deg,ics_selfshading1.SurfAlt) annotation(Line(points = {{-100,-20},{-74.1784,-20},{-74.1784,14.0845},{-35.446,14.0845},{-35.446,14.0845}}));
      connect(flowport_a,ics_stack1.flowport_a1) annotation(Line(points = {{-100,-80},{-19.9531,-80},{-19.9531,-13.8498},{20.1878,-13.8498},{20.1878,-13.8498}}));
      connect(ics_stack1.flowport_b1,flowport_b) annotation(Line(points = {{50,-5},{65.49299999999999,-5},{65.49299999999999,-20.1878},{99.5305,-20.1878},{99.5305,-20.1878}}));
      connect(ics_stack1.Current,Current) annotation(Line(points = {{50,1},{63.8498,1},{63.8498,40.6103},{94.1315,40.6103},{94.1315,40.6103}}));
      connect(ics_selfshading1.DNI_out,ics_stack1.DNI) annotation(Line(points = {{-5,23},{3.05164,23},{3.05164,-8.215960000000001},{20.1878,-8.215960000000001},{20.1878,-8.215960000000001}}));
      connect(ics_glazinglosses1.HDirNor,ics_selfshading1.DNI_in) annotation(Line(points = {{-50,42},{-44.1315,42},{-44.1315,32.1596},{-35.2113,32.1596},{-35.2113,32.1596}}));
      connect(DNI,ics_glazinglosses1.DNI) annotation(Line(points = {{-100,40},{-70.4225,40},{-70.4225,39.9061},{-70.4225,39.9061}}));
      connect(TAmb_in,ics_stack1.TAmb_in);
    end ICS_EnvelopeCassette;
    model ICS_GlazingLosses
      Modelica.Blocks.Interfaces.RealOutput HDirNor annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      parameter Real G1Tran = 0.99 "Glazing layer 1 solar transmittance, can be made more accurate later";
      Modelica.Blocks.Math.Product GlazingLoss annotation(Placement(visible = true, transformation(origin = {0,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI annotation(Placement(visible = true, transformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      connect(DNI,GlazingLoss.u1) annotation(Line(points = {{-100,20},{-42.3803,20},{-42.3803,26.1248},{-12,26.1248},{-12,26}}));
      connect(GlazingLoss.y,HDirNor) annotation(Line(points = {{11,20},{94.3396,20},{94.3396,19.7388},{94.3396,19.7388}}));
      connect(G1Tran,GlazingLoss.u2);
    end ICS_GlazingLosses;
    model ICS_SelfShading
      parameter Real HSpace;
      parameter Real VSpace;
      Modelica.Blocks.Interfaces.RealOutput DNI_out annotation(Placement(visible = true, transformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Tables.CombiTable2D Shading(table = [0,120,125,130,135,140,145,150,155,160,165,170,175,180,185,190,195,200,205,210,215,220,225,230,235,240;50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;45,0,0.515733288,0.582273933,0.644111335,0.700774874,0.751833306,0.796898047,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.806390346,0.796898047,0.751833306,0.700774874,0.644111335,0.582273933,0.515733288,0;40,0,0.558719885,0.630806722,0.697798298,0.759184768,0.814498944,0.86331985,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.873603336,0.86331985,0.814498944,0.759184768,0.697798298,0.630806722,0.558719885,0;35,0,0.5974542859999999,0.674538691,0.746174596,0.811816808,0.870965752,0.923171268,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.934167678,0.923171268,0.870965752,0.811816808,0.746174596,0.674538691,0.5974542859999999,0;30,0,0.6316417,0.713137013,0.788872054,0.8582704330000001,0.920803986,0.975996795,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.98762244,0.975996795,0.920803986,0.8582704330000001,0.788872054,0.713137013,0.6316417,0;25,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;20,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;15,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;10,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;5,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;0,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0;-5,0,0.639557866,0.722074534,0.798758738,0.869026865,0.932344131,0.988228655,1,1,1,1,1,1,1,1,1,1,1,0.988228655,0.932344131,0.869026865,0.798758738,0.722074534,0.639557866,0]) annotation(Placement(visible = true, transformation(origin = {-20,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
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
      ICSolar.Receiver.subClasses.Egen_port Current annotation(Placement(visible = true, transformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ICSolar.Module.ICS_Module ics_module1 annotation(Placement(visible = true, transformation(origin = {0,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1 annotation(Placement(visible = true, transformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1 annotation(Placement(visible = true, transformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in annotation(Placement(visible = true, transformation(origin = {-100,60}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      connect(TAmb_in,ics_module1.TAmb_in) annotation(Line(points = {{-100,60},{-50.7983,60},{-50.7983,27.8665},{-9.86938,27.8665},{-9.86938,27.8665}}));
      connect(ics_module1.Current,Current) annotation(Line(points = {{10,24},{40.3756,24},{40.3756,39.9061},{92.4883,39.9061},{92.4883,39.9061}}));
      connect(ics_module1.flowport_b1,flowport_b1) annotation(Line(points = {{10,16},{39.2019,16},{39.2019,0},{100,0},{100,0}}));
      connect(flowport_a1,ics_module1.flowport_a1) annotation(Line(points = {{-100,-60},{-54.9296,-60},{-54.9296,16.1972},{-9.389670000000001,16.1972},{-9.389670000000001,16.1972}}));
      connect(DNI,ics_module1.DNI) annotation(Line(points = {{-100,-20},{-65.9624,-20},{-65.9624,21.831},{-10.5634,21.831},{-10.5634,21.831}}));
    end ICS_Stack;
  end Stack;
  package Module "Package of all the necessary components to create an Integrated Concentrating Solar simulation"
    extends Modelica.Icons.Package;
    model ICS_Module "This model contains all the components and equations that simulate one module of Integrated Concentrating Solar"
      parameter Modelica.SIunits.Length LensWidth = 0.25019 "Width of Fresnel Lens, meters";
      parameter Modelica.SIunits.Area LensArea = LensWidth ^ 2 "Area of Fresnel Lens sqmeters";
      parameter Modelica.SIunits.Length CellWidth = 0.01 "Width of the PV cell, meters";
      parameter Modelica.SIunits.Area CellArea = CellWidth ^ 2 "Area of PV cell, square meters";
      parameter Real FNum = 0.85;
      parameter String FresMat = "PMMA" "'PMMA' or 'Silicon on Glass', use the exact spellings provided";
      Integer FMatNum;
      parameter Real PV_efficiency = 0.35;
      parameter Real Gc_Receiver = 0.75;
      parameter Real Gc_WaterTube = 0.75;
      parameter Real Gc_InsulationAir = 0.75;
      ICSolar.Module.ICS_LensLosses ics_lenslosses1 annotation(Placement(visible = true, transformation(origin = {-60,20}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      ICSolar.Module.ICS_CPVOpticalPerformance ics_cpvopticalperformance1 annotation(Placement(visible = true, transformation(origin = {0,0}, extent = {{-15,-15},{15,15}}, rotation = 0)));
      ICSolar.Receiver.subClasses.Egen_port Current annotation(Placement(visible = true, transformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1 annotation(Placement(visible = true, transformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1 annotation(Placement(visible = true, transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput DNI annotation(Placement(visible = true, transformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TAmb_in annotation(Placement(visible = true, transformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ICSolar.Receiver.moduleReceiver modulereceiver1 annotation(Placement(visible = true, transformation(origin = {65,-5}, extent = {{-15,-15},{15,15}}, rotation = 0)));
    equation
      connect(TAmb_in,modulereceiver1.TAmb_in) annotation(Line(points = {{-100,80},{18.5776,80},{18.5776,-30.7692},{65.0218,-30.7692},{65.0218,-20.029},{65.0218,-20.029}}));
      connect(modulereceiver1.elecGen_Out,Current) annotation(Line(points = {{80,7},{86.2119,7},{86.2119,40.0581},{95.21040000000001,40.0581},{95.21040000000001,40.0581}}));
      connect(flowport_b1,modulereceiver1.flowport_b1) annotation(Line(points = {{100,-40},{79.2453,-40},{79.2453,-22.3512},{79.2453,-22.3512},{79.2453,-22.3512}}));
      connect(flowport_a1,modulereceiver1.flowport_a1) annotation(Line(points = {{-100,-40},{26.9956,-40},{26.9956,19.7388},{65.0218,19.7388},{65.0218,10.1597},{65.0218,10.1597}}));
      connect(ics_cpvopticalperformance1.EIPC_out,modulereceiver1.Input_CCA_1) annotation(Line(points = {{15,3},{35.7039,3},{35.7039,6.96662},{50.2177,6.96662},{50.2177,6.96662}}));
      connect(ics_lenslosses1.DNI_out,ics_cpvopticalperformance1.DNI_in) annotation(Line(points = {{-45,20},{-31.6872,20},{-31.6872,11.9342},{-15.6379,11.9342},{-15.6379,11.9342}}));
      connect(DNI,ics_lenslosses1.DNI_in) annotation(Line(points = {{-100,20},{-75.10290000000001,20},{-75.10290000000001,19.9588},{-75.10290000000001,19.9588}}));
      if FresMat == "PMMA" then
        FMatNum = 1;
      elseif FresMat == "Silicon on Glass" then
        FMatNum = 2;
      else
      end if;
      connect(FMatNum,ics_cpvopticalperformance1.FMat);
      connect(LensWidth,ics_cpvopticalperformance1.LensWidth);
      connect(CellWidth,ics_cpvopticalperformance1.CellWidth);
      connect(FNum,ics_cpvopticalperformance1.FNum);
      connect(Gc_Receiver,modulereceiver1.Input_waterBlock_1);
      connect(Gc_WaterTube,modulereceiver1.Input_heatLossTube_1);
      connect(Gc_InsulationAir,modulereceiver1.Input_heatLossTube_2);
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
      connect(Fresnel,DNI_Fresnel.u2) annotation(Line(points = {{-29,20},{-23.8026,20},{-23.8026,33.9623},{-11.9013,33.9623},{-11.9013,33.9623}}));
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
      ICSolar.Receiver.subClasses.Egen_port elecGen_Out annotation(Placement(visible = true, transformation(origin = {148.3485,100.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {100.0,80.0}, extent = {{-15.2671,-15.2671},{15.2671,15.2671}}, rotation = 0)));
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
    equation
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
      connect(CCA_energyBalance1.egen_port1,elecGen_Out) annotation(Line(visible = true, origin = {27.5043,91.8053}, points = {{-82.50020000000001,-7.292},{-79.3185,-7.292},{-79.3185,8.194699999999999},{120.5686,8.194699999999999},{120.8442,8.194699999999999}}));
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
        Egen_port egen_port1 annotation(Placement(visible = true, transformation(origin = {100.0,68.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {100.0125,67.7333}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation(Placement(visible = true, transformation(origin = {100,-40}, extent = {{-15,-15},{15,15}}, rotation = 0), iconTransformation(origin = {100,-60}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      equation
        egen_port1.p = wattsIn_perCell * PV_eff;
        port_b.Q_flow = -wattsIn_perCell * (1 - PV_eff);
      end CCA_energyBalance;
      class Water_Block_HX
        parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium = Modelica.Thermal.FluidHeatFlow.Media.Water() "Water" annotation(choicesAllMatching = true);
        parameter Modelica.SIunits.Temperature TAmb(displayUnit = "degK") = 293.15 "Ambient temperature";
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowport_b1(medium = medium) annotation(Placement(visible = true, transformation(origin = {100.0,40.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {102.0,-4.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput Gc_Receiver annotation(Placement(visible = true, transformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,80}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowport_a1(medium = medium) annotation(Placement(visible = true, transformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0), iconTransformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.FluidHeatFlow.Components.HeatedPipe heatedpipe1(h_g = 0, m = 1, T0 = TAmb, medium = medium, V_flowLaminar = 0.1, dpLaminar = 0.1, V_flowNominal = 0.008, dpNominal = 1, T.start = TAmb, pressureDrop.fixed = false) annotation(Placement(visible = true, transformation(origin = {-20,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
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
        Modelica.Thermal.FluidHeatFlow.Components.HeatedPipe Tubing(medium = medium, dpLaminar = 1, dpNominal = 1, T0 = 293, m = 0.02) annotation(Placement(visible = true, transformation(origin = {-80,0}, extent = {{-10,-10},{10,10}}, rotation = 90)));
        Modelica.Thermal.HeatTransfer.Components.Convection convection1 annotation(Placement(visible = true, transformation(origin = {80.0,0.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor Conduction_Insulation(G = 0.1) annotation(Placement(visible = true, transformation(origin = {40,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor Conduction_Tube(G = 0.1) annotation(Placement(visible = true, transformation(origin = {0,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.Convection convection2 annotation(Placement(visible = true, transformation(origin = {-40,0}, extent = {{10,-10},{-10,10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a(T.start = 293) annotation(Placement(visible = true, transformation(origin = {100.0,-60.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0), iconTransformation(origin = {102.0,-70.0}, extent = {{-10.0,-10.0},{10.0,10.0}}, rotation = 0)));
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
end ICSolar;