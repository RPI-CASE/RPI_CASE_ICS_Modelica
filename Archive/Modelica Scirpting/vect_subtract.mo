function vect_subtract
  input Real[:] x1;
  input Real[:] x2;
  output Real[size(x1,1)] y;

algorithm
  y:=x1-x2;
end vect_subtract;
