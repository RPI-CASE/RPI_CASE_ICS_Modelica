#if defined(_MSC_VER)
extern "C" {
#endif
  int HelloWorld_test_mayer(DATA* data, modelica_real* res);
  int HelloWorld_test_lagrange(DATA* data, modelica_real* res);
  int HelloWorld_test_pickUpBoundsForInputsInOptimization(DATA* data, modelica_real* min, modelica_real* max, modelica_real*nominal, modelica_boolean *useNominal, char ** name, modelica_real * start, modelica_real * startTimeOpt);
#if defined(_MSC_VER)
}
#endif