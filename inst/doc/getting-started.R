## ---- echo = FALSE------------------------------------------------------------
NOT_CRAN <- identical(tolower(Sys.getenv("NOT_CRAN")), "true")
knitr::opts_chunk$set(purl = NOT_CRAN,
											comment = "#>")

## ---- eval = FALSE------------------------------------------------------------
#  # Add key to .Renviron
#  Sys.setenv(CENSUS_KEY=YOURKEYHERE)
#  # Reload .Renviron
#  readRenviron("~/.Renviron")
#  # Check to see that the expected key is output in your R console
#  Sys.getenv("CENSUS_KEY")

## ---- message = FALSE---------------------------------------------------------
library(censusapi)

## ---- eval = FALSE------------------------------------------------------------
#  apis <- listCensusApis()
#  View(apis)

## -----------------------------------------------------------------------------
sahie_vars <- listCensusMetadata(
	name = "timeseries/healthins/sahie", 
	type = "variables")
head(sahie_vars)

## -----------------------------------------------------------------------------
listCensusMetadata(
	name = "timeseries/healthins/sahie", 
	type = "geography")

## ---- purl = NOT_CRAN, eval = NOT_CRAN----------------------------------------
sahie_national <- getCensus(
	name = "timeseries/healthins/sahie",
	vars = c("NAME", "IPRCAT", "IPR_DESC", "PCTUI_PT"), 
	region = "us:*", 
	time = 2018)
sahie_national

## ---- purl = NOT_CRAN, eval = NOT_CRAN----------------------------------------
sahie_states <- getCensus(
	name = "timeseries/healthins/sahie",
	vars = c("NAME", "IPRCAT", "IPR_DESC", "PCTUI_PT"), 
	region = "state:*", 
	time = 2018)
head(sahie_states)

## ---- purl = NOT_CRAN, eval = NOT_CRAN----------------------------------------
sahie_counties <- getCensus(
	name = "timeseries/healthins/sahie",
	vars = c("NAME", "IPRCAT", "IPR_DESC", "PCTUI_PT"), 
	region = "county:*", 
	regionin = "state:01,02", 
	time = 2018)
head(sahie_counties, n=12L)

## ---- purl = NOT_CRAN, eval = NOT_CRAN----------------------------------------
sahie_years <- getCensus(
	name = "timeseries/healthins/sahie",
	vars = c("NAME", "PCTUI_PT"), 
	region = "state:01", 
	time = "from 2006 to 2018")
head(sahie_years)

## ---- purl = NOT_CRAN, eval = NOT_CRAN----------------------------------------
sahie_nonelderly <- getCensus(
	name = "timeseries/healthins/sahie",
	vars = c("NAME", "PCTUI_PT", "IPR_DESC", "AGE_DESC", "RACECAT", "RACE_DESC"), 
	region = "state:*", 
	time = 2018,
	IPRCAT = 5,
	AGECAT = 1)
head(sahie_nonelderly)

## ---- purl = NOT_CRAN, eval = NOT_CRAN----------------------------------------
sahie_nonelderly_annual <- getCensus(
	name = "timeseries/healthins/sahie",
	vars = c("NAME", "PCTUI_PT", "PCTUI_MOE", "NUI_PT", "NUI_MOE", "IPRCAT", "IPR_DESC", "AGE_DESC", "RACECAT", "RACE_DESC"), 
	region = "us:*", 
	time = "from 2006 to 2018",
	AGECAT = 1)
head(sahie_nonelderly_annual)

## -----------------------------------------------------------------------------
listCensusMetadata(
	name = "timeseries/idb/1year", 
	type = "variables")

## ---- purl = NOT_CRAN, eval = NOT_CRAN----------------------------------------
pop_2050 <- getCensus(name = "timeseries/idb/1year",
	vars = c("FIPS", "NAME", "AGE", "POP"),
	time = 2050)
head(pop_2050)

## ---- purl = NOT_CRAN, eval = NOT_CRAN----------------------------------------
pop_portugal <- getCensus(
	name = "timeseries/idb/1year",
	vars = c("NAME", "POP"),
	time = 2050,
	FIPS = "PO",
	AGE = "13:19")
pop_portugal

## ---- purl = NOT_CRAN, eval = NOT_CRAN----------------------------------------
qwi <- getCensus(
	name = "timeseries/qwi/sa",
	region = "state:02",
	vars = c("Emp", "sex"),
	year = 2012,
	quarter = 1,
	agegrp = "A07",
	ownercode = "A05",
	firmsize = 1,
	seasonadj = "U",
	industry = 21)
qwi

## ---- purl = NOT_CRAN, eval = NOT_CRAN----------------------------------------
acs_income <- getCensus(
	name = "acs/acs5",
	vintage = 2017, 
	vars = c("NAME", "B19013_001E", "B19013_001EA", "B19013_001M", "B19013_001MA"), 
	region = "tract:*", 
	regionin = "state:02")
head(acs_income)

## ---- purl = NOT_CRAN, eval = NOT_CRAN----------------------------------------
# See descriptions of the variables in group B19013
group_B19013 <- listCensusMetadata(
	name = "acs/acs5",
	vintage = 2017,
	type = "variables",
	group = "B19013")
group_B19013

acs_income_group <- getCensus(
	name = "acs/acs5", 
	vintage = 2017, 
	vars = c("NAME", "group(B19013)"), 
	region = "tract:*", 
	regionin = "state:02")
head(acs_income_group)

## ---- purl = NOT_CRAN, eval = NOT_CRAN----------------------------------------
group_B17020 <- listCensusMetadata(
	name = "acs/acs5",
	vintage = 2017,
	type = "variables",
	group = "B17020")
head(group_B17020)

## ---- purl = NOT_CRAN, eval = NOT_CRAN----------------------------------------
tracts <- NULL
for (f in fips) {
	stateget <- paste("state:", f, sep="")
	temp <- getCensus(
		name = "dec/sf1",
		vintage = 2010,
		vars = "P001001",
		region = "tract:*",
		regionin = stateget)
	tracts <- rbind(tracts, temp)
}
head(tracts)

## ---- purl = NOT_CRAN, eval = NOT_CRAN----------------------------------------
data2010 <- getCensus(
	name = "dec/sf1",
	vintage = 2010,
	vars = "P001001", 
	region = "block:*",
	regionin = "state:36+county:027+tract:010000")
head(data2010)

