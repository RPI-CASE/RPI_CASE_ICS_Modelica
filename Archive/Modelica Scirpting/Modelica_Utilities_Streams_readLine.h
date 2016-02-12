#ifndef Modelica_Utilities_Streams_readLine__H
#define Modelica_Utilities_Streams_readLine__H

#include "util/modelica.h"
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

#ifdef __cplusplus
extern "C" {
#endif


DLLExport
modelica_string omc_Modelica_Utilities_Streams_readLine(threadData_t *threadData, modelica_string _fileName, modelica_integer _lineNumber, modelica_boolean *out_endOfFile);
DLLExport
modelica_metatype boxptr_Modelica_Utilities_Streams_readLine(threadData_t *threadData, modelica_metatype _fileName, modelica_metatype _lineNumber, modelica_metatype *out_endOfFile);
static const MMC_DEFSTRUCTLIT(boxvar_lit_Modelica_Utilities_Streams_readLine,2,0) {boxptr_Modelica_Utilities_Streams_readLine,0}};
#define boxvar_Modelica_Utilities_Streams_readLine MMC_REFSTRUCTLIT(boxvar_lit_Modelica_Utilities_Streams_readLine)

extern const char* ModelicaInternal_readLine(const char* /*_fileName*/, int /*_lineNumber*/, int* /*_endOfFile*/);


#ifdef __cplusplus
}
#endif
#endif
