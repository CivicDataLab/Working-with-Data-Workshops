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

# For screenshots
# https://www.garrickadenbuie.com/blog/sharing-xaringan-slides/#embed-your-slides

library(webshot2)
screenshot_share_image <- function(
    slides_rmd,
    path_image = "share-card.png"
) {
  if (!requireNamespace("webshot2", quietly = TRUE)) {
    stop(
      "`webshot2` is required: ",
      'remotes::install_github("rstudio/webshot2")'
    )
  }
  
  webshot2::rmdshot(
    doc = slides_rmd,
    file = path_image,
    vheight = 600,
    vwidth = 600 * 191 / 100,
    rmd_args = list(
      output_options = list(
        nature = list(ratio = "191:100"),
        self_contained = TRUE
      )
    )
  )
  
  path_image
}
