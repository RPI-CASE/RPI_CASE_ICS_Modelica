#ifndef RMSE__H
#define RMSE__H

#include "util/modelica.h"
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

#ifdef __cplusplus
extern "C" {
#endif


DLLExport
modelica_real omc_RMSE(threadData_t *threadData, real_array _x1, real_array _x2);
DLLExport
modelica_metatype boxptr_RMSE(threadData_t *threadData, modelica_metatype _x1, modelica_metatype _x2);
static const MMC_DEFSTRUCTLIT(boxvar_lit_RMSE,2,0) {boxptr_RMSE,0}};
#define boxvar_RMSE MMC_REFSTRUCTLIT(boxvar_lit_RMSE)


#ifdef __cplusplus
}
#endif
#endif
