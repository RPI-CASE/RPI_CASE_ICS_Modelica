within ;
model Xo_componentArray0 "Modeling discretized rod"
  import HTC =
             Modelica.Thermal.HeatTransfer.Components;

  parameter Integer n(start=2,min=2) "Number of rod segments";
  parameter Modelica.SIunits.Temperature T0 "Initial rod temperature";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    "Thermal connector for rod end 'a'"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    "Thermal connector for rod end 'b'"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  parameter Modelica.SIunits.HeatCapacity C
    "Total heat capacity of element (= cp*m)";
  parameter Modelica.SIunits.ThermalConductance G_wall
    "Thermal conductivity of wall";
  parameter Modelica.SIunits.ThermalConductance G_rod
    "Thermal conductivie of rod";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ambient
    "Thermal connector for rod end 'a'"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
protected
  HTC.HeatCapacitor capacitance[n](each final C=C/n, each T(start=T0, fixed=true))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-30,20})));
  HTC.ThermalConductor wall[n](each final G=G_wall/n)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90, origin={-30,-20})));
  HTC.ThermalConductor rod_conduction[n-1](each final G=G_rod)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  for i in 1:n loop
    connect(capacitance[i].port, wall[i].port_b) "Capacitance to walls";
    connect(wall[i].port_a, ambient) "Walls to ambient";
  end for;
  for i in 1:n-1 loop
    connect(capacitance[i].port, rod_conduction[i].port_a)
      "Capacitance to next conduction";
    connect(capacitance[i+1].port, rod_conduction[i].port_b)
      "Capacitance to prev conduction";
  end for;
  connect(capacitance[1].port, port_a) "First capacitance to rod end";
  connect(capacitance[n].port, port_b) "Last capacitance to (other) rod end";
  annotation (uses(Modelica(version="3.2.1")));
end Xo_componentArray0;
