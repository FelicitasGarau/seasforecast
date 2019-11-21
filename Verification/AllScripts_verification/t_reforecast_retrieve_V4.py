#!/usr/bin/env python
import cdsapi
import os.path

c = cdsapi.Client()

mon=["%.2d" % i for i in range(3,7)]

steps = []
for i in range(6,5161,6):
        steps.append(i)

for y in range(1993, 2017):
    for m in mon:
        file = [str(os.path.dirname(os.path.realpath("__file__")) + '/t_refc_{year}_{month}.grib'.format(year = y, month = m))]
        if not os.path.exists(file[0]):      
            c.retrieve('seasonal-original-single-levels',
                        {
                                'originating_centre':'ecmwf',
                                'system':'5',
                                'variable':['2m_temperature','total_precipitation'],
                                'year':y,
                                'month':m,
                                'day':'01',
                                'leadtime_hour':steps,
                                'format':'grib'
                        },
                        file[0])

