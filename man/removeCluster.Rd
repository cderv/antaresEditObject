% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/removeCluster.R
\name{removeCluster}
\alias{removeCluster}
\title{Remove a cluster}
\usage{
removeCluster(area, cluster_name, add_prefix = TRUE,
  opts = antaresRead::simOptions())
}
\arguments{
\item{area}{Area from which to remove a cluster.}

\item{cluster_name}{Cluster to remove.}

\item{add_prefix}{If \code{TRUE}, cluster_name will be prefixed by area's name.}

\item{opts}{List of simulation parameters returned by the function
\code{antaresRead::setSimulationPath}}
}
\value{
An upddated list containing various information about the simulation.
}
\description{
Remove a cluster
}
\examples{
\dontrun{
createCluster(area = "fr", cluster_name = "fr_gas",
              group = "other", `marginal-cost` = 50)

removeCluster(area = "fr", cluster_name = "fr_gas")

}


}
