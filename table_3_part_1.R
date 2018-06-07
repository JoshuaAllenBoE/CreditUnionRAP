#' @title Create table 3, part 1 from the credit union publication
#'
#' @description Creates Table 3, part 1 from the \href{https://www.bankofengland.co.uk/news?NewsTypes=571948d14c6943f7b5b7748ad80bef29&Direction=Upcoming}{Credit Union Quarterly Release}.
#'
#' @details \code{table_1} takes as input a standardised long format data frame of class \code{series_period_data},
#' uses associated metadata to create table elements and uses \code{dsdtabs} to format a table.
#'
#' @keywords internal
#'
#' @param x Object of class \code{series_period_data()}.
#'
#' @return Table 3, part 1
#'
#' @examples
#'
#'
#' table_3_part_1(CQ)
#'
#'
#' @export


table_3_part_1<- function(x) {

  #input_dates <- c("2017 Q1", "2017 Q2", "2017 Q3", "2017 Q4", "2018 Q1")
  input_dates <- c("2017 Q1", "2017 Q2", "2017 Q3", "2017 Q4", "2018 Q1")

 #  input_date_5 <- x  %>%
 #    #dplyr::arrange(desc(Quarter)) %>%
 #    dplyr::filter(Data.Element %in% c("CQ_J13"), Quarter %in% input_dates[5]) %>%
 #    dplyr:: select( Quarter, Country, Year.End, Position) %>%
 #    dplyr:: group_by( Country, Quarter, Year.End) %>%
 #    dplyr:: summarise(Position = sum(Position)/1000) #convert into 1000s
 #
 #  input_date_4 <- x  %>%
 #    #dplyr::arrange(desc(Quarter)) %>%
 #    dplyr::filter(Data.Element %in% c("CQ_J13"), Quarter %in% input_dates[4]) %>%
 #    dplyr:: select( Quarter, Country, Year.End, Position) %>%
 #    dplyr:: group_by( Country, Quarter, Year.End) %>%
 #    dplyr:: summarise(Position = sum(Position)/1000) #convert into 1000s
 #
 #  input_date_3 <- x  %>%
 #    #dplyr::arrange(desc(Quarter)) %>%
 #    dplyr::filter(Data.Element %in% c("CQ_J13"), Quarter %in% input_dates[3]) %>%
 #    dplyr:: select( Quarter, Country, Year.End, Position) %>%
 #    dplyr:: group_by( Country, Quarter, Year.End) %>%
 #    dplyr:: summarise(Position = sum(Position)/1000) #convert into 1000s
 #
 #  input_date_2 <- x  %>%
 #    #dplyr::arrange(desc(Quarter)) %>%
 #    dplyr::filter(Data.Element %in% c("CQ_J13"), Quarter %in% input_dates[2]) %>%
 #    dplyr:: select( Quarter, Country, Year.End, Position) %>%
 #    dplyr:: group_by( Country, Quarter, Year.End) %>%
 #    dplyr:: summarise(Position = sum(Position)/1000) #convert into 1000s
 #
 #  input_date_1 <- x  %>%
 #    #dplyr::arrange(desc(Quarter)) %>%
 #    dplyr::filter(Data.Element %in% c("CQ_J13"), Quarter %in% input_dates[1]) %>%
 #    dplyr:: select( Quarter, Country, Year.End, Position) %>%
 #    dplyr:: group_by( Country, Quarter, Year.End) %>%
 #    dplyr:: summarise(Position = sum(Position)/1000) #convert into 1000s
 #
 #
 # x<- dplyr:: bind_rows(input_date_1, input_date_2, input_date_3, input_date_4, input_date_5) %>%
 #   dplyr:: ungroup() %>%
 #   dplyr:: group_by(Year.End) %>%
 #   dplyr:: select(Country, Year.End, Quarter, Position) %>%
 #   dplyr:: arrange(desc( Country )) %>%
 #   dplyr:: arrange(desc(Year.End)) %>%
 #   dplyr:: group_by(Country, Year.End) %>%
 #   dplyr:: mutate(lag.value = dplyr::lag(Position, n = 1L, default = first(Position))) %>%
 #   dplyr:: mutate(decumulation =  Position - lag.value)
 #
 #
 # Dec.Q1 <- x %>%
 #   dplyr:: ungroup() %>%
 #   dplyr:: filter(Year.End == "DEC" & Quarter == "2017 Q1") %>%
 #   dplyr:: select(Position)
 #
 # Mar.Q2 <- x %>%
 #   dplyr:: ungroup() %>%
 #   dplyr:: filter(Year.End == "MAR" & Quarter == "2017 Q2") %>%
 #   dplyr:: select(Position)
 #
 # Sep.Q4.Eng <- x %>%
 #   dplyr:: ungroup() %>%
 #   dplyr:: filter(Year.End == "SEP" & Quarter == "2017 Q4" & Country == "England") %>%
 #   dplyr:: select(Position)
 #
 # Sep.Q4.Wal <- x %>%
 #   dplyr:: ungroup() %>%
 #   dplyr:: filter(Year.End == "SEP" & Quarter == "2017 Q4" & Country == "Wales") %>%
 #   dplyr:: select(Position)
 #
 # Sep.Q4.Scot <- x %>%
 #   dplyr:: ungroup() %>%
 #   dplyr:: filter(Year.End == "SEP" & Quarter == "2017 Q4" & Country == "Scotland") %>%
 #   dplyr:: select(Position)
 #
 # Sep.Q4.NI <- x %>%
 #   dplyr:: ungroup() %>%
 #   dplyr:: filter(Year.End == "SEP" & Quarter == "2017 Q4" & Country == "Northern Ireland") %>%
 #   dplyr:: select(Position)
 #
 #
 # Decumulated.Data <- x %>%
 #   dplyr:: mutate(decumulation = ifelse(Year.End == "DEC" & Quarter == "2017 Q1", as.numeric(Dec.Q1), decumulation)) %>%
 #   dplyr:: mutate(decumulation = ifelse(Year.End == "MAR" & Quarter == "2017 Q2", as.numeric(Mar.Q2), decumulation)) %>%
 #   dplyr:: mutate(decumulation = ifelse(Year.End == "SEP" & Quarter == "2017 Q4" & Country == "England", as.numeric(Sep.Q4.Eng), decumulation)) %>%
 #   dplyr:: mutate(decumulation = ifelse(Year.End == "SEP" & Quarter == "2017 Q4" & Country == "Wales", as.numeric(Sep.Q4.Wal), decumulation)) %>%
 #   dplyr:: mutate(decumulation = ifelse(Year.End == "SEP" & Quarter == "2017 Q4" & Country == "Scotland", as.numeric(Sep.Q4.Scot), decumulation)) %>%
 #   dplyr:: mutate(decumulation = ifelse(Year.End == "SEP" & Quarter == "2017 Q4" & Country == "Northern Ireland", as.numeric(Sep.Q4.NI), decumulation)) %>%
 #   dplyr:: ungroup() %>%
 #   dplyr:: select(Country,  Quarter, decumulation) %>%
 #   dplyr:: group_by(Country, Quarter ) %>%
 #   dplyr:: summarise(decumulation = sum(decumulation)) %>%
 #   dplyr:: select(Country, Quarter, decumulation)

  x <- x %>%
    dplyr::arrange(desc(Quarter)) %>%
    dplyr::filter(Data.Element %in% c("CQ_J13")) %>%
    dplyr:: select( Quarter, Country, Year.End, Position) %>%
    dplyr:: group_by( Country, Quarter, Year.End) %>%
    dplyr:: summarise(Position = sum(Position)/1000) %>%#convert into 1000s
    dplyr:: ungroup() %>%
    dplyr:: group_by(Year.End) %>%
    dplyr:: select(Country, Year.End, Quarter, Position) %>%
    dplyr:: arrange(desc( Country )) %>%
    dplyr:: arrange(desc(Year.End)) %>%
    dplyr:: group_by(Country, Year.End) %>%
    dplyr:: mutate(lag.value = dplyr::lag(Position, n = 1L, default = first(Position))) %>%
    dplyr:: mutate(decumulation =  Position - lag.value)

  #define quarters with 1 or 2 values for this reporting period - e.g 2017Q1 and 2018Q1, Q1 appears twice
  Q1.dates <- input_dates[grep("Q1", input_dates)]
  Q2.dates <- input_dates[grep("Q2", input_dates)]
  Q3.dates <- input_dates[grep("Q3", input_dates)]
  Q4.dates <- input_dates[grep("Q4", input_dates)]


  Dec.Q1 <- x %>%
    dplyr:: ungroup() %>%
    dplyr:: filter(Year.End == "DEC" & Quarter %in% max(Q1.dates)) %>%
    dplyr:: select(Position)

  Mar.Q2 <- x %>%
    dplyr:: ungroup() %>%
    dplyr:: filter(Year.End == "MAR" & Quarter %in% max(Q2.dates)) %>%
    dplyr:: select(Position)

  Sep.Q4.Eng <- x %>%
    dplyr:: ungroup() %>%
    dplyr:: filter(Year.End == "SEP" & Quarter %in% max(Q4.dates) & Country == "England") %>%
    dplyr:: select(Position)

  Sep.Q4.Wal <- x %>%
    dplyr:: ungroup() %>%
    dplyr:: filter(Year.End == "SEP" & Quarter %in% max(Q4.dates) & Country == "Wales") %>%
    dplyr:: select(Position)

  Sep.Q4.Scot <- x %>%
    dplyr:: ungroup() %>%
    dplyr:: filter(Year.End == "SEP" & Quarter %in% max(Q4.dates) & Country == "Scotland") %>%
    dplyr:: select(Position)

  Sep.Q4.NI <- x %>%
    dplyr:: ungroup() %>%
    dplyr:: filter(Year.End == "SEP" & Quarter %in% max(Q4.dates) & Country == "Northern Ireland") %>%
    dplyr:: select(Position)


  Decumulated.Data <- x %>%
    dplyr:: mutate(decumulation = ifelse(Year.End == "DEC" & Quarter %in% max(Q1.dates), as.numeric(Dec.Q1), decumulation)) %>%
    dplyr:: mutate(decumulation = ifelse(Year.End == "MAR" & Quarter %in% max(Q2.dates), as.numeric(Mar.Q2), decumulation)) %>%
    dplyr:: mutate(decumulation = ifelse(Year.End == "SEP" & Quarter %in% max(Q4.dates) & Country == "England", as.numeric(Sep.Q4.Eng), decumulation)) %>%
    dplyr:: mutate(decumulation = ifelse(Year.End == "SEP" & Quarter %in% max(Q4.dates) & Country == "Wales", as.numeric(Sep.Q4.Wal), decumulation)) %>%
    dplyr:: mutate(decumulation = ifelse(Year.End == "SEP" & Quarter %in% max(Q4.dates) & Country == "Scotland", as.numeric(Sep.Q4.Scot), decumulation)) %>%
    dplyr:: mutate(decumulation = ifelse(Year.End == "SEP" & Quarter %in% max(Q4.dates) & Country == "Northern Ireland", as.numeric(Sep.Q4.NI), decumulation)) %>%
    dplyr:: ungroup() %>%
    dplyr:: select(Country,  Quarter, decumulation) %>%
    dplyr:: group_by(Country, Quarter ) %>%
    dplyr:: summarise(decumulation = sum(decumulation)) %>%
    dplyr:: select(Country, Quarter, decumulation)

  UK <- Decumulated.Data %>%
    dplyr:: ungroup() %>%
    dplyr:: group_by(Quarter) %>%
    dplyr:: summarise(Country = as.factor("UK"),
                      decumulation = sum(decumulation)) %>%
    bind_rows( .)

  Decumulated.Data <- dplyr:: bind_rows(Decumulated.Data, UK)

  # create wide representation of the data
  Decumulated.Data <- tidyr:: spread(Decumulated.Data, key=Quarter, value= decumulation)

  names<-  data.frame(a = c("UK", "England", "Scotland", "Wales","Northern Ireland"))

  Decumulated.Data<- Decumulated.Data[match(names$a, Decumulated.Data$Country),]


  # Define the class here ----

  structure(
    list(
      data = Decumulated.Data,
      quarters = colnames(Decumulated.Data[!colnames(Decumulated.Data) == ""]),
      country = Decumulated.Data[,2],
      units = paste("\ua3", "Thousands"),
      title = "Total income",
      transformation = "Not seasonally adjusted",
      Box_code = Decumulated.Data[,1]
    ),
    class = "table_3")
}

#View(table_3_part_1(CQ_Combine)[[1]])
