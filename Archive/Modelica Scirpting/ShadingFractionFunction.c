#include "ShadingFractionFunction.h"
#include "util/modelica.h"

#include "ShadingFractionFunction_includes.h"


void (*omc_assert)(threadData_t*,FILE_INFO info,const char *msg,...) __attribute__ ((noreturn)) = omc_assert_function;
void (*omc_assert_warning)(FILE_INFO info,const char *msg,...) = omc_assert_warning_function;
void (*omc_terminate)(FILE_INFO info,const char *msg,...) = omc_terminate_function;
void (*omc_throw)(threadData_t*) __attribute__ ((noreturn)) = omc_throw_function;

DLLExport
modelica_real omc_ShadingFractionFunction(threadData_t *threadData, modelica_integer _rowType, modelica_integer _colType, modelica_real _arrayPitch, modelica_real _arrayYaw, modelica_real *out_Index)
{
  modelica_real _SFraction;
  modelica_real _Index;
  modelica_real _Max_angle;
  modelica_real _Min_angle;
  modelica_real _arrayPitch_2;
  modelica_real _arrayYaw_2;
  _tailrecursive: OMC_LABEL_UNUSED
  TRACE_PUSH
  _Max_angle = 1.25664;
  _Min_angle = -1.25664;
  if((_arrayPitch > 1.25664))
  {
    _arrayPitch_2 = 1.25664;
  }
  else
  {
    _arrayPitch_2 = _arrayPitch;
  }

  _Index = (1201.0 + ((12005.0 * ((modelica_real)((modelica_integer)_rowType + (modelica_integer) -1))) + ((2401.0 * ((modelica_real)((modelica_integer)_colType + (modelica_integer) -1))) + ((-935.83 * _arrayPitch_2) + (19.099 * _arrayYaw_2)))));

  _SFraction = ((modelica_real)omc_round(threadData, _Index));
  _return: OMC_LABEL_UNUSED
  if (out_Index) { *out_Index = _Index; }
  TRACE_POP
  return _SFraction;
}
DLLExport
int in_ShadingFractionFunction(type_description * inArgs, type_description * outVar)
{
  modelica_integer _rowType;
  modelica_integer _colType;
  modelica_real _arrayPitch;
  modelica_real _arrayYaw;
  modelica_real _SFraction;
  modelica_real _Index;
  if (read_modelica_integer(&inArgs, &_rowType)) return 1;
  if (read_modelica_integer(&inArgs, &_colType)) return 1;
  if (read_modelica_real(&inArgs, &_arrayPitch)) return 1;
  if (read_modelica_real(&inArgs, &_arrayYaw)) return 1;
  MMC_INIT();
  MMC_TRY_TOP()
  _SFraction = omc_ShadingFractionFunction(threadData, _rowType, _colType, _arrayPitch, _arrayYaw, &_Index);
  MMC_CATCH_TOP(return 1)
  write_modelica_real(outVar, &_SFraction);
  write_modelica_real(outVar, &_Index);
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
  
    omc_ShadingFractionFunction(threadData, lst);
    
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
modelica_metatype boxptr_ShadingFractionFunction(threadData_t *threadData, modelica_metatype _rowType, modelica_metatype _colType, modelica_metatype _arrayPitch, modelica_metatype _arrayYaw, modelica_metatype *out_Index)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real tmp3;
  modelica_real tmp4;
  modelica_real _Index;
  modelica_real _SFraction;
  modelica_metatype out_SFraction;
  tmp1 = mmc_unbox_integer(_rowType);
  tmp2 = mmc_unbox_integer(_colType);
  tmp3 = mmc_unbox_real(_arrayPitch);
  tmp4 = mmc_unbox_real(_arrayYaw);
  _SFraction = omc_ShadingFractionFunction(threadData, tmp1, tmp2, tmp3, tmp4, &_Index);
  out_SFraction = mmc_mk_rcon(_SFraction);
  if (out_Index) { *out_Index = mmc_mk_rcon(_Index); }
  return out_SFraction;
}
DLLExport
modelica_integer omc_round(threadData_t *threadData, modelica_real _r)
{
  modelica_integer _i;
  _tailrecursive: OMC_LABEL_UNUSED
  TRACE_PUSH
  _i = ((_r > 0.0)?((modelica_integer)floor(floor((0.5 + _r)))):((modelica_integer)floor(ceil((_r + -0.5)))));
  _return: OMC_LABEL_UNUSED
  TRACE_POP
  return _i;
}
modelica_metatype boxptr_round(threadData_t *threadData, modelica_metatype _r)
{
  modelica_real tmp1;
  modelica_integer _i;
  modelica_metatype out_i;
  tmp1 = mmc_unbox_real(_r);
  _i = omc_round(threadData, tmp1);
  out_i = mmc_mk_icon(_i);
  return out_i;
}

