#include "RMSE.h"
#include "util/modelica.h"
void (*omc_assert)(threadData_t*,FILE_INFO info,const char *msg,...) = omc_assert_function;
void (*omc_assert_warning)(FILE_INFO info,const char *msg,...) = omc_assert_warning_function;
void (*omc_terminate)(FILE_INFO info,const char *msg,...) = omc_terminate_function;
void (*omc_throw)(threadData_t*) = omc_throw_function;

DLLExport
RMSE_rettype omc_RMSE(threadData_t *threadData, real_array _x1, real_array _x2)
{
  /* functionBodyRegularFunction: arguments */
  /* functionBodyRegularFunction: locals */
  RMSE_rettype tmp1;
  modelica_real _error;
  modelica_real _length;
  real_array _y;
  modelica_integer tmp2;
  modelica_integer tmp3;
  real_array tmp4;
  real_array tmp5;
  _tailrecursive: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out inits */
  /* functionBodyRegularFunction: var inits */
  tmp2 = size_of_dimension_base_array(&_x1, (modelica_integer) 1);
  alloc_real_array(&_y, 1, tmp2);
  /* functionBodyRegularFunction: body */
  tmp3 = size_of_dimension_base_array(&_x1, (modelica_integer) 1);
  _length = ((modelica_real)tmp3);

  sub_alloc_real_array(&_x1, &_x2, &tmp4);
  pow_alloc_real_array_scalar(&tmp4, 2.0, &tmp5);
  copy_real_array(&tmp5, &_y);

  _error = (sum_real_array(&_y) / _length);
  _return: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out var copy */
  /* functionBodyRegularFunction: out var assign */
  tmp1.c1 = _error;
  /* GC: pop the mark! */
  /* functionBodyRegularFunction: return the outs */
  return  tmp1;
}
DLLExport
int in_RMSE(type_description * inArgs, type_description * outVar)
{
  real_array _x1;
  real_array _x2;
  RMSE_rettype out;
  if (read_real_array(&inArgs, &_x1)) return 1;
  if (read_real_array(&inArgs, &_x2)) return 1;
  MMC_INIT();
  MMC_TRY_TOP()
  out = omc_RMSE(threadData, _x1, _x2);
  MMC_CATCH_TOP(return 1)
  write_modelica_real(outVar, &out.c1);
  fflush(NULL);
  return 0;
}
#ifdef GENERATE_MAIN_EXECUTABLE
static int rml_execution_failed()
{
  fflush(NULL);
  fprintf(stderr, "Execution failed!\n");
  fflush(NULL);
  return 1;
}

int main(int argc, char **argv) {
  MMC_INIT();
  {
  void *lst = mmc_mk_nil();
  int i = 0;

  for (i=argc-1; i>0; i--) {
    lst = mmc_mk_cons(mmc_mk_scon(argv[i]), lst);
  }

  {
    MMC_TRY_TOP()
  
    MMC_TRY_STACK()
  
    omc_RMSE(threadData, lst);
    
    MMC_ELSE()
    rml_execution_failed();
    fprintf(stderr, "Stack overflow detected and was not caught.\nSend us a bug report at https://trac.openmodelica.org/OpenModelica/newticket\n    Include the following trace:\n");
    printStacktraceMessages();
    fflush(NULL);
    return 1;
    MMC_CATCH_STACK()
    
    MMC_CATCH_TOP(return rml_execution_failed());
  }
  }
  
  fflush(NULL);
  EXIT(0);
  return 0;
}
#endif

