#' Use variable metadata to find variables containing a given string.
#'
#' Return a list of variable names or data frame of variable metadata containing a given string.
#' This can be used create a list of variables to later pass to getCensus, or a data frame
#' documenting variables used in a given project.
#'
#' @param name API name - e.g. acs5. See list at https://api.census.gov/data.html
#' @param vintage Year of dataset, e.g. 2014 - not required for timeseries APIs
#' @param find A string to find in the variable metadata
#' @param varsearch Optional argument specifying which fields to search. Default is "all".
#' Options are "all", "name", "label", or "concept".
#' @param output Optional argument, specifying output to "list" or "dataframe". Default is "list".
#' @export
#' @examples
#' # Return a list, and then use getCensus function to retrieve those variables
#' \dontrun{
#' myvars <- makeVarlist(name = "timeseries/poverty/saipe",
#'   find = "Ages 0-4",
#'   varsearch = "label")
#' myvars
#' saipe_dt <- getCensus(name = "timeseries/poverty/saipe",
#'   time = 2016,
#'   vars = myvars,
#'   region = "state:*")
#' head(saipe_dt)
#' }

makeVarlist <- function(name, vintage = NULL, find, varsearch = "all", output = "list") {
	df <- listCensusMetadata(name, vintage, type = "variables")
	index_name <- with(df, grepl(find, name, ignore.case = T))
	index_label <- with(df, grepl(find, label, ignore.case = T))
	index_concept <- with(df, grepl(find, concept, ignore.case = T))
	if (varsearch == "all") {
		vartable <- df[index_name|index_label|index_concept, ]
	} else if (varsearch == "name") {
		vartable <- df[index_name, ]
	} else if (varsearch == "label") {
		vartable <- df[index_label, ]
	} else if (varsearch == "concept") {
		vartable <- df[index_concept, ]
	}
	if (output == "dataframe") {
		return(vartable)
	} else {
		varlist <- vartable$name
		return(varlist)
	}
}
