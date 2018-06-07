#' @title Create publication excel file from template using user defined CQ data
#'
#' @description Creates Credit Union Quarterly publication excel document (without commentary) from the \href{https://www.bankofengland.co.uk/news?NewsTypes=571948d14c6943f7b5b7748ad80bef29&Direction=Upcoming}{Credit Union Quarterly Release}.
#'
#' @details Publication takes a standardised format using the user defined input data of class \code{series_period_data()}
#'
#' @keywords internal
#'
#' @param template Object of class .xlsx workbook to which the data will be published
#'
#' @param input.dates object of class vector of length 5 specifying reporting periods for the publication
#'
#' @return Credit Union Publication
#'
#' @examples
#'
#' library(CreditUnionRAP)
#' library(dplyr)
#' library(openxlsx)
#' Render_Publication(template = "N:/DATA/RDG/Credit Union Data/Publication/Credit Union RAP/CreditUnionRAP/PublishTemplate.xlsx",
#'                    input.dates = c("2017 Q1", "2017 Q2", "2017 Q3", "2017 Q4", "2018 Q1"))
#'
#'
#' @export

# READ in CQ data from latest file

Render_Publication <- function(template = "N:/DATA/RDG/Credit Union Data/Publication/Credit Union RAP/CreditUnionRAP/PublishTemplate.xlsx",
                               input.dates = c("2017 Q1", "2017 Q2", "2017 Q3", "2017 Q4", "2018 Q1"),
                               FileName = "2018 Q1.xlsx"){

 # read in CQ data and CQ 'missing' data from CQ VO data store - user to select reporting periods for this publication using input_dates
 CQ<- CreditUnionRAP:: read_CQ_vo(periods = input.dates)
 CQ_Missing<- CreditUnionRAP:: read_CQ_missing(periods = input.dates)
 CQ_Combine <- dplyr:: bind_rows(CQ, CQ_Missing)
 #read in the publish template file
 PublishTemplate <- openxlsx::loadWorkbook(file = template)

 ############################################################################################################
 #-------------------------- BASIC INFORMATION TAB -------------------------------------------#
 #Define tables for Basic Information tab
 table1_p1<- CreditUnionRAP:: table_1_part_1(CQ_Combine)$data
 table_1_P1_data <- table1_p1[, sapply(table1_p1, class) == "integer"]

 table1_p2<- CreditUnionRAP:: table_1_part_2(CQ_Combine)$data
 table_1_P2_data <- table1_p2[,-c(1,2)]

 table1_p3<- CreditUnionRAP:: table_1_part_3(CQ_Combine)$data
 table_1_P3_data <- table1_p3[,-c(1,2)]
 # # SETUP ------------------------------------------------

 # # set sheet name
 sheet_name_1 <- "Basic information"
 #
 # # GLOBAL PARAMETERS ------------------------------------
 #reference for table 1
 data_T1P1 <- c(9, 4)
 data_T1P2 <- c(15, 4)
 data_T1P3 <- c(21, 4)

 #reference for dates across all sheets except sheet 4
 dates_ref <- c(7, 4)


 bold_font <- openxlsx:: createStyle( textDecoration = "bold", fontSize = 8, fontName = "Arial", fontColour = "black", numFmt = "COMMA")

 #
 # # WRITE DATA / METADATA --------------------------------
 #write latest dates to heading in sheet 1
 y<- as.matrix(input.dates, nrow = 5, ncol = 1)
 dim(y) <- c(1,5)
 openxlsx::writeData(PublishTemplate, y, sheet = sheet_name_1, startRow = dates_ref[1], startCol = dates_ref[2],
                    colNames = FALSE)

 # # write table 1 title to sheet
 openxlsx::writeData(PublishTemplate, table_1_P1_data, sheet = sheet_name_1, startRow = data_T1P1[1], startCol = data_T1P1[2],
                     colNames = FALSE)
 openxlsx:: conditionalFormatting(PublishTemplate, sheet_name_1, cols=4:8, rows= data_T1P1[1], rule="!=0", style = bold_font)


 openxlsx::writeData(PublishTemplate, table_1_P2_data, sheet = sheet_name_1, startRow = data_T1P2[1], startCol = data_T1P2[2],
                     colNames = FALSE)
 openxlsx:: conditionalFormatting(PublishTemplate, sheet_name_1, cols=4:8, rows= data_T1P2[1], rule="!=0", style = bold_font)


 openxlsx::writeData(PublishTemplate, table_1_P3_data, sheet = sheet_name_1, startRow = data_T1P3[1], startCol = data_T1P3[2],
                     colNames = FALSE)
 openxlsx:: conditionalFormatting(PublishTemplate, sheet_name_1, cols=4:8, rows= data_T1P3[1], rule="!=0", style = bold_font)


 openxlsx::showGridLines(PublishTemplate,sheet = sheet_name_1, showGridLines = FALSE)
 openxlsx:: removeComment(PublishTemplate, sheet = sheet_name_1, rows = 1:100, cols = 1:100, gridExpand = TRUE)
 #

 # # ADD STYLES --------------------------------------------
 #
 # # add data element style
 openxlsx::addStyle(PublishTemplate, sheet = sheet_name_1, style = tab_styles$series, rows = data_T1P1[1]:(data_T1P1[1] + nrow(table_1_P1_data) -1),
                          cols = data_T1P1[2]:(data_T1P1[2] + length(table_1_P1_data)-1), gridExpand = TRUE)
 openxlsx::addStyle(PublishTemplate, sheet = sheet_name_1, style = tab_styles$series, rows = data_T1P2[1]:(data_T1P2[1] + nrow(table_1_P2_data) -1),
                    cols = data_T1P2[2]:(data_T1P2[2] + length(table_1_P2_data)-1), gridExpand = TRUE)
 openxlsx::addStyle(PublishTemplate, sheet = sheet_name_1, style = tab_styles$series, rows = data_T1P3[1]:(data_T1P3[1] + nrow(table_1_P3_data) -1),
                    cols = data_T1P3[2]:(data_T1P3[2] + length(table_1_P3_data)-1), gridExpand = TRUE)

 ############################################################################################################
 #-------------------------- BALANCE SHEET TAB -------------------------------------------#
 #Define tables for Basic Information tab
 table2_p1<- CreditUnionRAP:: table_2_part_1(CQ_Combine)$data
 table_2_P1_data <- table2_p1[,-c(1,2)]

 table2_p2<- CreditUnionRAP:: table_2_part_2(CQ_Combine)$data
 table_2_P2_data <- table1_p2[,-c(1,2)]

 table2_p3<- CreditUnionRAP:: table_2_part_3(CQ_Combine)$data
 table_2_P3_data <- table2_p3[,-c(1,2)]

 table2_p4<- CreditUnionRAP:: table_2_part_4(CQ_Combine)$data
 table_2_P4_data <- table2_p4[,-c(1,2)]

 table2_p5<- CreditUnionRAP:: table_2_part_5(CQ_Combine)$data
 table_2_P5_data <- table2_p5[,-c(1,2)]

 table2_p6<- CreditUnionRAP:: table_2_part_6(CQ_Combine)$data
 table_2_P6_data <- table2_p6[,-c(1,2)]

 table2_p7<- CreditUnionRAP:: table_2_part_7(CQ_Combine)$data
 table_2_P7_data <- table2_p7[,-c(1,2)]
 # # SETUP ------------------------------------------------

 # # set sheet name
 sheet_name_2 <- "Balance sheet"
 #
 # # GLOBAL PARAMETERS ------------------------------------
 #reference for table 1
 data_T2P1 <- c(9, 4)
 data_T2P2 <- c(15, 4)
 data_T2P3 <- c(21, 4)
 data_T2P4 <- c(27, 4)
 data_T2P5 <- c(33, 4)
 data_T2P6 <- c(39, 4)
 data_T2P7 <- c(45, 4)

 # # WRITE DATA / METADATA --------------------------------
 #
 #write latest dates to heading in sheet 1
 y<- as.matrix(input.dates, nrow = 5, ncol = 1)
 dim(y) <- c(1,5)
 openxlsx::writeData(PublishTemplate, y, sheet = sheet_name_2, startRow = dates_ref[1], startCol = dates_ref[2],
                     colNames = FALSE)
 # # write table 1 title to sheet
 openxlsx::writeData(PublishTemplate, table_2_P1_data, sheet = sheet_name_2, startRow = data_T2P1[1], startCol = data_T2P1[2],
                     colNames = FALSE)
 openxlsx:: conditionalFormatting(PublishTemplate, sheet_name_2, cols=4:8, rows= data_T2P1[1], rule="!=0", style = bold_font)


 openxlsx::writeData(PublishTemplate, table_2_P2_data, sheet = sheet_name_2, startRow = data_T2P2[1], startCol = data_T2P2[2],
                     colNames = FALSE)
 openxlsx:: conditionalFormatting(PublishTemplate, sheet_name_2, cols=4:8, rows= data_T2P2[1], rule="!=0", style = bold_font)


 openxlsx::writeData(PublishTemplate, table_2_P3_data, sheet = sheet_name_2, startRow = data_T2P3[1], startCol = data_T2P3[2],
                     colNames = FALSE)
 openxlsx:: conditionalFormatting(PublishTemplate, sheet_name_2, cols=4:8, rows= data_T2P3[1], rule="!=0", style = bold_font)


 openxlsx::writeData(PublishTemplate, table_2_P4_data, sheet = sheet_name_2, startRow = data_T2P4[1], startCol = data_T2P4[2],
                     colNames = FALSE)
 openxlsx:: conditionalFormatting(PublishTemplate, sheet_name_2, cols=4:8, rows= data_T2P4[1], rule="!=0", style = bold_font)


 openxlsx::writeData(PublishTemplate, table_2_P5_data, sheet = sheet_name_2, startRow = data_T2P5[1], startCol = data_T2P5[2],
                     colNames = FALSE)
 openxlsx:: conditionalFormatting(PublishTemplate, sheet_name_2, cols=4:8, rows= data_T2P5[1], rule="!=0", style = bold_font)


 openxlsx::writeData(PublishTemplate, table_2_P6_data, sheet = sheet_name_2, startRow = data_T2P6[1], startCol = data_T2P6[2],
                     colNames = FALSE)
 openxlsx:: conditionalFormatting(PublishTemplate, sheet_name_2, cols=4:8, rows= data_T2P6[1], rule="!=0", style = bold_font)


 openxlsx::writeData(PublishTemplate, table_2_P7_data, sheet = sheet_name_2, startRow = data_T2P7[1], startCol = data_T2P7[2],
                     colNames = FALSE)
 openxlsx:: conditionalFormatting(PublishTemplate, sheet_name_2, cols=4:8, rows= data_T2P7[1], rule="!=0", style = bold_font)


 openxlsx::showGridLines(PublishTemplate,sheet = sheet_name_2, showGridLines = FALSE)
 #

 # # ADD STYLES --------------------------------------------
 #
 # # add data element style
 openxlsx::addStyle(PublishTemplate, sheet = sheet_name_2, style = tab_styles$series, rows = data_T2P1[1]:(data_T2P1[1] + nrow(table_2_P1_data) -1),
                    cols = data_T2P1[2]:(data_T2P1[2] + length(table_2_P1_data)-1), gridExpand = TRUE)
 openxlsx::addStyle(PublishTemplate, sheet = sheet_name_2, style = tab_styles$series, rows = data_T2P2[1]:(data_T2P2[1] + nrow(table_2_P2_data) -1),
                    cols = data_T2P2[2]:(data_T2P2[2] + length(table_2_P2_data)-1), gridExpand = TRUE)
 openxlsx::addStyle(PublishTemplate, sheet = sheet_name_2, style = tab_styles$series, rows = data_T2P3[1]:(data_T2P3[1] + nrow(table_2_P3_data) -1),
                    cols = data_T2P3[2]:(data_T2P3[2] + length(table_2_P3_data)-1), gridExpand = TRUE)
 openxlsx::addStyle(PublishTemplate, sheet = sheet_name_2, style = tab_styles$series, rows = data_T2P4[1]:(data_T2P4[1] + nrow(table_2_P4_data) -1),
                    cols = data_T2P4[2]:(data_T2P4[2] + length(table_2_P4_data)-1), gridExpand = TRUE)
 openxlsx::addStyle(PublishTemplate, sheet = sheet_name_2, style = tab_styles$series, rows = data_T2P5[1]:(data_T2P5[1] + nrow(table_2_P5_data) -1),
                    cols = data_T2P5[2]:(data_T2P5[2] + length(table_2_P5_data)-1), gridExpand = TRUE)
 openxlsx::addStyle(PublishTemplate, sheet = sheet_name_2, style = tab_styles$series, rows = data_T2P6[1]:(data_T2P6[1] + nrow(table_2_P6_data) -1),
                    cols = data_T2P6[2]:(data_T2P6[2] + length(table_2_P6_data)-1), gridExpand = TRUE)
 openxlsx::addStyle(PublishTemplate, sheet = sheet_name_2, style = tab_styles$series, rows = data_T2P7[1]:(data_T2P7[1] + nrow(table_2_P7_data) -1),
                    cols = data_T2P7[2]:(data_T2P7[2] + length(table_2_P7_data)-1), gridExpand = TRUE)


 ############################################################################################################
 #-------------------------- INCOME STATEMENT TAB -------------------------------------------#
 #Define tables for income statement tab
 table3_p1<- CreditUnionRAP:: table_3_part_1(CQ_Combine)$data
 table_3_P1_data <- table3_p1[,-c(1,2)]

 table3_p2<- CreditUnionRAP:: table_3_part_2(CQ_Combine)$data
 table_3_P2_data <- table3_p2[,-c(1,2)]

 table3_p3<- CreditUnionRAP:: table_3_part_3(CQ_Combine)$data
 table_3_P3_data <- table3_p3[,-c(1,2)]

 # # # SETUP ------------------------------------------------
 # # set sheet name
 sheet_name_3<- "Income statement"

 # # # GLOBAL PARAMETERS ------------------------------------
 #reference for table 1
 data_T3P1 <- c(9, 5)
 data_T3P2 <- c(15, 5)
 data_T3P3 <- c(21, 5)

 # # WRITE DATA / METADATA --------------------------------
 #write latest dates to heading in sheet 1
 y<- as.matrix(input.dates, nrow = 5, ncol = 1)
 dim(y) <- c(1,5)
 openxlsx::writeData(PublishTemplate, y, sheet = sheet_name_3, startRow = dates_ref[1], startCol = dates_ref[2],
                     colNames = FALSE)
 # write table 3 title to sheet
 openxlsx::writeData(PublishTemplate, table_3_P1_data, sheet = sheet_name_3, startRow = data_T3P1[1], startCol = data_T3P1[2],
                     colNames = FALSE)
 openxlsx:: conditionalFormatting(PublishTemplate, sheet_name_3, cols=4:8, rows= data_T3P1[1], rule="!=0", style = bold_font)

 openxlsx::writeData(PublishTemplate, table_3_P2_data, sheet = sheet_name_3, startRow = data_T3P2[1], startCol = data_T3P2[2],
                     colNames = FALSE)
 openxlsx:: conditionalFormatting(PublishTemplate, sheet_name_3, cols=4:8, rows= data_T3P2[1], rule="!=0", style = bold_font)

 openxlsx::writeData(PublishTemplate, table_3_P3_data, sheet = sheet_name_3, startRow = data_T3P3[1], startCol = data_T3P3[2],
                     colNames = FALSE)
 openxlsx:: conditionalFormatting(PublishTemplate, sheet_name_3, cols=4:8, rows= data_T3P3[1], rule="!=0", style = bold_font)

 openxlsx::showGridLines(PublishTemplate,sheet = sheet_name_3, showGridLines = FALSE)

 # # ADD STYLES --------------------------------------------
 # add data element style
 openxlsx::addStyle(PublishTemplate, sheet = sheet_name_3, style = tab_styles$series, rows = data_T2P1[1]:(data_T3P1[1] + nrow(table_3_P1_data) -1),
                    cols = data_T3P1[2]:(data_T3P1[2] + length(table_3_P1_data)-1), gridExpand = TRUE)
 openxlsx::addStyle(PublishTemplate, sheet = sheet_name_3, style = tab_styles$series, rows = data_T2P2[1]:(data_T3P2[1] + nrow(table_3_P2_data) -1),
                    cols = data_T3P2[2]:(data_T3P2[2] + length(table_3_P2_data)-1), gridExpand = TRUE)
 openxlsx::addStyle(PublishTemplate, sheet = sheet_name_3, style = tab_styles$series, rows = data_T2P3[1]:(data_T3P3[1] + nrow(table_3_P3_data) -1),
                    cols = data_T3P3[2]:(data_T3P3[2] + length(table_3_P3_data)-1), gridExpand = TRUE)


 ############################################################################################################
 #-------------------------- ARREARS TAB -------------------------------------------#
 #Define tables for arrears tab
 table4_p1<- CreditUnionRAP:: table_4_part_1(CQ_Combine)$data
 table_4_P1_data <- table4_p1[,-c(1,2)]

 table4_p2<- CreditUnionRAP:: table_4_part_2(CQ_Combine)$data
 table_4_P2_data <- table4_p2[,-c(1,2)]

 # # SETUP ------------------------------------------------

 # # set sheet name
 sheet_name_4 <- "Arrears"
 #
 # # GLOBAL PARAMETERS ------------------------------------
 #data ref for sheet 4
 dates_ref_sheet_4 <- c(7, 5)
 #reference for table 1
 data_T4P1 <- c(9, 5)
 data_T4P2 <- c(15, 5)

 # # WRITE DATA / METADATA --------------------------------
 #
 #write latest dates to heading in sheet 1
 y<- as.matrix(input.dates, nrow = 5, ncol = 1)
 dim(y) <- c(1,5)
 openxlsx::writeData(PublishTemplate, y, sheet = sheet_name_4, startRow = dates_ref_sheet_4[1], startCol = dates_ref_sheet_4[2],
                     colNames = FALSE)
 # # write table 1 title to sheet
 openxlsx::writeData(PublishTemplate, table_4_P1_data, sheet = sheet_name_4, startRow = data_T4P1[1], startCol = data_T4P1[2],
                     colNames = FALSE)
 openxlsx:: conditionalFormatting(PublishTemplate, sheet_name_4, cols=5:9, rows= data_T4P1[1], rule="!=0", style = bold_font)


 openxlsx::writeData(PublishTemplate, table_4_P2_data, sheet = sheet_name_4, startRow = data_T4P2[1], startCol = data_T4P2[2],
                     colNames = FALSE)
 openxlsx:: conditionalFormatting(PublishTemplate, sheet_name_4, cols=5:9, rows= data_T4P2[1], rule="!=0", style = bold_font)

 openxlsx::showGridLines(PublishTemplate,sheet = sheet_name_4, showGridLines = FALSE)
 #

 # # ADD STYLES --------------------------------------------
 #
 # # add data element style
 openxlsx::addStyle(PublishTemplate, sheet = sheet_name_4, style = tab_styles$series, rows = data_T4P1[1]:(data_T4P1[1] + nrow(table_4_P1_data) -1),
                    cols = data_T4P1[2]:(data_T4P1[2] + length(table_4_P1_data)-1), gridExpand = TRUE)
 openxlsx::addStyle(PublishTemplate, sheet = sheet_name_4, style = tab_styles$series, rows = data_T4P2[1]:(data_T4P2[1] + nrow(table_4_P2_data) -1),
                    cols = data_T4P2[2]:(data_T4P2[2] + length(table_4_P2_data)-1), gridExpand = TRUE)




 # # EXPORT ------------------------------------------------
 #
 # # test excel output
 openxlsx::saveWorkbook(PublishTemplate, file = FileName, overwrite = TRUE)

}
