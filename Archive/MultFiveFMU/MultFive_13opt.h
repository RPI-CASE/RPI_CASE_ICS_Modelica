#if defined(_MSC_VER)
extern "C" {
#endif
  int MultFive_mayer(DATA* data, modelica_real* res);
  int MultFive_lagrange(DATA* data, modelica_real* res);
  int MultFive_pickUpBoundsForInputsInOptimization(DATA* data, modelica_real* min, modelica_real* max, modelica_real*nominal, modelica_boolean *useNominal, char ** name, modelica_real * start, modelica_real * startTimeOpt);
#if defined(_MSC_VER)
}
#endif