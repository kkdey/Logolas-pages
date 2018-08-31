
################  uniprot  annotations   ############################

library(seqinr)
glycolysation <- read.fasta(file = "../data/uniprot_humans_N_glycosylation.fasta")
length(glycolysation)

glyco_locs <- read.delim("../data/uniprot_glyco_N_locs.tab")

if(dim(glyco_locs)[1] != length(glycolysation)[1]){
  stop("the first dimension for two matrices should match")
}

sequences <- c()

type = "N"

for(l in 1:length(glycolysation)){
  if(type == "N"){
    locs <- as.character(glyco_locs[l,7])
    identifiers_list <- strsplit(locs, ".;")[[1]]

    if(length(identifiers_list) > 0){
      linked_ids  <- c()
      for(s in 1:length(identifiers_list)){
        broken_ids <- strsplit(identifiers_list[s], " ")[[1]]
        if(broken_ids[1] == "") broken_ids <- broken_ids[-1]
        if(!is.na(broken_ids[4])){
          if(broken_ids[4] == "N-linked") linked_ids <- c(linked_ids, broken_ids[2])
        }
      }
      linked_ids <- as.numeric(linked_ids)
    }else{
      next
    }
  }else if (type == "O"){
    locs <- as.character(glyco_locs[l,7])
    identifiers_list <- strsplit(locs, ".;")[[1]]

    if(length(identifiers_list) > 0){
      linked_ids  <- c()
      for(s in 1:length(identifiers_list)){
        broken_ids <- strsplit(identifiers_list[s], " ")[[1]]
        if(broken_ids[1] == "") broken_ids <- broken_ids[-1]
        if(!is.na(broken_ids[4])){
          if(broken_ids[4] == "O-linked") linked_ids <- c(linked_ids, broken_ids[2])
        }
      }
      linked_ids <- as.numeric(linked_ids)
    }else{
      next
    }
  }

  if(length(all_indices) > 0) {
    all_indices <- linked_ids
    all_indices_2 <- setdiff(all_indices,
      c(1:5, (length(glycolysation[[l]])-5):(length(glycolysation[[l]]))))
    if(length(all_indices_2) > 0){
      for(m in 1:length(all_indices_2)){
        sequences <- c(sequences,
        toupper(paste0(glycolysation[[l]][(all_indices_2[m]-5):(all_indices_2[m]+5)],
                                      collapse="")))
      }
    }
  }else{
    next
  }
}

library(Logolas)
cols1 <- c(rev(RColorBrewer::brewer.pal(12, "Paired"))[c(3,4,7,8,11,12,5,6,9,10)],
           RColorBrewer::brewer.pal(12, "Set3")[c(1,2,5,8,9)],
           RColorBrewer::brewer.pal(9, "Set1")[c(9,7)],
           RColorBrewer::brewer.pal(8, "Dark2")[c(3,4,8)])

color_profile <- list("type" = "per_row",
                      "col" = cols1)

bg <- c(8.25, 1.38, 5.46, 6.73, 3.86, 7.07, 2.27, 5.92, 5.81, 9.65, 2.41,
        4.05, 4.73, 3.93, 5.53, 6.62, 5.35, 6.86, 1.09, 2.91)
bg <- bg/sum(bg)
names(bg) <- c("A", "C", "D", "E", "F", "G", "H", "I",
               "K", "L", "M", "N", "P", "Q", "R", "S", "T",
               "V", "W", "Y")

rep.col<-function(x,n){
  matrix(rep(x,each=n), ncol=n, byrow=TRUE)
}
bgmat <- rep.col(bg, 11)
rownames(bgmat) <- names(bg)

out <- Logolas::logomaker(sequences,
                   type = "EDLogo",
                   color_type = "per_row",
                   colors = cols1,
                   return_heights = TRUE,
                   logo_control = list(score = "log",
                                       control= list(quant=0.5,
                                                     posbins = 3,
                                                     negbins = 3)))

out <- Logolas::logomaker(sequences,
                          type = "EDLogo",
                          color_type = "per_row",
                          colors = cols1,
                          return_heights = TRUE,
                          logo_control = list(score = "wKL",
                                              control= list(quant=0,
                                                            posbins = 2,
                                                            negbins = 3)))

table(sapply(sequences, function(x) return(substring(x,7,7))))

pfm <- Biostrings::consensusMatrix(sequences)

Logolas::nlogomaker(m, logoheight = "wKL",
                    color_profile = color_profile,
                    frame_width = 1, pop_name = "",
                    newpage = FALSE,
                    control = list(quant = 0,
                                   depletion_weight = 0, epsilon = 0.1,
                                   round_off = 1,
                                   posbins = 2, negbins = 3))
Logolas::nlogomaker(m, logoheight = "log",
                    color_profile = color_profile,
                    frame_width = 1, pop_name = "",
                    newpage = FALSE,
                    control = list(quant = 0.5,
                                   depletion_weight = 0, epsilon = 0.1,
                                   round_off = 1,
                                   posbins = 3, negbins = 3))
