from pyfmi import load_fmu

myModel = load_fmu('ICSolar_ICS_Skeleton.fmu')

days = 365
year_time = 86400.0 * days
steps = 24 * days


opts = myModel.simulate_options()
# opts["tfinal"] = 86400.0 #End time of simulation in seconds
opts['solver'] = 'CVode' # Solver Description: https://computation.llnl.gov/casc/sundials/description/description.html
opts["ncp"] = steps # Change the number of communication points

# rtol = 1.0e-4
# atol = rtol*0.01
# opts['CVode_options']['atol'] = atol  # Options specific for CVode
# opts['CVode_options']['rtol'] = rtol  # Options specific for CVode
# opts['CVode_options']['discr'] = 'Adams' # Change from using BDF (stiff problems) to Adams
# opts['CVode_options']['iter'] = 'Newton' #Change to Newton , FixedPoint
# opts['CVode_options']['result_file_name']= 'output.txt'
# opts['CVode_options']['verbosity'] = 10

vars = ['time', 'ics_envelopecassette1.DNI','Pump.internalVolumeFlow','Source.TAmbient']

values = myModel.get(vars)

values[0] = data['timestamp'][i]
values[1] = data['DNI'][i]
values[2] = data['exp_flowrate'][i]
values[3] = data['exp_inlet'][i]

myModel.set(vars, values)

res = myModel.simulate(final_time=year_time, options=opts)

timestamp = res['time']
cellTemp1 = res['ics_envelopecassette1.ics_stack1.iCS_Module[1].modulereceiver1.water_Block_HX1.thermalresistor_celltoreceiver.port_b.T']
cellTemp2 = res['ics_envelopecassette1.ics_stack1.iCS_Module[2].modulereceiver1.water_Block_HX1.thermalresistor_celltoreceiver.port_b.T']

print timestamp
print cellTemp1
print cellTemp2