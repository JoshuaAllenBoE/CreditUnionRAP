# CQ<- read_CQ_vo()
#
# table_3_part_1<- function(x) {
#
#
#   input_date_5 <- x  %>%
#     #dplyr::arrange(desc(Quarter)) %>%
#     dplyr::filter(Data.Element %in% c("CQ_J13"), Quarter %in% c("2017 Q4")) %>%
#     dplyr:: mutate(dup = duplicated(FRN, Position, Quarter)) %>%
#     dplyr:: filter(dup != TRUE) %>%
#     dplyr:: select( Quarter, Country, Year.End, Position) %>%
#     dplyr:: group_by( Country, Quarter, Year.End) %>%
#     dplyr:: summarise(Position = sum(Position))
#
#   input_date_4 <- x  %>%
#     #dplyr::arrange(desc(Quarter)) %>%
#     dplyr::filter(Data.Element %in% c("CQ_J13"), Quarter %in% c("2017 Q3")) %>%
#     dplyr:: mutate(dup = duplicated(FRN, Position, Quarter)) %>%
#     dplyr:: filter(dup != TRUE) %>%
#     dplyr:: select( Quarter, Country, Year.End, Position) %>%
#     dplyr:: group_by( Country, Quarter, Year.End) %>%
#     dplyr:: summarise(Position = sum(Position))
#
#   input_date_3 <- x  %>%
#     #dplyr::arrange(desc(Quarter)) %>%
#     dplyr::filter(Data.Element %in% c("CQ_J13"), Quarter %in% c("2017 Q2")) %>%
#     dplyr:: mutate(dup = duplicated(FRN, Position, Quarter)) %>%
#     dplyr:: filter(dup != TRUE) %>%
#     dplyr:: select( Quarter, Country, Year.End, Position) %>%
#     dplyr:: group_by( Country, Quarter, Year.End) %>%
#     dplyr:: summarise(Position = sum(Position))
#
#   input_date_2 <- x  %>%
#     #dplyr::arrange(desc(Quarter)) %>%
#     dplyr::filter(Data.Element %in% c("CQ_J13"), Quarter %in% c("2017 Q1")) %>%
#     dplyr:: mutate(dup = duplicated(FRN, Position, Quarter)) %>%
#     dplyr:: filter(dup != TRUE) %>%
#     dplyr:: select( Quarter, Country, Year.End, Position) %>%
#     dplyr:: group_by( Country, Quarter, Year.End) %>%
#     dplyr:: summarise(Position = sum(Position))
#
#   input_date_1 <- x  %>%
#     #dplyr::arrange(desc(Quarter)) %>%
#     dplyr::filter(Data.Element %in% c("CQ_J13"), Quarter %in% c("2016 Q4")) %>%
#     dplyr:: mutate(dup = duplicated(FRN, Position, Quarter)) %>%
#     dplyr:: filter(dup != TRUE) %>%
#     dplyr:: select( Quarter, Country, Year.End, Position) %>%
#     dplyr:: group_by( Country, Quarter, Year.End) %>%
#     dplyr:: summarise(Position = sum(Position))
#
#
#  x<- dplyr:: bind_rows(input_date_1, input_date_2, input_date_3, input_date_4, input_date_5) %>%
#    dplyr:: ungroup() %>%
#    dplyr:: group_by(Year.End) %>%
#    dplyr:: select(Country, Year.End, Quarter, Position) %>%
#    dplyr:: arrange(desc( Country )) %>%
#    dplyr:: arrange(desc(Year.End)) %>%
#    dplyr:: group_by(Country, Year.End) %>%
#    dplyr:: mutate(lag.value = dplyr::lag(Position, n = 1L, default = first(Position))) %>%
#    dplyr:: mutate(decumulation =  Position - lag.value)
#
#
#  Dec.Q1 <- x %>%
#    dplyr:: ungroup() %>%
#    dplyr:: filter(Year.End == "DEC" & Quarter == "2017 Q1") %>%
#    dplyr:: select(Position)
#
#  Mar.Q2 <- x %>%
#    dplyr:: ungroup() %>%
#    dplyr:: filter(Year.End == "MAR" & Quarter == "2017 Q2") %>%
#    dplyr:: select(Position)
#
#  Sep.Q4.Eng <- x %>%
#    dplyr:: ungroup() %>%
#    dplyr:: filter(Year.End == "SEP" & Quarter == "2017 Q4" & Country == "England") %>%
#    dplyr:: select(Position)
#
#  Sep.Q4.Wal <- x %>%
#    dplyr:: ungroup() %>%
#    dplyr:: filter(Year.End == "SEP" & Quarter == "2017 Q4" & Country == "Wales") %>%
#    dplyr:: select(Position)
#
#  Sep.Q4.Scot <- x %>%
#    dplyr:: ungroup() %>%
#    dplyr:: filter(Year.End == "SEP" & Quarter == "2017 Q4" & Country == "Scotland") %>%
#    dplyr:: select(Position)
#
#  Sep.Q4.NI <- x %>%
#    dplyr:: ungroup() %>%
#    dplyr:: filter(Year.End == "SEP" & Quarter == "2017 Q4" & Country == "Northern Ireland") %>%
#    dplyr:: select(Position)
#
#
#  Decumulated.Data <- x %>%
#    dplyr:: mutate(decumulation = ifelse(Year.End == "DEC" & Quarter == "2017 Q1", as.numeric(Dec.Q1), decumulation)) %>%
#    dplyr:: mutate(decumulation = ifelse(Year.End == "MAR" & Quarter == "2017 Q2", as.numeric(Mar.Q2), decumulation)) %>%
#    dplyr:: mutate(decumulation = ifelse(Year.End == "SEP" & Quarter == "2017 Q4" & Country == "England", as.numeric(Sep.Q4.Eng), decumulation)) %>%
#    dplyr:: mutate(decumulation = ifelse(Year.End == "SEP" & Quarter == "2017 Q4" & Country == "Wales", as.numeric(Sep.Q4.Wal), decumulation)) %>%
#    dplyr:: mutate(decumulation = ifelse(Year.End == "SEP" & Quarter == "2017 Q4" & Country == "Scotland", as.numeric(Sep.Q4.Scot), decumulation)) %>%
#    dplyr:: mutate(decumulation = ifelse(Year.End == "SEP" & Quarter == "2017 Q4" & Country == "Northern Ireland", as.numeric(Sep.Q4.NI), decumulation)) %>%
#    dplyr:: ungroup() %>%
#    dplyr:: select(Country,  Quarter, decumulation) %>%
#    dplyr:: group_by(Country, Quarter ) %>%
#    dplyr:: summarise(decumulation = sum(decumulation)) %>%
#    dplyr:: select(Country, Quarter, decumulation)
#
#  UK <- Decumulated.Data %>%
#    dplyr:: ungroup() %>%
#    dplyr:: group_by(Quarter) %>%
#    dplyr:: summarise(Country = as.factor("UK"),
#                      decumulation = sum(decumulation)) %>%
#    bind_rows( .)
#
#  Decumulated.Data <- dplyr:: bind_rows(Decumulated.Data, UK)
#
#  # create wide representation of the data
#  Decumulated.Data <- tidyr:: spread(Decumulated.Data, key=Quarter, value= decumulation)
#
#  names<-  data.frame(a = c("UK", "England", "Scotland", "Wales","Northern Ireland"))
#
#  Decumulated.Data<- Decumulated.Data[match(names$a, Decumulated.Data$Country),]
#
#
#  colnames(x)[1] <- ""
#  colnames(x)[2] <- ""
#
#
#  # x2<- CQ  %>%
#  #   dplyr::arrange(desc(Quarter)) %>%
#  #   dplyr::filter(Data.Element %in% c("CQ_J13"), Quarter %in% c("2016 Q4", "2017 Q1", "2017 Q2", "2017 Q3", "2017 Q4")) %>%
#  #   #dplyr:: mutate(dup = duplicated(FRN, Position, Quarter)) %>%
#  #   #dplyr:: filter(dup != TRUE) %>%
#  #   dplyr:: select( Quarter, Country, Year.End, Position) %>%
#  #   dplyr:: group_by( Country, Quarter, Year.End) %>%
#  #   dplyr:: summarise(Position = sum(Position)) %>%
#  #   dplyr:: ungroup() %>%
#  #   dplyr:: group_by(Year.End) %>%
#  #   dplyr:: select(Country, Year.End, Quarter, Position) %>%
#  #   dplyr:: arrange(desc( Country )) %>%
#  #   dplyr:: arrange(desc(Year.End)) %>%
#  #   dplyr:: group_by(Country, Year.End) %>%
#  #   dplyr:: mutate(lag.value = dplyr::lag(Position, n = 1L, default = first(Position))) %>%
#  #   dplyr:: mutate(decumulation =  Position - lag.value)
#  #
#
#
#   # Define the class here ----
#
#   structure(
#     list(
#       data = Decumulated.Data,
#       quarters = colnames(Decumulated.Data[!colnames(Decumulated.Data) == ""]),
#       country = Decumulated.Data[,2],
#       units = "£ thousands",
#       title = "Total income",
#       transformation = "Not seasonally adjusted",
#       Box_code = Decumulated.Data[,1]
#     ),
#     class = "table_3")
# }
#
# View(table_3_part_1(CQ)[[1]])
