histones <- get(load(system.file("extdata", "histone_marks.Rdata", package = "Logolas")))
logomaker(histones$mat, bg=histones$bgmat, type = "EDLogo")
