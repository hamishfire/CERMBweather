% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/db_functions.R
\name{bom_db_open}
\alias{bom_db_open}
\title{Open a connection to an existing database}
\usage{
bom_db_open(dbpath, readonly = TRUE)
}
\arguments{
\item{dbpath}{A character path to an existing database file.}

\item{readonly}{If TRUE (default) a read-only connection is returned that
you can use to query the database but not to import new data. If
FALSE, a read-write connection is returned that can be used with
\code{\link{bom_db_import}}.}
}
\value{
A database connection pool object that can be used with other package
  functions such as \code{\link{bom_db_import}} as well as with \code{dplyr}
  functions. It should be closed at the end of a session with
  \code{\link{bom_db_close}}.
}
\description{
This function connects an existing database and checks that it contains the
required tables for synoptic and AWS data. If a 'Stations' table is not present
in the database, it is added. By default, a read-only connection is returned.
}
\examples{
\dontrun{
# Open a database
DB <- bom_db_open("c:/foo/bar/weather.db")

# Do things with it
bom_db_import(DB, "c:/foo/updates/some_aws.zip")

# At end of session
bom_db_close(DB)
}

}
