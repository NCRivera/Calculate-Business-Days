import pandas

# START ----

holidays=[
    '2022-01-01', # New Years Day             
    '2022-01-17', # Martin Luther King Jr. Day
    '2022-02-21', # President's Day           
    '2022-05-30', # Memorial Day              
    '2022-07-04', # Independence Day          
    '2022-09-05', # Labor Day                 
    '2022-11-11', # Veterans Day              
    '2022-11-24', # Thanksgiving Day          
    '2022-12-25'  # Christmas Day             
]

df = pandas.DataFrame() # Data

df['n_days'] = df.apply(
    lambda x: len(pandas.bdate_range(
        start=x['Create Date'], 
        end=x['Appointment Date'], 
        freq='C', 
        closed='left', 
        holidays=holidays
    )), axis = 1
)


# Demonstration Below ----

# pandas.bdate_range(begin_dt, end_dt, freq="C", weekmask=weekmask, holidays=holidays)

# pandas.bdate_range(start=begin_dt, end=end_dt, closed='left')
# len(pandas.bdate_range(start=begin_dt, end=end_dt, closed='left'))

# pandas.bdate_range(start=begin_dt, end=end_dt, freq='C', closed='left',  holidays=holidays)
# len(pandas.bdate_range(start=begin_dt, end=end_dt, freq='C', closed='left',  holidays=holidays))

patient_name = ["A", "B", "C"]
create_date  = ["2022-01-03", "2022-01-14", "2022-01-03"]
appt_date    = ["2022-01-06", "2022-01-18", "2022-01-31"]

df = pandas.DataFrame(
    data=list(zip(patient_name, create_date, appt_date)), 
    columns = ['patient_name', 'create_date', 'appt_date']
)
df['n_days'] = df.apply(
    lambda x: len(pandas.bdate_range(
        start=x['create_date'], 
        end=x['appt_date'], 
        freq='C', 
        closed='left', 
        holidays=holidays
    )), axis = 1
)

