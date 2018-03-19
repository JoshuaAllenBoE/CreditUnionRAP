#' @title Create table 1, part 1 from the credit union publication
#'
#' @description Creates Table 1, part 1 from the \href{https://www.bankofengland.co.uk/news?NewsTypes=571948d14c6943f7b5b7748ad80bef29&Direction=Upcoming}{Credit Union Quarterly Release}.
#'
#' @details \code{table_1} takes as input a standardised long format data frame of class \code{series_period_data},
#' uses associated metadata to create table elements and uses \code{dsdtabs} to format a table.
#'
#' @keywords internal
#'
#' @param x Object of class \code{series_period_data()}.
#'
#' @return Table 1, part 1
#'
#' @examples
#'
#'
#' table_1_part_1(CQ)
#'
#'
#' @export

table_1_part_1<- function(x) {

  x <- x %>%
    dplyr::arrange(desc(Quarter)) %>%
    dplyr::filter(Data.Element == "CQ_A2") %>%
    dplyr:: group_by(Country, Quarter) %>%
    dplyr:: add_tally() %>%
    dplyr:: distinct(Country, Quarter, .keep_all = TRUE) %>%
    dplyr:: select(Data.Element, Country, Quarter, n) %>%
    dplyr::slice(1:5) %>%
    dplyr:: group_by(Data.Element, Quarter)

  UK <- x %>%
    summarise(Country = as.character("UK"),
              n = sum(n)) %>%
    bind_rows( .)

  x<-  rbind(x, UK)

  # create wide representation of the data
  x <- tidyr::spread(x, key=Quarter, value=n)

  names<-  data.frame(a = c("UK", "England", "Scotland", "Wales","Northern Ireland"))

  x<- x[match(names$a, x$Country),]


  # Define the class here ----

  structure(
    list(
      data = x,
      quarters = colnames(x),
      series = as.character(unique(x$Data.Element)),
      country = as.character(x$Country),
      units = "Number of submisions",
      title = "Quarterly Returns submitted"
    ),
    class = "table_1")


}
