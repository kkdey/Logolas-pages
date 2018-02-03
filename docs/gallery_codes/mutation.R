library(Logolas)

table <- get(load(system.file("extdata", "mutation_sig.Rdata", package = "Logolas")))
logomaker(table, type = "EDLogo", color_type = "per_symbol", color_seed = 1800)

