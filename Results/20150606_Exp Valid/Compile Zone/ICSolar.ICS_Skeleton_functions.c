#include "ICSolar.ICS_Skeleton_functions.h"
#ifdef __cplusplus
extern "C" {
#endif

#include "ICSolar.ICS_Skeleton_literals.h"
#include "ICSolar.ICS_Skeleton_includes.h"


modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__1_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _u1_ext;
  double _u2_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _u1_ext = (double)_u1;
  _u2_ext = (double)_u2;
  _y_ext = ModelicaStandardTables_CombiTable2D_getValue(_tableID_ext, _u1_ext, _u2_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__1_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _u1, modelica_metatype _u2, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_u1);
  tmp2 = mmc_unbox_real(_u2);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__1_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$eGen__on_getTableValueNoDer(threadData_t *threadData, modelica_complex _tableID, modelica_integer _icol, modelica_real _timeIn, modelica_real _nextTimeEvent, modelica_real _pre_nextTimeEvent, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  int _icol_ext;
  double _timeIn_ext;
  double _nextTimeEvent_ext;
  double _pre_nextTimeEvent_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _icol_ext = (int)_icol;
  _timeIn_ext = (double)_timeIn;
  _nextTimeEvent_ext = (double)_nextTimeEvent;
  _pre_nextTimeEvent_ext = (double)_pre_nextTimeEvent;
  _y_ext = ModelicaStandardTables_CombiTimeTable_getValue(_tableID_ext, _icol_ext, _timeIn_ext, _nextTimeEvent_ext, _pre_nextTimeEvent_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$eGen__on_getTableValueNoDer(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _icol, modelica_metatype _timeIn, modelica_metatype _nextTimeEvent, modelica_metatype _pre_nextTimeEvent, modelica_metatype _tableAvailable)
{
  modelica_integer tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real tmp4;
  modelica_real tmp5;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_integer(_icol);
  tmp2 = mmc_unbox_real(_timeIn);
  tmp3 = mmc_unbox_real(_nextTimeEvent);
  tmp4 = mmc_unbox_real(_pre_nextTimeEvent);
  tmp5 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$eGen__on_getTableValueNoDer(threadData, _tableID, tmp1, tmp2, tmp3, tmp4, tmp5);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
ICSolar_Water__75degC omc_ICSolar_Water__75degC(threadData_t *threadData, modelica_real rho, modelica_real cp, modelica_real cv, modelica_real lamda, modelica_real nue)
{
  ICSolar_Water__75degC tmp1;
  tmp1._rho = rho;
  tmp1._cp = cp;
  tmp1._cv = cv;
  tmp1._lamda = lamda;
  tmp1._nue = nue;
  return tmp1;
}

modelica_metatype boxptr_ICSolar_Water__75degC(threadData_t *threadData, modelica_metatype _rho, modelica_metatype _cp, modelica_metatype _cv, modelica_metatype _lamda, modelica_metatype _nue)
{
  return mmc_mk_box6(3, &ICSolar_Water__75degC__desc, _rho, _cp, _cv, _lamda, _nue);
}
DLLExport
modelica_real omc_Buildings_Utilities_Math_Functions_smoothLimit(threadData_t *threadData, modelica_real _x, modelica_real _l, modelica_real _u, modelica_real _deltaX)
{
  modelica_real _y;
  modelica_real _cor;
  _tailrecursive: OMC_LABEL_UNUSED
  TRACE_PUSH
  _cor = (0.1 * _deltaX);

  _y = omc_Buildings_Utilities_Math_Functions_smoothMax(threadData, _x, (_l + _deltaX), _cor);

  _y = omc_Buildings_Utilities_Math_Functions_smoothMin(threadData, _y, (_u - _deltaX), _cor);
  _return: OMC_LABEL_UNUSED
  TRACE_POP
  return _y;
}
modelica_metatype boxptr_Buildings_Utilities_Math_Functions_smoothLimit(threadData_t *threadData, modelica_metatype _x, modelica_metatype _l, modelica_metatype _u, modelica_metatype _deltaX)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real tmp4;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_x);
  tmp2 = mmc_unbox_real(_l);
  tmp3 = mmc_unbox_real(_u);
  tmp4 = mmc_unbox_real(_deltaX);
  _y = omc_Buildings_Utilities_Math_Functions_smoothLimit(threadData, tmp1, tmp2, tmp3, tmp4);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
DLLExport
modelica_real omc_Buildings_Utilities_Math_Functions_smoothMin(threadData_t *threadData, modelica_real _x1, modelica_real _x2, modelica_real _deltaX)
{
  modelica_real _y;
  _tailrecursive: OMC_LABEL_UNUSED
  TRACE_PUSH
  _y = omc_Buildings_Utilities_Math_Functions_spliceFunction(threadData, _x1, _x2, (_x2 - _x1), _deltaX);
  _return: OMC_LABEL_UNUSED
  TRACE_POP
  return _y;
}
modelica_metatype boxptr_Buildings_Utilities_Math_Functions_smoothMin(threadData_t *threadData, modelica_metatype _x1, modelica_metatype _x2, modelica_metatype _deltaX)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_x1);
  tmp2 = mmc_unbox_real(_x2);
  tmp3 = mmc_unbox_real(_deltaX);
  _y = omc_Buildings_Utilities_Math_Functions_smoothMin(threadData, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
DLLExport
modelica_real omc_Buildings_Utilities_Math_Functions_smoothMax(threadData_t *threadData, modelica_real _x1, modelica_real _x2, modelica_real _deltaX)
{
  modelica_real _y;
  _tailrecursive: OMC_LABEL_UNUSED
  TRACE_PUSH
  _y = omc_Buildings_Utilities_Math_Functions_spliceFunction(threadData, _x1, _x2, (_x1 - _x2), _deltaX);
  _return: OMC_LABEL_UNUSED
  TRACE_POP
  return _y;
}
modelica_metatype boxptr_Buildings_Utilities_Math_Functions_smoothMax(threadData_t *threadData, modelica_metatype _x1, modelica_metatype _x2, modelica_metatype _deltaX)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_x1);
  tmp2 = mmc_unbox_real(_x2);
  tmp3 = mmc_unbox_real(_deltaX);
  _y = omc_Buildings_Utilities_Math_Functions_smoothMax(threadData, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
DLLExport
modelica_real omc_Buildings_Utilities_Math_Functions_spliceFunction(threadData_t *threadData, modelica_real _pos, modelica_real _neg, modelica_real _x, modelica_real _deltax)
{
  modelica_real _out;
  modelica_real _scaledX1;
  modelica_real _y;
  modelica_real _asin1;
  modelica_real tmp1;
  _tailrecursive: OMC_LABEL_UNUSED
  TRACE_PUSH
  _asin1 = 1.570796326794897;
  tmp1 = _deltax;
  if (tmp1 == 0) {throwStreamPrint(threadData, "Division by zero %s", "x / deltax");}
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
      _y = (0.5 + (0.5 * tanh(tan((1.570796326794897 * _scaledX1)))));

      _out = ((_pos * _y) + ((1.0 - _y) * _neg));
    }
  }
  _return: OMC_LABEL_UNUSED
  TRACE_POP
  return _out;
}
modelica_metatype boxptr_Buildings_Utilities_Math_Functions_spliceFunction(threadData_t *threadData, modelica_metatype _pos, modelica_metatype _neg, modelica_metatype _x, modelica_metatype _deltax)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real tmp4;
  modelica_real _out;
  modelica_metatype out_out;
  tmp1 = mmc_unbox_real(_pos);
  tmp2 = mmc_unbox_real(_neg);
  tmp3 = mmc_unbox_real(_x);
  tmp4 = mmc_unbox_real(_deltax);
  _out = omc_Buildings_Utilities_Math_Functions_spliceFunction(threadData, tmp1, tmp2, tmp3, tmp4);
  out_out = mmc_mk_rcon(_out);
  return out_out;
}
modelica_real omc_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$eGen__on_getNextTimeEvent(threadData_t *threadData, modelica_complex _tableID, modelica_real _timeIn, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _timeIn_ext;
  double _nextTimeEvent_ext;
  modelica_real _nextTimeEvent;
  _tableID_ext = (void *)_tableID;
  _timeIn_ext = (double)_timeIn;
  _nextTimeEvent_ext = ModelicaStandardTables_CombiTimeTable_nextTimeEvent(_tableID_ext, _timeIn_ext);
  _nextTimeEvent = (modelica_real)_nextTimeEvent_ext;
  return _nextTimeEvent;
}
modelica_metatype boxptr_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$eGen__on_getNextTimeEvent(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _timeIn, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real _nextTimeEvent;
  modelica_metatype out_nextTimeEvent;
  tmp1 = mmc_unbox_real(_timeIn);
  tmp2 = mmc_unbox_real(_tableAvailable);
  _nextTimeEvent = omc_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$eGen__on_getNextTimeEvent(threadData, _tableID, tmp1, tmp2);
  out_nextTimeEvent = mmc_mk_rcon(_nextTimeEvent);
  return out_nextTimeEvent;
}
modelica_real omc_Modelica_Blocks_Sources_CombiTimeTable$IC__Data__all_getTableTimeTmin(threadData_t *threadData, modelica_complex _tableID, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _timeMin_ext;
  modelica_real _timeMin;
  _tableID_ext = (void *)_tableID;
  _timeMin_ext = ModelicaStandardTables_CombiTimeTable_minimumTime(_tableID_ext);
  _timeMin = (modelica_real)_timeMin_ext;
  return _timeMin;
}
modelica_metatype boxptr_Modelica_Blocks_Sources_CombiTimeTable$IC__Data__all_getTableTimeTmin(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real _timeMin;
  modelica_metatype out_timeMin;
  tmp1 = mmc_unbox_real(_tableAvailable);
  _timeMin = omc_Modelica_Blocks_Sources_CombiTimeTable$IC__Data__all_getTableTimeTmin(threadData, _tableID, tmp1);
  out_timeMin = mmc_mk_rcon(_timeMin);
  return out_timeMin;
}
modelica_real omc_Modelica_Blocks_Sources_CombiTimeTable$IC__Data__all_getNextTimeEvent(threadData_t *threadData, modelica_complex _tableID, modelica_real _timeIn, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _timeIn_ext;
  double _nextTimeEvent_ext;
  modelica_real _nextTimeEvent;
  _tableID_ext = (void *)_tableID;
  _timeIn_ext = (double)_timeIn;
  _nextTimeEvent_ext = ModelicaStandardTables_CombiTimeTable_nextTimeEvent(_tableID_ext, _timeIn_ext);
  _nextTimeEvent = (modelica_real)_nextTimeEvent_ext;
  return _nextTimeEvent;
}
modelica_metatype boxptr_Modelica_Blocks_Sources_CombiTimeTable$IC__Data__all_getNextTimeEvent(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _timeIn, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real _nextTimeEvent;
  modelica_metatype out_nextTimeEvent;
  tmp1 = mmc_unbox_real(_timeIn);
  tmp2 = mmc_unbox_real(_tableAvailable);
  _nextTimeEvent = omc_Modelica_Blocks_Sources_CombiTimeTable$IC__Data__all_getNextTimeEvent(threadData, _tableID, tmp1, tmp2);
  out_nextTimeEvent = mmc_mk_rcon(_nextTimeEvent);
  return out_nextTimeEvent;
}
modelica_real omc_Modelica_Blocks_Sources_CombiTimeTable$IC__Data__all_getDerTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_integer _icol, modelica_real _timeIn, modelica_real _nextTimeEvent, modelica_real _pre_nextTimeEvent, modelica_real _tableAvailable, modelica_real _der_timeIn)
{
  void * _tableID_ext;
  int _icol_ext;
  double _timeIn_ext;
  double _nextTimeEvent_ext;
  double _pre_nextTimeEvent_ext;
  double _der_timeIn_ext;
  double _der_y_ext;
  modelica_real _der_y;
  _tableID_ext = (void *)_tableID;
  _icol_ext = (int)_icol;
  _timeIn_ext = (double)_timeIn;
  _nextTimeEvent_ext = (double)_nextTimeEvent;
  _pre_nextTimeEvent_ext = (double)_pre_nextTimeEvent;
  _der_timeIn_ext = (double)_der_timeIn;
  _der_y_ext = ModelicaStandardTables_CombiTimeTable_getDerValue(_tableID_ext, _icol_ext, _timeIn_ext, _nextTimeEvent_ext, _pre_nextTimeEvent_ext, _der_timeIn_ext);
  _der_y = (modelica_real)_der_y_ext;
  return _der_y;
}
modelica_metatype boxptr_Modelica_Blocks_Sources_CombiTimeTable$IC__Data__all_getDerTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _icol, modelica_metatype _timeIn, modelica_metatype _nextTimeEvent, modelica_metatype _pre_nextTimeEvent, modelica_metatype _tableAvailable, modelica_metatype _der_timeIn)
{
  modelica_integer tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real tmp4;
  modelica_real tmp5;
  modelica_real tmp6;
  modelica_real _der_y;
  modelica_metatype out_der_y;
  tmp1 = mmc_unbox_integer(_icol);
  tmp2 = mmc_unbox_real(_timeIn);
  tmp3 = mmc_unbox_real(_nextTimeEvent);
  tmp4 = mmc_unbox_real(_pre_nextTimeEvent);
  tmp5 = mmc_unbox_real(_tableAvailable);
  tmp6 = mmc_unbox_real(_der_timeIn);
  _der_y = omc_Modelica_Blocks_Sources_CombiTimeTable$IC__Data__all_getDerTableValue(threadData, _tableID, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6);
  out_der_y = mmc_mk_rcon(_der_y);
  return out_der_y;
}
modelica_real omc_Modelica_Blocks_Sources_CombiTimeTable$IC__Data__all_getTableTimeTmax(threadData_t *threadData, modelica_complex _tableID, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _timeMax_ext;
  modelica_real _timeMax;
  _tableID_ext = (void *)_tableID;
  _timeMax_ext = ModelicaStandardTables_CombiTimeTable_maximumTime(_tableID_ext);
  _timeMax = (modelica_real)_timeMax_ext;
  return _timeMax;
}
modelica_metatype boxptr_Modelica_Blocks_Sources_CombiTimeTable$IC__Data__all_getTableTimeTmax(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real _timeMax;
  modelica_metatype out_timeMax;
  tmp1 = mmc_unbox_real(_tableAvailable);
  _timeMax = omc_Modelica_Blocks_Sources_CombiTimeTable$IC__Data__all_getTableTimeTmax(threadData, _tableID, tmp1);
  out_timeMax = mmc_mk_rcon(_timeMax);
  return out_timeMax;
}
modelica_real omc_Modelica_Blocks_Sources_CombiTimeTable$IC__Data__all_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_integer _icol, modelica_real _timeIn, modelica_real _nextTimeEvent, modelica_real _pre_nextTimeEvent, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  int _icol_ext;
  double _timeIn_ext;
  double _nextTimeEvent_ext;
  double _pre_nextTimeEvent_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _icol_ext = (int)_icol;
  _timeIn_ext = (double)_timeIn;
  _nextTimeEvent_ext = (double)_nextTimeEvent;
  _pre_nextTimeEvent_ext = (double)_pre_nextTimeEvent;
  _y_ext = ModelicaStandardTables_CombiTimeTable_getValue(_tableID_ext, _icol_ext, _timeIn_ext, _nextTimeEvent_ext, _pre_nextTimeEvent_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Sources_CombiTimeTable$IC__Data__all_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _icol, modelica_metatype _timeIn, modelica_metatype _nextTimeEvent, modelica_metatype _pre_nextTimeEvent, modelica_metatype _tableAvailable)
{
  modelica_integer tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real tmp4;
  modelica_real tmp5;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_integer(_icol);
  tmp2 = mmc_unbox_real(_timeIn);
  tmp3 = mmc_unbox_real(_nextTimeEvent);
  tmp4 = mmc_unbox_real(_pre_nextTimeEvent);
  tmp5 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Sources_CombiTimeTable$IC__Data__all_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3, tmp4, tmp5);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Sources_CombiTimeTable$IC__Data__all_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTimeTable_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Sources_CombiTimeTable$IC__Data__all_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Sources_CombiTimeTable$IC__Data__all_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$eGen__on_getTableTimeTmin(threadData_t *threadData, modelica_complex _tableID, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _timeMin_ext;
  modelica_real _timeMin;
  _tableID_ext = (void *)_tableID;
  _timeMin_ext = ModelicaStandardTables_CombiTimeTable_minimumTime(_tableID_ext);
  _timeMin = (modelica_real)_timeMin_ext;
  return _timeMin;
}
modelica_metatype boxptr_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$eGen__on_getTableTimeTmin(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real _timeMin;
  modelica_metatype out_timeMin;
  tmp1 = mmc_unbox_real(_tableAvailable);
  _timeMin = omc_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$eGen__on_getTableTimeTmin(threadData, _tableID, tmp1);
  out_timeMin = mmc_mk_rcon(_timeMin);
  return out_timeMin;
}
modelica_real omc_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$eGen__on_getTableTimeTmax(threadData_t *threadData, modelica_complex _tableID, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _timeMax_ext;
  modelica_real _timeMax;
  _tableID_ext = (void *)_tableID;
  _timeMax_ext = ModelicaStandardTables_CombiTimeTable_maximumTime(_tableID_ext);
  _timeMax = (modelica_real)_timeMax_ext;
  return _timeMax;
}
modelica_metatype boxptr_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$eGen__on_getTableTimeTmax(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real _timeMax;
  modelica_metatype out_timeMax;
  tmp1 = mmc_unbox_real(_tableAvailable);
  _timeMax = omc_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$eGen__on_getTableTimeTmax(threadData, _tableID, tmp1);
  out_timeMax = mmc_mk_rcon(_timeMax);
  return out_timeMax;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__11_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _u1_ext;
  double _u2_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _u1_ext = (double)_u1;
  _u2_ext = (double)_u2;
  _y_ext = ModelicaStandardTables_CombiTable2D_getValue(_tableID_ext, _u1_ext, _u2_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__11_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _u1, modelica_metatype _u2, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_u1);
  tmp2 = mmc_unbox_real(_u2);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__11_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable1Ds$ics__context1$weaDat$datRea1_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_integer _icol, modelica_real _u, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  int _icol_ext;
  double _u_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _icol_ext = (int)_icol;
  _u_ext = (double)_u;
  _y_ext = ModelicaStandardTables_CombiTable1D_getValue(_tableID_ext, _icol_ext, _u_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable1Ds$ics__context1$weaDat$datRea1_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _icol, modelica_metatype _u, modelica_metatype _tableAvailable)
{
  modelica_integer tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_integer(_icol);
  tmp2 = mmc_unbox_real(_u);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable1Ds$ics__context1$weaDat$datRea1_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$eGen__on_getTableValueNoDer(threadData_t *threadData, modelica_complex _tableID, modelica_integer _icol, modelica_real _timeIn, modelica_real _nextTimeEvent, modelica_real _pre_nextTimeEvent, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  int _icol_ext;
  double _timeIn_ext;
  double _nextTimeEvent_ext;
  double _pre_nextTimeEvent_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _icol_ext = (int)_icol;
  _timeIn_ext = (double)_timeIn;
  _nextTimeEvent_ext = (double)_nextTimeEvent;
  _pre_nextTimeEvent_ext = (double)_pre_nextTimeEvent;
  _y_ext = ModelicaStandardTables_CombiTimeTable_getValue(_tableID_ext, _icol_ext, _timeIn_ext, _nextTimeEvent_ext, _pre_nextTimeEvent_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$eGen__on_getTableValueNoDer(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _icol, modelica_metatype _timeIn, modelica_metatype _nextTimeEvent, modelica_metatype _pre_nextTimeEvent, modelica_metatype _tableAvailable)
{
  modelica_integer tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real tmp4;
  modelica_real tmp5;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_integer(_icol);
  tmp2 = mmc_unbox_real(_timeIn);
  tmp3 = mmc_unbox_real(_nextTimeEvent);
  tmp4 = mmc_unbox_real(_pre_nextTimeEvent);
  tmp5 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$eGen__on_getTableValueNoDer(threadData, _tableID, tmp1, tmp2, tmp3, tmp4, tmp5);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$eGen__on_getTableTimeTmax(threadData_t *threadData, modelica_complex _tableID, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _timeMax_ext;
  modelica_real _timeMax;
  _tableID_ext = (void *)_tableID;
  _timeMax_ext = ModelicaStandardTables_CombiTimeTable_maximumTime(_tableID_ext);
  _timeMax = (modelica_real)_timeMax_ext;
  return _timeMax;
}
modelica_metatype boxptr_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$eGen__on_getTableTimeTmax(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real _timeMax;
  modelica_metatype out_timeMax;
  tmp1 = mmc_unbox_real(_tableAvailable);
  _timeMax = omc_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$eGen__on_getTableTimeTmax(threadData, _tableID, tmp1);
  out_timeMax = mmc_mk_rcon(_timeMax);
  return out_timeMax;
}
modelica_real omc_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$eGen__on_getNextTimeEvent(threadData_t *threadData, modelica_complex _tableID, modelica_real _timeIn, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _timeIn_ext;
  double _nextTimeEvent_ext;
  modelica_real _nextTimeEvent;
  _tableID_ext = (void *)_tableID;
  _timeIn_ext = (double)_timeIn;
  _nextTimeEvent_ext = ModelicaStandardTables_CombiTimeTable_nextTimeEvent(_tableID_ext, _timeIn_ext);
  _nextTimeEvent = (modelica_real)_nextTimeEvent_ext;
  return _nextTimeEvent;
}
modelica_metatype boxptr_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$eGen__on_getNextTimeEvent(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _timeIn, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real _nextTimeEvent;
  modelica_metatype out_nextTimeEvent;
  tmp1 = mmc_unbox_real(_timeIn);
  tmp2 = mmc_unbox_real(_tableAvailable);
  _nextTimeEvent = omc_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$eGen__on_getNextTimeEvent(threadData, _tableID, tmp1, tmp2);
  out_nextTimeEvent = mmc_mk_rcon(_nextTimeEvent);
  return out_nextTimeEvent;
}
modelica_real omc_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$eGen__on_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTimeTable_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$eGen__on_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$eGen__on_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$eGen__on_getTableTimeTmin(threadData_t *threadData, modelica_complex _tableID, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _timeMin_ext;
  modelica_real _timeMin;
  _tableID_ext = (void *)_tableID;
  _timeMin_ext = ModelicaStandardTables_CombiTimeTable_minimumTime(_tableID_ext);
  _timeMin = (modelica_real)_timeMin_ext;
  return _timeMin;
}
modelica_metatype boxptr_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$eGen__on_getTableTimeTmin(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real _timeMin;
  modelica_metatype out_timeMin;
  tmp1 = mmc_unbox_real(_tableAvailable);
  _timeMin = omc_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$eGen__on_getTableTimeTmin(threadData, _tableID, tmp1);
  out_timeMin = mmc_mk_rcon(_timeMin);
  return out_timeMin;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable1Ds$ics__context1$weaDat$datRea_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_integer _icol, modelica_real _u, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  int _icol_ext;
  double _u_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _icol_ext = (int)_icol;
  _u_ext = (double)_u;
  _y_ext = ModelicaStandardTables_CombiTable1D_getValue(_tableID_ext, _icol_ext, _u_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable1Ds$ics__context1$weaDat$datRea_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _icol, modelica_metatype _u, modelica_metatype _tableAvailable)
{
  modelica_integer tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_integer(_icol);
  tmp2 = mmc_unbox_real(_u);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable1Ds$ics__context1$weaDat$datRea_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$eGen__on_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTimeTable_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$eGen__on_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Sources_CombiTimeTable$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$eGen__on_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable1Ds$ics__context1$weaDat$datRea_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable1D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable1Ds$ics__context1$weaDat$datRea_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable1Ds$ics__context1$weaDat$datRea_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__1_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _u1_ext;
  double _u2_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _u1_ext = (double)_u1;
  _u2_ext = (double)_u2;
  _y_ext = ModelicaStandardTables_CombiTable2D_getValue(_tableID_ext, _u1_ext, _u2_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__1_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _u1, modelica_metatype _u2, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_u1);
  tmp2 = mmc_unbox_real(_u2);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__1_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$Shading__matrix_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _u1_ext;
  double _u2_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _u1_ext = (double)_u1;
  _u2_ext = (double)_u2;
  _y_ext = ModelicaStandardTables_CombiTable2D_getValue(_tableID_ext, _u1_ext, _u2_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$Shading__matrix_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _u1, modelica_metatype _u2, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_u1);
  tmp2 = mmc_unbox_real(_u2);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$Shading__matrix_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable1Ds$ics__context1$weaDat$datRea1_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable1D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable1Ds$ics__context1$weaDat$datRea1_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable1Ds$ics__context1$weaDat$datRea1_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$Shading__matrix_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable2D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$Shading__matrix_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$Shading__matrix_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__10_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _u1_ext;
  double _u2_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _u1_ext = (double)_u1;
  _u2_ext = (double)_u2;
  _y_ext = ModelicaStandardTables_CombiTable2D_getValue(_tableID_ext, _u1_ext, _u2_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__10_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _u1, modelica_metatype _u2, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_u1);
  tmp2 = mmc_unbox_real(_u2);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__10_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__1_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable2D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__1_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__1_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__10_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable2D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__10_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__10_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__7_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _u1_ext;
  double _u2_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _u1_ext = (double)_u1;
  _u2_ext = (double)_u2;
  _y_ext = ModelicaStandardTables_CombiTable2D_getValue(_tableID_ext, _u1_ext, _u2_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__7_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _u1, modelica_metatype _u2, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_u1);
  tmp2 = mmc_unbox_real(_u2);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__7_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__3_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _u1_ext;
  double _u2_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _u1_ext = (double)_u1;
  _u2_ext = (double)_u2;
  _y_ext = ModelicaStandardTables_CombiTable2D_getValue(_tableID_ext, _u1_ext, _u2_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__3_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _u1, modelica_metatype _u2, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_u1);
  tmp2 = mmc_unbox_real(_u2);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__3_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__2_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _u1_ext;
  double _u2_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _u1_ext = (double)_u1;
  _u2_ext = (double)_u2;
  _y_ext = ModelicaStandardTables_CombiTable2D_getValue(_tableID_ext, _u1_ext, _u2_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__2_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _u1, modelica_metatype _u2, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_u1);
  tmp2 = mmc_unbox_real(_u2);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__2_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__12_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _u1_ext;
  double _u2_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _u1_ext = (double)_u1;
  _u2_ext = (double)_u2;
  _y_ext = ModelicaStandardTables_CombiTable2D_getValue(_tableID_ext, _u1_ext, _u2_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__12_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _u1, modelica_metatype _u2, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_u1);
  tmp2 = mmc_unbox_real(_u2);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__12_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__11_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable2D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__11_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__11_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__12_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable2D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__12_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__12_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__2_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable2D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__2_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__2_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__5_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _u1_ext;
  double _u2_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _u1_ext = (double)_u1;
  _u2_ext = (double)_u2;
  _y_ext = ModelicaStandardTables_CombiTable2D_getValue(_tableID_ext, _u1_ext, _u2_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__5_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _u1, modelica_metatype _u2, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_u1);
  tmp2 = mmc_unbox_real(_u2);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__5_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__4_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _u1_ext;
  double _u2_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _u1_ext = (double)_u1;
  _u2_ext = (double)_u2;
  _y_ext = ModelicaStandardTables_CombiTable2D_getValue(_tableID_ext, _u1_ext, _u2_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__4_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _u1, modelica_metatype _u2, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_u1);
  tmp2 = mmc_unbox_real(_u2);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__4_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__3_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable2D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__3_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__3_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__4_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable2D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__4_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__4_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__6_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _u1_ext;
  double _u2_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _u1_ext = (double)_u1;
  _u2_ext = (double)_u2;
  _y_ext = ModelicaStandardTables_CombiTable2D_getValue(_tableID_ext, _u1_ext, _u2_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__6_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _u1, modelica_metatype _u2, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_u1);
  tmp2 = mmc_unbox_real(_u2);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__6_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__5_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable2D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__5_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__5_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__6_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable2D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__6_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__6_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__9_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _u1_ext;
  double _u2_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _u1_ext = (double)_u1;
  _u2_ext = (double)_u2;
  _y_ext = ModelicaStandardTables_CombiTable2D_getValue(_tableID_ext, _u1_ext, _u2_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__9_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _u1, modelica_metatype _u2, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_u1);
  tmp2 = mmc_unbox_real(_u2);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__9_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__8_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _u1_ext;
  double _u2_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _u1_ext = (double)_u1;
  _u2_ext = (double)_u2;
  _y_ext = ModelicaStandardTables_CombiTable2D_getValue(_tableID_ext, _u1_ext, _u2_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__8_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _u1, modelica_metatype _u2, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_u1);
  tmp2 = mmc_unbox_real(_u2);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__8_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__7_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable2D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__7_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__7_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__8_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable2D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__8_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__8_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$Shading__matrix_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _u1_ext;
  double _u2_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _u1_ext = (double)_u1;
  _u2_ext = (double)_u2;
  _y_ext = ModelicaStandardTables_CombiTable2D_getValue(_tableID_ext, _u1_ext, _u2_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$Shading__matrix_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _u1, modelica_metatype _u2, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_u1);
  tmp2 = mmc_unbox_real(_u2);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$Shading__matrix_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__9_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable2D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__9_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack1$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__9_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$Shading__matrix_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable2D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$Shading__matrix_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$Shading__matrix_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__5_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _u1_ext;
  double _u2_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _u1_ext = (double)_u1;
  _u2_ext = (double)_u2;
  _y_ext = ModelicaStandardTables_CombiTable2D_getValue(_tableID_ext, _u1_ext, _u2_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__5_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _u1, modelica_metatype _u2, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_u1);
  tmp2 = mmc_unbox_real(_u2);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__5_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__2_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _u1_ext;
  double _u2_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _u1_ext = (double)_u1;
  _u2_ext = (double)_u2;
  _y_ext = ModelicaStandardTables_CombiTable2D_getValue(_tableID_ext, _u1_ext, _u2_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__2_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _u1, modelica_metatype _u2, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_u1);
  tmp2 = mmc_unbox_real(_u2);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__2_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__11_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _u1_ext;
  double _u2_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _u1_ext = (double)_u1;
  _u2_ext = (double)_u2;
  _y_ext = ModelicaStandardTables_CombiTable2D_getValue(_tableID_ext, _u1_ext, _u2_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__11_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _u1, modelica_metatype _u2, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_u1);
  tmp2 = mmc_unbox_real(_u2);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__11_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__10_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _u1_ext;
  double _u2_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _u1_ext = (double)_u1;
  _u2_ext = (double)_u2;
  _y_ext = ModelicaStandardTables_CombiTable2D_getValue(_tableID_ext, _u1_ext, _u2_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__10_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _u1, modelica_metatype _u2, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_u1);
  tmp2 = mmc_unbox_real(_u2);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__10_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__1_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable2D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__1_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__1_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__10_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable2D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__10_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__10_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__12_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _u1_ext;
  double _u2_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _u1_ext = (double)_u1;
  _u2_ext = (double)_u2;
  _y_ext = ModelicaStandardTables_CombiTable2D_getValue(_tableID_ext, _u1_ext, _u2_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__12_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _u1, modelica_metatype _u2, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_u1);
  tmp2 = mmc_unbox_real(_u2);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__12_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__11_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable2D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__11_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__11_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__12_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable2D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__12_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__12_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__4_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _u1_ext;
  double _u2_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _u1_ext = (double)_u1;
  _u2_ext = (double)_u2;
  _y_ext = ModelicaStandardTables_CombiTable2D_getValue(_tableID_ext, _u1_ext, _u2_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__4_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _u1, modelica_metatype _u2, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_u1);
  tmp2 = mmc_unbox_real(_u2);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__4_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__3_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _u1_ext;
  double _u2_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _u1_ext = (double)_u1;
  _u2_ext = (double)_u2;
  _y_ext = ModelicaStandardTables_CombiTable2D_getValue(_tableID_ext, _u1_ext, _u2_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__3_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _u1, modelica_metatype _u2, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_u1);
  tmp2 = mmc_unbox_real(_u2);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__3_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__2_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable2D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__2_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__2_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__3_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable2D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__3_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__3_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__4_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable2D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__4_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__4_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_complex omc_Modelica_Blocks_Types_ExternalCombiTable2D_constructor(threadData_t *threadData, modelica_string _tableName, modelica_string _fileName, real_array _table, modelica_integer _smoothness)
{
  int _smoothness_ext;
  void * _externalCombiTable2D_ext;
  modelica_complex _externalCombiTable2D;
  _smoothness_ext = (int)_smoothness;
  _externalCombiTable2D_ext = ModelicaStandardTables_CombiTable2D_init(_tableName, _fileName, (const double*) data_of_real_array(&(_table)), size_of_dimension_base_array(_table, (modelica_integer) 1), size_of_dimension_base_array(_table, (modelica_integer) 2), _smoothness_ext);
  _externalCombiTable2D = (modelica_complex)_externalCombiTable2D_ext;
  return _externalCombiTable2D;
}
modelica_metatype boxptr_Modelica_Blocks_Types_ExternalCombiTable2D_constructor(threadData_t *threadData, modelica_metatype _tableName, modelica_metatype _fileName, modelica_metatype _table, modelica_metatype _smoothness)
{
  modelica_integer tmp1;
  modelica_complex _externalCombiTable2D;
  tmp1 = mmc_unbox_integer(_smoothness);
  _externalCombiTable2D = omc_Modelica_Blocks_Types_ExternalCombiTable2D_constructor(threadData, _tableName, _fileName, *((base_array_t*)_table), tmp1);
  /* skip box _externalCombiTable2D; ExternalObject Modelica.Blocks.Types.ExternalCombiTable2D */
  return _externalCombiTable2D;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__8_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _u1_ext;
  double _u2_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _u1_ext = (double)_u1;
  _u2_ext = (double)_u2;
  _y_ext = ModelicaStandardTables_CombiTable2D_getValue(_tableID_ext, _u1_ext, _u2_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__8_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _u1, modelica_metatype _u2, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_u1);
  tmp2 = mmc_unbox_real(_u2);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__8_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__7_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _u1_ext;
  double _u2_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _u1_ext = (double)_u1;
  _u2_ext = (double)_u2;
  _y_ext = ModelicaStandardTables_CombiTable2D_getValue(_tableID_ext, _u1_ext, _u2_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__7_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _u1, modelica_metatype _u2, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_u1);
  tmp2 = mmc_unbox_real(_u2);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__7_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__6_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _u1_ext;
  double _u2_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _u1_ext = (double)_u1;
  _u2_ext = (double)_u2;
  _y_ext = ModelicaStandardTables_CombiTable2D_getValue(_tableID_ext, _u1_ext, _u2_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__6_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _u1, modelica_metatype _u2, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_u1);
  tmp2 = mmc_unbox_real(_u2);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__6_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__5_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable2D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__5_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__5_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__6_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable2D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__6_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__6_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__7_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable2D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__7_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__7_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_complex omc_Modelica_Blocks_Types_ExternalCombiTable1D_constructor(threadData_t *threadData, modelica_string _tableName, modelica_string _fileName, real_array _table, integer_array _columns, modelica_integer _smoothness)
{
  int _smoothness_ext;
  void * _externalCombiTable1D_ext;
  modelica_complex _externalCombiTable1D;
  pack_integer_array(&_columns);
  _smoothness_ext = (int)_smoothness;
  _externalCombiTable1D_ext = ModelicaStandardTables_CombiTable1D_init(_tableName, _fileName, (const double*) data_of_real_array(&(_table)), size_of_dimension_base_array(_table, (modelica_integer) 1), size_of_dimension_base_array(_table, (modelica_integer) 2), (const int*) data_of_integer_array(&(_columns)), size_of_dimension_base_array(_columns, (modelica_integer) 1), _smoothness_ext);
  _externalCombiTable1D = (modelica_complex)_externalCombiTable1D_ext;
  return _externalCombiTable1D;
}
modelica_metatype boxptr_Modelica_Blocks_Types_ExternalCombiTable1D_constructor(threadData_t *threadData, modelica_metatype _tableName, modelica_metatype _fileName, modelica_metatype _table, modelica_metatype _columns, modelica_metatype _smoothness)
{
  modelica_integer tmp1;
  modelica_complex _externalCombiTable1D;
  tmp1 = mmc_unbox_integer(_smoothness);
  _externalCombiTable1D = omc_Modelica_Blocks_Types_ExternalCombiTable1D_constructor(threadData, _tableName, _fileName, *((base_array_t*)_table), *((base_array_t*)_columns), tmp1);
  /* skip box _externalCombiTable1D; ExternalObject Modelica.Blocks.Types.ExternalCombiTable1D */
  return _externalCombiTable1D;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__9_getTableValue(threadData_t *threadData, modelica_complex _tableID, modelica_real _u1, modelica_real _u2, modelica_real _tableAvailable)
{
  void * _tableID_ext;
  double _u1_ext;
  double _u2_ext;
  double _y_ext;
  modelica_real _y;
  _tableID_ext = (void *)_tableID;
  _u1_ext = (double)_u1;
  _u2_ext = (double)_u2;
  _y_ext = ModelicaStandardTables_CombiTable2D_getValue(_tableID_ext, _u1_ext, _u2_ext);
  _y = (modelica_real)_y_ext;
  return _y;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__9_getTableValue(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _u1, modelica_metatype _u2, modelica_metatype _tableAvailable)
{
  modelica_real tmp1;
  modelica_real tmp2;
  modelica_real tmp3;
  modelica_real _y;
  modelica_metatype out_y;
  tmp1 = mmc_unbox_real(_u1);
  tmp2 = mmc_unbox_real(_u2);
  tmp3 = mmc_unbox_real(_tableAvailable);
  _y = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__9_getTableValue(threadData, _tableID, tmp1, tmp2, tmp3);
  out_y = mmc_mk_rcon(_y);
  return out_y;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__8_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable2D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__8_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__8_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
modelica_real omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__9_readTableData(threadData_t *threadData, modelica_complex _tableID, modelica_boolean _forceRead, modelica_boolean _verboseRead)
{
  void * _tableID_ext;
  int _forceRead_ext;
  int _verboseRead_ext;
  double _readSuccess_ext;
  modelica_real _readSuccess;
  _tableID_ext = (void *)_tableID;
  _forceRead_ext = (int)_forceRead;
  _verboseRead_ext = (int)_verboseRead;
  _readSuccess_ext = ModelicaStandardTables_CombiTable2D_read(_tableID_ext, _forceRead_ext, _verboseRead_ext);
  _readSuccess = (modelica_real)_readSuccess_ext;
  return _readSuccess;
}
modelica_metatype boxptr_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__9_readTableData(threadData_t *threadData, modelica_metatype _tableID, modelica_metatype _forceRead, modelica_metatype _verboseRead)
{
  modelica_integer tmp1;
  modelica_integer tmp2;
  modelica_real _readSuccess;
  modelica_metatype out_readSuccess;
  tmp1 = mmc_unbox_integer(_forceRead);
  tmp2 = mmc_unbox_integer(_verboseRead);
  _readSuccess = omc_Modelica_Blocks_Tables_CombiTable2D$ics__envelopecassette1$ics__stack2$ICS__Module__Twelve__1$shading__twelve1$modShadingLUT__9_readTableData(threadData, _tableID, tmp1, tmp2);
  out_readSuccess = mmc_mk_rcon(_readSuccess);
  return out_readSuccess;
}
void omc_Modelica_Blocks_Types_ExternalCombiTable1D_destructor(threadData_t *threadData, modelica_complex _externalCombiTable1D)
{
  void * _externalCombiTable1D_ext;
  _externalCombiTable1D_ext = (void *)_externalCombiTable1D;
  ModelicaStandardTables_CombiTable1D_close(_externalCombiTable1D_ext);
  return;
}
void boxptr_Modelica_Blocks_Types_ExternalCombiTable1D_destructor(threadData_t *threadData, modelica_metatype _externalCombiTable1D)
{
  omc_Modelica_Blocks_Types_ExternalCombiTable1D_destructor(threadData, _externalCombiTable1D);
  return;
}
modelica_complex omc_Modelica_Blocks_Types_ExternalCombiTimeTable_constructor(threadData_t *threadData, modelica_string _tableName, modelica_string _fileName, real_array _table, modelica_real _startTime, integer_array _columns, modelica_integer _smoothness, modelica_integer _extrapolation)
{
  double _startTime_ext;
  int _smoothness_ext;
  int _extrapolation_ext;
  void * _externalCombiTimeTable_ext;
  modelica_complex _externalCombiTimeTable;
  _startTime_ext = (double)_startTime;
  pack_integer_array(&_columns);
  _smoothness_ext = (int)_smoothness;
  _extrapolation_ext = (int)_extrapolation;
  _externalCombiTimeTable_ext = ModelicaStandardTables_CombiTimeTable_init(_tableName, _fileName, (const double*) data_of_real_array(&(_table)), size_of_dimension_base_array(_table, (modelica_integer) 1), size_of_dimension_base_array(_table, (modelica_integer) 2), _startTime_ext, (const int*) data_of_integer_array(&(_columns)), size_of_dimension_base_array(_columns, (modelica_integer) 1), _smoothness_ext, _extrapolation_ext);
  _externalCombiTimeTable = (modelica_complex)_externalCombiTimeTable_ext;
  return _externalCombiTimeTable;
}
modelica_metatype boxptr_Modelica_Blocks_Types_ExternalCombiTimeTable_constructor(threadData_t *threadData, modelica_metatype _tableName, modelica_metatype _fileName, modelica_metatype _table, modelica_metatype _startTime, modelica_metatype _columns, modelica_metatype _smoothness, modelica_metatype _extrapolation)
{
  modelica_real tmp1;
  modelica_integer tmp2;
  modelica_integer tmp3;
  modelica_complex _externalCombiTimeTable;
  tmp1 = mmc_unbox_real(_startTime);
  tmp2 = mmc_unbox_integer(_smoothness);
  tmp3 = mmc_unbox_integer(_extrapolation);
  _externalCombiTimeTable = omc_Modelica_Blocks_Types_ExternalCombiTimeTable_constructor(threadData, _tableName, _fileName, *((base_array_t*)_table), tmp1, *((base_array_t*)_columns), tmp2, tmp3);
  /* skip box _externalCombiTimeTable; ExternalObject Modelica.Blocks.Types.ExternalCombiTimeTable */
  return _externalCombiTimeTable;
}
void omc_Modelica_Blocks_Types_ExternalCombiTable2D_destructor(threadData_t *threadData, modelica_complex _externalCombiTable2D)
{
  void * _externalCombiTable2D_ext;
  _externalCombiTable2D_ext = (void *)_externalCombiTable2D;
  ModelicaStandardTables_CombiTable2D_close(_externalCombiTable2D_ext);
  return;
}
void boxptr_Modelica_Blocks_Types_ExternalCombiTable2D_destructor(threadData_t *threadData, modelica_metatype _externalCombiTable2D)
{
  omc_Modelica_Blocks_Types_ExternalCombiTable2D_destructor(threadData, _externalCombiTable2D);
  return;
}
void omc_Modelica_Blocks_Types_ExternalCombiTimeTable_destructor(threadData_t *threadData, modelica_complex _externalCombiTimeTable)
{
  void * _externalCombiTimeTable_ext;
  _externalCombiTimeTable_ext = (void *)_externalCombiTimeTable;
  ModelicaStandardTables_CombiTimeTable_close(_externalCombiTimeTable_ext);
  return;
}
void boxptr_Modelica_Blocks_Types_ExternalCombiTimeTable_destructor(threadData_t *threadData, modelica_metatype _externalCombiTimeTable)
{
  omc_Modelica_Blocks_Types_ExternalCombiTimeTable_destructor(threadData, _externalCombiTimeTable);
  return;
}
Modelica_Thermal_FluidHeatFlow_Media_Medium omc_Modelica_Thermal_FluidHeatFlow_Media_Medium(threadData_t *threadData, modelica_real rho, modelica_real cp, modelica_real cv, modelica_real lamda, modelica_real nue)
{
  Modelica_Thermal_FluidHeatFlow_Media_Medium tmp1;
  tmp1._rho = rho;
  tmp1._cp = cp;
  tmp1._cv = cv;
  tmp1._lamda = lamda;
  tmp1._nue = nue;
  return tmp1;
}

modelica_metatype boxptr_Modelica_Thermal_FluidHeatFlow_Media_Medium(threadData_t *threadData, modelica_metatype _rho, modelica_metatype _cp, modelica_metatype _cv, modelica_metatype _lamda, modelica_metatype _nue)
{
  return mmc_mk_box6(3, &Modelica_Thermal_FluidHeatFlow_Media_Medium__desc, _rho, _cp, _cv, _lamda, _nue);
}

#ifdef __cplusplus
}
#endif
