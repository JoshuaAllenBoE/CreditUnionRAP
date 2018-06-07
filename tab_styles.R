# create styles -----------------------------------------


# series
series <- openxlsx::createStyle(halign = "right", valign = "bottom",
                                fontColour = 'black', fontSize = 8, fontName = 'Arial',
                                borderStyle = "none", numFmt = "COMMA")

# # dates
# dates <- openxlsx::createStyle(halign = "left", valign = "bottom",
#                                fontColour = "black", fontSize = 9, fontName = 'Arial')


# create styles object

tab_styles <- structure(
  list(

    series = series
    #dates = dates,
  ),
  class = "tab_styles")


# EXPORT ---------------------------------------------------

devtools::use_data(tab_styles, internal = TRUE, overwrite = TRUE)
