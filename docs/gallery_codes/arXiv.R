library(Logolas)
tab_data <- get(load(system.file("extdata", "aRxiv_field_cat.Rdata", package = "Logolas")))
logomaker(tab_data, type = "Logo", color_seed = 4000)
