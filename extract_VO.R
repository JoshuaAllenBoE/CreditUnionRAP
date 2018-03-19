# GET DATA -----------------------------------

# retrieve stats release data from VOs

CQ <- read_CQ_vo()

# SAVE --------------------------------------------

devtools::use_data(CQ, overwrite = TRUE)
