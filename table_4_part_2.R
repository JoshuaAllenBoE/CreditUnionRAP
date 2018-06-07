#' @title Create table 4, part 2 from the credit union publication
#'
#' @description Creates Table 4, part 2 from the \href{https://www.bankofengland.co.uk/news?NewsTypes=571948d14c6943f7b5b7748ad80bef29&Direction=Upcoming}{Credit Union Quarterly Release}.
#'
#' @details \code{table_2} takes as input a standardised long format data frame of class \code{series_period_data},
#' uses associated metadata to create table elements and uses \code{dsdtabs} to format a table.
#'
#' @keywords internal
#'
#' @param x Object of class \code{series_period_data()}.
#'
#' @return Table 4, part 2
#'
#' @examples
#'
#'
#' table_4_part_2(CQ)
#'
#'
#' @export

table_4_part_2<- function(x) {

  x <- x  %>%
    dplyr::arrange(desc(Quarter)) %>%

    dplyr::filter(Data.Element %in% c("CQ_H3", "CQ_H5","CQ_H7","CQ_H9")) %>%
    dplyr:: group_by(Data.Element, Country, Quarter) %>%
    tidyr:: spread(key = Data.Element, value  = Position) %>%
    dplyr:: mutate_if(is.numeric, funs(replace(., is.na(.), 0))) %>%
    dplyr:: mutate(Arrears = CQ_H3 + CQ_H5 + CQ_H7 + CQ_H9)   %>%
    dplyr:: select(FRN, Country, Quarter, Arrears) %>%
    dplyr:: summarise(Arrears = sum(Arrears)) %>%
    dplyr:: select( Quarter, Country, Arrears) %>%
    dplyr:: slice(1:5) %>%
    dplyr:: mutate(Data.Element = "CQ_H3 + CQ_H5 + CQ_H7 + CQ_H9") %>%
    dplyr:: group_by(Data.Element, Quarter)


  UK <- x %>%
    dplyr:: summarise(Country = as.factor("UK"),
              Arrears = sum(Arrears)) %>%
    dplyr:: bind_rows( .)

  x<- dplyr:: bind_rows(x, UK)
  #x<-  rbind(x, UK)

  # create wide representation of the data
  x <- tidyr:: spread(x, key=Quarter, value= Arrears) #%>%
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
      units = "Number of submisions",
      title = "Quarterly Returns submitted",
      transformation = "Not seasonally adjusted",
      Box_code = x[,1]
    ),
    class = "table_5")
}
