#if defined(__cplusplus)
  extern "C" {
#endif
  int ICSolar_ICS_Skeleton_mayer(DATA* data, modelica_real** res, short*);
  int ICSolar_ICS_Skeleton_lagrange(DATA* data, modelica_real** res, short *, short *);
  int ICSolar_ICS_Skeleton_pickUpBoundsForInputsInOptimization(DATA* data, modelica_real* min, modelica_real* max, modelica_real*nominal, modelica_boolean *useNominal, char ** name, modelica_real * start, modelica_real * startTimeOpt);
#if defined(__cplusplus)
}
#endif