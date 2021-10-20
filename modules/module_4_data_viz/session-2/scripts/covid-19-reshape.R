library(tidyr)

covid_data <- readr::read_csv("modules/module_4_data_viz/session-2/datasets/covid_states_timeseries_t.csv")
covid_data$monthID <- NULL
covid_data_t <- pivot_wider(data = covid_data, names_from = "Month",values_from = "Total Cases")
readr::write_csv(covid_data_t,"modules/module_4_data_viz/session-2/datasets/covid_data_transposed.csv")

