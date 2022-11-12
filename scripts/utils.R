library(kableExtra)
library(dplyr)
library(readr)

sample_df <- data.frame(
  stringsAsFactors = FALSE,
  Id = c(1L, 2L, 3L, 4L, 5L),
  Name = c("Ajay", "Vijay", "Radhika", "Shikha", "Hrithik"),
  Gender = c("M", "M", "F", "F", "M"),
  City = c("Delhi", "Mumbai", "Bhipal", "Jaipur", "Jaipur"),
  Dep_Id = c(1L, 2L, 1L, 2L, 2L),
  Points = c(10L, 5L, 15L, 25L, 10L)
)

census_11 <-
  readr::read_csv("data/census-2011-pca-ndap.csv",
                  col_types = cols())
