# GET DATA -----------------------------------

# retrieve stats release data from VOs
library(dplyr)
library(readxl)
library(tibble)

 periods = c("2017 Q1", "2017 Q2", "2017 Q3", "2017 Q4", "2018 Q1")


    CQ <- readxl:: read_xlsx(path = "N:/DATA/RDG/Credit Union Data/Publication/Credit Union RAP/CreditUnionRAP/CQ_VO.xlsx", sheet = "VO", col_names = TRUE)
    colnames(CQ)[1] <- "FRN"
    colnames(CQ)[2] <- "Data.Element"
    colnames(CQ)[3] <- "Country"
    colnames(CQ)[4] <- "Quarter"
    colnames(CQ)[5] <- "Year.End"
    colnames(CQ)[6] <- "Position"

     CQ <- dplyr:: filter(CQ, !FRN == 0 & !Data.Element ==0 & !Position == 0, Quarter %in% periods, !FRN == 999999)

# SAVE --------------------------------------------

devtools::use_data(CQ, overwrite = TRUE)
