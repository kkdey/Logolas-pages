library(Logolas)

suppressWarnings(suppressMessages(load(system.file("extdata", "aRxiv_field_cat.Rdata", package = "Logolas"))))


colnames(tab_data) <- c("Matthew Stephens",
                        "John Lafferty",
                        "Wei Biao Wu",
                        "Peter McCullagh")
tab_data <- as.matrix(tab_data)

color_profile <- list("type" = "per_row",
                      "col" = RColorBrewer::brewer.pal(dim(tab_data)[1],
                                                       name = "Spectral"))

logomaker(tab_data,
          color_profile = color_profile,
          frame_width = 1,
          pop_name = "arXiv field categories of UChicago STAT professors",
          xlab = "Professors",
          ylab = "Information content")