/* Jacobians */
/* Jacobian Variables */
#if defined(_MSC_VER)
extern "C" {
#endif
  #define MultFive_INDEX_JAC_G 0
  int MultFive_functionJacG_column(void* data);
  int MultFive_initialAnalyticJacobianG(void* data);
#if defined(_MSC_VER)
}
#endif
/* G */
/* G sparse indexes */

#if defined(_MSC_VER)
extern "C" {
#endif
  #define MultFive_INDEX_JAC_A 1
  int MultFive_functionJacA_column(void* data);
  int MultFive_initialAnalyticJacobianA(void* data);
#if defined(_MSC_VER)
}
#endif
/* A */
#define $P$dummy$pDERA$P$dummy data->simulationInfo.analyticJacobians[1].seedVars[0]
#define $P$dummy$pDERA$P$dummy__varInfo dummyVAR_INFO
/* A sparse indexes */
#define $P$dummy$pDERA$indexdiff 0
#define $P$dummy$pDERA$indexdiffed 0
#if defined(_MSC_VER)
extern "C" {
#endif
  #define MultFive_INDEX_JAC_B 2
  int MultFive_functionJacB_column(void* data);
  int MultFive_initialAnalyticJacobianB(void* data);
#if defined(_MSC_VER)
}
#endif
/* B */
/* B sparse indexes */

#if defined(_MSC_VER)
extern "C" {
#endif
  #define MultFive_INDEX_JAC_C 3
  int MultFive_functionJacC_column(void* data);
  int MultFive_initialAnalyticJacobianC(void* data);
#if defined(_MSC_VER)
}
#endif
/* C */
/* C sparse indexes */

#if defined(_MSC_VER)
extern "C" {
#endif
  #define MultFive_INDEX_JAC_D 4
  int MultFive_functionJacD_column(void* data);
  int MultFive_initialAnalyticJacobianD(void* data);
#if defined(_MSC_VER)
}
#endif
/* D */
/* D sparse indexes */


