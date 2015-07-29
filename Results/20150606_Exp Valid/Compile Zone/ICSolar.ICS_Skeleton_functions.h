#ifndef ICSolar_ICS_Skeleton__H
#define ICSolar_ICS_Skeleton__H

#include "util/modelica.h"
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

#include "simulation/simulation_runtime.h"
#ifdef __cplusplus
extern "C" {
#endif

typedef struct ICSolar_Water__75degC_s {
  modelica_real _rho;
  modelica_real _cp;
  modelica_real _cv;
  modelica_real _lamda;
  modelica_real _nue;
} ICSolar_Water__75degC;
typedef base_array_t ICSolar_Water__75degC_array;
extern struct record_description ICSolar_Water__75degC__desc;

typedef struct Modelica_Thermal_FluidHeatFlow_Media_Medium_s {
  modelica_real _rho;
  modelica_real _cp;
  modelica_real _cv;
  modelica_real _lamda;
  modelica_real _nue;
} Modelica_Thermal_FluidHeatFlow_Media_Medium;
typedef base_array_t Modelica_Thermal_FluidHeatFlow_Media_Medium_array;
extern struct record_description Modelica_Thermal_FluidHeatFlow_Media_Medium__desc;

typedef struct ModelicaServices_ExternalReferences_loadResource_rettype_s {
  modelica_string c1; /* fileReference */
} ModelicaServices_ExternalReferences_loadResource_rettype;
DLLExport
ModelicaServices_ExternalReferences_loadResource_rettype omc_ModelicaServices_ExternalReferences_loadResource(threadData_t *threadData, modelica_string _uri);


DLLExport
void omc_Modelica_Blocks_Types_ExternalCombiTable1D_destructor(threadData_t *threadData, modelica_complex _externalCombiTable1D);

extern void ModelicaStandardTables_CombiTable1D_close(void * /*_externalCombiTable1D*/);
typedef struct Modelica_Blocks_Sources_CombiTimeTable_getNextTimeEvent_rettype_s {
  modelica_real c1; /* nextTimeEvent */
} Modelica_Blocks_Sources_CombiTimeTable_getNextTimeEvent_rettype;
DLLExport
Modelica_Blocks_Sources_CombiTimeTable_getNextTimeEvent_rettype omc_Modelica_Blocks_Sources_CombiTimeTable_getNextTimeEvent(threadData_t *threadData, modelica_complex _tableID, modelica_real _timeIn, modelica_real _tableAvailable);

extern double ModelicaStandardTables_CombiTimeTable_nextTimeEvent(void * /*_tableID*/, double /*_timeIn*/);
typedef struct ICSolar_Water__75degC_rettype_s {
  ICSolar_Water__75degC c1;
} ICSolar_Water__75degC_rettype;

DLLExport
ICSolar_Water__75degC_rettype omc_ICSolar_Water__75degC(threadData_t *threadData, modelica_real rho, modelica_real cp, modelica_real cv, modelica_real lamda, modelica_real nue); /* record head */


typedef struct Buildings_Utilities_Math_Functions_smoothMin_rettype_s {
  modelica_real c1; /* y */
} Buildings_Utilities_Math_Functions_smoothMin_rettype;
DLLExport
Buildings_Utilities_Math_Functions_smoothMin_rettype omc_Buildings_Utilities_Math_Functions_smoothMin(threadData_t *threadData, modelica_real _x1, modelica_real _x2, modelica_real _deltaX);

typedef struct Buildings_Utilities_Math_Functions_smoothLimit_rettype_s {
  modelica_real c1; /* y */
} Buildings_Utilities_Math_Functions_smoothLimit_rettype;
DLLExport
Buildings_Utilities_Math_Functions_smoothLimit_rettype omc_Buildings_Utilities_Math_Functions_smoothLimit(threadData_t *threadData, modelica_real _x, modelica_real _l, modelica_real _u, modelica_real _deltaX);

typedef struct Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_rettype_s {
  modelica_string c1; /* path */
} Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_rettype;
DLLExport
Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_rettype omc_Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath(threadData_t *threadData, modelica_string _uri);

typedef struct Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_loadResource_rettype_s {
  modelica_string c1; /* path */
} Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_loadResource_rettype;
DLLExport
Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_loadResource_rettype omc_Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_loadResource(threadData_t *threadData, modelica_string _name);

typedef struct Buildings_Utilities_Math_Functions_smoothMax_rettype_s {
  modelica_real c1; /* y */
} Buildings_Utilities_Math_Functions_smoothMax_rettype;
DLLExport
Buildings_Utilities_Math_Functions_smoothMax_rettype omc_Buildings_Utilities_Math_Functions_smoothMax(threadData_t *threadData, modelica_real _x1, modelica_real _x2, modelica_real _deltaX);

typedef struct Buildings_Utilities_Math_Functions_spliceFunction_rettype_s {
  modelica_real c1; /* out */
} Buildings_Utilities_Math_Functions_spliceFunction_rettype;
DLLExport
Buildings_Utilities_Math_Functions_spliceFunction_rettype omc_Buildings_Utilities_Math_Functions_spliceFunction(threadData_t *threadData, modelica_real _pos, modelica_real _neg, modelica_real _x, modelica_real _deltax);

typedef struct Modelica_Blocks_Sources_CombiTimeTable_getDerTableValue_rettype_s {
  modelica_real c1; /* der_y */
} Modelica_Blocks_Sources_CombiTimeTable_getDerTableValue_rettype;
DLLExport
Modelica_Blocks_Sources_CombiTimeTable_getDerTableValue_rettype omc_Modelica_Blocks_Sources_CombiTimeTable_getDerTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_integer _icol, modelica_real _timeIn, modelica_real _nextTimeEvent, modelica_real _pre_nextTimeEvent, modelica_real _tableAvailable, modelica_real _der_timeIn);

extern double ModelicaStandardTables_CombiTimeTable_getDerValue(void * /*_tableID*/, int /*_icol*/, double /*_timeIn*/, double /*_nextTimeEvent*/, double /*_pre_nextTimeEvent*/, double /*_der_timeIn*/);
typedef struct Modelica_Blocks_Sources_CombiTimeTable_getTableValueNoDer_rettype_s {
  modelica_real c1; /* y */
} Modelica_Blocks_Sources_CombiTimeTable_getTableValueNoDer_rettype;
DLLExport
Modelica_Blocks_Sources_CombiTimeTable_getTableValueNoDer_rettype omc_Modelica_Blocks_Sources_CombiTimeTable_getTableValueNoDer(threadData_t *threadData, modelica_complex _tableID, modelica_integer _icol, modelica_real _timeIn, modelica_real _nextTimeEvent, modelica_real _pre_nextTimeEvent, modelica_real _tableAvailable);

extern double ModelicaStandardTables_CombiTimeTable_getValue(void * /*_tableID*/, int /*_icol*/, double /*_timeIn*/, double /*_nextTimeEvent*/, double /*_pre_nextTimeEvent*/);
typedef struct Modelica_Blocks_Sources_CombiTimeTable_getTableValue_rettype_s {
  modelica_real c1; /* y */
} Modelica_Blocks_Sources_CombiTimeTable_getTableValue_rettype;
DLLExport
Modelica_Blocks_Sources_CombiTimeTable_getTableValue_rettype omc_Modelica_Blocks_Sources_CombiTimeTable_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_integer _icol, modelica_real _timeIn, modelica_real _nextTimeEvent, modelica_real _pre_nextTimeEvent, modelica_real _tableAvailable);

extern double ModelicaStandardTables_CombiTimeTable_getValue(void * /*_tableID*/, int /*_icol*/, double /*_timeIn*/, double /*_nextTimeEvent*/, double /*_pre_nextTimeEvent*/);
typedef struct Modelica_Blocks_Sources_CombiTimeTable_getTableTimeTmin_rettype_s {
  modelica_real c1; /* timeMin */
} Modelica_Blocks_Sources_CombiTimeTable_getTableTimeTmin_rettype;
DLLExport
Modelica_Blocks_Sources_CombiTimeTable_getTableTimeTmin_rettype omc_Modelica_Blocks_Sources_CombiTimeTable_getTableTimeTmin(threadData_t *threadData, modelica_complex _tableID, modelica_real _tableAvailable);

extern double ModelicaStandardTables_CombiTimeTable_minimumTime(void * /*_tableID*/);
typedef struct Modelica_Blocks_Sources_CombiTimeTable_getTableTimeTmax_rettype_s {
  modelica_real c1; /* timeMax */
} Modelica_Blocks_Sources_CombiTimeTable_getTableTimeTmax_rettype;
DLLExport
Modelica_Blocks_Sources_CombiTimeTable_getTableTimeTmax_rettype omc_Modelica_Blocks_Sources_CombiTimeTable_getTableTimeTmax(threadData_t *threadData, modelica_complex _tableID, modelica_real _tableAvailable);

extern double ModelicaStandardTables_CombiTimeTable_maximumTime(void * /*_tableID*/);
typedef struct Modelica_Blocks_Types_ExternalCombiTable1D_constructor_rettype_s {
  modelica_complex c1; /* externalCombiTable1D */
} Modelica_Blocks_Types_ExternalCombiTable1D_constructor_rettype;
DLLExport
Modelica_Blocks_Types_ExternalCombiTable1D_constructor_rettype omc_Modelica_Blocks_Types_ExternalCombiTable1D_constructor(threadData_t *threadData, modelica_string _tableName, modelica_string _fileName, real_array _table, integer_array _columns, modelica_integer _smoothness);

extern void * ModelicaStandardTables_CombiTable1D_init(const char* /*_tableName*/, const char* /*_fileName*/, const double* /*_table*/, size_t, size_t, const int* /*_columns*/, size_t, int /*_smoothness*/);
typedef struct Modelica_Blocks_Tables_CombiTable2D_readTableData_rettype_s {
  modelica_real c1; /* readSuccess */
} Modelica_Blocks_Tables_CombiTable2D_readTableData_rettype;
DLLExport
Modelica_Blocks_Tables_CombiTable2D_readTableData_rettype omc_Modelica_Blocks_Tables_CombiTable2D_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead);

extern double ModelicaStandardTables_CombiTable2D_read(void * /*_tableID*/, int /*_forceRead*/, int /*_verboseRead*/);
typedef struct Modelica_Blocks_Tables_CombiTable1Ds_readTableData_rettype_s {
  modelica_real c1; /* readSuccess */
} Modelica_Blocks_Tables_CombiTable1Ds_readTableData_rettype;
DLLExport
Modelica_Blocks_Tables_CombiTable1Ds_readTableData_rettype omc_Modelica_Blocks_Tables_CombiTable1Ds_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead);

extern double ModelicaStandardTables_CombiTable1D_read(void * /*_tableID*/, int /*_forceRead*/, int /*_verboseRead*/);
typedef struct Modelica_Blocks_Tables_CombiTable1Ds_getTableValue_rettype_s {
  modelica_real c1; /* y */
} Modelica_Blocks_Tables_CombiTable1Ds_getTableValue_rettype;
DLLExport
Modelica_Blocks_Tables_CombiTable1Ds_getTableValue_rettype omc_Modelica_Blocks_Tables_CombiTable1Ds_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_integer _icol, modelica_real _u, modelica_real _tableAvailable);

extern double ModelicaStandardTables_CombiTable1D_getValue(void * /*_tableID*/, int /*_icol*/, double /*_u*/);
typedef struct Modelica_Blocks_Sources_CombiTimeTable_readTableData_rettype_s {
  modelica_real c1; /* readSuccess */
} Modelica_Blocks_Sources_CombiTimeTable_readTableData_rettype;
DLLExport
Modelica_Blocks_Sources_CombiTimeTable_readTableData_rettype omc_Modelica_Blocks_Sources_CombiTimeTable_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead);

extern double ModelicaStandardTables_CombiTimeTable_read(void * /*_tableID*/, int /*_forceRead*/, int /*_verboseRead*/);
typedef struct Modelica_Blocks_Tables_CombiTable2D_getTableValue_rettype_s {
  modelica_real c1; /* y */
} Modelica_Blocks_Tables_CombiTable2D_getTableValue_rettype;
DLLExport
Modelica_Blocks_Tables_CombiTable2D_getTableValue_rettype omc_Modelica_Blocks_Tables_CombiTable2D_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable);

extern double ModelicaStandardTables_CombiTable2D_getValue(void * /*_tableID*/, double /*_u1*/, double /*_u2*/);
typedef struct Modelica_Utilities_Internal_FileSystem_stat_rettype_s {
  modelica_integer c1; /* fileType */
} Modelica_Utilities_Internal_FileSystem_stat_rettype;
DLLExport
Modelica_Utilities_Internal_FileSystem_stat_rettype omc_Modelica_Utilities_Internal_FileSystem_stat(threadData_t *threadData, modelica_string _name);

extern int ModelicaInternal_stat(const char* /*_name*/);

DLLExport
void omc_Modelica_Blocks_Types_ExternalCombiTimeTable_destructor(threadData_t *threadData, modelica_complex _externalCombiTimeTable);

extern void ModelicaStandardTables_CombiTimeTable_close(void * /*_externalCombiTimeTable*/);

DLLExport
void omc_Modelica_Blocks_Types_ExternalCombiTable2D_destructor(threadData_t *threadData, modelica_complex _externalCombiTable2D);

extern void ModelicaStandardTables_CombiTable2D_close(void * /*_externalCombiTable2D*/);
typedef struct Modelica_Blocks_Types_ExternalCombiTable2D_constructor_rettype_s {
  modelica_complex c1; /* externalCombiTable2D */
} Modelica_Blocks_Types_ExternalCombiTable2D_constructor_rettype;
DLLExport
Modelica_Blocks_Types_ExternalCombiTable2D_constructor_rettype omc_Modelica_Blocks_Types_ExternalCombiTable2D_constructor(threadData_t *threadData, modelica_string _tableName, modelica_string _fileName, real_array _table, modelica_integer _smoothness);

extern void * ModelicaStandardTables_CombiTable2D_init(const char* /*_tableName*/, const char* /*_fileName*/, const double* /*_table*/, size_t, size_t, int /*_smoothness*/);
typedef struct Modelica_Blocks_Types_ExternalCombiTimeTable_constructor_rettype_s {
  modelica_complex c1; /* externalCombiTimeTable */
} Modelica_Blocks_Types_ExternalCombiTimeTable_constructor_rettype;
DLLExport
Modelica_Blocks_Types_ExternalCombiTimeTable_constructor_rettype omc_Modelica_Blocks_Types_ExternalCombiTimeTable_constructor(threadData_t *threadData, modelica_string _tableName, modelica_string _fileName, real_array _table, modelica_real _startTime, integer_array _columns, modelica_integer _smoothness, modelica_integer _extrapolation);

extern void * ModelicaStandardTables_CombiTimeTable_init(const char* /*_tableName*/, const char* /*_fileName*/, const double* /*_table*/, size_t, size_t, double /*_startTime*/, const int* /*_columns*/, size_t, int /*_smoothness*/, int /*_extrapolation*/);
typedef struct Modelica_Utilities_Files_exist_rettype_s {
  modelica_boolean c1; /* result */
} Modelica_Utilities_Files_exist_rettype;
DLLExport
Modelica_Utilities_Files_exist_rettype omc_Modelica_Utilities_Files_exist(threadData_t *threadData, modelica_string _name);

typedef struct Modelica_Thermal_FluidHeatFlow_Media_Medium_rettype_s {
  Modelica_Thermal_FluidHeatFlow_Media_Medium c1;
} Modelica_Thermal_FluidHeatFlow_Media_Medium_rettype;

DLLExport
Modelica_Thermal_FluidHeatFlow_Media_Medium_rettype omc_Modelica_Thermal_FluidHeatFlow_Media_Medium(threadData_t *threadData, modelica_real rho, modelica_real cp, modelica_real cv, modelica_real lamda, modelica_real nue); /* record head */


typedef struct Modelica_Utilities_Files_fullPathName_rettype_s {
  modelica_string c1; /* fullName */
} Modelica_Utilities_Files_fullPathName_rettype;
DLLExport
Modelica_Utilities_Files_fullPathName_rettype omc_Modelica_Utilities_Files_fullPathName(threadData_t *threadData, modelica_string _name);

extern const char* ModelicaInternal_fullPathName(const char* /*_name*/);
typedef struct Modelica_Utilities_Strings_length_rettype_s {
  modelica_integer c1; /* result */
} Modelica_Utilities_Strings_length_rettype;
DLLExport
Modelica_Utilities_Strings_length_rettype omc_Modelica_Utilities_Strings_length(threadData_t *threadData, modelica_string _string);

extern int ModelicaStrings_length(const char* /*_string*/);
typedef struct Modelica_Utilities_Strings_find_rettype_s {
  modelica_integer c1; /* index */
} Modelica_Utilities_Strings_find_rettype;
DLLExport
Modelica_Utilities_Strings_find_rettype omc_Modelica_Utilities_Strings_find(threadData_t *threadData, modelica_string _string, modelica_string _searchString, modelica_integer _startIndex, modelica_boolean _caseSensitive);

typedef struct Modelica_Utilities_Strings_compare_rettype_s {
  modelica_integer c1; /* result */
} Modelica_Utilities_Strings_compare_rettype;
DLLExport
Modelica_Utilities_Strings_compare_rettype omc_Modelica_Utilities_Strings_compare(threadData_t *threadData, modelica_string _string1, modelica_string _string2, modelica_boolean _caseSensitive);

extern int ModelicaStrings_compare(const char* /*_string1*/, const char* /*_string2*/, int /*_caseSensitive*/);
typedef struct Modelica_Utilities_Strings_isEqual_rettype_s {
  modelica_boolean c1; /* identical */
} Modelica_Utilities_Strings_isEqual_rettype;
DLLExport
Modelica_Utilities_Strings_isEqual_rettype omc_Modelica_Utilities_Strings_isEqual(threadData_t *threadData, modelica_string _string1, modelica_string _string2, modelica_boolean _caseSensitive);

typedef struct Modelica_Utilities_Strings_substring_rettype_s {
  modelica_string c1; /* result */
} Modelica_Utilities_Strings_substring_rettype;
DLLExport
Modelica_Utilities_Strings_substring_rettype omc_Modelica_Utilities_Strings_substring(threadData_t *threadData, modelica_string _string, modelica_integer _startIndex, modelica_integer _endIndex);

extern const char* ModelicaStrings_substring(const char* /*_string*/, int /*_startIndex*/, int /*_endIndex*/);
typedef struct OpenModelica_Scripting_uriToFilename_rettype_s {
  modelica_string c1; /* filename */
  modelica_string c2; /* message */
} OpenModelica_Scripting_uriToFilename_rettype;
DLLExport
OpenModelica_Scripting_uriToFilename_rettype omc_OpenModelica_Scripting_uriToFilename(threadData_t *threadData, modelica_string _uri);

typedef struct OpenModelica_Scripting_regexBool_rettype_s {
  modelica_boolean c1; /* matches */
} OpenModelica_Scripting_regexBool_rettype;
DLLExport
OpenModelica_Scripting_regexBool_rettype omc_OpenModelica_Scripting_regexBool(threadData_t *threadData, modelica_string _str, modelica_string _re, modelica_boolean _extended, modelica_boolean _caseInsensitive);

typedef struct OpenModelica_Scripting_realpath_rettype_s {
  modelica_string c1; /* fullName */
} OpenModelica_Scripting_realpath_rettype;
DLLExport
OpenModelica_Scripting_realpath_rettype omc_OpenModelica_Scripting_realpath(threadData_t *threadData, modelica_string _name);

extern const char* ModelicaInternal_fullPathName(const char* /*_name*/);
typedef struct OpenModelica_Scripting_Internal_stat_rettype_s {
  modelica_integer c1; /* fileType */
} OpenModelica_Scripting_Internal_stat_rettype;
DLLExport
OpenModelica_Scripting_Internal_stat_rettype omc_OpenModelica_Scripting_Internal_stat(threadData_t *threadData, modelica_string _name);

extern int ModelicaInternal_stat(const char* /*_name*/);
typedef struct OpenModelica_Scripting_directoryExists_rettype_s {
  modelica_boolean c1; /* exists */
} OpenModelica_Scripting_directoryExists_rettype;
DLLExport
OpenModelica_Scripting_directoryExists_rettype omc_OpenModelica_Scripting_directoryExists(threadData_t *threadData, modelica_string _dirName);

typedef struct OpenModelica_Scripting_regex_rettype_s {
  modelica_integer c1; /* numMatches */
  string_array c2; /* matchedSubstrings */
} OpenModelica_Scripting_regex_rettype;
DLLExport
OpenModelica_Scripting_regex_rettype omc_OpenModelica_Scripting_regex(threadData_t *threadData, modelica_string _str, modelica_string _re, modelica_integer _maxMatches, modelica_boolean _extended, modelica_boolean _caseInsensitive);

extern int OpenModelica_regex(const char* /*_str*/, const char* /*_re*/, int /*_maxMatches*/, int /*_extended*/, int /*_caseInsensitive*/, const char** /*_matchedSubstrings*/);
typedef struct OpenModelica_Scripting_regularFileExists_rettype_s {
  modelica_boolean c1; /* exists */
} OpenModelica_Scripting_regularFileExists_rettype;
DLLExport
OpenModelica_Scripting_regularFileExists_rettype omc_OpenModelica_Scripting_regularFileExists(threadData_t *threadData, modelica_string _fileName);

#ifdef __cplusplus
}
#endif
#endif


