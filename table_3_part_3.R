#' @title Create table 3, part 3 from the credit union publication
#'
#' @description Creates Table 3, part 3 from the \href{https://www.bankofengland.co.uk/news?NewsTypes=571948d14c6943f7b5b7748ad80bef29&Direction=Upcoming}{Credit Union Quarterly Release}.
#'
#' @details \code{table_1} takes the difference between the decumulated income and expenditure data to calculate intermim profit/loss
#'
#' @keywords internal
#'
#' @param x Object of class \code{series_period_data()}.
#'
#' @return Table 3, part 3
#'
#' @examples
#'
#'
#' table_3_part_3()
#'
#'
#' @export


table_3_part_3<- function(...) {

  names<-  data.frame(a = c("UK", "England", "Scotland", "Wales","Northern Ireland"))


  income<-  CreditUnionRAP:: table_3_part_1(CQ_Combine)$data
  expenditure <- CreditUnionRAP:: table_3_part_2(CQ_Combine)$data
  x<- income[,-c(1)] - expenditure[,-c(1)]
  x<- tibble:: add_column(x, Country = as.character(names$a), .before = 1) %>%
      tibble:: as.tibble()

  colnames(x)[1] <- ""

  # Define the class here ----

  structure(
    list(
      data = x,
      quarters = colnames(x[!colnames(x) == ""]),
      country = x[,1],
      units = paste("\ua3", "Thousands"),
      title = "Interim profit / loss",
      transformation = "Not seasonally adjusted",
      Box_code = x[,1]
    ),
    class = "table_3")
}

