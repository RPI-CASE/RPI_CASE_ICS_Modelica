#include "Buildings_getLongitudeTMY3_13.h"
#define _OMC_LIT0_data "Angle"
static const char _OMC_LIT0[6] = _OMC_LIT0_data;
#define _OMC_LIT1_data "rad"
static const char _OMC_LIT1[4] = _OMC_LIT1_data;
#define _OMC_LIT2_data "deg"
static const char _OMC_LIT2[4] = _OMC_LIT2_data;
#define _OMC_LIT3_data "#LOCATION"
static const char _OMC_LIT3[10] = _OMC_LIT3_data;
#define _OMC_LIT4_data "longitude"
static const char _OMC_LIT4[10] = _OMC_LIT4_data;
#define _OMC_LIT5_data "Error when converting the longitude '"
static const char _OMC_LIT5[38] = _OMC_LIT5_data;
#define _OMC_LIT6_data "' from a String to a Real."
static const char _OMC_LIT6[27] = _OMC_LIT6_data;
#define _OMC_LIT7_data "Wrong value for longitude. Received lon = "
static const char _OMC_LIT7[43] = _OMC_LIT7_data;
#define _OMC_LIT8_data " (= "
static const char _OMC_LIT8[5] = _OMC_LIT8_data;
#define _OMC_LIT9_data " degrees)."
static const char _OMC_LIT9[11] = _OMC_LIT9_data;
#define _OMC_LIT10_data "Error: Did not find '"
static const char _OMC_LIT10[22] = _OMC_LIT10_data;
#define _OMC_LIT11_data "' when scanning the weather file."
static const char _OMC_LIT11[34] = _OMC_LIT11_data;
#define _OMC_LIT12_data "\n   Check for correct weather file syntax."
static const char _OMC_LIT12[43] = _OMC_LIT12_data;
#define _OMC_LIT13_data ","
static const char _OMC_LIT13[2] = _OMC_LIT13_data;
#define _OMC_LIT14_data "Error when scanning weather file. Not enough tokens to find "
static const char _OMC_LIT14[61] = _OMC_LIT14_data;
#define _OMC_LIT15_data "."
static const char _OMC_LIT15[2] = _OMC_LIT15_data;
#define _OMC_LIT16_data "\n   Check for correct file syntax."
static const char _OMC_LIT16[35] = _OMC_LIT16_data;
#define _OMC_LIT17_data "\n   The scanned line is '"
static const char _OMC_LIT17[26] = _OMC_LIT17_data;
#define _OMC_LIT18_data "'."
static const char _OMC_LIT18[3] = _OMC_LIT18_data;
#define _OMC_LIT19_data "File '"
static const char _OMC_LIT19[7] = _OMC_LIT19_data;
#define _OMC_LIT20_data "' does not exist."
static const char _OMC_LIT20[18] = _OMC_LIT20_data;
#define _OMC_LIT21_data "file://"
static const char _OMC_LIT21[8] = _OMC_LIT21_data;
#define _OMC_LIT22_data "modelica://"
static const char _OMC_LIT22[12] = _OMC_LIT22_data;
#define _OMC_LIT23_data "modelica://Buildings/"
static const char _OMC_LIT23[22] = _OMC_LIT23_data;
#define _OMC_LIT24_data "' does not exist.\n  Expected to find either 'file://"
static const char _OMC_LIT24[53] = _OMC_LIT24_data;
#define _OMC_LIT25_data "\n                       or 'modelica://"
static const char _OMC_LIT25[40] = _OMC_LIT25_data;
#define _OMC_LIT26_data " +\n                       or 'modelica://Buildings/"
static const char _OMC_LIT26[52] = _OMC_LIT26_data;
#define _OMC_LIT27_data ""
static const char _OMC_LIT27[1] = _OMC_LIT27_data;
#define _OMC_LIT28_data "^[A-Za-z]*://"
static const char _OMC_LIT28[14] = _OMC_LIT28_data;
#define _OMC_LIT29_data "^/"
static const char _OMC_LIT29[3] = _OMC_LIT29_data;
#define _OMC_LIT30_data "C:/Users/Justin/Documents/GitHub/RPI_CASE_ICS_Modelica/Archive/Modelica Scirpting//"
static const char _OMC_LIT30[84] = _OMC_LIT30_data;
#define _OMC_LIT31_data "^[A-Za-z]*://?([^/]*)(.*)$"
static const char _OMC_LIT31[27] = _OMC_LIT31_data;
#define _OMC_LIT32_data "^modelica://"
static const char _OMC_LIT32[13] = _OMC_LIT32_data;
#define _OMC_LIT33_data "^file:///"
static const char _OMC_LIT33[10] = _OMC_LIT33_data;
#define _OMC_LIT34_data "^file://"
static const char _OMC_LIT34[9] = _OMC_LIT34_data;
#define _OMC_LIT35_data "Unknown error"
static const char _OMC_LIT35[14] = _OMC_LIT35_data;
#define _OMC_LIT36_data "Unknown URI schema: "
static const char _OMC_LIT36[21] = _OMC_LIT36_data;
#define _OMC_LIT37_data "file://(.*)"
static const char _OMC_LIT37[12] = _OMC_LIT37_data;
#define _OMC_LIT38_data "file://(/.*)?"
static const char _OMC_LIT38[14] = _OMC_LIT38_data;
#define _OMC_LIT39_data "Modelica"
static const char _OMC_LIT39[9] = _OMC_LIT39_data;
#define _OMC_LIT40_data "C:/OpenModelica1.9.1/lib/omlibrary/Modelica 3.2.1"
static const char _OMC_LIT40[50] = _OMC_LIT40_data;
#define _OMC_LIT41_data "ModelicaServices"
static const char _OMC_LIT41[17] = _OMC_LIT41_data;
#define _OMC_LIT42_data "C:/OpenModelica1.9.1/lib/omlibrary/ModelicaServices 3.2.1"
static const char _OMC_LIT42[58] = _OMC_LIT42_data;
#define _OMC_LIT43_data "ICSolar"
static const char _OMC_LIT43[8] = _OMC_LIT43_data;
#define _OMC_LIT44_data "C:/Users/Justin/Documents/GitHub/RPI_CASE_ICS_Modelica"
static const char _OMC_LIT44[55] = _OMC_LIT44_data;
#define _OMC_LIT45_data "Buildings"
static const char _OMC_LIT45[10] = _OMC_LIT45_data;
#define _OMC_LIT46_data "C:/OpenModelica1.9.1/lib/omlibrary/Buildings 1.6"
static const char _OMC_LIT46[49] = _OMC_LIT46_data;
static _index_t _OMC_LIT47_dims[2] = {4, 2};
static const modelica_string _OMC_LIT47_data[] = {_OMC_LIT39, _OMC_LIT40, _OMC_LIT41, _OMC_LIT42, _OMC_LIT43, _OMC_LIT44, _OMC_LIT45, _OMC_LIT46};
static string_array const _OMC_LIT47 = {
  2, _OMC_LIT47_dims, (void*) _OMC_LIT47_data
};
#define _OMC_LIT48_data "Malformed modelica:// URI path. Package name '"
static const char _OMC_LIT48[47] = _OMC_LIT48_data;
#define _OMC_LIT49_data "', path: '"
static const char _OMC_LIT49[11] = _OMC_LIT49_data;
#define _OMC_LIT50_data "'"
static const char _OMC_LIT50[2] = _OMC_LIT50_data;
#define _OMC_LIT51_data "^([A-Za-z_][A-Za-z0-9_]*)?[.]?(.*)?$"
static const char _OMC_LIT51[37] = _OMC_LIT51_data;
#define _OMC_LIT52_data "Could not resolve URI: "
static const char _OMC_LIT52[24] = _OMC_LIT52_data;
#define _OMC_LIT53_data "/"
static const char _OMC_LIT53[2] = _OMC_LIT53_data;
#include "util/modelica.h"

#include "Buildings_getLongitudeTMY3_13_includes.h"

static modelica_string omc_Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_loadResource(threadData_t *threadData, modelica_string _name);
static const MMC_DEFSTRUCTLIT(boxvar_lit_Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_loadResource,2,0) {boxptr_Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_loadResource,0}};
#define boxvar_Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_loadResource MMC_REFSTRUCTLIT(boxvar_lit_Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_loadResource)

void (*omc_assert)(threadData_t*,FILE_INFO info,const char *msg,...) __attribute__ ((noreturn)) = omc_assert_function;
void (*omc_assert_warning)(FILE_INFO info,const char *msg,...) = omc_assert_warning_function;
void (*omc_terminate)(FILE_INFO info,const char *msg,...) = omc_terminate_function;
void (*omc_throw)(threadData_t*) __attribute__ ((noreturn)) = omc_throw_function;

DLLExport
modelica_real omc_Buildings_BoundaryConditions_WeatherData_BaseClasses_getLongitudeTMY3(threadData_t *threadData, modelica_string _filNam)
{
  modelica_real _lon;
  modelica_integer _nexInd;
  modelica_string _element;
  modelica_string tmp1;
  modelica_string tmp2;
  modelica_string tmp3;
  modelica_string tmp4;
  modelica_string tmp5;
  modelica_string tmp6;
  modelica_string tmp7;
  modelica_string tmp8;
  _tailrecursive: OMC_LABEL_UNUSED
  TRACE_PUSH
  _element = omc_Buildings_BoundaryConditions_WeatherData_BaseClasses_getHeaderElementTMY3(threadData, _filNam, _OMC_LIT3, _OMC_LIT4, (modelica_integer) 8);

  /* tuple assignment nexInd, lon*/
  _nexInd = omc_Modelica_Utilities_Strings_Advanced_scanReal(threadData, _element, (modelica_integer) 1, 0, &_lon);

  if(!((modelica_integer)_nexInd > (modelica_integer) 1))
  {
      tmp1 = cat_modelica_string(_OMC_LIT5,_element);
      tmp2 = cat_modelica_string(tmp1,_OMC_LIT6);
      FILE_INFO info = {"C:/OpenModelica1.9.1/lib/omlibrary/Buildings 1.6/BoundaryConditions/WeatherData/BaseClasses/getLongitudeTMY3.mo",22,4,23,62,0};
      omc_assert(threadData, info, tmp2);
  }

  _lon = (0.0174532925199433 * _lon);

  if(!(fabs(_lon) < 6.283185307179586))
  {
      tmp3 = modelica_real_to_modelica_string(_lon, (modelica_integer) 0, 1, (modelica_integer) 6);
      tmp4 = cat_modelica_string(_OMC_LIT7,tmp3);
      tmp5 = cat_modelica_string(tmp4,_OMC_LIT8);
      tmp6 = modelica_real_to_modelica_string((57.29577951308232 * _lon), (modelica_integer) 0, 1, (modelica_integer) 6);
      tmp7 = cat_modelica_string(tmp5,tmp6);
      tmp8 = cat_modelica_string(tmp7,_OMC_LIT9);
      FILE_INFO info = {"C:/OpenModelica1.9.1/lib/omlibrary/Buildings 1.6/BoundaryConditions/WeatherData/BaseClasses/getLongitudeTMY3.mo",27,4,29,84,0};
      omc_assert(threadData, info, tmp8);
  }
  _return: OMC_LABEL_UNUSED
  TRACE_POP
  return _lon;
}
DLLExport
int in_Buildings_BoundaryConditions_WeatherData_BaseClasses_getLongitudeTMY3(type_description * inArgs, type_description * outVar)
{
  modelica_string _filNam;
  modelica_real _lon;
  if (read_modelica_string(&inArgs, (char**) &_filNam)) return 1;
  MMC_INIT();
  MMC_TRY_TOP()
  _lon = omc_Buildings_BoundaryConditions_WeatherData_BaseClasses_getLongitudeTMY3(threadData, _filNam);
  MMC_CATCH_TOP(return 1)
  write_modelica_real(outVar, &_lon);
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
  
    omc_Buildings_BoundaryConditions_WeatherData_BaseClasses_getLongitudeTMY3(threadData, lst);
    
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
modelica_metatype boxptr_Buildings_BoundaryConditions_WeatherData_BaseClasses_getLongitudeTMY3(threadData_t *threadData, modelica_metatype _filNam)
{
  modelica_real _lon;
  modelica_metatype out_lon;
  _lon = omc_Buildings_BoundaryConditions_WeatherData_BaseClasses_getLongitudeTMY3(threadData, _filNam);
  out_lon = mmc_mk_rcon(_lon);
  return out_lon;
}
modelica_integer omc_Modelica_Utilities_Strings_Advanced_scanReal(threadData_t *threadData, modelica_string _string, modelica_integer _startIndex, modelica_boolean _unsigned, modelica_real *out_number)
{
  int _startIndex_ext;
  int _unsigned_ext;
  int _nextIndex_ext;
  double _number_ext;
  modelica_integer _nextIndex;
  modelica_real _number;
  _startIndex_ext = (int)_startIndex;
  _unsigned_ext = (int)_unsigned;
  ModelicaStrings_scanReal(_string, _startIndex_ext, _unsigned_ext, &_nextIndex_ext, &_number_ext);
  _nextIndex = (modelica_integer)_nextIndex_ext;
  _number = (modelica_real)_number_ext;
  if (out_number) { *out_number = _number; }
  return _nextIndex;
}
modelica_metatype boxptr_Modelica_Utilities_Strings_Advanced_scanReal(threadData_t *threadData, modelica_metatype _string, modelica_metatype _startIndex, modelica_metatype _unsigned, modelica_metatype *out_number)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _number;
  modelica_integer _nextIndex;
  modelica_metatype out_nextIndex;
  tmp1 = mmc_unbox_integer(_startIndex);
  tmp2 = mmc_unbox_integer(_unsigned);
  _nextIndex = omc_Modelica_Utilities_Strings_Advanced_scanReal(threadData, _string, tmp1, tmp2, &_number);
  out_nextIndex = mmc_mk_icon(_nextIndex);
  if (out_number) { *out_number = mmc_mk_rcon(_number); }
  return out_nextIndex;
}
DLLExport
modelica_string omc_Buildings_BoundaryConditions_WeatherData_BaseClasses_getHeaderElementTMY3(threadData_t *threadData, modelica_string _filNam, modelica_string _start, modelica_string _name, modelica_integer _position)
{
  modelica_string _element;
  modelica_string _lin;
  modelica_integer _iLin;
  modelica_integer _index;
  modelica_integer _staInd;
  modelica_integer _nexInd;
  modelica_boolean _found;
  modelica_boolean _EOF;
  modelica_string _fouDel;
  modelica_string tmp1;
  modelica_string tmp2;
  modelica_string tmp3;
  modelica_string tmp4;
  modelica_string tmp5;
  modelica_string tmp6;
  modelica_string tmp7;
  modelica_string tmp8;
  modelica_string tmp9;
  modelica_integer tmp10;
  modelica_integer tmp11;
  modelica_integer tmp12;
  modelica_string tmp13;
  modelica_string tmp14;
  modelica_string tmp15;
  modelica_string tmp16;
  modelica_string tmp17;
  modelica_string tmp18;
  _tailrecursive: OMC_LABEL_UNUSED
  TRACE_PUSH
  _index = (modelica_integer) 0;
  _iLin = (modelica_integer) 0;

  _EOF = 0;

  while(1)
  {
    if(!((!_EOF) && ((modelica_integer)_index == (modelica_integer) 0))) break;
    _iLin = ((modelica_integer) 1 + (modelica_integer)_iLin);

    /* tuple assignment lin, EOF*/
    _lin = omc_Modelica_Utilities_Streams_readLine(threadData, omc_Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath(threadData, _filNam), (modelica_integer)_iLin, &_EOF);

    _index = omc_Modelica_Utilities_Strings_find(threadData, _lin, _start, (modelica_integer) 1, 0);
  }

  if(!(!_EOF))
  {
      tmp1 = cat_modelica_string(_OMC_LIT10,_start);
      tmp2 = cat_modelica_string(tmp1,_OMC_LIT11);
      tmp3 = cat_modelica_string(tmp2,_OMC_LIT12);
      FILE_INFO info = {"C:/OpenModelica1.9.1/lib/omlibrary/Buildings 1.6/BoundaryConditions/WeatherData/BaseClasses/getHeaderElementTMY3.mo",37,3,38,71,0};
      omc_assert(threadData, info, tmp3);
  }

  _nexInd = (modelica_integer) 1;

  tmp10 = (modelica_integer) 1; tmp11 = 1; tmp12 = ((modelica_integer)_position + (modelica_integer) -1);
  if(!tmp11)
  {
    FILE_INFO info = omc_dummyFileInfo;
    omc_assert(threadData, info, "assertion range step != 0 failed");
  }
  else if(!(((tmp11 > 0) && (tmp10 > tmp12)) || ((tmp11 < 0) && (tmp10 < tmp12))))
  {
    modelica_integer _i;
    for(_i = (modelica_integer) 1; in_range_integer(_i, tmp10, tmp12); _i += tmp11)
    {
      _nexInd = omc_Modelica_Utilities_Strings_find(threadData, _lin, _OMC_LIT13, ((modelica_integer) 1 + (modelica_integer)_nexInd), 1);

      if(!((modelica_integer)_nexInd > (modelica_integer) 0))
      {
          tmp4 = cat_modelica_string(_OMC_LIT14,_name);
          tmp5 = cat_modelica_string(tmp4,_OMC_LIT15);
          tmp6 = cat_modelica_string(tmp5,_OMC_LIT16);
          tmp7 = cat_modelica_string(tmp6,_OMC_LIT17);
          tmp8 = cat_modelica_string(tmp7,_lin);
          tmp9 = cat_modelica_string(tmp8,_OMC_LIT18);
          FILE_INFO info = {"C:/OpenModelica1.9.1/lib/omlibrary/Buildings 1.6/BoundaryConditions/WeatherData/BaseClasses/getHeaderElementTMY3.mo",46,4,48,20,0};
          omc_assert(threadData, info, tmp9);
      }
    }
  }

  _staInd = (modelica_integer)_nexInd;

  _nexInd = omc_Modelica_Utilities_Strings_find(threadData, _lin, _OMC_LIT13, ((modelica_integer) 1 + (modelica_integer)_nexInd), 1);

  if(!((modelica_integer)_nexInd > (modelica_integer) 0))
  {
      tmp13 = cat_modelica_string(_OMC_LIT14,_name);
      tmp14 = cat_modelica_string(tmp13,_OMC_LIT15);
      tmp15 = cat_modelica_string(tmp14,_OMC_LIT16);
      tmp16 = cat_modelica_string(tmp15,_OMC_LIT17);
      tmp17 = cat_modelica_string(tmp16,_lin);
      tmp18 = cat_modelica_string(tmp17,_OMC_LIT18);
      FILE_INFO info = {"C:/OpenModelica1.9.1/lib/omlibrary/Buildings 1.6/BoundaryConditions/WeatherData/BaseClasses/getHeaderElementTMY3.mo",56,3,58,21,0};
      omc_assert(threadData, info, tmp18);
  }

  _element = omc_Modelica_Utilities_Strings_substring(threadData, _lin, ((modelica_integer) 1 + (modelica_integer)_staInd), ((modelica_integer)_nexInd + (modelica_integer) -1));
  _return: OMC_LABEL_UNUSED
  TRACE_POP
  return _element;
}
modelica_metatype boxptr_Buildings_BoundaryConditions_WeatherData_BaseClasses_getHeaderElementTMY3(threadData_t *threadData, modelica_metatype _filNam, modelica_metatype _start, modelica_metatype _name, modelica_metatype _position)
{
  modelica_integer tmp1;
  modelica_string _element;
  tmp1 = mmc_unbox_integer(_position);
  _element = omc_Buildings_BoundaryConditions_WeatherData_BaseClasses_getHeaderElementTMY3(threadData, _filNam, _start, _name, tmp1);
  /* skip box _element; String */
  return _element;
}
modelica_string omc_Modelica_Utilities_Strings_substring(threadData_t *threadData, modelica_string _string, modelica_integer _startIndex, modelica_integer _endIndex)
{
  int _startIndex_ext;
  int _endIndex_ext;
  const char* _result_ext;
  modelica_string _result;
  _startIndex_ext = (int)_startIndex;
  _endIndex_ext = (int)_endIndex;
  _result_ext = ModelicaStrings_substring(_string, _startIndex_ext, _endIndex_ext);
  _result = (modelica_string)_result_ext;
  return _result;
}
modelica_metatype boxptr_Modelica_Utilities_Strings_substring(threadData_t *threadData, modelica_metatype _string, modelica_metatype _startIndex, modelica_metatype _endIndex)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_string _result;
  tmp1 = mmc_unbox_integer(_startIndex);
  tmp2 = mmc_unbox_integer(_endIndex);
  _result = omc_Modelica_Utilities_Strings_substring(threadData, _string, tmp1, tmp2);
  /* skip box _result; String */
  return _result;
}
DLLExport
modelica_integer omc_Modelica_Utilities_Strings_find(threadData_t *threadData, modelica_string _string, modelica_string _searchString, modelica_integer _startIndex, modelica_boolean _caseSensitive)
{
  modelica_integer _index;
  modelica_integer _lengthSearchString;
  modelica_integer _i;
  modelica_integer _len;
  modelica_integer _i_max;
  _tailrecursive: OMC_LABEL_UNUSED
  TRACE_PUSH
  _lengthSearchString = omc_Modelica_Utilities_Strings_length(threadData, _searchString);
  _i = (modelica_integer)_startIndex;
  _len = ((modelica_integer)_lengthSearchString + (modelica_integer) -1);
  _i_max = ((modelica_integer) 1 + (omc_Modelica_Utilities_Strings_length(threadData, _string) - (modelica_integer)_lengthSearchString));
  _index = (modelica_integer) 0;

  while(1)
  {
    if(!((modelica_integer)_i <= (modelica_integer)_i_max)) break;
    if(omc_Modelica_Utilities_Strings_isEqual(threadData, omc_Modelica_Utilities_Strings_substring(threadData, _string, (modelica_integer)_i, ((modelica_integer)_i + (modelica_integer)_len)), _searchString, _caseSensitive))
    {
      _index = (modelica_integer)_i;

      _i = ((modelica_integer) 1 + (modelica_integer)_i_max);
    }
    else
    {
      _i = ((modelica_integer) 1 + (modelica_integer)_i);
    }
  }
  _return: OMC_LABEL_UNUSED
  TRACE_POP
  return _index;
}
modelica_metatype boxptr_Modelica_Utilities_Strings_find(threadData_t *threadData, modelica_metatype _string, modelica_metatype _searchString, modelica_metatype _startIndex, modelica_metatype _caseSensitive)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_integer _index;
  modelica_metatype out_index;
  tmp1 = mmc_unbox_integer(_startIndex);
  tmp2 = mmc_unbox_integer(_caseSensitive);
  _index = omc_Modelica_Utilities_Strings_find(threadData, _string, _searchString, tmp1, tmp2);
  out_index = mmc_mk_icon(_index);
  return out_index;
}
DLLExport
modelica_boolean omc_Modelica_Utilities_Strings_isEqual(threadData_t *threadData, modelica_string _string1, modelica_string _string2, modelica_boolean _caseSensitive)
{
  modelica_boolean _identical;
  _tailrecursive: OMC_LABEL_UNUSED
  TRACE_PUSH
  _identical = (omc_Modelica_Utilities_Strings_compare(threadData, _string1, _string2, _caseSensitive) == 2);
  _return: OMC_LABEL_UNUSED
  TRACE_POP
  return _identical;
}
modelica_metatype boxptr_Modelica_Utilities_Strings_isEqual(threadData_t *threadData, modelica_metatype _string1, modelica_metatype _string2, modelica_metatype _caseSensitive)
{
  modelica_integer tmp1;
  modelica_boolean _identical;
  modelica_metatype out_identical;
  tmp1 = mmc_unbox_integer(_caseSensitive);
  _identical = omc_Modelica_Utilities_Strings_isEqual(threadData, _string1, _string2, tmp1);
  out_identical = mmc_mk_icon(_identical);
  return out_identical;
}
modelica_integer omc_Modelica_Utilities_Strings_compare(threadData_t *threadData, modelica_string _string1, modelica_string _string2, modelica_boolean _caseSensitive)
{
  int _caseSensitive_ext;
  int _result_ext;
  modelica_integer _result;
  _caseSensitive_ext = (int)_caseSensitive;
  _result_ext = ModelicaStrings_compare(_string1, _string2, _caseSensitive_ext);
  _result = (modelica_integer)_result_ext;
  return _result;
}
modelica_metatype boxptr_Modelica_Utilities_Strings_compare(threadData_t *threadData, modelica_metatype _string1, modelica_metatype _string2, modelica_metatype _caseSensitive)
{
  modelica_integer tmp1;
  modelica_integer _result;
  modelica_metatype out_result;
  tmp1 = mmc_unbox_integer(_caseSensitive);
  _result = omc_Modelica_Utilities_Strings_compare(threadData, _string1, _string2, tmp1);
  out_result = mmc_mk_icon(_result);
  return out_result;
}
modelica_integer omc_Modelica_Utilities_Strings_length(threadData_t *threadData, modelica_string _string)
{
  int _result_ext;
  modelica_integer _result;
  _result_ext = ModelicaStrings_length(_string);
  _result = (modelica_integer)_result_ext;
  return _result;
}
modelica_metatype boxptr_Modelica_Utilities_Strings_length(threadData_t *threadData, modelica_metatype _string)
{
  modelica_integer _result;
  modelica_metatype out_result;
  _result = omc_Modelica_Utilities_Strings_length(threadData, _string);
  out_result = mmc_mk_icon(_result);
  return out_result;
}
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
DLLExport
modelica_string omc_Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath(threadData_t *threadData, modelica_string _uri)
{
  modelica_string _path;
  modelica_string tmp1;
  modelica_string tmp2;
  modelica_string tmp3;
  modelica_string tmp4;
  modelica_string tmp5;
  modelica_string tmp6;
  modelica_string tmp7;
  modelica_string tmp8;
  modelica_string tmp9;
  modelica_string tmp10;
  modelica_string tmp11;
  modelica_string tmp12;
  _tailrecursive: OMC_LABEL_UNUSED
  TRACE_PUSH
  if(((omc_Modelica_Utilities_Strings_find(threadData, _uri, _OMC_LIT21, (modelica_integer) 1, 0) == (modelica_integer) 0) && (omc_Modelica_Utilities_Strings_find(threadData, _uri, _OMC_LIT22, (modelica_integer) 1, 0) == (modelica_integer) 0)))
  {
    tmp1 = cat_modelica_string(_OMC_LIT21,_uri);
    _path = omc_Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_loadResource(threadData, tmp1);

    if((!omc_Modelica_Utilities_Files_exist(threadData, _path)))
    {
      tmp2 = cat_modelica_string(_OMC_LIT22,_uri);
      _path = omc_Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_loadResource(threadData, tmp2);

      if((!omc_Modelica_Utilities_Files_exist(threadData, _path)))
      {
        tmp3 = cat_modelica_string(_OMC_LIT23,_uri);
        _path = omc_Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_loadResource(threadData, tmp3);

        if(!omc_Modelica_Utilities_Files_exist(threadData, _path))
        {
            tmp4 = cat_modelica_string(_OMC_LIT19,_uri);
            tmp5 = cat_modelica_string(tmp4,_OMC_LIT24);
            tmp6 = cat_modelica_string(tmp5,_uri);
            tmp7 = cat_modelica_string(tmp6,_OMC_LIT25);
            tmp8 = cat_modelica_string(tmp7,_uri);
            tmp9 = cat_modelica_string(tmp8,_OMC_LIT26);
            tmp10 = cat_modelica_string(tmp9,_uri);
            FILE_INFO info = {"C:/OpenModelica1.9.1/lib/omlibrary/Buildings 1.6/BoundaryConditions/WeatherData/BaseClasses/getAbsolutePath.mo",32,9,35,57,0};
            omc_assert(threadData, info, tmp10);
        }
      }
    }
  }
  else
  {
    _path = omc_ModelicaServices_ExternalReferences_loadResource(threadData, _uri);

    _path = omc_Modelica_Utilities_Files_fullPathName(threadData, _path);

    if(!omc_Modelica_Utilities_Files_exist(threadData, _path))
    {
        tmp11 = cat_modelica_string(_OMC_LIT19,_uri);
        tmp12 = cat_modelica_string(tmp11,_OMC_LIT20);
        FILE_INFO info = {"C:/OpenModelica1.9.1/lib/omlibrary/Buildings 1.6/BoundaryConditions/WeatherData/BaseClasses/getAbsolutePath.mo",42,5,42,87,0};
        omc_assert(threadData, info, tmp12);
    }
  }
  _return: OMC_LABEL_UNUSED
  TRACE_POP
  return _path;
}

DLLExport
modelica_boolean omc_Modelica_Utilities_Files_exist(threadData_t *threadData, modelica_string _name)
{
  modelica_boolean _result;
  _tailrecursive: OMC_LABEL_UNUSED
  TRACE_PUSH
  _result = (omc_Modelica_Utilities_Internal_FileSystem_stat(threadData, _name) > 1);
  _return: OMC_LABEL_UNUSED
  TRACE_POP
  return _result;
}
modelica_metatype boxptr_Modelica_Utilities_Files_exist(threadData_t *threadData, modelica_metatype _name)
{
  modelica_boolean _result;
  modelica_metatype out_result;
  _result = omc_Modelica_Utilities_Files_exist(threadData, _name);
  out_result = mmc_mk_icon(_result);
  return out_result;
}
modelica_integer omc_Modelica_Utilities_Internal_FileSystem_stat(threadData_t *threadData, modelica_string _name)
{
  int _fileType_ext;
  modelica_integer _fileType;
  _fileType_ext = ModelicaInternal_stat(_name);
  _fileType = (modelica_integer)_fileType_ext;
  return _fileType;
}
modelica_metatype boxptr_Modelica_Utilities_Internal_FileSystem_stat(threadData_t *threadData, modelica_metatype _name)
{
  modelica_integer _fileType;
  modelica_metatype out_fileType;
  _fileType = omc_Modelica_Utilities_Internal_FileSystem_stat(threadData, _name);
  out_fileType = mmc_mk_icon(_fileType);
  return out_fileType;
}
static modelica_string omc_Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_loadResource(threadData_t *threadData, modelica_string _name)
{
  modelica_string _path;
  _tailrecursive: OMC_LABEL_UNUSED
  TRACE_PUSH
  _path = omc_ModelicaServices_ExternalReferences_loadResource(threadData, _name);

  if((omc_Modelica_Utilities_Strings_length(threadData, _path) > (modelica_integer) 0))
  {
    _path = omc_Modelica_Utilities_Files_fullPathName(threadData, _path);
  }
  _return: OMC_LABEL_UNUSED
  TRACE_POP
  return _path;
}

modelica_string omc_Modelica_Utilities_Files_fullPathName(threadData_t *threadData, modelica_string _name)
{
  const char* _fullName_ext;
  modelica_string _fullName;
  _fullName_ext = ModelicaInternal_fullPathName(_name);
  _fullName = (modelica_string)_fullName_ext;
  return _fullName;
}

DLLExport
modelica_string omc_ModelicaServices_ExternalReferences_loadResource(threadData_t *threadData, modelica_string _uri)
{
  modelica_string _fileReference;
  _tailrecursive: OMC_LABEL_UNUSED
  TRACE_PUSH
  _fileReference = omc_OpenModelica_Scripting_uriToFilename(threadData, _uri, NULL);
  _return: OMC_LABEL_UNUSED
  TRACE_POP
  return _fileReference;
}

DLLExport
modelica_string omc_OpenModelica_Scripting_uriToFilename(threadData_t *threadData, modelica_string _uri, modelica_string *out_message)
{
  modelica_string _filename;
  modelica_string _message;
  string_array _libraries;
  modelica_integer _numMatches;
  string_array _matches;
  string_array _matches2;
  modelica_string _path;
  modelica_string _schema;
  modelica_string _str;
  modelica_boolean _isUri;
  modelica_boolean _isMatch;
  modelica_boolean _isModelicaUri;
  modelica_boolean _isFileUri;
  modelica_boolean _isFileUriAbsolute;
  base_array_t tmp1;
  modelica_integer tmp2;
  modelica_string tmp5;
  modelica_string tmp6;
  modelica_string tmp7;
  modelica_string tmp8;
  base_array_t tmp9;
  modelica_string tmp10;
  modelica_string tmp11;
  modelica_string tmp12;
  modelica_string tmp13;
  modelica_integer tmp14;
  modelica_integer tmp15;
  modelica_integer tmp16;
  modelica_integer tmp17;
  modelica_string tmp20;
  modelica_string tmp21;
  modelica_boolean tmp22;
  modelica_string tmp23;
  base_array_t tmp24;
  base_array_t tmp25;
  modelica_string tmp26;
  modelica_string tmp27;
  modelica_string tmp28;
  modelica_boolean tmp29;
  modelica_string tmp30;
  modelica_boolean tmp31;
  modelica_string tmp32;
  _tailrecursive: OMC_LABEL_UNUSED
  TRACE_PUSH
  _filename = _OMC_LIT27;
  _message = _OMC_LIT27;
  alloc_string_array(&_libraries, 2, (modelica_integer) -1, (modelica_integer) 2);
  alloc_string_array(&_matches, 1, (modelica_integer) -1);
  alloc_string_array(&_matches2, 1, (modelica_integer) -1);
  _isMatch = 0;
  _isUri = omc_OpenModelica_Scripting_regexBool(threadData, _uri, _OMC_LIT28, 1, 0);

  if(_isUri)
  {
    /* tuple assignment numMatches, matches*/
    _numMatches = omc_OpenModelica_Scripting_regex(threadData, _uri, _OMC_LIT31, (modelica_integer) 4, 1, 0, &tmp1);
    _matches = tmp1;

    _isModelicaUri = omc_OpenModelica_Scripting_regexBool(threadData, _uri, _OMC_LIT32, 1, 1);

    _isFileUriAbsolute = omc_OpenModelica_Scripting_regexBool(threadData, _uri, _OMC_LIT33, 1, 1);

    _isFileUri = omc_OpenModelica_Scripting_regexBool(threadData, _uri, _OMC_LIT34, 1, 1);

    if(_isModelicaUri)
    {
      copy_string_array(_OMC_LIT47, &_libraries);

      {
        modelica_integer _$tmpVar5;
        modelica_integer _$tmpVar4;
        int tmp3;
        string_array lib_loopVar;
        int tmp4;
        modelica_string _lib;
        lib_loopVar = _libraries;
        tmp4 = 1;
        _$tmpVar5 = (modelica_integer) 0; /* defaultValue */
        while(1) {
          tmp3 = 1;
          while(tmp4 <= size_of_dimension_base_array(lib_loopVar, 1)) {
            _lib = *(string_array_element_addr1(&lib_loopVar, 1, tmp4++));
            if(1) { /* found non-guarded */
              tmp3--;
              break;
            }
          }
          if (tmp3 == 0) {
            _$tmpVar4 = (modelica_integer) 1;
            _$tmpVar5 = ((modelica_integer)_$tmpVar5 + (modelica_integer)_$tmpVar4);
          } else if (tmp3 == 1) {
            break;
          } else {
            MMC_THROW_INTERNAL();
          }
        }
        tmp2 = _$tmpVar5;
      }
      if((tmp2 == (modelica_integer) 0))
      {
        _filename = _OMC_LIT27;

        goto _return;
      }

      _path = (*string_array_element_addr(&_matches, 1, /* modelica_integer */ (modelica_integer) 2));

      if((stringEqual(_path, _OMC_LIT27)))
      {
        tmp5 = cat_modelica_string(_OMC_LIT48,(*string_array_element_addr(&_matches, 1, /* modelica_integer */ (modelica_integer) 2)));
        tmp6 = cat_modelica_string(tmp5,_OMC_LIT49);
        tmp7 = cat_modelica_string(tmp6,(*string_array_element_addr(&_matches, 1, /* modelica_integer */ (modelica_integer) 3)));
        tmp8 = cat_modelica_string(tmp7,_OMC_LIT50);
        _message = tmp8;

        goto _return;
      }

      while(1)
      {
        if(!(!stringEqual(_path, _OMC_LIT27))) break;
        /* tuple assignment numMatches, matches2*/
        _numMatches = omc_OpenModelica_Scripting_regex(threadData, _path, _OMC_LIT51, (modelica_integer) 3, 1, 0, &tmp9);
        _matches2 = tmp9;

        _path = (*string_array_element_addr(&_matches2, 1, /* modelica_integer */ (modelica_integer) 3));

        if(_isMatch)
        {
          tmp10 = cat_modelica_string(_filename,_OMC_LIT53);
          tmp11 = cat_modelica_string(tmp10,(*string_array_element_addr(&_matches2, 1, /* modelica_integer */ (modelica_integer) 2)));
          if(omc_OpenModelica_Scripting_directoryExists(threadData, tmp11))
          {
            tmp12 = cat_modelica_string(_filename,_OMC_LIT53);
            tmp13 = cat_modelica_string(tmp12,(*string_array_element_addr(&_matches2, 1, /* modelica_integer */ (modelica_integer) 2)));
            _filename = omc_OpenModelica_Scripting_realpath(threadData, tmp13);
          }
          else
          {
            break;
          }
        }
        else
        {
          {
            modelica_integer _$tmpVar7;
            modelica_integer _$tmpVar6;
            int tmp18;
            string_array lib_loopVar;
            int tmp19;
            modelica_string _lib;
            lib_loopVar = _libraries;
            tmp19 = 1;
            _$tmpVar7 = (modelica_integer) 0; /* defaultValue */
            while(1) {
              tmp18 = 1;
              while(tmp19 <= size_of_dimension_base_array(lib_loopVar, 1)) {
                _lib = *(string_array_element_addr1(&lib_loopVar, 1, tmp19++));
                if(1) { /* found non-guarded */
                  tmp18--;
                  break;
                }
              }
              if (tmp18 == 0) {
                _$tmpVar6 = (modelica_integer) 1;
                _$tmpVar7 = ((modelica_integer)_$tmpVar7 + (modelica_integer)_$tmpVar6);
              } else if (tmp18 == 1) {
                break;
              } else {
                MMC_THROW_INTERNAL();
              }
            }
            tmp17 = _$tmpVar7;
          }
          tmp14 = (modelica_integer) 1; tmp15 = 1; tmp16 = tmp17;
          if(!tmp15)
          {
            FILE_INFO info = omc_dummyFileInfo;
            omc_assert(threadData, info, "assertion range step != 0 failed");
          }
          else if(!(((tmp15 > 0) && (tmp14 > tmp16)) || ((tmp15 < 0) && (tmp14 < tmp16))))
          {
            modelica_integer _i;
            for(_i = (modelica_integer) 1; in_range_integer(_i, tmp14, tmp16); _i += tmp15)
            {
              if((stringEqual((*string_array_element_addr(&_libraries, 2, /* modelica_integer */ (modelica_integer)_i, /* modelica_integer */ (modelica_integer) 1)), (*string_array_element_addr(&_matches2, 1, /* modelica_integer */ (modelica_integer) 2)))))
              {
                _filename = (*string_array_element_addr(&_libraries, 2, /* modelica_integer */ (modelica_integer)_i, /* modelica_integer */ (modelica_integer) 2));

                _isMatch = 1;

                break;
              }
            }
          }

          if((!_isMatch))
          {
            tmp20 = cat_modelica_string(_OMC_LIT52,_uri);
            _message = tmp20;

            _filename = _OMC_LIT27;

            goto _return;
          }
        }
      }

      tmp22 = (modelica_boolean)_isMatch;
      if(tmp22)
      {
        tmp21 = cat_modelica_string(_filename,(*string_array_element_addr(&_matches, 1, /* modelica_integer */ (modelica_integer) 3)));
        tmp23 = tmp21;
      }
      else
      {
        tmp23 = _filename;
      }
      _filename = tmp23;
    }
    else
    {
      if(_isFileUriAbsolute)
      {
        /* tuple assignment _, matches*/
        omc_OpenModelica_Scripting_regex(threadData, _uri, _OMC_LIT38, (modelica_integer) 2, 1, 1, &tmp24);
        _matches = tmp24;

        _filename = (*string_array_element_addr(&_matches, 1, /* modelica_integer */ (modelica_integer) 2));
      }
      else
      {
        if((_isFileUri && (!_isFileUriAbsolute)))
        {
          /* tuple assignment _, matches*/
          omc_OpenModelica_Scripting_regex(threadData, _uri, _OMC_LIT37, (modelica_integer) 2, 1, 1, &tmp25);
          _matches = tmp25;

          tmp26 = cat_modelica_string(_OMC_LIT30,(*string_array_element_addr(&_matches, 1, /* modelica_integer */ (modelica_integer) 2)));
          _filename = tmp26;

          goto _return;
        }
        else
        {
          if((!(_isModelicaUri || _isFileUri)))
          {
            tmp27 = cat_modelica_string(_OMC_LIT36,_uri);
            _message = tmp27;

            _filename = _OMC_LIT27;

            goto _return;
          }
          else
          {
            _message = _OMC_LIT35;

            _filename = _OMC_LIT27;
          }
        }
      }
    }
  }
  else
  {
    tmp31 = (modelica_boolean)omc_OpenModelica_Scripting_regularFileExists(threadData, _uri);
    if(tmp31)
    {
      tmp32 = omc_OpenModelica_Scripting_realpath(threadData, _uri);
    }
    else
    {
      tmp29 = (modelica_boolean)omc_OpenModelica_Scripting_regexBool(threadData, _uri, _OMC_LIT29, 1, 0);
      if(tmp29)
      {
        tmp30 = _uri;
      }
      else
      {
        tmp28 = cat_modelica_string(_OMC_LIT30,_uri);
        tmp30 = tmp28;
      }
      tmp32 = tmp30;
    }
    _filename = tmp32;
  }
  _return: OMC_LABEL_UNUSED
  if (out_message) { *out_message = _message; }
  TRACE_POP
  return _filename;
}

DLLExport
modelica_boolean omc_OpenModelica_Scripting_directoryExists(threadData_t *threadData, modelica_string _dirName)
{
  modelica_boolean _exists;
  _tailrecursive: OMC_LABEL_UNUSED
  TRACE_PUSH
  _exists = (omc_OpenModelica_Scripting_Internal_stat(threadData, _dirName) == 3);
  _return: OMC_LABEL_UNUSED
  TRACE_POP
  return _exists;
}
modelica_metatype boxptr_OpenModelica_Scripting_directoryExists(threadData_t *threadData, modelica_metatype _dirName)
{
  modelica_boolean _exists;
  modelica_metatype out_exists;
  _exists = omc_OpenModelica_Scripting_directoryExists(threadData, _dirName);
  out_exists = mmc_mk_icon(_exists);
  return out_exists;
}
modelica_integer omc_OpenModelica_Scripting_Internal_stat(threadData_t *threadData, modelica_string _name)
{
  int _fileType_ext;
  modelica_integer _fileType;
  _fileType_ext = ModelicaInternal_stat(_name);
  _fileType = (modelica_integer)_fileType_ext;
  return _fileType;
}
modelica_metatype boxptr_OpenModelica_Scripting_Internal_stat(threadData_t *threadData, modelica_metatype _name)
{
  modelica_integer _fileType;
  modelica_metatype out_fileType;
  _fileType = omc_OpenModelica_Scripting_Internal_stat(threadData, _name);
  out_fileType = mmc_mk_icon(_fileType);
  return out_fileType;
}
modelica_string omc_OpenModelica_Scripting_realpath(threadData_t *threadData, modelica_string _name)
{
  const char* _fullName_ext;
  modelica_string _fullName;
  _fullName_ext = ModelicaInternal_fullPathName(_name);
  _fullName = (modelica_string)_fullName_ext;
  return _fullName;
}

modelica_integer omc_OpenModelica_Scripting_regex(threadData_t *threadData, modelica_string _str, modelica_string _re, modelica_integer _maxMatches, modelica_boolean _extended, modelica_boolean _caseInsensitive, string_array *out_matchedSubstrings)
{
  int _maxMatches_ext;
  int _extended_ext;
  int _caseInsensitive_ext;
  int _numMatches_ext;
  modelica_integer _numMatches;
  string_array _matchedSubstrings;
  alloc_string_array(&_matchedSubstrings, 1, (modelica_integer)_maxMatches);
  _maxMatches_ext = (int)_maxMatches;
  _extended_ext = (int)_extended;
  _caseInsensitive_ext = (int)_caseInsensitive;
  _numMatches_ext = OpenModelica_regex(_str, _re, _maxMatches_ext, _extended_ext, _caseInsensitive_ext, (const char**) data_of_string_array(&(_matchedSubstrings)));
  _numMatches = (modelica_integer)_numMatches_ext;
  if (out_matchedSubstrings) { *out_matchedSubstrings = _matchedSubstrings; }
  return _numMatches;
}
modelica_metatype boxptr_OpenModelica_Scripting_regex(threadData_t *threadData, modelica_metatype _str, modelica_metatype _re, modelica_metatype _maxMatches, modelica_metatype _extended, modelica_metatype _caseInsensitive, modelica_metatype *out_matchedSubstrings)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_integer tmp3;
  string_array _matchedSubstrings;
  modelica_integer _numMatches;
  modelica_metatype out_numMatches;
  tmp1 = mmc_unbox_integer(_maxMatches);
  tmp2 = mmc_unbox_integer(_extended);
  tmp3 = mmc_unbox_integer(_caseInsensitive);
  _numMatches = omc_OpenModelica_Scripting_regex(threadData, _str, _re, tmp1, tmp2, tmp3, &_matchedSubstrings);
  out_numMatches = mmc_mk_icon(_numMatches);
  if (out_matchedSubstrings) { *out_matchedSubstrings = mmc_mk_modelica_array(_matchedSubstrings); }
  return out_numMatches;
}
DLLExport
modelica_boolean omc_OpenModelica_Scripting_regexBool(threadData_t *threadData, modelica_string _str, modelica_string _re, modelica_boolean _extended, modelica_boolean _caseInsensitive)
{
  modelica_boolean _matches;
  modelica_integer _numMatches;
  _tailrecursive: OMC_LABEL_UNUSED
  TRACE_PUSH
  _numMatches = omc_OpenModelica_Scripting_regex(threadData, _str, _re, (modelica_integer) 0, _extended, _caseInsensitive, NULL);

  _matches = ((modelica_integer)_numMatches == (modelica_integer) 1);
  _return: OMC_LABEL_UNUSED
  TRACE_POP
  return _matches;
}
modelica_metatype boxptr_OpenModelica_Scripting_regexBool(threadData_t *threadData, modelica_metatype _str, modelica_metatype _re, modelica_metatype _extended, modelica_metatype _caseInsensitive)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_boolean _matches;
  modelica_metatype out_matches;
  tmp1 = mmc_unbox_integer(_extended);
  tmp2 = mmc_unbox_integer(_caseInsensitive);
  _matches = omc_OpenModelica_Scripting_regexBool(threadData, _str, _re, tmp1, tmp2);
  out_matches = mmc_mk_icon(_matches);
  return out_matches;
}
DLLExport
modelica_boolean omc_OpenModelica_Scripting_regularFileExists(threadData_t *threadData, modelica_string _fileName)
{
  modelica_boolean _exists;
  _tailrecursive: OMC_LABEL_UNUSED
  TRACE_PUSH
  _exists = (omc_OpenModelica_Scripting_Internal_stat(threadData, _fileName) == 2);
  _return: OMC_LABEL_UNUSED
  TRACE_POP
  return _exists;
}
modelica_metatype boxptr_OpenModelica_Scripting_regularFileExists(threadData_t *threadData, modelica_metatype _fileName)
{
  modelica_boolean _exists;
  modelica_metatype out_exists;
  _exists = omc_OpenModelica_Scripting_regularFileExists(threadData, _fileName);
  out_exists = mmc_mk_icon(_exists);
  return out_exists;
}

