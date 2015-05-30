/* Jacobians */
/* Jacobian Variables */
#if defined(_MSC_VER)
extern "C" {
#endif
  #define HelloWorld_test_INDEX_JAC_G 0
  int HelloWorld_test_functionJacG_column(void* data);
  int HelloWorld_test_initialAnalyticJacobianG(void* data);
#if defined(_MSC_VER)
}
#endif
/* G */
/* G sparse indexes */

#if defined(_MSC_VER)
extern "C" {
#endif
  #define HelloWorld_test_INDEX_JAC_A 1
  int HelloWorld_test_functionJacA_column(void* data);
  int HelloWorld_test_initialAnalyticJacobianA(void* data);
#if defined(_MSC_VER)
}
#endif
/* A */
#define $PHello1$Px$pDERA$PHello1$Px data->simulationInfo.analyticJacobians[1].seedVars[0]
#define $PHello1$Px$pDERA$PHello1$Px__varInfo dummyVAR_INFO
/* A sparse indexes */
#define $PHello1$Px$pDERA$indexdiff 0
#define $PHello1$Px$pDERA$indexdiffed 0
#if defined(_MSC_VER)
extern "C" {
#endif
  #define HelloWorld_test_INDEX_JAC_B 2
  int HelloWorld_test_functionJacB_column(void* data);
  int HelloWorld_test_initialAnalyticJacobianB(void* data);
#if defined(_MSC_VER)
}
#endif
/* B */
/* B sparse indexes */

#if defined(_MSC_VER)
extern "C" {
#endif
  #define HelloWorld_test_INDEX_JAC_C 3
  int HelloWorld_test_functionJacC_column(void* data);
  int HelloWorld_test_initialAnalyticJacobianC(void* data);
#if defined(_MSC_VER)
}
#endif
/* C */
/* C sparse indexes */

#if defined(_MSC_VER)
extern "C" {
#endif
  #define HelloWorld_test_INDEX_JAC_D 4
  int HelloWorld_test_functionJacD_column(void* data);
  int HelloWorld_test_initialAnalyticJacobianD(void* data);
#if defined(_MSC_VER)
}
#endif
/* D */
/* D sparse indexes */


