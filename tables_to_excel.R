# # SETUP ------------------------------------------------
#
# # run table A example
# a <- table_a(stats_release_data)
#
# # create excel workbook object
# wb <- openxlsx::createWorkbook()
#
# # set sheet name
# sheet_name <- as.character(class(a))
#
# # create sheet for table A
# openxlsx::addWorksheet(wb, sheetName = sheet_name, gridLines = FALSE)
#
#
# # GLOBAL PARAMETERS ------------------------------------
#
# # set cell references (start row, start col)
# title_ref <- c(1, 2)
# curr_ref <- c(2, 2)
# trans_ref <- c(3, 2)
# inst_ref <- c(4, 5)
# count_ref <- c(5, 5)
# measure_ref <- c(6, 5)
# unit_ref <- c(7, 5)
# series_ref <- c(8, 5)
# data_ref <- c(9, 4)
# foot_ref <- c(14, 2)
#
# # set end col of table param
# end_col_ref <- data_ref[2] + length(a$series)
#
#
# # WRITE DATA / METADATA --------------------------------
#
# # write table A title to sheet
# openxlsx::writeData(wb, sheet = sheet_name, a$title, startRow = title_ref[1], startCol = title_ref[2],
#                     colNames = FALSE)
#
# # write table A currency to sheet
# openxlsx::writeData(wb, sheet = sheet_name, a$currency, startRow = curr_ref[1], startCol = curr_ref[2],
#                     colNames = FALSE)
#
# # write table A transformation to sheet
# openxlsx::writeData(wb, sheet = sheet_name, a$transformation, startRow = trans_ref[1], startCol = trans_ref[2],
#                     colNames = FALSE)
#
# # write table A instruments to sheet
# openxlsx::writeData(wb, sheet = sheet_name, as.matrix(t(a$instruments)), startRow = inst_ref[1], startCol = inst_ref[2],
#                     colNames = FALSE)
#
# # write table A counterparties to sheet
# openxlsx::writeData(wb, sheet = sheet_name, as.matrix(t(a$counterparties)), startRow = count_ref[1], startCol = count_ref[2],
#                     colNames = FALSE)
#
# # write table A measures to sheet
# openxlsx::writeData(wb, sheet = sheet_name, as.matrix(t(a$measures)), startRow = measure_ref[1], startCol = measure_ref[2],
#                     colNames = FALSE)
#
# # write table A units to sheet
# openxlsx::writeData(wb, sheet = sheet_name, as.matrix(t(a$units)), startRow = unit_ref[1], startCol = unit_ref[2],
#                     colNames = FALSE)
#
# # write table A series names to sheet
# openxlsx::writeData(wb, sheet = sheet_name, as.matrix(t(a$series)), startRow = series_ref[1], startCol = series_ref[2],
#                     colNames = FALSE)
#
# # write table A data to sheet
# openxlsx::writeData(wb, sheet = sheet_name, a$data, startRow = data_ref[1], startCol = data_ref[2],
#                     colNames = FALSE)
#
# # write table A footnotes to sheet
# openxlsx::writeData(wb, sheet = sheet_name, a$footnotes, startRow = foot_ref[1], startCol = foot_ref[2],
#                     colNames = FALSE)
#
#
# # ADD STYLES --------------------------------------------
#
# # add title style
# openxlsx::addStyle(wb, sheet = sheet_name, style = tab_styles$title_1, rows = title_ref[1],
#                    cols = title_ref[2], gridExpand = TRUE)
#
# # add subtitle styles
# openxlsx::addStyle(wb, sheet = sheet_name, style = tab_styles$title_2, rows = curr_ref[1]:trans_ref[1],
#                    cols = curr_ref[2]:trans_ref[2], gridExpand = TRUE)
#
# # add instrument / counterparty styles
# openxlsx::addStyle(wb, sheet = sheet_name, style = tab_styles$header_1, rows = inst_ref[1]:count_ref[1],
#                    cols = inst_ref[2]:end_col_ref, gridExpand = TRUE)
#
# # add measure / unit styles
# openxlsx::addStyle(wb, sheet = sheet_name, style = tab_styles$header_2, rows = measure_ref[1]:unit_ref[1],
#                    cols = measure_ref[2]:end_col_ref, gridExpand = TRUE)
#
# # add series styles
# openxlsx::addStyle(wb, sheet = sheet_name, style = tab_styles$series, rows = series_ref[1],
#                    cols = series_ref[2]:end_col_ref, gridExpand = TRUE)
#
# # add data styles
# openxlsx::addStyle(wb, sheet = sheet_name, style = tab_styles$body, rows = data_ref[1]:(data_ref[1] + nrow(a$data)),
#                    cols = data_ref[2]:(data_ref[2] + length(data_ref[2])), gridExpand = TRUE)
#
# # add footnote styles
# openxlsx::addStyle(wb, sheet = sheet_name, style = tab_styles$footnotes, rows = foot_ref[1],
#                    cols = foot_ref[2], gridExpand = TRUE)
#
#
# # INSTRUMENTS MERGE --------------------------------------------
#
# # get unique instrument vals
# instruments <- unique(a$instruments)
#
# # get positions of instrument vals
# instrument_pos <- list()
# for(i in 1:length(instruments)) {
#
#   pos <- which(a$instruments %in%
#                  instruments[[i]])
#
#   instrument_pos[[i]] <- pos
#
# }
#
# # merge instrument cells
#
# for (i in 1:length(instrument_pos)) {
#
#   openxlsx::mergeCells(wb, sheet = sheet_name,
#                        cols = (inst_ref[2] + instrument_pos[[i]][[1]] - 1):(inst_ref[2] + instrument_pos[[i]][[tail(instrument_pos[[1]], 1)]] - 1),
#                        rows = inst_ref[1])
#
#   openxlsx::mergeCells(wb, sheet = sheet_name,
#                        cols = (inst_ref[2] + instrument_pos[[i]][[1]] - 1):(inst_ref[2] + instrument_pos[[i]][[tail(instrument_pos[[1]], 1)]] - 1),
#                        rows = count_ref[1])
#
# }
#
#
# # EXPORT ------------------------------------------------
#
# # test excel output
# openxlsx::saveWorkbook(wb, file = "table_workbook_test.xlsx", overwrite = TRUE)
