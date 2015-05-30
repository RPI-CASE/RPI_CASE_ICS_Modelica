#ifndef RMSE__H
#define RMSE__H

#include "util/modelica.h"
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

#ifdef __cplusplus
extern "C" {
#endif


typedef struct RMSE_rettype_s {
  modelica_real c1; /* error */
} RMSE_rettype;

DLLExport
int in_RMSE(type_description * inArgs, type_description * outVar);
DLLExport
RMSE_rettype omc_RMSE(threadData_t *threadData, real_array _x1, real_array _x2);


/* start - annotation(Include=...) if we have any */
/* end - annotation(Include=...) */

#ifdef __cplusplus
}
#endif
#endif

