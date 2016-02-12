#include "Modelica_Utilities_Streams_readLine.h"
#include "util/modelica.h"

#include "Modelica_Utilities_Streams_readLine_includes.h"


void (*omc_assert)(threadData_t*,FILE_INFO info,const char *msg,...) __attribute__ ((noreturn)) = omc_assert_function;
void (*omc_assert_warning)(FILE_INFO info,const char *msg,...) = omc_assert_warning_function;
void (*omc_terminate)(FILE_INFO info,const char *msg,...) = omc_terminate_function;
void (*omc_throw)(threadData_t*) __attribute__ ((noreturn)) = omc_throw_function;

modelica_string omc_Modelica_Utilities_Streams_readLine(threadData_t *threadData, modelica_string _fileName, modelica_integer _lineNumber, modelica_boolean *out_endOfFile)
{
  int _lineNumber_ext;
  int _endOfFile_ext;
  const char* _string_ext;
  modelica_string _string;
  modelica_boolean _endOfFile;
  _lineNumber_ext = (int)_lineNumber;
  _string_ext = ModelicaInternal_readLine(_fileName, _lineNumber_ext, &_endOfFile_ext);
  _endOfFile = (modelica_boolean)_endOfFile_ext;
  _string = (modelica_string)_string_ext;
  if (out_endOfFile) { *out_endOfFile = _endOfFile; }
  return _string;
}
DLLExport
int in_Modelica_Utilities_Streams_readLine(type_description * inArgs, type_description * outVar)
{
  modelica_string _fileName;
  modelica_integer _lineNumber;
  modelica_string _string;
  modelica_boolean _endOfFile;
  if (read_modelica_string(&inArgs, (char**) &_fileName)) return 1;
  if (read_modelica_integer(&inArgs, &_lineNumber)) return 1;
  MMC_INIT();
  MMC_TRY_TOP()
  _string = omc_Modelica_Utilities_Streams_readLine(threadData, _fileName, _lineNumber, &_endOfFile);
  MMC_CATCH_TOP(return 1)
  write_modelica_string(outVar, &_string);
  write_modelica_boolean(outVar, &_endOfFile);
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
  
    omc_Modelica_Utilities_Streams_readLine(threadData, lst);
    
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
modelica_metatype boxptr_Modelica_Utilities_Streams_readLine(threadData_t *threadData, modelica_metatype _fileName, modelica_metatype _lineNumber, modelica_metatype *out_endOfFile)
{
  modelica_integer tmp1;
  modelica_boolean _endOfFile;
  modelica_string _string;
  tmp1 = mmc_unbox_integer(_lineNumber);
  _string = omc_Modelica_Utilities_Streams_readLine(threadData, _fileName, tmp1, &_endOfFile);
  /* skip box _string; String */if (out_endOfFile) { *out_endOfFile = mmc_mk_icon(_endOfFile); }
  return _string;
}

