#include "ICSolar.ICS_Skeleton_functions.h"
#ifdef __cplusplus
extern "C" {
#endif

#include "ICSolar.ICS_Skeleton_literals.h"

void omc_Modelica_Blocks_Types_ExternalCombiTable2D_destructor(threadData_t *threadData, modelica_complex _externalCombiTable2D)
{
  /* functionBodyExternalFunction: varDecls */
  void * _externalCombiTable2D_ext;
  /* functionBodyExternalFunction: preExp */
  /* functionBodyExternalFunction: outputAlloc */
  /* functionBodyExternalFunction: callPart */
  _externalCombiTable2D_ext = (void *)_externalCombiTable2D;
  ModelicaStandardTables_CombiTable2D_close(_externalCombiTable2D_ext);
  /* functionBodyExternalFunction: return */
  return ;
}

Modelica_Blocks_Tables_CombiTable1Ds_getTableValue_rettype omc_Modelica_Blocks_Tables_CombiTable1Ds_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_integer _icol, modelica_real _u, modelica_real _tableAvailable)
{
  /* functionBodyExternalFunction: varDecls */
  Modelica_Blocks_Tables_CombiTable1Ds_getTableValue_rettype out;
  void * _tableID_ext;
  int _icol_ext;
  double _u_ext;
  double _y_ext;
  /* functionBodyExternalFunction: preExp */
  /* functionBodyExternalFunction: outputAlloc */
  /* functionBodyExternalFunction: callPart */
  _tableID_ext = (void *)_tableID;
  _icol_ext = (int)_icol;
  _u_ext = (double)_u;
  _y_ext = ModelicaStandardTables_CombiTable1D_getValue(_tableID_ext, _icol_ext, _u_ext);
  out.c1 = (modelica_real)_y_ext;
  /* functionBodyExternalFunction: return */
  return out;
}

Modelica_Blocks_Sources_CombiTimeTable_getTableValue_rettype omc_Modelica_Blocks_Sources_CombiTimeTable_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_integer _icol, modelica_real _timeIn, modelica_real _nextTimeEvent, modelica_real _pre_nextTimeEvent, modelica_real _tableAvailable)
{
  /* functionBodyExternalFunction: varDecls */
  Modelica_Blocks_Sources_CombiTimeTable_getTableValue_rettype out;
  void * _tableID_ext;
  int _icol_ext;
  double _timeIn_ext;
  double _nextTimeEvent_ext;
  double _pre_nextTimeEvent_ext;
  double _y_ext;
  /* functionBodyExternalFunction: preExp */
  /* functionBodyExternalFunction: outputAlloc */
  /* functionBodyExternalFunction: callPart */
  _tableID_ext = (void *)_tableID;
  _icol_ext = (int)_icol;
  _timeIn_ext = (double)_timeIn;
  _nextTimeEvent_ext = (double)_nextTimeEvent;
  _pre_nextTimeEvent_ext = (double)_pre_nextTimeEvent;
  _y_ext = ModelicaStandardTables_CombiTimeTable_getValue(_tableID_ext, _icol_ext, _timeIn_ext, _nextTimeEvent_ext, _pre_nextTimeEvent_ext);
  out.c1 = (modelica_real)_y_ext;
  /* functionBodyExternalFunction: return */
  return out;
}

Modelica_Blocks_Sources_CombiTimeTable_getNextTimeEvent_rettype omc_Modelica_Blocks_Sources_CombiTimeTable_getNextTimeEvent(threadData_t *threadData, modelica_complex _tableID, modelica_real _timeIn, modelica_real _tableAvailable)
{
  /* functionBodyExternalFunction: varDecls */
  Modelica_Blocks_Sources_CombiTimeTable_getNextTimeEvent_rettype out;
  void * _tableID_ext;
  double _timeIn_ext;
  double _nextTimeEvent_ext;
  /* functionBodyExternalFunction: preExp */
  /* functionBodyExternalFunction: outputAlloc */
  /* functionBodyExternalFunction: callPart */
  _tableID_ext = (void *)_tableID;
  _timeIn_ext = (double)_timeIn;
  _nextTimeEvent_ext = ModelicaStandardTables_CombiTimeTable_nextTimeEvent(_tableID_ext, _timeIn_ext);
  out.c1 = (modelica_real)_nextTimeEvent_ext;
  /* functionBodyExternalFunction: return */
  return out;
}

DLLExport
Buildings_Utilities_Math_Functions_spliceFunction_rettype omc_Buildings_Utilities_Math_Functions_spliceFunction(threadData_t *threadData, modelica_real _pos, modelica_real _neg, modelica_real _x, modelica_real _deltax)
{
  /* functionBodyRegularFunction: arguments */
  /* functionBodyRegularFunction: locals */
  Buildings_Utilities_Math_Functions_spliceFunction_rettype tmp1;
  modelica_real _out;
  modelica_real _scaledX1;
  modelica_real _y;
  modelica_real _asin1;
  modelica_real tmp2;
  modelica_real tmp3;
  _tailrecursive: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out inits */
  /* functionBodyRegularFunction: var inits */
  _asin1 = 1.570796326794897;
  /* functionBodyRegularFunction: body */
  _scaledX1 = (_x / _deltax);

  if((_scaledX1 <= -0.999999999))
  {
    _out = _neg;
  }
  else
  {
    if((_scaledX1 >= 0.999999999))
    {
      _out = _pos;
    }
    else
    {
      tmp2 = tan((1.570796326794897 * _scaledX1));
      tmp3 = tanh(tmp2);
      _y = (0.5 + (0.5 * tmp3));

      _out = ((_pos * _y) + ((1.0 - _y) * _neg));
    }
  }
  _return: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out var copy */
  /* functionBodyRegularFunction: out var assign */
  tmp1.c1 = _out;
  /* GC: pop the mark! */
  /* functionBodyRegularFunction: return the outs */
  return  tmp1;
}

DLLExport
Buildings_Utilities_Math_Functions_smoothMax_rettype omc_Buildings_Utilities_Math_Functions_smoothMax(threadData_t *threadData, modelica_real _x1, modelica_real _x2, modelica_real _deltaX)
{
  /* functionBodyRegularFunction: arguments */
  /* functionBodyRegularFunction: locals */
  Buildings_Utilities_Math_Functions_smoothMax_rettype tmp1;
  modelica_real _y;
  Buildings_Utilities_Math_Functions_spliceFunction_rettype tmp2;
  _tailrecursive: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out inits */
  /* functionBodyRegularFunction: var inits */
  /* functionBodyRegularFunction: body */
  tmp2 = omc_Buildings_Utilities_Math_Functions_spliceFunction(threadData, _x1, _x2, (_x1 - _x2), _deltaX);
  _y = tmp2.c1;
  _return: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out var copy */
  /* functionBodyRegularFunction: out var assign */
  tmp1.c1 = _y;
  /* GC: pop the mark! */
  /* functionBodyRegularFunction: return the outs */
  return  tmp1;
}

DLLExport
Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_loadResource_rettype omc_Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_loadResource(threadData_t *threadData, modelica_string _name)
{
  /* functionBodyRegularFunction: arguments */
  /* functionBodyRegularFunction: locals */
  Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_loadResource_rettype tmp1;
  modelica_string _path;
  ModelicaServices_ExternalReferences_loadResource_rettype tmp2;
  Modelica_Utilities_Strings_length_rettype tmp3;
  Modelica_Utilities_Files_fullPathName_rettype tmp4;
  _tailrecursive: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out inits */
  /* functionBodyRegularFunction: var inits */
  /* functionBodyRegularFunction: body */
  tmp2 = omc_ModelicaServices_ExternalReferences_loadResource(threadData, _name);
  _path = tmp2.c1;

  tmp3 = omc_Modelica_Utilities_Strings_length(threadData, _path);
  if((tmp3.c1 > (modelica_integer) 0))
  {
    tmp4 = omc_Modelica_Utilities_Files_fullPathName(threadData, _path);
    _path = tmp4.c1;
  }
  _return: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out var copy */
  /* functionBodyRegularFunction: out var assign */
  tmp1.c1 = _path;
  /* GC: pop the mark! */
  /* functionBodyRegularFunction: return the outs */
  return  tmp1;
}

DLLExport
Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_rettype omc_Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath(threadData_t *threadData, modelica_string _uri)
{
  /* functionBodyRegularFunction: arguments */
  /* functionBodyRegularFunction: locals */
  Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_rettype tmp1;
  modelica_string _path;
  Modelica_Utilities_Strings_find_rettype tmp2;
  Modelica_Utilities_Strings_find_rettype tmp3;
  modelica_string tmp4;
  Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_loadResource_rettype tmp5;
  Modelica_Utilities_Files_exist_rettype tmp6;
  modelica_string tmp7;
  Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_loadResource_rettype tmp8;
  Modelica_Utilities_Files_exist_rettype tmp9;
  modelica_string tmp10;
  Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_loadResource_rettype tmp11;
  Modelica_Utilities_Files_exist_rettype tmp12;
  modelica_string tmp13;
  modelica_string tmp14;
  modelica_string tmp15;
  modelica_string tmp16;
  modelica_string tmp17;
  modelica_string tmp18;
  modelica_string tmp19;
  ModelicaServices_ExternalReferences_loadResource_rettype tmp20;
  Modelica_Utilities_Files_fullPathName_rettype tmp21;
  Modelica_Utilities_Files_exist_rettype tmp22;
  modelica_string tmp23;
  modelica_string tmp24;
  _tailrecursive: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out inits */
  /* functionBodyRegularFunction: var inits */
  /* functionBodyRegularFunction: body */
  tmp2 = omc_Modelica_Utilities_Strings_find(threadData, _uri, _OMC_LIT4, (modelica_integer) 1, (0));
  tmp3 = omc_Modelica_Utilities_Strings_find(threadData, _uri, _OMC_LIT5, (modelica_integer) 1, (0));
  if(((tmp2.c1 == (modelica_integer) 0) && (tmp3.c1 == (modelica_integer) 0)))
  {
    tmp4 = cat_modelica_string(_OMC_LIT4,_uri);
    tmp5 = omc_Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_loadResource(threadData, tmp4);
    _path = tmp5.c1;

    tmp6 = omc_Modelica_Utilities_Files_exist(threadData, _path);
    if((!tmp6.c1))
    {
      tmp7 = cat_modelica_string(_OMC_LIT5,_uri);
      tmp8 = omc_Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_loadResource(threadData, tmp7);
      _path = tmp8.c1;

      tmp9 = omc_Modelica_Utilities_Files_exist(threadData, _path);
      if((!tmp9.c1))
      {
        tmp10 = cat_modelica_string(_OMC_LIT6,_uri);
        tmp11 = omc_Buildings_BoundaryConditions_WeatherData_BaseClasses_getAbsolutePath_loadResource(threadData, tmp10);
        _path = tmp11.c1;

        tmp12 = omc_Modelica_Utilities_Files_exist(threadData, _path);
        if(!tmp12.c1)
        {
            tmp13 = cat_modelica_string(_OMC_LIT2,_uri);
            tmp14 = cat_modelica_string(tmp13,_OMC_LIT7);
            tmp15 = cat_modelica_string(tmp14,_uri);
            tmp16 = cat_modelica_string(tmp15,_OMC_LIT8);
            tmp17 = cat_modelica_string(tmp16,_uri);
            tmp18 = cat_modelica_string(tmp17,_OMC_LIT9);
            tmp19 = cat_modelica_string(tmp18,_uri);
            FILE_INFO info = {"C:\\OpenModelica1.9.1Beta2\\lib\\omlibrary\\Buildings 1.6\\BoundaryConditions\\WeatherData\\BaseClasses\\getAbsolutePath.mo",32,9,35,57,0};
            omc_assert(threadData, info, tmp19);
        }
      }
    }
  }
  else
  {
    tmp20 = omc_ModelicaServices_ExternalReferences_loadResource(threadData, _uri);
    _path = tmp20.c1;

    tmp21 = omc_Modelica_Utilities_Files_fullPathName(threadData, _path);
    _path = tmp21.c1;

    tmp22 = omc_Modelica_Utilities_Files_exist(threadData, _path);
    if(!tmp22.c1)
    {
        tmp23 = cat_modelica_string(_OMC_LIT2,_uri);
        tmp24 = cat_modelica_string(tmp23,_OMC_LIT3);
        FILE_INFO info = {"C:\\OpenModelica1.9.1Beta2\\lib\\omlibrary\\Buildings 1.6\\BoundaryConditions\\WeatherData\\BaseClasses\\getAbsolutePath.mo",42,5,42,87,0};
        omc_assert(threadData, info, tmp24);
    }
  }
  _return: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out var copy */
  /* functionBodyRegularFunction: out var assign */
  tmp1.c1 = _path;
  /* GC: pop the mark! */
  /* functionBodyRegularFunction: return the outs */
  return  tmp1;
}

DLLExport
Buildings_Utilities_Math_Functions_smoothLimit_rettype omc_Buildings_Utilities_Math_Functions_smoothLimit(threadData_t *threadData, modelica_real _x, modelica_real _l, modelica_real _u, modelica_real _deltaX)
{
  /* functionBodyRegularFunction: arguments */
  /* functionBodyRegularFunction: locals */
  Buildings_Utilities_Math_Functions_smoothLimit_rettype tmp1;
  modelica_real _y;
  modelica_real _cor;
  Buildings_Utilities_Math_Functions_smoothMax_rettype tmp2;
  Buildings_Utilities_Math_Functions_smoothMin_rettype tmp3;
  _tailrecursive: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out inits */
  /* functionBodyRegularFunction: var inits */
  /* functionBodyRegularFunction: body */
  _cor = (0.1 * _deltaX);

  tmp2 = omc_Buildings_Utilities_Math_Functions_smoothMax(threadData, _x, (_l + _deltaX), _cor);
  _y = tmp2.c1;

  tmp3 = omc_Buildings_Utilities_Math_Functions_smoothMin(threadData, _y, (_u - _deltaX), _cor);
  _y = tmp3.c1;
  _return: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out var copy */
  /* functionBodyRegularFunction: out var assign */
  tmp1.c1 = _y;
  /* GC: pop the mark! */
  /* functionBodyRegularFunction: return the outs */
  return  tmp1;
}

DLLExport
Buildings_Utilities_Math_Functions_smoothMin_rettype omc_Buildings_Utilities_Math_Functions_smoothMin(threadData_t *threadData, modelica_real _x1, modelica_real _x2, modelica_real _deltaX)
{
  /* functionBodyRegularFunction: arguments */
  /* functionBodyRegularFunction: locals */
  Buildings_Utilities_Math_Functions_smoothMin_rettype tmp1;
  modelica_real _y;
  Buildings_Utilities_Math_Functions_spliceFunction_rettype tmp2;
  _tailrecursive: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out inits */
  /* functionBodyRegularFunction: var inits */
  /* functionBodyRegularFunction: body */
  tmp2 = omc_Buildings_Utilities_Math_Functions_spliceFunction(threadData, _x1, _x2, (_x2 - _x1), _deltaX);
  _y = tmp2.c1;
  _return: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out var copy */
  /* functionBodyRegularFunction: out var assign */
  tmp1.c1 = _y;
  /* GC: pop the mark! */
  /* functionBodyRegularFunction: return the outs */
  return  tmp1;
}

Modelica_Blocks_Sources_CombiTimeTable_getDerTableValue_rettype omc_Modelica_Blocks_Sources_CombiTimeTable_getDerTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_integer _icol, modelica_real _timeIn, modelica_real _nextTimeEvent, modelica_real _pre_nextTimeEvent, modelica_real _tableAvailable, modelica_real _der_timeIn)
{
  /* functionBodyExternalFunction: varDecls */
  Modelica_Blocks_Sources_CombiTimeTable_getDerTableValue_rettype out;
  void * _tableID_ext;
  int _icol_ext;
  double _timeIn_ext;
  double _nextTimeEvent_ext;
  double _pre_nextTimeEvent_ext;
  double _der_timeIn_ext;
  double _der_y_ext;
  /* functionBodyExternalFunction: preExp */
  /* functionBodyExternalFunction: outputAlloc */
  /* functionBodyExternalFunction: callPart */
  _tableID_ext = (void *)_tableID;
  _icol_ext = (int)_icol;
  _timeIn_ext = (double)_timeIn;
  _nextTimeEvent_ext = (double)_nextTimeEvent;
  _pre_nextTimeEvent_ext = (double)_pre_nextTimeEvent;
  _der_timeIn_ext = (double)_der_timeIn;
  _der_y_ext = ModelicaStandardTables_CombiTimeTable_getDerValue(_tableID_ext, _icol_ext, _timeIn_ext, _nextTimeEvent_ext, _pre_nextTimeEvent_ext, _der_timeIn_ext);
  out.c1 = (modelica_real)_der_y_ext;
  /* functionBodyExternalFunction: return */
  return out;
}

Modelica_Blocks_Sources_CombiTimeTable_getTableTimeTmin_rettype omc_Modelica_Blocks_Sources_CombiTimeTable_getTableTimeTmin(threadData_t *threadData, modelica_complex _tableID, modelica_real _tableAvailable)
{
  /* functionBodyExternalFunction: varDecls */
  Modelica_Blocks_Sources_CombiTimeTable_getTableTimeTmin_rettype out;
  void * _tableID_ext;
  double _timeMin_ext;
  /* functionBodyExternalFunction: preExp */
  /* functionBodyExternalFunction: outputAlloc */
  /* functionBodyExternalFunction: callPart */
  _tableID_ext = (void *)_tableID;
  _timeMin_ext = ModelicaStandardTables_CombiTimeTable_minimumTime(_tableID_ext);
  out.c1 = (modelica_real)_timeMin_ext;
  /* functionBodyExternalFunction: return */
  return out;
}

Modelica_Blocks_Sources_CombiTimeTable_getTableTimeTmax_rettype omc_Modelica_Blocks_Sources_CombiTimeTable_getTableTimeTmax(threadData_t *threadData, modelica_complex _tableID, modelica_real _tableAvailable)
{
  /* functionBodyExternalFunction: varDecls */
  Modelica_Blocks_Sources_CombiTimeTable_getTableTimeTmax_rettype out;
  void * _tableID_ext;
  double _timeMax_ext;
  /* functionBodyExternalFunction: preExp */
  /* functionBodyExternalFunction: outputAlloc */
  /* functionBodyExternalFunction: callPart */
  _tableID_ext = (void *)_tableID;
  _timeMax_ext = ModelicaStandardTables_CombiTimeTable_maximumTime(_tableID_ext);
  out.c1 = (modelica_real)_timeMax_ext;
  /* functionBodyExternalFunction: return */
  return out;
}

Modelica_Blocks_Sources_CombiTimeTable_getTableValueNoDer_rettype omc_Modelica_Blocks_Sources_CombiTimeTable_getTableValueNoDer(threadData_t *threadData, modelica_complex _tableID, modelica_integer _icol, modelica_real _timeIn, modelica_real _nextTimeEvent, modelica_real _pre_nextTimeEvent, modelica_real _tableAvailable)
{
  /* functionBodyExternalFunction: varDecls */
  Modelica_Blocks_Sources_CombiTimeTable_getTableValueNoDer_rettype out;
  void * _tableID_ext;
  int _icol_ext;
  double _timeIn_ext;
  double _nextTimeEvent_ext;
  double _pre_nextTimeEvent_ext;
  double _y_ext;
  /* functionBodyExternalFunction: preExp */
  /* functionBodyExternalFunction: outputAlloc */
  /* functionBodyExternalFunction: callPart */
  _tableID_ext = (void *)_tableID;
  _icol_ext = (int)_icol;
  _timeIn_ext = (double)_timeIn;
  _nextTimeEvent_ext = (double)_nextTimeEvent;
  _pre_nextTimeEvent_ext = (double)_pre_nextTimeEvent;
  _y_ext = ModelicaStandardTables_CombiTimeTable_getValue(_tableID_ext, _icol_ext, _timeIn_ext, _nextTimeEvent_ext, _pre_nextTimeEvent_ext);
  out.c1 = (modelica_real)_y_ext;
  /* functionBodyExternalFunction: return */
  return out;
}

Modelica_Blocks_Sources_CombiTimeTable_readTableData_rettype omc_Modelica_Blocks_Sources_CombiTimeTable_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  /* functionBodyExternalFunction: varDecls */
  Modelica_Blocks_Sources_CombiTimeTable_readTableData_rettype out;
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  /* functionBodyExternalFunction: preExp */
  /* functionBodyExternalFunction: outputAlloc */
  /* functionBodyExternalFunction: callPart */
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTimeTable_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  out.c1 = (modelica_real)_readSuccess_ext;
  /* functionBodyExternalFunction: return */
  return out;
}

Modelica_Blocks_Tables_CombiTable2D_readTableData_rettype omc_Modelica_Blocks_Tables_CombiTable2D_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  /* functionBodyExternalFunction: varDecls */
  Modelica_Blocks_Tables_CombiTable2D_readTableData_rettype out;
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  /* functionBodyExternalFunction: preExp */
  /* functionBodyExternalFunction: outputAlloc */
  /* functionBodyExternalFunction: callPart */
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable2D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  out.c1 = (modelica_real)_readSuccess_ext;
  /* functionBodyExternalFunction: return */
  return out;
}

Modelica_Blocks_Tables_CombiTable1Ds_readTableData_rettype omc_Modelica_Blocks_Tables_CombiTable1Ds_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  /* functionBodyExternalFunction: varDecls */
  Modelica_Blocks_Tables_CombiTable1Ds_readTableData_rettype out;
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  /* functionBodyExternalFunction: preExp */
  /* functionBodyExternalFunction: outputAlloc */
  /* functionBodyExternalFunction: callPart */
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable1D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  out.c1 = (modelica_real)_readSuccess_ext;
  /* functionBodyExternalFunction: return */
  return out;
}

Modelica_Blocks_Tables_CombiTable2D_getTableValue_rettype omc_Modelica_Blocks_Tables_CombiTable2D_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable)
{
  /* functionBodyExternalFunction: varDecls */
  Modelica_Blocks_Tables_CombiTable2D_getTableValue_rettype out;
  void * _tableID_ext;
  double _u1_ext;
  double _u2_ext;
  double _y_ext;
  /* functionBodyExternalFunction: preExp */
  /* functionBodyExternalFunction: outputAlloc */
  /* functionBodyExternalFunction: callPart */
  _tableID_ext = (void *)_tableID;
  _u1_ext = (double)_u1;
  _u2_ext = (double)_u2;
  _y_ext = ModelicaStandardTables_CombiTable2D_getValue(_tableID_ext, _u1_ext, _u2_ext);
  out.c1 = (modelica_real)_y_ext;
  /* functionBodyExternalFunction: return */
  return out;
}

void omc_Modelica_Blocks_Types_ExternalCombiTable1D_destructor(threadData_t *threadData, modelica_complex _externalCombiTable1D)
{
  /* functionBodyExternalFunction: varDecls */
  void * _externalCombiTable1D_ext;
  /* functionBodyExternalFunction: preExp */
  /* functionBodyExternalFunction: outputAlloc */
  /* functionBodyExternalFunction: callPart */
  _externalCombiTable1D_ext = (void *)_externalCombiTable1D;
  ModelicaStandardTables_CombiTable1D_close(_externalCombiTable1D_ext);
  /* functionBodyExternalFunction: return */
  return ;
}

Modelica_Blocks_Types_ExternalCombiTable1D_constructor_rettype omc_Modelica_Blocks_Types_ExternalCombiTable1D_constructor(threadData_t *threadData, modelica_string _tableName, modelica_string _fileName, real_array _table, integer_array _columns, modelica_integer _smoothness)
{
  /* functionBodyExternalFunction: varDecls */
  Modelica_Blocks_Types_ExternalCombiTable1D_constructor_rettype out;
  int _smoothness_ext;
  void * _externalCombiTable1D_ext;
  /* functionBodyExternalFunction: preExp */
  /* functionBodyExternalFunction: outputAlloc */
  /* functionBodyExternalFunction: callPart */
  pack_integer_array(&_columns);
  _smoothness_ext = (int)_smoothness;
  _externalCombiTable1D_ext = ModelicaStandardTables_CombiTable1D_init(_tableName, _fileName, (const double*) data_of_real_array(&(_table)), size_of_dimension_real_array(&_table, (modelica_integer) 1), size_of_dimension_real_array(&_table, (modelica_integer) 2), (const int*) data_of_integer_array(&(_columns)), size_of_dimension_integer_array(&_columns, (modelica_integer) 1), _smoothness_ext);
  out.c1 = (modelica_complex)_externalCombiTable1D_ext;
  /* functionBodyExternalFunction: return */
  return out;
}

Modelica_Blocks_Types_ExternalCombiTable2D_constructor_rettype omc_Modelica_Blocks_Types_ExternalCombiTable2D_constructor(threadData_t *threadData, modelica_string _tableName, modelica_string _fileName, real_array _table, modelica_integer _smoothness)
{
  /* functionBodyExternalFunction: varDecls */
  Modelica_Blocks_Types_ExternalCombiTable2D_constructor_rettype out;
  int _smoothness_ext;
  void * _externalCombiTable2D_ext;
  /* functionBodyExternalFunction: preExp */
  /* functionBodyExternalFunction: outputAlloc */
  /* functionBodyExternalFunction: callPart */
  _smoothness_ext = (int)_smoothness;
  _externalCombiTable2D_ext = ModelicaStandardTables_CombiTable2D_init(_tableName, _fileName, (const double*) data_of_real_array(&(_table)), size_of_dimension_real_array(&_table, (modelica_integer) 1), size_of_dimension_real_array(&_table, (modelica_integer) 2), _smoothness_ext);
  out.c1 = (modelica_complex)_externalCombiTable2D_ext;
  /* functionBodyExternalFunction: return */
  return out;
}

Modelica_Thermal_FluidHeatFlow_Media_Water_rettype omc_Modelica_Thermal_FluidHeatFlow_Media_Water(threadData_t *threadData, modelica_real rho, modelica_real cp, modelica_real cv, modelica_real lamda, modelica_real nue)
{
  Modelica_Thermal_FluidHeatFlow_Media_Water_rettype tmp1;
  Modelica_Thermal_FluidHeatFlow_Media_Water tmp2;
  tmp2._rho = rho;
  tmp2._cp = cp;
  tmp2._cv = cv;
  tmp2._lamda = lamda;
  tmp2._nue = nue;
  tmp1.c1 = tmp2;
  return tmp1;
}






void omc_Modelica_Blocks_Types_ExternalCombiTimeTable_destructor(threadData_t *threadData, modelica_complex _externalCombiTimeTable)
{
  /* functionBodyExternalFunction: varDecls */
  void * _externalCombiTimeTable_ext;
  /* functionBodyExternalFunction: preExp */
  /* functionBodyExternalFunction: outputAlloc */
  /* functionBodyExternalFunction: callPart */
  _externalCombiTimeTable_ext = (void *)_externalCombiTimeTable;
  ModelicaStandardTables_CombiTimeTable_close(_externalCombiTimeTable_ext);
  /* functionBodyExternalFunction: return */
  return ;
}

Modelica_Blocks_Types_ExternalCombiTimeTable_constructor_rettype omc_Modelica_Blocks_Types_ExternalCombiTimeTable_constructor(threadData_t *threadData, modelica_string _tableName, modelica_string _fileName, real_array _table, modelica_real _startTime, integer_array _columns, modelica_integer _smoothness, modelica_integer _extrapolation)
{
  /* functionBodyExternalFunction: varDecls */
  Modelica_Blocks_Types_ExternalCombiTimeTable_constructor_rettype out;
  double _startTime_ext;
  int _smoothness_ext;
  int _extrapolation_ext;
  void * _externalCombiTimeTable_ext;
  /* functionBodyExternalFunction: preExp */
  /* functionBodyExternalFunction: outputAlloc */
  /* functionBodyExternalFunction: callPart */
  _startTime_ext = (double)_startTime;
  pack_integer_array(&_columns);
  _smoothness_ext = (int)_smoothness;
  _extrapolation_ext = (int)_extrapolation;
  _externalCombiTimeTable_ext = ModelicaStandardTables_CombiTimeTable_init(_tableName, _fileName, (const double*) data_of_real_array(&(_table)), size_of_dimension_real_array(&_table, (modelica_integer) 1), size_of_dimension_real_array(&_table, (modelica_integer) 2), _startTime_ext, (const int*) data_of_integer_array(&(_columns)), size_of_dimension_integer_array(&_columns, (modelica_integer) 1), _smoothness_ext, _extrapolation_ext);
  out.c1 = (modelica_complex)_externalCombiTimeTable_ext;
  /* functionBodyExternalFunction: return */
  return out;
}

Modelica_Thermal_FluidHeatFlow_Media_Medium_rettype omc_Modelica_Thermal_FluidHeatFlow_Media_Medium(threadData_t *threadData, modelica_real rho, modelica_real cp, modelica_real cv, modelica_real lamda, modelica_real nue)
{
  Modelica_Thermal_FluidHeatFlow_Media_Medium_rettype tmp1;
  Modelica_Thermal_FluidHeatFlow_Media_Medium tmp2;
  tmp2._rho = rho;
  tmp2._cp = cp;
  tmp2._cv = cv;
  tmp2._lamda = lamda;
  tmp2._nue = nue;
  tmp1.c1 = tmp2;
  return tmp1;
}






DLLExport
OpenModelica_Scripting_regexBool_rettype omc_OpenModelica_Scripting_regexBool(threadData_t *threadData, modelica_string _str, modelica_string _re, modelica_boolean _extended, modelica_boolean _caseInsensitive)
{
  /* functionBodyRegularFunction: arguments */
  /* functionBodyRegularFunction: locals */
  OpenModelica_Scripting_regexBool_rettype tmp1;
  modelica_boolean _matches;
  modelica_integer _numMatches;
  OpenModelica_Scripting_regex_rettype tmp2;
  _tailrecursive: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out inits */
  /* functionBodyRegularFunction: var inits */
  /* functionBodyRegularFunction: body */
  tmp2 = omc_OpenModelica_Scripting_regex(threadData, _str, _re, (modelica_integer) 0, _extended, _caseInsensitive);
  _numMatches = tmp2.c1;
  

  _matches = ((modelica_integer)_numMatches == (modelica_integer) 1);
  _return: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out var copy */
  /* functionBodyRegularFunction: out var assign */
  tmp1.c1 = _matches;
  /* GC: pop the mark! */
  /* functionBodyRegularFunction: return the outs */
  return  tmp1;
}

OpenModelica_Scripting_Internal_stat_rettype omc_OpenModelica_Scripting_Internal_stat(threadData_t *threadData, modelica_string _name)
{
  /* functionBodyExternalFunction: varDecls */
  OpenModelica_Scripting_Internal_stat_rettype out;
  int _fileType_ext;
  /* functionBodyExternalFunction: preExp */
  /* functionBodyExternalFunction: outputAlloc */
  /* functionBodyExternalFunction: callPart */
  _fileType_ext = ModelicaInternal_stat(_name);
  out.c1 = (modelica_integer)_fileType_ext;
  /* functionBodyExternalFunction: return */
  return out;
}

Modelica_Utilities_Internal_FileSystem_stat_rettype omc_Modelica_Utilities_Internal_FileSystem_stat(threadData_t *threadData, modelica_string _name)
{
  /* functionBodyExternalFunction: varDecls */
  Modelica_Utilities_Internal_FileSystem_stat_rettype out;
  int _fileType_ext;
  /* functionBodyExternalFunction: preExp */
  /* functionBodyExternalFunction: outputAlloc */
  /* functionBodyExternalFunction: callPart */
  _fileType_ext = ModelicaInternal_stat(_name);
  out.c1 = (modelica_integer)_fileType_ext;
  /* functionBodyExternalFunction: return */
  return out;
}

Modelica_Utilities_Files_fullPathName_rettype omc_Modelica_Utilities_Files_fullPathName(threadData_t *threadData, modelica_string _name)
{
  /* functionBodyExternalFunction: varDecls */
  Modelica_Utilities_Files_fullPathName_rettype out;
  const char* _fullName_ext;
  /* functionBodyExternalFunction: preExp */
  /* functionBodyExternalFunction: outputAlloc */
  /* functionBodyExternalFunction: callPart */
  _fullName_ext = ModelicaInternal_fullPathName(_name);
  out.c1 = (modelica_string)_fullName_ext;
  /* functionBodyExternalFunction: return */
  return out;
}

DLLExport
Modelica_Utilities_Files_exist_rettype omc_Modelica_Utilities_Files_exist(threadData_t *threadData, modelica_string _name)
{
  /* functionBodyRegularFunction: arguments */
  /* functionBodyRegularFunction: locals */
  Modelica_Utilities_Files_exist_rettype tmp1;
  modelica_boolean _result;
  Modelica_Utilities_Internal_FileSystem_stat_rettype tmp2;
  _tailrecursive: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out inits */
  /* functionBodyRegularFunction: var inits */
  /* functionBodyRegularFunction: body */
  tmp2 = omc_Modelica_Utilities_Internal_FileSystem_stat(threadData, _name);
  _result = (tmp2.c1 > 1);
  _return: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out var copy */
  /* functionBodyRegularFunction: out var assign */
  tmp1.c1 = _result;
  /* GC: pop the mark! */
  /* functionBodyRegularFunction: return the outs */
  return  tmp1;
}

DLLExport
ModelicaServices_ExternalReferences_loadResource_rettype omc_ModelicaServices_ExternalReferences_loadResource(threadData_t *threadData, modelica_string _uri)
{
  /* functionBodyRegularFunction: arguments */
  /* functionBodyRegularFunction: locals */
  ModelicaServices_ExternalReferences_loadResource_rettype tmp1;
  modelica_string _fileReference;
  OpenModelica_Scripting_uriToFilename_rettype tmp2;
  _tailrecursive: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out inits */
  /* functionBodyRegularFunction: var inits */
  /* functionBodyRegularFunction: body */
  tmp2 = omc_OpenModelica_Scripting_uriToFilename(threadData, _uri);
  _fileReference = tmp2.c1;
  
  _return: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out var copy */
  /* functionBodyRegularFunction: out var assign */
  tmp1.c1 = _fileReference;
  /* GC: pop the mark! */
  /* functionBodyRegularFunction: return the outs */
  return  tmp1;
}

Modelica_Utilities_Strings_length_rettype omc_Modelica_Utilities_Strings_length(threadData_t *threadData, modelica_string _string)
{
  /* functionBodyExternalFunction: varDecls */
  Modelica_Utilities_Strings_length_rettype out;
  int _result_ext;
  /* functionBodyExternalFunction: preExp */
  /* functionBodyExternalFunction: outputAlloc */
  /* functionBodyExternalFunction: callPart */
  _result_ext = ModelicaStrings_length(_string);
  out.c1 = (modelica_integer)_result_ext;
  /* functionBodyExternalFunction: return */
  return out;
}

DLLExport
Modelica_Utilities_Strings_find_rettype omc_Modelica_Utilities_Strings_find(threadData_t *threadData, modelica_string _string, modelica_string _searchString, modelica_integer _startIndex, modelica_boolean _caseSensitive)
{
  /* functionBodyRegularFunction: arguments */
  /* functionBodyRegularFunction: locals */
  Modelica_Utilities_Strings_find_rettype tmp1;
  modelica_integer _index;
  modelica_integer _lengthSearchString;
  Modelica_Utilities_Strings_length_rettype tmp2;
  modelica_integer _len;
  modelica_integer _i;
  modelica_integer _i_max;
  Modelica_Utilities_Strings_length_rettype tmp3;
  Modelica_Utilities_Strings_substring_rettype tmp4;
  Modelica_Utilities_Strings_isEqual_rettype tmp5;
  _tailrecursive: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out inits */
  /* functionBodyRegularFunction: var inits */
  tmp2 = omc_Modelica_Utilities_Strings_length(threadData, _searchString);
  _lengthSearchString = tmp2.c1;
  _len = ((modelica_integer)_lengthSearchString + (modelica_integer) -1);
  _i = (modelica_integer)_startIndex;
  tmp3 = omc_Modelica_Utilities_Strings_length(threadData, _string);
  _i_max = ((modelica_integer) 1 + (tmp3.c1 - (modelica_integer)_lengthSearchString));
  /* functionBodyRegularFunction: body */
  _index = (modelica_integer) 0;

  while(1)
  {
    if(!((modelica_integer)_i <= (modelica_integer)_i_max)) break;
    tmp4 = omc_Modelica_Utilities_Strings_substring(threadData, _string, (modelica_integer)_i, ((modelica_integer)_i + (modelica_integer)_len));
    tmp5 = omc_Modelica_Utilities_Strings_isEqual(threadData, tmp4.c1, _searchString, _caseSensitive);
    if(tmp5.c1)
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
  /* functionBodyRegularFunction: out var copy */
  /* functionBodyRegularFunction: out var assign */
  tmp1.c1 = _index;
  /* GC: pop the mark! */
  /* functionBodyRegularFunction: return the outs */
  return  tmp1;
}

Modelica_Utilities_Strings_compare_rettype omc_Modelica_Utilities_Strings_compare(threadData_t *threadData, modelica_string _string1, modelica_string _string2, modelica_boolean _caseSensitive)
{
  /* functionBodyExternalFunction: varDecls */
  Modelica_Utilities_Strings_compare_rettype out;
  int _caseSensitive_ext;
  int _result_ext;
  /* functionBodyExternalFunction: preExp */
  /* functionBodyExternalFunction: outputAlloc */
  /* functionBodyExternalFunction: callPart */
  _caseSensitive_ext = (int)_caseSensitive;
  _result_ext = ModelicaStrings_compare(_string1, _string2, _caseSensitive_ext);
  out.c1 = (modelica_integer)_result_ext;
  /* functionBodyExternalFunction: return */
  return out;
}

DLLExport
Modelica_Utilities_Strings_isEqual_rettype omc_Modelica_Utilities_Strings_isEqual(threadData_t *threadData, modelica_string _string1, modelica_string _string2, modelica_boolean _caseSensitive)
{
  /* functionBodyRegularFunction: arguments */
  /* functionBodyRegularFunction: locals */
  Modelica_Utilities_Strings_isEqual_rettype tmp1;
  modelica_boolean _identical;
  Modelica_Utilities_Strings_compare_rettype tmp2;
  _tailrecursive: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out inits */
  /* functionBodyRegularFunction: var inits */
  /* functionBodyRegularFunction: body */
  tmp2 = omc_Modelica_Utilities_Strings_compare(threadData, _string1, _string2, _caseSensitive);
  _identical = (tmp2.c1 == 2);
  _return: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out var copy */
  /* functionBodyRegularFunction: out var assign */
  tmp1.c1 = _identical;
  /* GC: pop the mark! */
  /* functionBodyRegularFunction: return the outs */
  return  tmp1;
}

Modelica_Utilities_Strings_substring_rettype omc_Modelica_Utilities_Strings_substring(threadData_t *threadData, modelica_string _string, modelica_integer _startIndex, modelica_integer _endIndex)
{
  /* functionBodyExternalFunction: varDecls */
  Modelica_Utilities_Strings_substring_rettype out;
  int _startIndex_ext;
  int _endIndex_ext;
  const char* _result_ext;
  /* functionBodyExternalFunction: preExp */
  /* functionBodyExternalFunction: outputAlloc */
  /* functionBodyExternalFunction: callPart */
  _startIndex_ext = (int)_startIndex;
  _endIndex_ext = (int)_endIndex;
  _result_ext = ModelicaStrings_substring(_string, _startIndex_ext, _endIndex_ext);
  out.c1 = (modelica_string)_result_ext;
  /* functionBodyExternalFunction: return */
  return out;
}

OpenModelica_Scripting_regex_rettype omc_OpenModelica_Scripting_regex(threadData_t *threadData, modelica_string _str, modelica_string _re, modelica_integer _maxMatches, modelica_boolean _extended, modelica_boolean _caseInsensitive)
{
  /* functionBodyExternalFunction: varDecls */
  OpenModelica_Scripting_regex_rettype out;
  int _maxMatches_ext;
  int _extended_ext;
  int _caseInsensitive_ext;
  int _numMatches_ext;
  /* functionBodyExternalFunction: preExp */
  /* functionBodyExternalFunction: outputAlloc */
  alloc_string_array(&out.c2, 1, (modelica_integer)_maxMatches);
  /* functionBodyExternalFunction: callPart */
  _maxMatches_ext = (int)_maxMatches;
  _extended_ext = (int)_extended;
  _caseInsensitive_ext = (int)_caseInsensitive;
  _numMatches_ext = OpenModelica_regex(_str, _re, _maxMatches_ext, _extended_ext, _caseInsensitive_ext, (const char**) data_of_string_array(&(out.c2)));
  out.c1 = (modelica_integer)_numMatches_ext;
  /* functionBodyExternalFunction: return */
  return out;
}

OpenModelica_Scripting_realpath_rettype omc_OpenModelica_Scripting_realpath(threadData_t *threadData, modelica_string _name)
{
  /* functionBodyExternalFunction: varDecls */
  OpenModelica_Scripting_realpath_rettype out;
  const char* _fullName_ext;
  /* functionBodyExternalFunction: preExp */
  /* functionBodyExternalFunction: outputAlloc */
  /* functionBodyExternalFunction: callPart */
  _fullName_ext = ModelicaInternal_fullPathName(_name);
  out.c1 = (modelica_string)_fullName_ext;
  /* functionBodyExternalFunction: return */
  return out;
}

DLLExport
OpenModelica_Scripting_directoryExists_rettype omc_OpenModelica_Scripting_directoryExists(threadData_t *threadData, modelica_string _dirName)
{
  /* functionBodyRegularFunction: arguments */
  /* functionBodyRegularFunction: locals */
  OpenModelica_Scripting_directoryExists_rettype tmp1;
  modelica_boolean _exists;
  OpenModelica_Scripting_Internal_stat_rettype tmp2;
  _tailrecursive: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out inits */
  /* functionBodyRegularFunction: var inits */
  /* functionBodyRegularFunction: body */
  tmp2 = omc_OpenModelica_Scripting_Internal_stat(threadData, _dirName);
  _exists = (tmp2.c1 == 3);
  _return: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out var copy */
  /* functionBodyRegularFunction: out var assign */
  tmp1.c1 = _exists;
  /* GC: pop the mark! */
  /* functionBodyRegularFunction: return the outs */
  return  tmp1;
}

DLLExport
OpenModelica_Scripting_uriToFilename_rettype omc_OpenModelica_Scripting_uriToFilename(threadData_t *threadData, modelica_string _uri)
{
  /* functionBodyRegularFunction: arguments */
  /* functionBodyRegularFunction: locals */
  OpenModelica_Scripting_uriToFilename_rettype tmp1;
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
  OpenModelica_Scripting_regexBool_rettype tmp2;
  OpenModelica_Scripting_regex_rettype tmp3;
  OpenModelica_Scripting_regexBool_rettype tmp4;
  OpenModelica_Scripting_regexBool_rettype tmp5;
  OpenModelica_Scripting_regexBool_rettype tmp6;
  modelica_integer tmp9;
  modelica_string tmp10;
  modelica_string tmp11;
  modelica_string tmp12;
  modelica_string tmp13;
  OpenModelica_Scripting_regex_rettype tmp14;
  modelica_string tmp15;
  modelica_string tmp16;
  OpenModelica_Scripting_directoryExists_rettype tmp17;
  modelica_string tmp18;
  modelica_string tmp19;
  OpenModelica_Scripting_realpath_rettype tmp20;
  modelica_integer tmp21;
  modelica_integer tmp22;
  modelica_integer tmp23;
  modelica_integer tmp26;
  modelica_string tmp27;
  modelica_string tmp28;
  modelica_boolean tmp29;
  modelica_string tmp30;
  OpenModelica_Scripting_regex_rettype tmp31;
  OpenModelica_Scripting_regex_rettype tmp32;
  OpenModelica_Scripting_realpath_rettype tmp33;
  modelica_string tmp34;
  modelica_string tmp35;
  modelica_string tmp36;
  OpenModelica_Scripting_regularFileExists_rettype tmp37;
  OpenModelica_Scripting_realpath_rettype tmp38;
  OpenModelica_Scripting_regexBool_rettype tmp39;
  OpenModelica_Scripting_realpath_rettype tmp40;
  modelica_string tmp41;
  modelica_string tmp42;
  modelica_boolean tmp43;
  modelica_string tmp44;
  modelica_boolean tmp45;
  modelica_string tmp46;
  _tailrecursive: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out inits */
  /* functionBodyRegularFunction: var inits */
  _filename = _OMC_LIT10;
  _message = _OMC_LIT10;
  alloc_string_array(&_libraries, 2, (modelica_integer) 99, (modelica_integer) 2);
  alloc_string_array(&_matches, 1, (modelica_integer) 99);
  alloc_string_array(&_matches2, 1, (modelica_integer) 99);
  _isMatch = (0);
  /* functionBodyRegularFunction: body */
  tmp2 = omc_OpenModelica_Scripting_regexBool(threadData, _uri, _OMC_LIT11, (1), (0));
  _isUri = tmp2.c1;

  if(_isUri)
  {
    tmp3 = omc_OpenModelica_Scripting_regex(threadData, _uri, _OMC_LIT15, (modelica_integer) 4, (1), (0));
    _numMatches = tmp3.c1;
    _matches = tmp3.c2;

    tmp4 = omc_OpenModelica_Scripting_regexBool(threadData, _uri, _OMC_LIT16, (1), (1));
    _isModelicaUri = tmp4.c1;

    tmp5 = omc_OpenModelica_Scripting_regexBool(threadData, _uri, _OMC_LIT17, (1), (1));
    _isFileUriAbsolute = tmp5.c1;

    tmp6 = omc_OpenModelica_Scripting_regexBool(threadData, _uri, _OMC_LIT18, (1), (1));
    _isFileUri = tmp6.c1;

    if(_isModelicaUri)
    {
      copy_string_array(&_OMC_LIT31, &_libraries);

      {
        string_array tmp7;
        int tmp8;
        modelica_integer _$reductionFoldTmpB;
        modelica_integer _$reductionFoldTmpA;
        tmp7 = _libraries;
        tmp8 = 1;
        _$reductionFoldTmpB = (modelica_integer) 0; /* defaultValue */
        while(tmp8 <= size_of_dimension_string_array(&tmp7, 1))
        {
          modelica_string _lib;
          _lib = *(string_array_element_addr1(&tmp7, 1, tmp8++));
          if(1)
          {
            _$reductionFoldTmpA = (modelica_integer) 1;
            _$reductionFoldTmpB = ((modelica_integer)_$reductionFoldTmpA + (modelica_integer)_$reductionFoldTmpB);
          }
        }
        tmp9 = _$reductionFoldTmpB;
      }
      if((tmp9 == (modelica_integer) 0))
      {
        _filename = _OMC_LIT10;

        goto _return;
      }

      _path =  (*string_array_element_addr(&_matches, 1, (modelica_integer) 2));

      if((stringEqual(_path, _OMC_LIT10)))
      {
        tmp10 = cat_modelica_string(_OMC_LIT32, (*string_array_element_addr(&_matches, 1, (modelica_integer) 2)));
        tmp11 = cat_modelica_string(tmp10,_OMC_LIT33);
        tmp12 = cat_modelica_string(tmp11, (*string_array_element_addr(&_matches, 1, (modelica_integer) 3)));
        tmp13 = cat_modelica_string(tmp12,_OMC_LIT34);
        _message = tmp13;

        goto _return;
      }

      while(1)
      {
        if(!(!stringEqual(_path, _OMC_LIT10))) break;
        tmp14 = omc_OpenModelica_Scripting_regex(threadData, _path, _OMC_LIT35, (modelica_integer) 3, (1), (0));
        _numMatches = tmp14.c1;
        _matches2 = tmp14.c2;

        _path =  (*string_array_element_addr(&_matches2, 1, (modelica_integer) 3));

        if(_isMatch)
        {
          tmp15 = cat_modelica_string(_filename,_OMC_LIT14);
          tmp16 = cat_modelica_string(tmp15, (*string_array_element_addr(&_matches2, 1, (modelica_integer) 2)));
          tmp17 = omc_OpenModelica_Scripting_directoryExists(threadData, tmp16);
          if(tmp17.c1)
          {
            tmp18 = cat_modelica_string(_filename,_OMC_LIT14);
            tmp19 = cat_modelica_string(tmp18, (*string_array_element_addr(&_matches2, 1, (modelica_integer) 2)));
            tmp20 = omc_OpenModelica_Scripting_realpath(threadData, tmp19);
            _filename = tmp20.c1;
          }
          else
          {
            break;
          }
        }
        else
        {
          {
            string_array tmp24;
            int tmp25;
            modelica_integer _$reductionFoldTmpB;
            modelica_integer _$reductionFoldTmpA;
            tmp24 = _libraries;
            tmp25 = 1;
            _$reductionFoldTmpB = (modelica_integer) 0; /* defaultValue */
            while(tmp25 <= size_of_dimension_string_array(&tmp24, 1))
            {
              modelica_string _lib;
              _lib = *(string_array_element_addr1(&tmp24, 1, tmp25++));
              if(1)
              {
                _$reductionFoldTmpA = (modelica_integer) 1;
                _$reductionFoldTmpB = ((modelica_integer)_$reductionFoldTmpA + (modelica_integer)_$reductionFoldTmpB);
              }
            }
            tmp26 = _$reductionFoldTmpB;
          }
          tmp21 = (modelica_integer) 1; tmp22 = (1); tmp23 = tmp26;
          if(!tmp22)
          {
            FILE_INFO info = omc_dummyFileInfo;
            omc_assert(threadData, info, "assertion range step != 0 failed");
          }
          else if(!(((tmp22 > 0) && (tmp21 > tmp23)) || ((tmp22 < 0) && (tmp21 < tmp23))))
          {
            modelica_integer _i;
            for(_i = (modelica_integer) 1; in_range_integer(_i, tmp21, tmp23); _i += tmp22)
            {
              if((stringEqual( (*string_array_element_addr(&_libraries, 2, (modelica_integer)_i, (modelica_integer) 1)),  (*string_array_element_addr(&_matches2, 1, (modelica_integer) 2)))))
              {
                _filename =  (*string_array_element_addr(&_libraries, 2, (modelica_integer)_i, (modelica_integer) 2));

                _isMatch = (1);

                break;
              }
            }
          }

          if((!_isMatch))
          {
            tmp27 = cat_modelica_string(_OMC_LIT36,_uri);
            _message = tmp27;

            _filename = _OMC_LIT10;

            goto _return;
          }
        }
      }

      tmp29 = (modelica_boolean)_isMatch;
      if(tmp29)
      {
        tmp28 = cat_modelica_string(_filename, (*string_array_element_addr(&_matches, 1, (modelica_integer) 3)));
        tmp30 = tmp28;
      }
      else
      {
        tmp30 = _filename;
      }
      _filename = tmp30;
    }
    else
    {
      if(_isFileUriAbsolute)
      {
        tmp31 = omc_OpenModelica_Scripting_regex(threadData, _uri, _OMC_LIT22, (modelica_integer) 2, (1), (1));
        
        _matches = tmp31.c2;

        _filename =  (*string_array_element_addr(&_matches, 1, (modelica_integer) 2));
      }
      else
      {
        if((_isFileUri && (!_isFileUriAbsolute)))
        {
          tmp32 = omc_OpenModelica_Scripting_regex(threadData, _uri, _OMC_LIT21, (modelica_integer) 2, (1), (1));
          
          _matches = tmp32.c2;

          tmp33 = omc_OpenModelica_Scripting_realpath(threadData, _OMC_LIT13);
          tmp34 = cat_modelica_string(tmp33.c1,_OMC_LIT14);
          tmp35 = cat_modelica_string(tmp34, (*string_array_element_addr(&_matches, 1, (modelica_integer) 2)));
          _filename = tmp35;

          goto _return;
        }
        else
        {
          if((!(_isModelicaUri || _isFileUri)))
          {
            tmp36 = cat_modelica_string(_OMC_LIT20,_uri);
            _message = tmp36;

            _filename = _OMC_LIT10;

            goto _return;
          }
          else
          {
            _message = _OMC_LIT19;

            _filename = _OMC_LIT10;
          }
        }
      }
    }
  }
  else
  {
    tmp37 = omc_OpenModelica_Scripting_regularFileExists(threadData, _uri);
    tmp45 = (modelica_boolean)tmp37.c1;
    if(tmp45)
    {
      tmp38 = omc_OpenModelica_Scripting_realpath(threadData, _uri);
      tmp46 = tmp38.c1;
    }
    else
    {
      tmp39 = omc_OpenModelica_Scripting_regexBool(threadData, _uri, _OMC_LIT12, (1), (0));
      tmp43 = (modelica_boolean)tmp39.c1;
      if(tmp43)
      {
        tmp44 = _uri;
      }
      else
      {
        tmp40 = omc_OpenModelica_Scripting_realpath(threadData, _OMC_LIT13);
        tmp41 = cat_modelica_string(tmp40.c1,_OMC_LIT14);
        tmp42 = cat_modelica_string(tmp41,_uri);
        tmp44 = tmp42;
      }
      tmp46 = tmp44;
    }
    _filename = tmp46;
  }
  _return: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out var copy */
  /* functionBodyRegularFunction: out var assign */
  tmp1.c1 = _filename;
  tmp1.c2 = _message;
  /* GC: pop the mark! */
  /* functionBodyRegularFunction: return the outs */
  return  tmp1;
}

DLLExport
OpenModelica_Scripting_regularFileExists_rettype omc_OpenModelica_Scripting_regularFileExists(threadData_t *threadData, modelica_string _fileName)
{
  /* functionBodyRegularFunction: arguments */
  /* functionBodyRegularFunction: locals */
  OpenModelica_Scripting_regularFileExists_rettype tmp1;
  modelica_boolean _exists;
  OpenModelica_Scripting_Internal_stat_rettype tmp2;
  _tailrecursive: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out inits */
  /* functionBodyRegularFunction: var inits */
  /* functionBodyRegularFunction: body */
  tmp2 = omc_OpenModelica_Scripting_Internal_stat(threadData, _fileName);
  _exists = (tmp2.c1 == 2);
  _return: OMC_LABEL_UNUSED
  /* functionBodyRegularFunction: out var copy */
  /* functionBodyRegularFunction: out var assign */
  tmp1.c1 = _exists;
  /* GC: pop the mark! */
  /* functionBodyRegularFunction: return the outs */
  return  tmp1;
}

#ifdef __cplusplus
}
#endif

