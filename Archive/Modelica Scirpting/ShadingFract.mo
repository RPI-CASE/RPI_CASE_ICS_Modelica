function ShadingFractionFunction
  input Integer rowType;
  input Integer colType;
  input Real arrayPitch;
  input Real arrayYaw;
  output Real SFraction;
  protected
 	Real Index;
 	Real Max_angle = 72*3.1416/180;
 	Real Min_angle = -72*3.1416/180;
 	Real arrayPitch_2;
 	Real arrayYaw_2;

Modelica.Blocks.Tables.CombiTable1D LUT(tableOnFile = true, fileName = "C:\\Users\\Kenton\\Desktop\\4DLUT.txt", tableName = "4DLUT", smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments);



algorithm
  // Condense the 4D LUT to a 1D LUT
  // Assuming the columns in order from the 4d file our; Row, Column, Pitch, Yaw.
   
  // Add Limits for High and Low input typs
  if arrayPitch > Max_angle then
  	arrayPitch_2 := Max_angle;
  elseif arrayPitch < Min_angle then
  	arrayPitch_2 := Min_angle;
  else
  	arrayPitch_2 := arrayPitch;
  end if;
  
  if arrayYaw > Max_angle then
  	arrayYaw_2 := Max_angle;
  elseif arrayYaw < Min_angle then
  	arrayYaw_2 := Min_angle;
  else
  	arrayYaw_2 := arrayYaw;
  end if;
  

  arrayPitch_2 := roundn(arrayPitch_2,3*3.1416/180);
  arrayYaw_2 := roundn(arrayYaw_2,3*3.1416/180);








  Index := (rowType-1)*(60025/5) + (colType-1)*(60025/25) + (arrayPitch_2*(-935.83) + 1175) + (arrayYaw_2*19.099 + 25) + 1;

  SFraction := round(Index);

end ShadingFractionFunction;

  

function round "Round to nearest Integer"
       input Real r;
       output Integer i;
    algorithm
       i :=if r > 0 then integer(floor(r + 0.5)) else integer(ceil(r - 0.5));
   end round;



   function roundn "Round to nearest n"
       input Real r;
       input Real n;
       output Real i;
    algorithm
    	if mod(r,n) > n/2 then
    		i := r - mod(r,n) + n;
		elseif mod(r,n) <n/2 then
			i := r - mod(r,n);
		else
			i:=r;
		end if;
	end roundn;
