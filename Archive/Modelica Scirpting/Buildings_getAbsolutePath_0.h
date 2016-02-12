#ifndef Buildings_getAbsolutePath_0__H
#define Buildings_getAbsolutePath_0__H

#include "util/modelica.h"
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

#ifdef __cplusplus
extern "C" {
#endif


DLLExport
modelica_string omc_Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath(threadData_t *threadData, modelica_string _uri);
#define boxptr_Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath omc_Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath
static const MMC_DEFSTRUCTLIT(boxvar_lit_Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath,2,0) {boxptr_Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath,0}};
#define boxvar_Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath MMC_REFSTRUCTLIT(boxvar_lit_Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath)

DLLExport
modelica_integer omc_Modelica_Utilities_Strings_find(threadData_t *threadData, modelica_string _string, modelica_string _searchString, modelica_integer _startIndex, modelica_boolean _caseSensitive);
DLLExport
modelica_metatype boxptr_Modelica_Utilities_Strings_find(threadData_t *threadData, modelica_metatype _string, modelica_metatype _searchString, modelica_metatype _startIndex, modelica_metatype _caseSensitive);
static const MMC_DEFSTRUCTLIT(boxvar_lit_Modelica_Utilities_Strings_find,2,0) {boxptr_Modelica_Utilities_Strings_find,0}};
#define boxvar_Modelica_Utilities_Strings_find MMC_REFSTRUCTLIT(boxvar_lit_Modelica_Utilities_Strings_find)

DLLExport
modelica_boolean omc_Modelica_Utilities_Strings_isEqual(threadData_t *threadData, modelica_string _string1, modelica_string _string2, modelica_boolean _caseSensitive);
DLLExport
modelica_metatype boxptr_Modelica_Utilities_Strings_isEqual(threadData_t *threadData, modelica_metatype _string1, modelica_metatype _string2, modelica_metatype _caseSensitive);
static const MMC_DEFSTRUCTLIT(boxvar_lit_Modelica_Utilities_Strings_isEqual,2,0) {boxptr_Modelica_Utilities_Strings_isEqual,0}};
#define boxvar_Modelica_Utilities_Strings_isEqual MMC_REFSTRUCTLIT(boxvar_lit_Modelica_Utilities_Strings_isEqual)

DLLExport
modelica_integer omc_Modelica_Utilities_Strings_compare(threadData_t *threadData, modelica_string _string1, modelica_string _string2, modelica_boolean _caseSensitive);
DLLExport
modelica_metatype boxptr_Modelica_Utilities_Strings_compare(threadData_t *threadData, modelica_metatype _string1, modelica_metatype _string2, modelica_metatype _caseSensitive);
static const MMC_DEFSTRUCTLIT(boxvar_lit_Modelica_Utilities_Strings_compare,2,0) {boxptr_Modelica_Utilities_Strings_compare,0}};
#define boxvar_Modelica_Utilities_Strings_compare MMC_REFSTRUCTLIT(boxvar_lit_Modelica_Utilities_Strings_compare)

extern int ModelicaStrings_compare(const char* /*_string1*/, const char* /*_string2*/, int /*_caseSensitive*/);
DLLExport
modelica_string omc_Modelica_Utilities_Strings_substring(threadData_t *threadData, modelica_string _string, modelica_integer _startIndex, modelica_integer _endIndex);
DLLExport
modelica_metatype boxptr_Modelica_Utilities_Strings_substring(threadData_t *threadData, modelica_metatype _string, modelica_metatype _startIndex, modelica_metatype _endIndex);
static const MMC_DEFSTRUCTLIT(boxvar_lit_Modelica_Utilities_Strings_substring,2,0) {boxptr_Modelica_Utilities_Strings_substring,0}};
#define boxvar_Modelica_Utilities_Strings_substring MMC_REFSTRUCTLIT(boxvar_lit_Modelica_Utilities_Strings_substring)

extern const char* ModelicaStrings_substring(const char* /*_string*/, int /*_startIndex*/, int /*_endIndex*/);
DLLExport
modelica_integer omc_Modelica_Utilities_Strings_length(threadData_t *threadData, modelica_string _string);
DLLExport
modelica_metatype boxptr_Modelica_Utilities_Strings_length(threadData_t *threadData, modelica_metatype _string);
static const MMC_DEFSTRUCTLIT(boxvar_lit_Modelica_Utilities_Strings_length,2,0) {boxptr_Modelica_Utilities_Strings_length,0}};
#define boxvar_Modelica_Utilities_Strings_length MMC_REFSTRUCTLIT(boxvar_lit_Modelica_Utilities_Strings_length)

extern int ModelicaStrings_length(const char* /*_string*/);
DLLExport
modelica_boolean omc_Modelica_Utilities_Files_exist(threadData_t *threadData, modelica_string _name);
DLLExport
modelica_metatype boxptr_Modelica_Utilities_Files_exist(threadData_t *threadData, modelica_metatype _name);
static const MMC_DEFSTRUCTLIT(boxvar_lit_Modelica_Utilities_Files_exist,2,0) {boxptr_Modelica_Utilities_Files_exist,0}};
#define boxvar_Modelica_Utilities_Files_exist MMC_REFSTRUCTLIT(boxvar_lit_Modelica_Utilities_Files_exist)

DLLExport
modelica_integer omc_Modelica_Utilities_Internal_FileSystem_stat(threadData_t *threadData, modelica_string _name);
DLLExport
modelica_metatype boxptr_Modelica_Utilities_Internal_FileSystem_stat(threadData_t *threadData, modelica_metatype _name);
static const MMC_DEFSTRUCTLIT(boxvar_lit_Modelica_Utilities_Internal_FileSystem_stat,2,0) {boxptr_Modelica_Utilities_Internal_FileSystem_stat,0}};
#define boxvar_Modelica_Utilities_Internal_FileSystem_stat MMC_REFSTRUCTLIT(boxvar_lit_Modelica_Utilities_Internal_FileSystem_stat)

extern int ModelicaInternal_stat(const char* /*_name*/);
#define boxptr_Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_loadResource omc_Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_loadResource

DLLExport
modelica_string omc_Modelica_Utilities_Files_fullPathName(threadData_t *threadData, modelica_string _name);
#define boxptr_Modelica_Utilities_Files_fullPathName omc_Modelica_Utilities_Files_fullPathName
static const MMC_DEFSTRUCTLIT(boxvar_lit_Modelica_Utilities_Files_fullPathName,2,0) {boxptr_Modelica_Utilities_Files_fullPathName,0}};
#define boxvar_Modelica_Utilities_Files_fullPathName MMC_REFSTRUCTLIT(boxvar_lit_Modelica_Utilities_Files_fullPathName)

extern const char* ModelicaInternal_fullPathName(const char* /*_name*/);
DLLExport
modelica_string omc_ModelicaServices_ExternalReferences_loadResource(threadData_t *threadData, modelica_string _uri);
#define boxptr_ModelicaServices_ExternalReferences_loadResource omc_ModelicaServices_ExternalReferences_loadResource
static const MMC_DEFSTRUCTLIT(boxvar_lit_ModelicaServices_ExternalReferences_loadResource,2,0) {boxptr_ModelicaServices_ExternalReferences_loadResource,0}};
#define boxvar_ModelicaServices_ExternalReferences_loadResource MMC_REFSTRUCTLIT(boxvar_lit_ModelicaServices_ExternalReferences_loadResource)

DLLExport
modelica_string omc_OpenModelica_Scripting_uriToFilename(threadData_t *threadData, modelica_string _uri, modelica_string *out_message);
#define boxptr_OpenModelica_Scripting_uriToFilename omc_OpenModelica_Scripting_uriToFilename
static const MMC_DEFSTRUCTLIT(boxvar_lit_OpenModelica_Scripting_uriToFilename,2,0) {boxptr_OpenModelica_Scripting_uriToFilename,0}};
#define boxvar_OpenModelica_Scripting_uriToFilename MMC_REFSTRUCTLIT(boxvar_lit_OpenModelica_Scripting_uriToFilename)

DLLExport
modelica_boolean omc_OpenModelica_Scripting_directoryExists(threadData_t *threadData, modelica_string _dirName);
DLLExport
modelica_metatype boxptr_OpenModelica_Scripting_directoryExists(threadData_t *threadData, modelica_metatype _dirName);
static const MMC_DEFSTRUCTLIT(boxvar_lit_OpenModelica_Scripting_directoryExists,2,0) {boxptr_OpenModelica_Scripting_directoryExists,0}};
#define boxvar_OpenModelica_Scripting_directoryExists MMC_REFSTRUCTLIT(boxvar_lit_OpenModelica_Scripting_directoryExists)

DLLExport
modelica_integer omc_OpenModelica_Scripting_Internal_stat(threadData_t *threadData, modelica_string _name);
DLLExport
modelica_metatype boxptr_OpenModelica_Scripting_Internal_stat(threadData_t *threadData, modelica_metatype _name);
static const MMC_DEFSTRUCTLIT(boxvar_lit_OpenModelica_Scripting_Internal_stat,2,0) {boxptr_OpenModelica_Scripting_Internal_stat,0}};
#define boxvar_OpenModelica_Scripting_Internal_stat MMC_REFSTRUCTLIT(boxvar_lit_OpenModelica_Scripting_Internal_stat)

extern int ModelicaInternal_stat(const char* /*_name*/);
DLLExport
modelica_string omc_OpenModelica_Scripting_realpath(threadData_t *threadData, modelica_string _name);
#define boxptr_OpenModelica_Scripting_realpath omc_OpenModelica_Scripting_realpath
static const MMC_DEFSTRUCTLIT(boxvar_lit_OpenModelica_Scripting_realpath,2,0) {boxptr_OpenModelica_Scripting_realpath,0}};
#define boxvar_OpenModelica_Scripting_realpath MMC_REFSTRUCTLIT(boxvar_lit_OpenModelica_Scripting_realpath)

extern const char* ModelicaInternal_fullPathName(const char* /*_name*/);
DLLExport
modelica_integer omc_OpenModelica_Scripting_regex(threadData_t *threadData, modelica_string _str, modelica_string _re, modelica_integer _maxMatches, modelica_boolean _extended, modelica_boolean _caseInsensitive, string_array *out_matchedSubstrings);
DLLExport
modelica_metatype boxptr_OpenModelica_Scripting_regex(threadData_t *threadData, modelica_metatype _str, modelica_metatype _re, modelica_metatype _maxMatches, modelica_metatype _extended, modelica_metatype _caseInsensitive, modelica_metatype *out_matchedSubstrings);
static const MMC_DEFSTRUCTLIT(boxvar_lit_OpenModelica_Scripting_regex,2,0) {boxptr_OpenModelica_Scripting_regex,0}};
#define boxvar_OpenModelica_Scripting_regex MMC_REFSTRUCTLIT(boxvar_lit_OpenModelica_Scripting_regex)

extern int OpenModelica_regex(const char* /*_str*/, const char* /*_re*/, int /*_maxMatches*/, int /*_extended*/, int /*_caseInsensitive*/, const char** /*_matchedSubstrings*/);
DLLExport
modelica_boolean omc_OpenModelica_Scripting_regexBool(threadData_t *threadData, modelica_string _str, modelica_string _re, modelica_boolean _extended, modelica_boolean _caseInsensitive);
DLLExport
modelica_metatype boxptr_OpenModelica_Scripting_regexBool(threadData_t *threadData, modelica_metatype _str, modelica_metatype _re, modelica_metatype _extended, modelica_metatype _caseInsensitive);
static const MMC_DEFSTRUCTLIT(boxvar_lit_OpenModelica_Scripting_regexBool,2,0) {boxptr_OpenModelica_Scripting_regexBool,0}};
#define boxvar_OpenModelica_Scripting_regexBool MMC_REFSTRUCTLIT(boxvar_lit_OpenModelica_Scripting_regexBool)

DLLExport
modelica_boolean omc_OpenModelica_Scripting_regularFileExists(threadData_t *threadData, modelica_string _fileName);
DLLExport
modelica_metatype boxptr_OpenModelica_Scripting_regularFileExists(threadData_t *threadData, modelica_metatype _fileName);
static const MMC_DEFSTRUCTLIT(boxvar_lit_OpenModelica_Scripting_regularFileExists,2,0) {boxptr_OpenModelica_Scripting_regularFileExists,0}};
#define boxvar_OpenModelica_Scripting_regularFileExists MMC_REFSTRUCTLIT(boxvar_lit_OpenModelica_Scripting_regularFileExists)

#ifdef __cplusplus
}
#endif
#endif
