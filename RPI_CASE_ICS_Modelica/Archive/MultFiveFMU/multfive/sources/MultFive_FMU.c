
// define class name and unique id
#define MODEL_IDENTIFIER MultFive
#define MODEL_GUID "{62bfd85e-2fbd-4cd6-b1d4-f33804744635}"

// include fmu header files, typedefs and macros
#include <stdio.h>
#include <string.h>
#include <assert.h>
#include "openmodelica.h"
#include "openmodelica_func.h"
#include "simulation_data.h"
#include "util/omc_error.h"
#include "MultFive_functions.h"
#include "MultFive_literals.h"
#include "fmiModelTypes.h"
#include "fmiModelFunctions.h"
#include "simulation/solver/initialization/initialization.h"
#include "simulation/solver/events.h"
#include "fmu_model_interface.h"

#ifdef __cplusplus
extern "C" {
#endif

void setStartValues(ModelInstance *comp);
void setDefaultStartValues(ModelInstance *comp);
void eventUpdate(ModelInstance* comp, fmiEventInfo* eventInfo);
fmiReal getReal(ModelInstance* comp, const fmiValueReference vr);
fmiStatus setReal(ModelInstance* comp, const fmiValueReference vr, const fmiReal value);
fmiInteger getInteger(ModelInstance* comp, const fmiValueReference vr);
fmiStatus setInteger(ModelInstance* comp, const fmiValueReference vr, const fmiInteger value);
fmiBoolean getBoolean(ModelInstance* comp, const fmiValueReference vr);
fmiStatus setBoolean(ModelInstance* comp, const fmiValueReference vr, const fmiBoolean value);
fmiString getString(ModelInstance* comp, const fmiValueReference vr);
fmiStatus setExternalFunction(ModelInstance* c, const fmiValueReference vr, const void* value);

// define model size
#define NUMBER_OF_STATES 0
#define NUMBER_OF_EVENT_INDICATORS 0
#define NUMBER_OF_REALS 4
#define NUMBER_OF_INTEGERS 0
#define NUMBER_OF_STRINGS 0
#define NUMBER_OF_BOOLEANS 0
#define NUMBER_OF_EXTERNALFUNCTIONS 0

// define variable data for model
#define $POutput_ 0 
#define $PInput_ 1 


// define initial state vector as vector of value references
#define STATES {  }
#define STATESDERIVATIVES {  }


// implementation of the Model Exchange functions
#define fmu_model_interface_setupDataStruc MultFive_setupDataStruc
#include "fmu_model_interface.c"

// Set values for all variables that define a start value
void setDefaultStartValues(ModelInstance *comp) {

comp->fmuData->modelData.realVarsData[0].attribute.start = 0;
comp->fmuData->modelData.realVarsData[1].attribute.start = 0;
comp->fmuData->modelData.realVarsData[2].attribute.start = 0;
comp->fmuData->modelData.realVarsData[3].attribute.start = 0;
}
// Set values for all variables that define a start value
void setStartValues(ModelInstance *comp) {

  comp->fmuData->modelData.realVarsData[2].attribute.start =  comp->fmuData->localData[0]->realVars[2];
  comp->fmuData->modelData.realVarsData[3].attribute.start =  comp->fmuData->localData[0]->realVars[3];
}
// Used to set the next time event, if any.
void eventUpdate(ModelInstance* comp, fmiEventInfo* eventInfo) {
}

fmiReal getReal(ModelInstance* comp, const fmiValueReference vr) {
  switch (vr) {
      case $POutput_ : return comp->fmuData->localData[0]->realVars[2]; break;
      case $PInput_ : return comp->fmuData->localData[0]->realVars[3]; break;
      default:
          return fmiError;
  }
}

fmiStatus setReal(ModelInstance* comp, const fmiValueReference vr, const fmiReal value) {
  switch (vr) {
      case $POutput_ : comp->fmuData->localData[0]->realVars[2]=value; break;
      case $PInput_ : comp->fmuData->localData[0]->realVars[3]=value; break;
      default:
          return fmiError;
  }
  return fmiOK;
}

fmiInteger getInteger(ModelInstance* comp, const fmiValueReference vr) {
  switch (vr) {
      default:
          return 0;
  }
}
fmiStatus setInteger(ModelInstance* comp, const fmiValueReference vr, const fmiInteger value) {
  switch (vr) {
      default:
          return fmiError;
  }
  return fmiOK;
}
fmiBoolean getBoolean(ModelInstance* comp, const fmiValueReference vr) {
  switch (vr) {
      default:
          return 0;
  }
}

fmiStatus setBoolean(ModelInstance* comp, const fmiValueReference vr, const fmiBoolean value) {
  switch (vr) {
      default:
          return fmiError;
  }
  return fmiOK;
}

fmiString getString(ModelInstance* comp, const fmiValueReference vr) {
  switch (vr) {
      default:
          return 0;
  }
}

fmiStatus setExternalFunction(ModelInstance* c, const fmiValueReference vr, const void* value){
  switch (vr) {
      default:
          return fmiError;
  }
  return fmiOK;
}


#ifdef __cplusplus
}
#endif

