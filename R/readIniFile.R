
# From antaresRead

#' Private function that reads the content of a .ini file and convert it to a
#' list
#'
#' @param file
#' file path
#'
#' @return
#' A list with an element for each section of the .ini file.
#' 
#' @importFrom utils type.convert
#'
#' @noRd
#'
readIniFile <- function(file, stringsAsFactors=FALSE) {
  X <- readLines(file)
  sections <- grep("^\\[.*\\]$", X)
  starts <- sections + 1
  ends <- c(sections[-1] - 1, length(X))
  L <- vector(mode="list", length=length(sections))
  names(L) <- gsub("\\[|\\]", "", X[sections])
  for(i in seq(along = sections)){
    if (starts[i] >= ends[i]) next
    pairs <- X[seq(starts[i], ends[i])]
    pairs <- pairs[pairs != ""]
    pairs <- strsplit(pairs, "=")
    
    key <- sapply(pairs, function(p) trimws(p[1]))
    value <- lapply(pairs, function(p) {
      v <- trimws(p[2])
      if (v == "true") return(TRUE)
      if (v == "false") return(FALSE)
      utils::type.convert(v, as.is = !stringsAsFactors)
    })
    
    L[[i]] <- value
    names(L[[i]]) <- key
  }
  L
}