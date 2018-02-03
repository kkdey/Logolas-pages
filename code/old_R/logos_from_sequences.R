#' @title Create logo plots from a vector of aligned sequences using Logolas
#'
#' @description Builds a consensus matrix from a vector of aligned DNA, RNA or
#' amino acid sequences and then plots the standard logo or the EDLogo on the
#' consensus matrix.
#'
#' @param sequence A vector of aligned sequences
#' @param type can either be "Logo" or "EDLogo" depending on if user wants to
#'             plot the standard Logo or the Enrichment Depletion Logo.
#' @param use_dash Boolean. If TRUE, performs adaptive scaling of the consensus
#'                 matrix from sequences based on the number of seqeunces.
#' @param bg The background probability matrix. Check the documentation of
#'           \code{logomaker} or \code{nlogomaker} to see the usage of \code{bg}.
#'           Defaults to NULL, which assumes same background probability for
#'           all the characters in the sequence.
#' @param color_profile The coloring scheme used for the logo plot. Defaults to
#'                       NULL, in which case the default coloring scheme is used.
#' @param seed The seed used for the coloring profile.
#' @param logo_control Control parameters for the logo plot. Check the
#'                     input arguments from the \code{logomaker} and
#'                     \code{nlogomaker} functions.
#' @param dash_control Control parameters for the adaptive scaling \code{dash}
#'                     function. Check the input arguments to the \code{dash}
#'                     function in this package.
#'
#' @examples
#'
#' #################  DNA, RNA sequences logo plot   #######################
#'
#' sequence <- c("CTATTGT", "CTCTTAT", "CTATTAA", "CTATTTA", "CTATTAT", "CTTGAAT",
#'               "CTTAGAT", "CTATTAA", "CTATTTA", "CTATTAT", "CTTTTAT", "CTATAGT",
#'               "CTATTTT", "CTTATAT", "CTATATT", "CTCATTT", "CTTATTT", "CAATAGT",
#'               "CATTTGA", "CTCTTAT", "CTATTAT", "CTTTTAT", "CTATAAT", "CTTAGGT",
#'               "CTATTGT", "CTCATGT", "CTATAGT", "CTCGTTA", "CTAGAAT", "CAATGGT")
#'
#' logos_from_sequences (sequence, type = "Logo")
#' logos_from_sequences (sequence, type = "EDLogo")
#'
#' ##################  Amino acid sequence logo plot ######################
#'
#' library(ggseqlogo)
#' data(ggseqlogo_sample)
#'
#' sequence <- seqs_aa$AKT1
#' logos_from_sequences (sequence, type = "Logo")
#' logos_from_sequences (sequence, type = "EDLogo")
#'
#' @import grid
#' @importFrom graphics par
#' @importFrom utils modifyList
#' @importFrom Biostrings consensusMatrix
#' @import ggplot2
#' @import gridBase
#' @export
logos_from_sequences <- function(sequence,
                                 type = c("Logo", "EDLogo"),
                                 use_dash = TRUE,
                                 bg = NULL,
                                 color_profile = NULL,
                                 seed = 2030,
                                 logo_control = list(),
                                 dash_control = list()){

  dash_control_default <- list(concentration = NULL,
                               mode = NULL,
                               optmethod = "mixEM",
                               sample_weights = NULL,
                               verbose = FALSE,
                               bf = TRUE,
                               pi_init = NULL,
                               squarem_control = list(),
                               dash_control = list(),
                               reportcov = FALSE)

  if(type == "Logo"){
    logo_control_default <- list(ic=NULL,
                                 total_chars = c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O",
                                                 "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "zero", "one", "two",
                                                 "three", "four", "five", "six", "seven", "eight", "nine", "dot", "comma",
                                                 "dash", "colon", "semicolon", "leftarrow", "rightarrow"),
                                 frame_width=NULL,  ic.scale=TRUE,
                                 xaxis=TRUE, yaxis=TRUE, xaxis_fontsize=10,
                                 xlab_fontsize=15, y_fontsize=15,
                                 main_fontsize=16, start=0.001,
                                 yscale_change=TRUE, pop_name = "",
                                 xlab = "position", ylab = "Information content",
                                 col_line_split="white", addlogos = NULL,
                                 addlogos_text = NULL, newpage = TRUE,
                                 control = list())
  }else{
    logo_control_default <- list(logoheight = "log",
                                 total_chars = c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O",
                                                 "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "zero", "one", "two",
                                                 "three", "four", "five", "six", "seven", "eight", "nine", "dot", "comma",
                                                 "dash", "colon", "semicolon", "leftarrow", "rightarrow"),
                                 frame_width=NULL, yscale_change=TRUE,
                                 pop_name = "", addlogos = NULL,
                                 addlogos_text = NULL, newpage = TRUE,
                                 yrange = NULL, xaxis=TRUE,
                                 yaxis=TRUE, xaxis_fontsize=10,
                                 xlab_fontsize=15, y_fontsize=15,
                                 main_fontsize=16, start=0.001,
                                 xlab = "position", ylab = "Enrichment Score",
                                 col_line_split="white",
                                 control = list())
  }


  logo_control <- utils::modifyList(logo_control_default, logo_control)
  dash_control <- utils::modifyList(dash_control_default, dash_control)


  L <- length(sequence)
  pfm <- Biostrings::consensusMatrix(sequence)
  colnames(pfm) <- 1:dim(pfm)[2]

  if(use_dash){
    pfm_scaled <- do.call(dash, append(list(comp_data = pfm),
                                       dash_control))$posmean
  }else{
    pfm_scaled <- pfm
  }


  if(is.null(color_profile)){
    cols = RColorBrewer::brewer.pal.info[RColorBrewer::brewer.pal.info$category == 'qual',]
    col_vector = unlist(mapply(RColorBrewer::brewer.pal, cols$maxcolors, rownames(cols)))
    set.seed(seed)
    color_profile <- list("type" = "per_row",
                   "col" = sample(col_vector, dim(pfm_scaled)[1], replace = FALSE))
  }


  if(type == "Logo"){
        do.call(logomaker, append (list(table = pfm_scaled,
                                         color_profile = color_profile,
                                         bg = bg),
                                logo_control))
   }else if (type == "EDLogo"){
        do.call(nlogomaker, append (list(table = pfm_scaled,
                                         color_profile = color_profile,
                                         bg = bg),
                                logo_control))
   }
}
