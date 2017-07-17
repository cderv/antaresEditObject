#' Remove a cluster
#'
#' @param area Area from which to remove a cluster
#' @param cluster_name Cluster to remove
#' @param opts
#'   List of simulation parameters returned by the function
#'   \code{antaresRead::setSimulationPath}
#'
#' @return An upddated list containing various information about the simulation.
#' @export
#'
#' @examples
#' \dontrun{
#' createCluster(area = "fr", cluster_name = "fr_gas",
#'               group = "other", `marginal-cost` = 50)
#' 
#' removeCluster(area = "fr", cluster_name = "fr_gas")
#' 
#' }
#' 
#' 
removeCluster <- function(area, cluster_name,
                          opts = antaresRead::simOptions()) {
  
  
  # Input path
  inputPath <- opts$inputPath
  
  
  # Remove from Ini file
  # path to ini file
  path_clusters_ini <- file.path(inputPath, "thermal", "clusters", area, "list.ini")
  
  # read previous content of ini
  previous_params <- readIniFile(file = path_clusters_ini)
  
  # Remove
  previous_params[[cluster_name]] <- NULL
  
  # write
  writeIni(
    listData = previous_params,
    pathIni = path_clusters_ini,
    overwrite = TRUE
  )
  
  if (length(previous_params) > 0) {
    # remove series
    unlink(x = file.path(inputPath, "thermal", "series", area, cluster_name), recursive = TRUE)
    
    # remove prepro
    unlink(x = file.path(inputPath, "thermal", "prepro", area, cluster_name), recursive = TRUE)
  } else {
    # remove series
    unlink(x = file.path(inputPath, "thermal", "series", area), recursive = TRUE)
    
    # remove prepro
    unlink(x = file.path(inputPath, "thermal", "prepro", area), recursive = TRUE)
  }
  
  
  
  
  # Maj simulation
  res <- antaresRead::setSimulationPath(path = opts$studyPath, simulation = "input")
  
  invisible(res)
}