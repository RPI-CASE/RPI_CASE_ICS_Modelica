from pymodelica import compile_fmu

model_name = 'ICSolar.ICS_Skeleton'
mo_file = 'ICSolar_master.mo'

my_fmu = compile_fmu(model_name, mo_file,
	compiler='auto',
	target='cs', 
	version='1.0',
	compiler_options={'extra_lib_dirs':['C:\Users\JShultz\Documents\GitHub\RPI_CASE_ICS_Modelica','C:\OpenModelica1.9.1\lib\omlibrary\Buildings 1.6']})