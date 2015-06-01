#ifndef ShadingFractionFunction__H
#define ShadingFractionFunction__H

#include "util/modelica.h"
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

#ifdef __cplusplus
extern "C" {
#endif


DLLExport
modelica_real omc_ShadingFractionFunction(threadData_t *threadData, modelica_integer _rowType, modelica_integer _colType, modelica_real _arrayPitch, modelica_real _arrayYaw, modelica_real *out_Index);
DLLExport
modelica_metatype boxptr_ShadingFractionFunction(threadData_t *threadData, modelica_metatype _rowType, modelica_metatype _colType, modelica_metatype _arrayPitch, modelica_metatype _arrayYaw, modelica_metatype *out_Index);
static const MMC_DEFSTRUCTLIT(boxvar_lit_ShadingFractionFunction,2,0) {boxptr_ShadingFractionFunction,0}};
#define boxvar_ShadingFractionFunction MMC_REFSTRUCTLIT(boxvar_lit_ShadingFractionFunction)

DLLExport
modelica_integer omc_round(threadData_t *threadData, modelica_real _r);
DLLExport
modelica_metatype boxptr_round(threadData_t *threadData, modelica_metatype _r);
static const MMC_DEFSTRUCTLIT(boxvar_lit_round,2,0) {boxptr_round,0}};
#define boxvar_round MMC_REFSTRUCTLIT(boxvar_lit_round)

#ifdef __cplusplus
}
#endif
#endif
