#!/usr/bin/env python
import cdsapi
from datetime import datetime, timedelta
from dateutil.relativedelta import relativedelta
import os.path 

c = cdsapi.Client()

def days_of_month(y, m):
    d0 = datetime(y, m, 1)
    d1 = d0 + relativedelta(months=1)
    out = list()
    while d0 < d1:
        out.append(d0.strftime('%Y-%m-%d'))
        d0 += timedelta(days=1)
    return out

year=range(1993, 2017)
mon=range(6,9)

for y in year:
    for m in mon:
        timerange = days_of_month(y, m)
        file = [str(os.path.dirname(os.path.realpath("__file__")) + '/ERA5_{yyyy}_0{mm}.grib'.format(yyyy = y, mm = m))]
        print(file[0])
        if not os.path.exists(file[0]):
             c.retrieve('reanalysis-era5-single-levels',
	        {
		'product_type':'reanalysis',
		'format':'grib',
		'variable':['2m_temperature','total_precipitation'],
		'date':timerange,
		'time':['00:00','06:00','12:00','18:00']
		},
                        file[0])
