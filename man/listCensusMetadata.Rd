% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/metadata_functions.R
\name{listCensusMetadata}
\alias{listCensusMetadata}
\title{Get variable or geography metadata for a given API as a data frame}
\usage{
listCensusMetadata(name, vintage = NULL, type = "variables", group = NULL)
}
\arguments{
\item{name}{API name - e.g. acs5. See list at https://api.census.gov/data.html}

\item{vintage}{Vintage of dataset, e.g. 2014 - not required for timeseries APIs}

\item{type}{Type of metadata to return, either "variables", "geographies" or "geography", or
"groups". Default is variables.}

\item{group}{An optional variable group code, used to return metadata for a specific group
of variables only.}
}
\description{
Get variable or geography metadata for a given API as a data frame
}
\keyword{metadata}
