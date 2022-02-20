
# install.packages(bizdays)
# install.packages(timeDate)
# install.packages(lubridate)

library(bizdays)
library(tidyverse)
library(timeDate)
library(lubridate)

# Make the year dynamic with the dataset that comes in. Check appointment date 
# and pluck the year from it.

# appt_yr <- data %>% select(appointment_date) %>% slice(1) %>% pull()
appt_yr <- Sys.Date() %>% lubridate::year() # REMOVE LINE AFTER TESTING


# Create a dataset of calendars ----
new_day      <- timeDate::USNewYearsDay(year = appt_yr)     %>% as.character()
mlk_day      <- timeDate::USMLKingsBirthday(year = appt_yr) %>% as.character()
pres_day     <- timeDate::USPresidentsDay(year = appt_yr)   %>% as.character()
mem_day      <- timeDate::USMemorialDay(year = appt_yr)     %>% as.character()
july_four    <- timeDate::USIndependenceDay(year = appt_yr) %>% as.character()
labor_day    <- timeDate::USLaborDay(year = appt_yr)        %>% as.character()
vets_day     <- timeDate::USVeteransDay(year = appt_yr)     %>% as.character()
thanksgiving <- timeDate::USThanksgivingDay(year = appt_yr) %>% as.character()
christmas    <- timeDate::USChristmasDay(year = appt_yr)    %>% as.character()
# listHolidays()

holiday_names <- c(
  "New Years Day", "Martin Luther King Jr. Day", "President's Day", 
  "Memorial Day",  "Independence Day",           "Labor Day", 
  "Veterans Day",  "Thanksgiving Day",           "Christmas Day"
)

holiday_dates <- c(
  new_day,  mlk_day,      pres_day, 
  mem_day,  july_four,    labor_day, 
  vets_day, thanksgiving, christmas
)

holiday_tbl <- tibble(
  Holidays = holiday_names, 
  Dates    = ymd(holiday_dates)
) %>% 
  mutate(
    week_day_num = wday(x = Dates, abbr = T, week_start = 1), 
    week_day_fct = wday(x = Dates, label = T)
  )


## Building the Calendar ----
weekend <- c("saturday","sunday")
holidays_vec <- holiday_tbl %>% select(Dates) %>% pull()

business_calendar <- create.calendar(
  name     = "mci_calendar", 
  weekdays = weekend, 
  holidays = holidays_vec
)

bizdays("2022-01-01", "2022-02-01", cal = business_calendar)

tibble(
  patient_name = c("A", "B", "C"),
  create_date  = ymd(c("2022-01-03", "2022-01-14", "2022-01-03")), 
  appt_date    = ymd(c("2022-01-06", "2022-01-18", "2022-01-31"))
) %>% 
  mutate(n_days = bizdays(create_date, appt_date, cal = business_calendar))
