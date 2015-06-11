model scaleable_sandbox_array_up
  extends Modelica.Icons.Example;
  parameter FluidHeatFlow.Media.Medium medium = FluidHeatFlow.Media.Medium() "Cooling medium" annotation(choicesAllMatching = true);
  parameter Modelica.SIunits.Temperature TAmb(displayUnit = "degC") = 293.15 "Ambient temperature";
  output Modelica.SIunits.TemperatureDifference dTSource1 = prescribedHeatFlow1.port.T - TAmb "Source1 over Ambient";
  output Modelica.SIunits.TemperatureDifference dTtoPipe1 = prescribedHeatFlow1.port.T - pipe1.heatPort.T "Source1 over Coolant1";
  output Modelica.SIunits.TemperatureDifference dTCoolant1 = pipe1.dT "Coolant1's temperature increase";
  output Modelica.SIunits.TemperatureDifference dTSource2 = prescribedHeatFlow2.port.T - TAmb "Source2 over Ambient";
  output Modelica.SIunits.TemperatureDifference dTtoPipe2 = prescribedHeatFlow2.port.T - pipe2.heatPort.T "Source2 over Coolant2";
  output Modelica.SIunits.TemperatureDifference dTCoolant2 = pipe2.dT "Coolant2's temperature increase";
  output Modelica.SIunits.TemperatureDifference dTmixedCoolant = ambient2.T_port - ambient1.T_port "mixed Coolant's temperature increase";
  FluidHeatFlow.Sources.Ambient ambient1(constantAmbientTemperature = TAmb, medium = medium, constantAmbientPressure = 0) annotation(Placement(transformation(extent = {{-60,-10},{-80,10}}, rotation = 0)));
  Sources.VolumeFlow pump(medium = medium, m = 0, T0 = TAmb, useVolumeFlowInput = true, constantVolumeFlow = 1) annotation(Placement(transformation(extent = {{-40,-10},{-20,10}}, rotation = 0)));
  FluidHeatFlow.Components.HeatedPipe pipe1(medium = medium, m = 0.1, T0 = TAmb, V_flowLaminar = 0.1, dpLaminar(displayUnit = "Pa") = 0.1, V_flowNominal = 1, dpNominal(displayUnit = "Pa") = 1, h_g = 0, V_flow(start = 0), T0fixed = true) annotation(Placement(transformation(extent = {{0,-20},{20,0}}, rotation = 0)));
  FluidHeatFlow.Components.HeatedPipe pipe2(medium = medium, m = 0.1, T0 = TAmb, V_flowLaminar = 0.1, dpLaminar(displayUnit = "Pa") = 0.1, V_flowNominal = 1, dpNominal(displayUnit = "Pa") = 1, h_g = 0, V_flow(start = 0), T0fixed = true) annotation(Placement(transformation(extent = {{0,20},{20,0}}, rotation = 0)));
  FluidHeatFlow.Components.IsolatedPipe pipe3(medium = medium, m = 0.1, T0 = TAmb, V_flowLaminar = 0.1, dpLaminar(displayUnit = "Pa") = 0.1, V_flowNominal = 1, dpNominal(displayUnit = "Pa") = 1, h_g = 0, T0fixed = true) annotation(Placement(transformation(extent = {{40,-10},{60,10}}, rotation = 0)));
  FluidHeatFlow.Sources.Ambient ambient2(constantAmbientTemperature = TAmb, medium = medium, constantAmbientPressure = 0) annotation(Placement(transformation(extent = {{80,-10},{100,10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(C = 0.1, T(start = TAmb, fixed = true)) annotation(Placement(transformation(origin = {40,-60}, extent = {{-10,10},{10,-10}}, rotation = 90)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1 annotation(Placement(transformation(origin = {-20,-60}, extent = {{10,-10},{-10,10}}, rotation = 180)));
  Modelica.Thermal.HeatTransfer.Components.Convection convection1 annotation(Placement(transformation(origin = {10,-40}, extent = {{10,10},{-10,-10}}, rotation = 270)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor2(C = 0.1, T(start = TAmb, fixed = true)) annotation(Placement(transformation(origin = {38,60}, extent = {{10,-10},{-10,10}}, rotation = 270)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow2 annotation(Placement(transformation(origin = {-20,60}, extent = {{10,10},{-10,-10}}, rotation = 180)));
  Modelica.Thermal.HeatTransfer.Components.Convection convection2 annotation(Placement(transformation(origin = {10,40}, extent = {{10,-10},{-10,10}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant volumeFlow(k = 1) annotation(Placement(transformation(extent = {{-60,10},{-40,30}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant heatFlow1(k = 5) annotation(Placement(transformation(extent = {{-60,-70},{-40,-50}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant heatFlow2(k = 10) annotation(Placement(transformation(extent = {{-60,50},{-40,70}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant thermalConductance1(k = 1) annotation(Placement(transformation(extent = {{-30,-50},{-10,-30}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant thermalConductance2(k = 1) annotation(Placement(transformation(extent = {{-30,30},{-10,50}}, rotation = 0)));
equation
  connect(ambient1.flowPort,pump.flowPort_a) annotation(Line(points = {{-60,0},{-40,0}}, color = {255,0,0}));
  connect(pump.flowPort_b,pipe1.flowPort_a) annotation(Line(points = {{-20,0},{-10,0},{-10,-10},{0,-10}}, color = {255,0,0}));
  connect(pump.flowPort_b,pipe2.flowPort_a) annotation(Line(points = {{-20,0},{-10,0},{-10,10},{0,10}}, color = {255,0,0}));
  connect(heatFlow2.y,prescribedHeatFlow2.Q_flow) annotation(Line(points = {{-39,60},{-30,60}}, color = {0,0,255}));
  connect(heatFlow1.y,prescribedHeatFlow1.Q_flow) annotation(Line(points = {{-39,-60},{-30,-60}}, color = {0,0,255}));
  connect(thermalConductance2.y,convection2.Gc) annotation(Line(points = {{-9,40},{0,40}}, color = {0,0,127}));
  connect(thermalConductance1.y,convection1.Gc) annotation(Line(points = {{-9,-40},{0,-40}}, color = {0,0,127}));
  connect(pipe1.heatPort,convection1.fluid) annotation(Line(points = {{10,-20},{10,-30}}, color = {191,0,0}));
  connect(convection2.fluid,pipe2.heatPort) annotation(Line(points = {{10,30},{10,20}}, color = {191,0,0}));
  connect(convection2.solid,prescribedHeatFlow2.port) annotation(Line(points = {{10,50},{10,60},{-10,60}}, color = {191,0,0}));
  connect(convection2.solid,heatCapacitor2.port) annotation(Line(points = {{10,50},{10,60},{28,60}}, color = {191,0,0}));
  connect(convection1.solid,prescribedHeatFlow1.port) annotation(Line(points = {{10,-50},{10,-60},{-10,-60}}, color = {191,0,0}));
  connect(convection1.solid,heatCapacitor1.port) annotation(Line(points = {{10,-50},{10,-60},{30,-60}}, color = {191,0,0}));
  connect(pipe2.flowPort_b,pipe3.flowPort_a) annotation(Line(points = {{20,10},{30,10},{30,0},{40,0}}, color = {255,0,0}));
  connect(pipe1.flowPort_b,pipe3.flowPort_a) annotation(Line(points = {{20,-10},{30,-10},{30,0},{40,0}}, color = {255,0,0}));
  connect(pipe3.flowPort_b,ambient2.flowPort) annotation(Line(points = {{60,0},{80,0}}, color = {255,0,0}));
  connect(volumeFlow.y,pump.volumeFlow) annotation(Line(points = {{-39,20},{-30,20},{-30,10}}, color = {0,0,127}, smooth = Smooth.None));
  annotation(Documentation(info = "<HTML>
<p>
2nd test example: ParallelCooling
</p>
Two prescribed heat sources dissipate their heat through thermal conductors to coolant flows. The coolant flow is taken from an ambient and driven by a pump with prescribed mass flow, then split into two coolant flows connected to the two heat sources, and afterwards merged. Splitting of coolant flows is determined by pressure drop characteristic of the two pipes.<br>
<b>Results</b>:<br>
<table>
<tr>
<td valign=\"top\"><b>output</b></td>
<td valign=\"top\"><b>explanation</b></td>
<td valign=\"top\"><b>formula</b></td>
<td valign=\"top\"><b>actual steady-state value</b></td>
</tr>
<tr>
<td valign=\"top\">dTSource1</td>
<td valign=\"top\">Source1 over Ambient</td>
<td valign=\"top\">dTCoolant1 + dTtoPipe1</td>
<td valign=\"top\">15 K</td>
</tr>
<tr>
<td valign=\"top\">dTtoPipe1</td>
<td valign=\"top\">Source1 over Coolant1</td>
<td valign=\"top\">Losses1 / ThermalConductor1.G</td>
<td valign=\"top\"> 5 K</td>
</tr>
<tr>
<td valign=\"top\">dTCoolant1</td>
<td valign=\"top\">Coolant's temperature increase</td>
<td valign=\"top\">Losses * cp * totalMassFlow/2</td>
<td valign=\"top\">10 K</td>
</tr>
<tr>
<td valign=\"top\">dTSource2</td>
<td valign=\"top\">Source2 over Ambient</td>
<td valign=\"top\">dTCoolant2 + dTtoPipe2</td>
<td valign=\"top\">30 K</td>
</tr>
<tr>
<td valign=\"top\">dTtoPipe2</td>
<td valign=\"top\">Source2 over Coolant2</td>
<td valign=\"top\">Losses2 / ThermalConductor2.G</td>
<td valign=\"top\">10 K</td>
</tr>
<tr>
<td valign=\"top\">dTCoolant2</td>
<td valign=\"top\">Coolant's temperature increase</td>
<td valign=\"top\">Losses * cp * totalMassFlow/2</td>
<td valign=\"top\">20 K</td>
</tr>
<tr>
<td valign=\"top\">dTmixedCoolant</td>
<td valign=\"top\">mixed Coolant's temperature increase</td>
<td valign=\"top\">(dTCoolant1+dTCoolant2)/2</td>
<td valign=\"top\">15 K</td>
</tr>
</table>
</HTML>"), experiment(StopTime = 1.0, Interval = 0.001));
end scaleable_sandbox_array_up;

