package HelloWorld
  model Hello
    Real x(start = 1);
    parameter Real a = 1 "a";
    equation
    der(x) = - a * x;
  end Hello;
  model test
    Hello Hello1;
  end test;
end HelloWorld;