#' @title Create logo plots from a table of compositional data
#'
#' @description Takes as input a positional frequency or probability of compositional
#' data and plots the standard logo or the EDLogo based on this matrix.
#'
#' @param table The input table (data frame or matrix) of compositional counts
#' with characters or symbols specified along the rows and the sites or positions
#' along the columns. Each column corresponds to a composition of the characters
#' specified along the rows.
#'
#' @param type can either be "Logo" or "EDLogo" depending on if user wants to
#'             plot the standard Logo or the Enrichment Depletion Logo.
#'
#' @param use_dash Boolean. If TRUE, performs adaptive scaling of the consensus
#'                 matrix from sequences based on the number of seqeunces.
#'
#' @param bg The background probability matrix. Check the documentation of
#'           \code{logomaker} or \code{nlogomaker} to see the usage of \code{bg}.
#'           Defaults to NULL, which assumes same background probability for
#'           all the characters in the sequence.
#'
#' @param color_profile A list containing two elements - "type" and "col". The type can
#' be of three types - "per-row", "per-column" and "per-symbol". The "col" element
#' is a vector of colors, of same length as number of rows in table for "per-row" (assigning
#' a color to each string), of same length as number of columns in table for "per-column"
#' (assuming a color for each column), or a distinct color for a distinct symbol in "per-symbol".
#' For "per-symbol", the length of the \code{color_profile$col} should be same as library size
#' of the logos, but if the vector of colors provided is more or less, we can
#' downsample or upsample the colors as required. The colors are matched with the symbols in
#' the \code{total_chars}
#'
#' @param logo_control Control parameters for the logo plot. Check the
#'                     input arguments from the \code{logomaker} and
#'                     \code{nlogomaker} functions.
#' @param dash_control Control parameters for the adaptive scaling \code{dash}
#'                     function. Check the input arguments to the \code{dash}
#'                     function in this package.
#'
#' @examples
#'
#' p <- get(load(system.file("extdata", "seqlogo_example.rda", package = "Logolas")))
#' color_profile <- list("type" = "per_row",
#'                      "col" = c("#7FC97F", "#BEAED4", "#FDC086", "#386CB0"))
#' logos_from_table(p, color_profile = color_profile, type = "Logo")
#' logos_from_table(p, color_profile = color_profile, type = "EDLogo")
#'
#' @import grid
#' @importFrom graphics par
#' @importFrom  utils  modifyList
#' @import ggplot2
#' @import gridBase
#' @export


logos_from_table <- function(table,
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


  if(all(table == floor(table))){
    datatype = "PFM"
  }else{
    datatype = "PWM"
  }

  if(datatype == "PWM"){
    use_dash = FALSE
  }

  if(use_dash){
    table_scaled <- do.call(dash, append(list(comp_data = table),
                                       dash_control))$posmean
  }else{
    table_scaled <- table
  }

  if(type == "Logo"){
    do.call(logomaker, append (list(table = table_scaled,
                                    color_profile = color_profile,
                                    bg = bg),
                               logo_control))
  }else if (type == "EDLogo"){
    do.call(nlogomaker, append (list(table = table_scaled,
                                     color_profile = color_profile,
                                     bg = bg),
                                logo_control))
  }
}
