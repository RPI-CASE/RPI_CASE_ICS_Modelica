from pyfmi import load_fmu
import matplotlib.pyplot as plt
from assimulo.solvers import CVode
from assimulo.problem import Explicit_Problem

myModel = load_fmu('ICSolar_ICS_Skeleton.fmu')

days = 5
time_plus = 86400.0 * (days+5)
time_current = 86400.0 * days
steps = 24 * days


opts = myModel.simulate_options()
# opts["tfinal"] = 86400.0 #End time of simulation in seconds
opts['solver'] = 'CVode' # Solver Description: https://computation.llnl.gov/casc/sundials/description/description.html
opts["ncp"] = steps #steps # Change the number of communication points
opts['initialize'] = False
# opts['CVode_options']["maxh"] = 10
# opts['CVode_options']["report_continuously"] = True
# opts['CVode_options']["clock_step"] = True

# opts_b = myModel.simulate_options()
# # opts["tfinal"] = 86400.0 #End time of simulation in seconds
# opts_b['solver'] = 'CVode' # Solver Description: https://computation.llnl.gov/casc/sundials/description/description.html
# opts_b["ncp"] = (24*5) # Change the number of communication points

# opts_c = myModel.simulate_options()
# # opts["tfinal"] = 86400.0 #End time of simulation in seconds
# opts_c['solver'] = 'CVode' # Solver Description: https://computation.llnl.gov/casc/sundials/description/description.html
# opts_c["ncp"] = (24*100) # Change the number of communication points

# rtol = 1.0e-4
# atol = rtol*0.01
# opts['CVode_options']['atol'] = atol  # Options specific for CVode
# opts['CVode_options']['rtol'] = rtol  # Options specific for CVode
# opts['CVode_options']['discr'] = 'Adams' # Change from using BDF (stiff problems) to Adams
# opts['CVode_options']['iter'] = 'Newton' #Change to Newton , FixedPoint
# opts['CVode_options']['result_file_name']= 'output.txt'
# opts['CVode_options']['verbosity'] = 10

# vars = ['time', 'ics_envelopecassette1.DNI','Pump.internalVolumeFlow','Source.TAmbient']

# values = myModel.get(vars)

# values[0] = data['timestamp'][i]
# values[1] = data['DNI'][i]
# values[2] = data['exp_flowrate'][i]
# values[3] = data['exp_inlet'][i]

# myModel.set(vars, values)

myModel.initialize()

NumOfModules = myModel.get('NumOfModules')
print "Number of Modules = " + str(NumOfModules)

heatGen = [None]*max(range(0,50+1))
DNI = [None]*max(range(0,50+1))
timestamp = [None]*max(range(0,50+1))
Q_module1 = [None]*max(range(0,50+1))
Q_module2 = [None]*max(range(0,50+1))
Q_module3 = [None]*max(range(0,50+1))
Q_module4 = [None]*max(range(0,50+1))
Q_module5 = [None]*max(range(0,50+1))
Q_module6 = [None]*max(range(0,50+1))

for i in range(0,50):
	# DNI[i] = myModel.get("ics_envelopecassette1.DNI")
	DNI[i] = 10*i
	# myModel.set("ics_envelopecassette1.DNI", DNI[i]) 
	res = myModel.simulate(start_time=86400/2.0+10*i,final_time=86400/2.0+10*(i+1), input=("ics_envelopecassette1.ics_selfshading1.DNI_in", DNI[i]), options=opts)
	timestamp[i] = res['time'][0]
	Q_module1[i] = res['ics_envelopecassette1.ics_stack1.iCS_Module[1].modulereceiver1.water_Block_HX1.Q_module'][-1]
	Q_module2[i] = res['ics_envelopecassette1.ics_stack1.iCS_Module[2].modulereceiver1.water_Block_HX1.Q_module'][-1]
	Q_module3[i] = res['ics_envelopecassette1.ics_stack1.iCS_Module[3].modulereceiver1.water_Block_HX1.Q_module'][-1]
	Q_module4[i] = res['ics_envelopecassette1.ics_stack1.iCS_Module[4].modulereceiver1.water_Block_HX1.Q_module'][-1]
	Q_module5[i] = res['ics_envelopecassette1.ics_stack1.iCS_Module[5].modulereceiver1.water_Block_HX1.Q_module'][-1]
	Q_module6[i] = res['ics_envelopecassette1.ics_stack1.iCS_Module[6].modulereceiver1.water_Block_HX1.Q_module'][-1]
	heatGen[i] = [Q_module1[i],Q_module2[i],Q_module3[i],Q_module4[i],Q_module5[i],Q_module6[i]]

# Tstart = time_current
# myModel.time = Tstart
# myModel.initialize()

# myModel.reset()

# res_b = myModel.simulate(start_time=time_current, final_time=time_plus, options=opts_b)

# myModel.reset()

# res_c = myModel.simulate(start_time=time_current+3600*14, final_time=time_current+3600*15, options=opts_c)


# timestamp_b = res_b['time']
# timestamp_c = res_c['time']

# for i in range(1,NumOfModules+1):
# 	Module_string = 'ics_envelopecassette1.ics_stack1.iCS_Module['+str(i)+'].modulereceiver1.water_Block_HX1.Q_module'
# 	print Module_string
# 	Q_module[i] = res[Module_string]
# 	print Q_module[i]


# cellTemp1 = res['ics_envelopecassette1.ics_stack1.iCS_Module[1].modulereceiver1.water_Block_HX1.thermalresistor_celltoreceiver.port_b.T']
# cellTemp2 = res['ics_envelopecassette1.ics_stack1.iCS_Module[2].modulereceiver1.water_Block_HX1.thermalresistor_celltoreceiver.port_b.T']



# cellTemp1_b = res_b['ics_envelopecassette1.ics_stack1.iCS_Module[1].modulereceiver1.water_Block_HX1.thermalresistor_celltoreceiver.port_b.T']

# cellTemp1_c = res_c['ics_envelopecassette1.ics_stack1.iCS_Module[1].modulereceiver1.water_Block_HX1.thermalresistor_celltoreceiver.port_b.T']


plt.figure(1)
plt.plot(timestamp, Q_module1, 'r--')
plt.plot(timestamp, DNI, 'b')
plt.show()

# plt.plot(timestamp, cellTemp1, 'r--')
# plt.plot(timestamp_b, cellTemp1_b, 'b')
# plt.plot(timestamp_c, cellTemp1_c, 'g')
# plt.show()

# print cellTemp1
# print cellTemp2