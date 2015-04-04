model Test_CASE_2
  extends Shading_import;
  //simulation inputs
  Modelica.Blocks.Sources.RealExpression realexpression1(y = -0.42) annotation(Placement(visible = true, transformation(origin = {-120,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realexpression2(y = -1.26) annotation(Placement(visible = true, transformation(origin = {-120,20}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Integer modNum = 1;
  Real out;
equation
  connect(realexpression1.y,table_1.u1);
  connect(realexpression2.y,table_1.u2);
  connect(realexpression1.y,table_2.u1);
  connect(realexpression2.y,table_2.u2);
  connect(realexpression1.y,table_3.u1);
  connect(realexpression2.y,table_3.u2);
  connect(realexpression1.y,table_4.u1);
  connect(realexpression2.y,table_4.u2);
  if modNum == 1 then
    out = table_1.y;
  elseif modNum == 2 then
    out = table_2.y;
  elseif modNum == 3 then
    out = table_3.y;
  else
    out = table_4.y;
  end if;
end Test_CASE_2;