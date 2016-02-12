function RMSE
  input Real[:] x1;
  input Real[:] x2;
  output Real error;
protected 
	Real[size(x1,1)] y;
	Real length;
algorithm

	length := size(x1,1);

	y:=(x1-x2).^2;

   	error := sum(y) / length;





end RMSE;