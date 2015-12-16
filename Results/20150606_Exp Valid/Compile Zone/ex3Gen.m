Ex_mod6 = measured_vFlow*974*4190.*(measured_T_s3m5in - ...
    measured_T_HTFin - Tref.*log(measured_T_s3m5in./measured_T_HTFin));
Ex_mod3 = measured_vFlow * 974.9 * 4190.*( measured_T_s3m2in - ...
    measured_T_s3m3in - Tref.*log(measured_T_s3m2in./measured_T_s3m2in));
Ex_mod2 = measured_vFlow * 974.9 * 4190.*(measured_T_s3m1in - ...
    measured_T_s3m2in - Tref.*log(measured_T_s3m1in./measured_T_s3m2in));

Ex_totes = Ex_mod6 + Ex_mod3 + Ex_mod2;
% properties of water at 75  Source: Kaminski Jensen Table A-6



