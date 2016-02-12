#if defined(__cplusplus)
  extern "C" {
#endif
  int HelloWorld_test_mayer(DATA* data, modelica_real** res, short*);
  int HelloWorld_test_lagrange(DATA* data, modelica_real** res, short *, short *);
  int HelloWorld_test_pickUpBoundsForInputsInOptimization(DATA* data, modelica_real* min, modelica_real* max, modelica_real*nominal, modelica_boolean *useNominal, char ** name, modelica_real * start, modelica_real * startTimeOpt);
#if defined(__cplusplus)
}
#endif