#ifndef Modelica_Utilities_Strings_Advanced_scanReal__H
#define Modelica_Utilities_Strings_Advanced_scanReal__H

#include "util/modelica.h"
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

#ifdef __cplusplus
extern "C" {
#endif


DLLExport
modelica_integer omc_Modelica_Utilities_Strings_Advanced_scanReal(threadData_t *threadData, modelica_string _string, modelica_integer _startIndex, modelica_boolean _unsigned, modelica_real *out_number);
DLLExport
modelica_metatype boxptr_Modelica_Utilities_Strings_Advanced_scanReal(threadData_t *threadData, modelica_metatype _string, modelica_metatype _startIndex, modelica_metatype _unsigned, modelica_metatype *out_number);
static const MMC_DEFSTRUCTLIT(boxvar_lit_Modelica_Utilities_Strings_Advanced_scanReal,2,0) {boxptr_Modelica_Utilities_Strings_Advanced_scanReal,0}};
#define boxvar_Modelica_Utilities_Strings_Advanced_scanReal MMC_REFSTRUCTLIT(boxvar_lit_Modelica_Utilities_Strings_Advanced_scanReal)

extern void ModelicaStrings_scanReal(const char* /*_string*/, int /*_startIndex*/, int /*_unsigned*/, int* /*_nextIndex*/, double* /*_number*/);


#ifdef __cplusplus
}
#endif
#endif
