#include "RMSE.h"
#include "util/modelica.h"

#include "RMSE_includes.h"


void (*omc_assert)(threadData_t*,FILE_INFO info,const char *msg,...) __attribute__ ((noreturn)) = omc_assert_function;
void (*omc_assert_warning)(FILE_INFO info,const char *msg,...) = omc_assert_warning_function;
void (*omc_terminate)(FILE_INFO info,const char *msg,...) = omc_terminate_function;
void (*omc_throw)(threadData_t*) __attribute__ ((noreturn)) = omc_throw_function;

DLLExport
modelica_real omc_RMSE(threadData_t *threadData, real_array _x1, real_array _x2)
{
  modelica_real _error;
  modelica_real _length;
  real_array _y;
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real tmp3;
  _tailrecursive: OMC_LABEL_UNUSED
  TRACE_PUSH
  tmp1 = size_of_dimension_base_array(_x1, (modelica_integer) 1);
  alloc_real_array(&_y, 1, tmp1);
  tmp2 = size_of_dimension_base_array(_x1, (modelica_integer) 1);
  _length = ((modelica_real)tmp2);

  copy_real_array(pow_alloc_real_array_scalar(sub_alloc_real_array(_x1, _x2), 2.0), &_y);

  tmp3 = _length;
  if (tmp3 == 0) {throwStreamPrint(threadData, "Division by zero %s", "sum(y) / length");}
  _error = (sum_real_array(_y) / _length);
  _return: OMC_LABEL_UNUSED
  TRACE_POP
  return _error;
}
DLLExport
int in_RMSE(type_description * inArgs, type_description * outVar)
{
  real_array _x1;
  real_array _x2;
  modelica_real _error;
  if (read_real_array(&inArgs, &_x1)) return 1;
  if (read_real_array(&inArgs, &_x2)) return 1;
  MMC_INIT();
  MMC_TRY_TOP()
  _error = omc_RMSE(threadData, _x1, _x2);
  MMC_CATCH_TOP(return 1)
  write_modelica_real(outVar, &_error);
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
modelica_metatype boxptr_RMSE(threadData_t *threadData, modelica_metatype _x1, modelica_metatype _x2)
{
  modelica_real _error;
  modelica_metatype out_error;
  _error = omc_RMSE(threadData, *((base_array_t*)_x1), *((base_array_t*)_x2));
  out_error = mmc_mk_rcon(_error);
  return out_error;
}

