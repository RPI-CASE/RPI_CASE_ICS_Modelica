from pyfmi import load_fmu

myModel = load_fmu('ICSolar_ICS_Skeleton.fmu')

days = 365
year_time = 86400.0 * days
steps = 24 * days


opts = myModel.simulate_options()
# opts["tfinal"] = 86400.0 #End time of simulation in seconds
opts["ncp"] = steps #Specify that 24 output points should be returned


res = myModel.simulate(final_time=year_time, options=opts)

timestamp = res['time']
cellTemp1 = res['ics_envelopecassette1.ics_stack1.iCS_Module[1].modulereceiver1.water_Block_HX1.thermalresistor_celltoreceiver.port_b.T']
cellTemp2 = res['ics_envelopecassette1.ics_stack1.iCS_Module[2].modulereceiver1.water_Block_HX1.thermalresistor_celltoreceiver.port_b.T']

print timestamp
print cellTemp1
print cellTemp2