#' @title Read a CQ extract from the N drive
#'
#' @description read a CQ VO export from N drive into a tidy dataframe.
#'
#' @keywords internal
#'
#' @param file Filepath of a VO (.csv) export#
#'
#' @param periods the periods used in publication of interest
#'
#' @return a tibble
#'
#' @examples
#'
#' library(dplyr)
#' library(utils)
#'
#' read_CQ_vo(file = "//MFSD/Data/DATA/RDG/Credit Union Data/Publication/Credit Union RAP/Credit Union RAP/CQ.VO.csv", periods = c("2016 Q4", "2017 Q1", "2017 Q2", "2017 Q3", "2017 Q4")) # if the file isn't open
#'
#'
#' @export

read_CQ_vo <- function(file = "N:/DATA/RDG/Credit Union Data/Publication/Credit Union RAP/CreditUnionRAP/Data/CQ.VO.csv", periods = c("2016 Q4", "2017 Q1", "2017 Q2", "2017 Q3", "2017 Q4")) {

  data <- read.csv(file = file, header = TRUE)
  data <- data %>%
    dplyr:: filter(!FRN == 0 & !Data.Element ==0 & !Position == 0) %>%
    dplyr:: filter(Quarter %in% periods) %>%
    dplyr:: filter(!FRN == 999999) %>%
    tibble:: as.tibble()


  return(data)

}

#' @title Transport and select columns for origanl extract
#'
#' @description read a CQ VO export from BEEDS and format columns
#'
#' @keywords internal
#'
#' @param file Filepath of a VO (.csv) export
#'
#' @return a tibble
#'
#' @examples
#'
#' library(dplyr)]
#' library(tidyr)
#' flatten_and_select(file = "//MFSD/Data/DATA/RDG/Credit Union Data/Publication/Credit Union RAP/Credit Union RAP/CQData.csv")
#'
#'
#'
#' @export
#'

flatten_and_select <- function(file){
#Import the data
CQData <- read.csv(file = file, stringsAsFactors=FALSE)

#Select columns
CQData <- CQData[,c("Firm.Code..FRN.","Firm.Name","Reporting.Date","CQ_A2","CQ_A7",
                    "CQ_C8","CQ_C9","CQ_C16","CQ_F3","CQ_F9","CQ_G1","CQ_G2","CQ_G8","CQ_H1",
                    "CQ_H2","CQ_H3","CQ_H4",
                    "CQ_H5","CQ_H6","CQ_H7","CQ_H8","CQ_H9","CQ_H10","CQ_J13","CQ_K18",
                    "CQ_P1","CQ_P5")]

CQDataFlat <- gather(CQData, key = Data.Element, value = Position, CQ_A2:CQ_P5)
write.csv(CQDataFlat,"CQDataFlat.csv")
}


