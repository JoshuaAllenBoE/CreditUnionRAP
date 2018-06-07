#' @title Extracting historic VO data for stats release series
#'
#' @description Automated exports supporting the credit union statistical release - quarterly
#'
#' @details The best way to understand what happens when you run this function
#' is to look at the source code.
#'
#' @param path = "N:/DATA/RDG/Credit Union Data/Publication/Credit Union RAP/CreditUnionRAP/Data/CQ_VO.xlsx"
#'
#' @param sheet = sheet = "VO"
#'
#' @param periods = c("2016 Q4", "2017 Q1", "2017 Q2", "2017 Q3", "2017 Q4")

#' @return a tibble
#'
#' @examples
#'
#' library(CreditUnionRAP)
#' library(dplyr)
#' library(tibble)
#' library(readxl)
#'
#' read_CQ_vo()
#'
#' @export
#'

read_CQ_vo <- function(path = "N:/DATA/RDG/Credit Union Data/Publication/Credit Union RAP/CreditUnionRAP/CQ_VO.xlsx",
                       sheet = "VO",
                       periods =  c("2017 Q1", "2017 Q2", "2017 Q3", "2017 Q4", "2018 Q1"))
{

  data <- readxl:: read_xlsx(path = path, col_names =  TRUE, sheet = sheet)
  colnames(data)[1] <- "FRN"
  colnames(data)[2] <- "Data.Element"
  colnames(data)[3] <- "Country"
  colnames(data)[4] <- "Quarter"
  colnames(data)[5] <- "Year.End"
  colnames(data)[6] <- "Position"


  data <- data %>%
    dplyr:: filter(!FRN == 0 & !Data.Element ==0 & !Position == 0) %>%
    dplyr:: filter(Quarter %in% periods) %>%
    dplyr:: filter(!FRN == 999999) %>%
    #dplyr:: distinct(FRN, Data.Element, Quarter, Position, keep_all = FALSE)%>%
    tibble:: as.tibble()


  return(data)

}

#' @title Extracting missing data for stats release series, entered manually into workbook
#'
#' @description Automated exports supporting the credit union statistical release - quarterly
#'
#' @details The best way to understand what happens when you run this function
#' is to look at the source code.
#'
#' @param path = "N:/DATA/RDG/Credit Union Data/Publication/Credit Union RAP/CreditUnionRAP/Data/CQ_VO.xlsx"
#'
#' @param sheet = sheet = "VO_Missing"
#'
#' @param periods = c("2016 Q4", "2017 Q1", "2017 Q2", "2017 Q3", "2017 Q4")

#' @return a tibble
#'
#' @examples
#'
#' library(CreditUnionRAP)
#' library(dplyr)
#' library(readxl)
#' library(tibble)
#'
#' read_CQ_missing()
#'
#' @export
#'

read_CQ_missing <- function(path = "N:/DATA/RDG/Credit Union Data/Publication/Credit Union RAP/CreditUnionRAP/CQ_VO.xlsx",
                            sheet = "VO_Missing",
                            periods =  c("2017 Q1", "2017 Q2", "2017 Q3", "2017 Q4", "2018 Q1"))
{

  data <- readxl:: read_xlsx(path = path, col_names =  TRUE, sheet = sheet)
  colnames(data)[1] <- "FRN"
  colnames(data)[2] <- "Data.Element"
  colnames(data)[3] <- "Country"
  colnames(data)[4] <- "Quarter"
  colnames(data)[5] <- "Year.End"
  colnames(data)[6] <- "Position"


  data <- data %>%
    dplyr:: filter(!FRN == 0 & !Data.Element ==0 & !Position == 0) %>%
    dplyr:: filter(Quarter %in% periods) %>%
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
#' library(dplyr)
#' library(tidyr)
#' library(utils)
#' flatten_and_select(file = "CQData.csv")
#'
#'
#'
#' @export
#'

flatten_and_select <- function(file, file.name = "CQExtract_2018Q1"){
#Import the data
setwd("N:/DATA/RDG/Credit Union Data/Publication/Credit Union RAP/CreditUnionRAP")
CQData <- utils:: read.csv(file = file, stringsAsFactors=FALSE)

#Select columns
CQData <- CQData[,c("Firm.Code..FRN.","Firm.Name","Reporting.Date","CQ_A2","CQ_A7",
                    "CQ_C8","CQ_C9","CQ_C16","CQ_F3","CQ_F9","CQ_G1","CQ_G2","CQ_G8","CQ_H1",
                    "CQ_H2","CQ_H3","CQ_H4",
                    "CQ_H5","CQ_H6","CQ_H7","CQ_H8","CQ_H9","CQ_H10","CQ_J13","CQ_K18",
                    "CQ_P1","CQ_P5")]

CQDataFlat <- tidyr:: gather(CQData, key = Data.Element, value = Position, CQ_A2:CQ_P5)
utils:: write.csv(CQDataFlat,"N:/DATA/RDG/Credit Union Data/Publication/Credit Union RAP/CreditUnionRAP/CQExtract_2018Q1.csv")
}


