#' @title Create table 2, part 3 from the credit union publication
#'
#' @description Creates table 2, part 3 from the \href{https://www.bankofengland.co.uk/news?NewsTypes=571948d14c6943f7b5b7748ad80bef29&Direction=Upcoming}{Credit Union Quarterly Release}.
#'
#' @details \code{table_2} takes as input a standardised long format data frame of class \code{series_period_data},
#' uses associated metadata to create table elements and uses \code{dsdtabs} to format a table.
#'
#' @keywords internal
#'
#' @param x Object of class \code{series_period_data()}.
#'
#' @return table 2, part 3
#'
#' @examples
#'
#'
#' table_2_part_3(CQ)
#'
#'
#' @export

table_2_part_3<- function(x) {

  x <- x %>%
    dplyr::arrange(desc(Quarter)) %>%
    dplyr::filter(Data.Element == "CQ_F9") %>%
    dplyr:: group_by(Data.Element, Country, Quarter) %>%
    dplyr:: summarise(Position = sum(Position)/1000) %>% # convert into thousands (£)
    dplyr:: select(Data.Element, Country, Quarter, Position) %>%
    dplyr::slice(1:5) %>%
    dplyr:: group_by(Data.Element, Quarter)


  UK <- x %>%
    dplyr:: summarise(Country = as.character("UK"),
              Position = sum(Position)) %>%
    bind_rows( .)

  x<-  rbind(x, UK)

  # create wide representation of the data
  x <- tidyr::spread(x, key=Quarter, value= Position) #%>%
  #dplyr::mutate_all(funs(prettyNum(., big.mark=",")))

  names<-  data.frame(a = c("UK", "England", "Scotland", "Wales","Northern Ireland"))

  x<- x[match(names$a, x$Country),]
  colnames(x)[1] <- ""
  colnames(x)[2] <- ""


  # Define the class here ----

  structure(
    list(
      data = x,
      quarters = colnames(x[!colnames(x) == ""]),
      country = x[,2],
      units = paste("\ua3", "Thousands"),
      title = "Total capital (a)",
      transformation = "Not seasonally adjusted",
      Box_code = x[,1]
    ),
    class = "table_2")
}

