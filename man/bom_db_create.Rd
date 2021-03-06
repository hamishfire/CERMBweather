% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/db_functions.R
\name{bom_db_create}
\alias{bom_db_create}
\title{Create a new database for weather data}
\usage{
bom_db_create(dbpath)
}
\arguments{
\item{dbpath}{A character path to the new database file. An error is thrown
if the file already exists.}
}
\value{
A database connection pool object that can be used with other package
  functions such as \code{\link{bom_db_import}} as well as with \code{dplyr}
  functions. It should be closed at the end of a session with
  \code{\link{bom_db_close}}.
}
\description{
This function creates a new database with tables: 'Synoptic' for synoptic
data records; 'AWS' for automatic weather station data records; and
'Stations' with details of station names and locations. SQLite databases
consist of a single file which holds all tables. The file extension is
arbitrary and may be omitted, but using '.db' or '.sqlite' is recommended for
sanity.
}
\examples{
\dontrun{
# Create a new database file with the required weather data tables
# for AWS and synoptic data and weather station metadata
DB <- bom_db_create("c:/foo/bar/weather.db")

# Do things with it
bom_db_import(DB, "c:/foo/bar/update_aws.zip")

# At end of session
bom_db_close(DB)
}
}
