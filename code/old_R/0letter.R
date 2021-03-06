#' @title Logo plot for numbers 0-9, A-Z and punctuation marks
#'
#' @description Plots the symbol or logo for numbers 0-9 and alphabets A-Z,
#' left arrow, right arrow, colon, semic colon, dash, comma and dot.
#'
#' @param plot A binary. If FALSE, only outputs grid co-ordinates for the logo,
#'        along with color labels. If TRUE, also plots the logo in a new grid
#'        window. Defaults to FALSE.
#' @param fill_symbol A binary. If TRUE, the function would fill the symbol by
#'        the color represented in \code{colfill}, else colors the boundary
#'        of the symbol by \code{colfill}. Defaults to TRUE.
#' @param colfill  The color used to highlight the symbol.  Defaults to "green".
#' @param lwd Specifies the border width of the symbol. Defaults to 10.
#' @name letters
#'
#' @return Returns a list with the following items.
#'         \item{x}{X co-ordinates of the logo in the [0,1] X [0,1] grid window}
#'         \item{y}{Y co-ordinates of the logo in the [0,1] X [0,1] grid window}
#'         \item{id}{id vector representing blocks in the logo co-ordinates}
#'         \item{fill}{a vector equal to the number of distinct ids or blocks in
#'                    the logo, whose elements correspond to colors of these blocks}
#' @keywords internal
#' @import grid
#'
#' @rdname letters
#' @export
#' @examples
#' out <- zeroletter(plot=TRUE, fill_symbol = TRUE, colfill = "green")
#' out <- zeroletter(plot=TRUE, fill_symbol = FALSE, colfill = "green")


zeroletter <- function(plot = FALSE,
                        fill_symbol = TRUE,
                        colfill="green",
                        lwd =10){

  angle2 <- c(seq(pi/2, 0, length.out=100), seq(0, -(3*pi/2), length.out=100))

  x1 <- 0.5 + 0.3*cos(angle2)
  y1 <- 0.5 + 0.5*sin(angle2)

  x2 <- 0.5 + 0.15*cos(angle2)
  y2 <- 0.5 + 0.35*sin(angle2)

  x <- c(x1, x2)
  y <- c(y1, y2)

  id <- c(rep(1, length(x1)), rep(2, length(x2)))
  fill <- c(colfill, "white")
  colfill <- rep(colfill, length(unique(id)))

  if(plot){
    get_plot(x, y, id, fill, colfill, lwd = lwd, fill_symbol = fill_symbol)
  }

  ll <- list("x"= x,
             "y"= y,
             "id" = id,
             "fill" = fill,
             "colfill" = colfill)
  return(ll)
}




