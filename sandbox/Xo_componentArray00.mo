within ;
model Xo_componentArray00 "Modeling discretized rod"
  import HTC = Modelica.Thermal.HeatTransfer.Components;
  //  parameter Integer n(start = 3, min = 3) "Number of rod segments";
  parameter Integer n = 5 "Number of rod segments";
  parameter Modelica.SIunits.Temperature T0 = 300 "Initial rod temperature";
  parameter Modelica.SIunits.Temperature T_source = 400 "Source T";
  //  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b "Thermal connector for rod end 'b'" annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
  parameter Modelica.SIunits.HeatCapacity C = 100
    "Total heat capacity of element (= cp*m)";
  parameter Modelica.SIunits.ThermalConductance G_wall = 1
    "Thermal conductivity of wall";
  parameter Modelica.SIunits.ThermalConductance G_rod = 200
    "Thermal conductivie of rod";
  // Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ambient "Thermal connector for rod end 'a'" annotation(Placement(transformation(extent = {{-10, -110}, {10, -90}})));
  //  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatcapacitor_source(C = 1e6, T.start = T_source, T.fixed = true) annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatcapacitor_amb(C = 1e66, T(
                                                                                     start =   250, fixed =   false))
                                                                                                    annotation(Placement(visible = true, transformation(origin = {-40, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  ICSolar.Stack.ICS_Stack iCS_Stack annotation(Placement(transformation(extent = {{-14, 50}, {6, 70}})));
  Buildings.HeatTransfer.Sources.FixedTemperature fixedTemperature(T = 400) annotation(Placement(transformation(extent = {{-88, 78}, {-76, 90}})));
  Modelica.Blocks.Sources.IntegerConstant integerConstant(k = 8) annotation(Placement(transformation(extent={{-68,50},
            {-56,62}})));
  Modelica.Blocks.Sources.Constant DNI(k = 1000) annotation(Placement(transformation(extent = {{-86, 62}, {-76, 72}})));
  Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow volumeFlow(m = 0.01, constantVolumeFlow(displayUnit = "l/min") = 1.6666666666667e-06) annotation(Placement(transformation(extent={{-52,26},
            {-42,36}})));
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient1(medium = Modelica.Thermal.FluidHeatFlow.Media.Water(), constantAmbientTemperature = 298.15) annotation(Placement(visible = true, transformation(origin = {-80, 40}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor capacitance[n](each final C = C / n, each T(start = T0, fixed = false)) annotation(Placement(visible = true, transformation(origin = {-40, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatcapacitor_sink(C = 1e66, T(
                                                                                      start =   275, fixed =   false))
                                                                                                    annotation(Placement(visible = true, transformation(origin = {60, -40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedtemperature1 annotation(Placement(visible = true, transformation(origin = {-80, -40}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Thermal.FluidHeatFlow.Components.Valve valve1(y1 = 1, Kv1 = 1e5, kv0 = 1e-9, dp0 = 10, rho0 = 1000, frictionLoss = 1, m = 0.1) annotation(Placement(visible = true, transformation(origin = {0, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Thermal.FluidHeatFlow.Components.Valve valve2 annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient2(medium = Modelica.Thermal.FluidHeatFlow.Media.Water(), constantAmbientTemperature = 298.15) annotation(Placement(visible = true, transformation(origin = {63.5, 63.5}, extent = {{-3.5, -3.5}, {3.5, 3.5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant1(k=0.9)   annotation(Placement(visible = true, transformation(origin = {-65, 15}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant2(k=0.2)   annotation(Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
protected
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor wall[n](each final G = G_wall / n) annotation(Placement(visible = true, transformation(origin = {-40, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor rod_conduction[n - 1](each final G = G_rod) annotation(Placement(visible = true, transformation(origin = {0, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(constant2.y, valve2.y) annotation(Line(points={{-54.5,0},{-22.2222,0},
          {-22.2222,-16.4875},{0.238949,-16.4875},{0.238949,-9},{-1.11022e-015,
          -9}},                                                                                                    color = {0, 0, 127}));
  connect(constant1.y, valve1.y) annotation(Line(points={{-59.5,15},{-0.238949,
          15},{-0.238949,11},{-1.11022e-015,11}},                                                                                     color = {0, 0, 127}));
  connect(iCS_Stack.flowport_b1, ambient2.flowPort) annotation(Line(points = {{6, 60}, {18, 60}, {31.3262, 62.5579}, {60, 63.5}}, color = {255, 0, 0}));
  connect(valve2.flowPort_a, ambient2.flowPort) annotation(Line(points = {{10, 0}, {26.5233, 0}, {26.5233, 53.2855}, {44, 63.5}, {60, 63.5}}, color = {255, 0, 0}));
  connect(valve1.flowPort_a, iCS_Stack.flowport_a1) annotation(Line(points={{10,20},
          {16.2485,20},{16.2485,39.9044},{-28.4349,39.9044},{-28.4349,53.2855},
          {-14,53.2855},{-14,54}},                                                                                                    color = {255, 0, 0}));
  connect(volumeFlow.flowPort_b, valve2.flowPort_b) annotation(Line(points={{-42,31},
          {-42,9.8578},{-10,9.8578},{-10,1.33227e-015}},                                                                                                color = {255, 0, 0}));
  connect(volumeFlow.flowPort_b, valve1.flowPort_b) annotation(Line(points={{-42,31},
          {-24,31},{-24,20},{-10,20}},                                                                                                    color = {255, 0, 0}));
  connect(ambient1.flowPort, volumeFlow.flowPort_a) annotation(Line(points={{-73,40},
          {-64,40},{-64,31},{-52,31}},                                                                                     color = {255, 0, 0}));
  for i in 1:n loop
    connect(capacitance[i].port, wall[i].port_b) "Capacitance to walls";
    connect(wall[i].port_a, heatcapacitor_amb.port) "Walls to ambient";
  end for;
  for i in 1:n - 1 loop
    connect(capacitance[i].port, rod_conduction[i].port_a)
      "Capacitance to next conduction";
    connect(capacitance[i + 1].port, rod_conduction[i].port_b)
      "Capacitance to prev conduction";
  end for;
  connect(capacitance[1].port, fixedTemperature.port)
    "First capacitance to rod end";
  connect(capacitance[n].port, heatcapacitor_sink.port)
    "Last capacitance to (other) rod end";
  connect(fixedTemperature.port, iCS_Stack.TAmb_in) annotation(Line(points = {{-76, 84}, {-44, 84}, {-44, 68}, {-14, 68}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(DNI.y, iCS_Stack.DNI) annotation(Line(points = {{-75.5, 67}, {-44.75, 67}, {-44.75, 58}, {-14, 58}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(integerConstant.y, iCS_Stack.StackHeight) annotation (Line(
      points={{-55.4,56},{-34,56},{-34,62},{-14,62}},
      color={255,127,0},
      smooth=Smooth.None));
  annotation(uses(Modelica(version = "3.2.1"), Buildings(version = "1.6")), Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                                                    graphics));
end Xo_componentArray00;
