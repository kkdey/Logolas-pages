#' @title Get heights of logos in nlogomaker() using ratios of the PWM with background.
#'
#' @description Genertes total heights of the logos in the positive and negative
#' scales of the nlogomaker() logo plot along with the proportion of the height
#' distributed between the logos to be plotted in the positive and the negative
#' scales respectively using ratios of the PWM with background.
#'
#' @param table The input table (data frame or matrix) of counts across different
#' logos or symbols (specified along the rows) ans across different sites or
#' positions or groups (specified along the columns).
#'
#' @param epsilon An additive constant added to the PWM before scaling to eliminate
#'  log (0) type errors.
#'
#' @param bg The background probability, which defaults to NULL, in which case
#' equal probability is assigned to each symbol. The user can however specify a
#' vector (equal to in length to the number of symbols) which specifies the
#' background probability for each symbol and assumes this background probability
#' to be the same across the columns (sites), or a matrix, whose each cell specifies
#' the background probability of the symbols for each position.
#'
#' @param alpha The Renyi entropy tuning parameter which is used in case of
#' scaling of the bar heights by information criterion. The default tuning
#' parameter value is 1, which corresponds to Shannon entropy.
#'
#' @param hist Whether to use the hist method or the information criterion
#' method to determine the heights of the logos.
#'
#' @param quant The quantile to be adjusted for in computing enrichment and
#' depletion scores. Defaults to 0.5, which corresponds to the median.
#'
#' @return Returns the heights of enrichment and depletion for
#' ratio approach to EDLogo.
#'
#' @importFrom  stats quantile
#'
#' @examples
#'
#' m = matrix(rep(0,48),4,12)
#' m[1,] = c(0,0,2.5,7,0,0,0,0,0,0,1,0)
#' m[2,] = c(4,6,3,1,0,0,0,0,0,5,0,5)
#' m[3,] = c(0,0,0,0,0,1,8,0,0,1,1,2)
#' m[4,] = c(4,2,2.5,0,8,7,0,8,8,2,6,1)
#' rownames(m) = c("A", "C", "G", "T")
#' colnames(m) = 1:12
#' m=m/8
#' get_logo_heights_ratio(m)
#'
#' @export


get_logo_heights_ratio <- function(table, epsilon = 0.01, bg = NULL,
                                 alpha = 1, hist=FALSE, quant = 0.5){

  if (is.vector(bg)==TRUE){
    if(length(bg) != dim(table)[1]){
      stop("If background prob (bg) is a vector, the length of bg must equal the number of symbols for the logo plot")
    }else if(length(which(is.na(table))) > 0){
      stop("For NA in table, a vector bg is not allowed")
    }else{
      bgmat <- bg %*% t(rep(1, dim(table)[2]))
      bgmat[which(is.na(table))] <- NA
      bgmat <- apply(bgmat, 2, function(x) return(x/sum(x[!is.na(x)])))
    }
  }else if (is.matrix(bg)==TRUE){
    if(dim(bg)[1] != dim(table)[1] | dim(bg)[2] != dim(table)[2]){
      stop("If background prob (bg) is a matrix, its dimensions must match that of the table")
    }else{
      bgmat <- bg
      bgmat[which(is.na(table))] <- NA
      bgmat <- apply(bgmat, 2, function(x) return(x/sum(x[!is.na(x)])))
    }
  }else {
    message ("using a background with equal probability for all symbols")
    bgmat <- matrix(1/dim(table)[1], dim(table)[1], dim(table)[2])
    bgmat[which(is.na(table))] <- NA
    bgmat <- apply(bgmat, 2, function(x) return(x/sum(x[!is.na(x)])))
  }



  table <- apply(table+0.0001,2,normalize_ratio)
  bgmat <- apply(bgmat+0.0001,2,normalize_ratio)


  if (class(table) == "data.frame"){
    table <- as.matrix(table)
  }else if (class(table) != "matrix"){
    stop("the table must be of class matrix or data.frame")
  }
  table_mat_norm <-  apply(table, 2, function(x) return(x/sum(x[!is.na(x)])))
  bgmat <-  apply(bgmat, 2, function(x) return(x/sum(x[!is.na(x)])))

  npos <- ncol(table_mat_norm)
  chars <- as.character(rownames(table_mat_norm))

  table_mat_adj <- apply((table_mat_norm+epsilon)/(bgmat+epsilon), 2, function(x)
  {
    indices <- which(is.na(x))
    if(length(indices) == 0){
      y = x
      if(quant != 0){
        qq <- quantile(y, quant)
      }else{
        qq <- 0
      }
      z <- y - qq
      return(z)
    }else{
      y <- x[!is.na(x)]
      if(quant != 0){
        qq <- quantile(y, quant)
      }else{
        qq <- 0
      }
      z <- y - qq
      zext <- array(0, length(x))
      zext[indices] <- 0
      zext[-indices] <- z
      return(zext)
    }
  })

  table_mat_pos <- table_mat_adj
  table_mat_pos[table_mat_pos<= 0] = 0
  table_mat_pos_norm  <- apply(table_mat_pos, 2, function(x) return(x/sum(x)))
  table_mat_pos_norm[table_mat_pos_norm == "NaN"] = 0

  table_mat_neg <- table_mat_adj
  table_mat_neg[table_mat_neg >= 0] = 0
  table_mat_neg_norm  <- apply(abs(table_mat_neg), 2, function(x) return(x/sum(x)))
  table_mat_neg_norm[table_mat_neg_norm == "NaN"] = 0


  pos_ic <- colSums(table_mat_pos)
  neg_ic <- colSums(abs(table_mat_neg))


  ll <- list()
  ll$pos_ic <- pos_ic
  ll$neg_ic <- neg_ic
  ll$table_mat_pos_norm <- table_mat_pos_norm
  ll$table_mat_neg_norm <- table_mat_neg_norm
  return(ll)
}

normalize_ratio = function(x){return(x/sum(x[!is.na(x)]))}
