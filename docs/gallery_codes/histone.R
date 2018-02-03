histones <- get(load(system.file("extdata", "histone_marks.rda", package = "Logolas")))
logomaker(histones$mat, bg=histones$bgmat, type = "EDLogo")
