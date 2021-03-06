% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read.R
\name{read_drake_config}
\alias{read_drake_config}
\title{Read the cached \code{\link[=drake_config]{drake_config()}}
list from the last \code{\link[=make]{make()}}.}
\usage{
read_drake_config(path = getwd(), search = TRUE, cache = NULL,
  verbose = drake::default_verbose(), jobs = 1,
  envir = parent.frame())
}
\arguments{
\item{path}{Root directory of the drake project,
or if \code{search} is \code{TRUE}, either the
project root or a subdirectory of the project.
Ignored if a \code{cache} is supplied.}

\item{search}{logical. If \code{TRUE}, search parent directories
to find the nearest drake cache. Otherwise, look in the
current working directory only.
Ignored if a \code{cache} is supplied.}

\item{cache}{drake cache. See \code{\link[=new_cache]{new_cache()}}.
If supplied, \code{path} and \code{search} are ignored.}

\item{verbose}{logical or numeric, control printing to the console.
Use \code{pkgconfig} to set the default value of \code{verbose}
for your R session:
for example, \code{pkgconfig::set_config("drake::verbose" = 2)}.
\describe{
\item{0 or \code{FALSE}:}{print nothing.}
\item{1 or \code{TRUE}:}{print only targets to build.}
\item{2:}{in addition, print checks and cache info.}
\item{3:}{in addition, print any potentially missing items.}
\item{4:}{in addition, print imports. Full verbosity.}
}}

\item{jobs}{number of jobs for light parallelism.
Supports 1 job only on Windows.}

\item{envir}{Optional environment to fill in if
\code{config$envir} was not cached. Defaults to your workspace.}
}
\value{
The cached master internal configuration list
of the last \code{\link[=make]{make()}}.
}
\description{
See \code{\link[=drake_config]{drake_config()}} for more information
about drake's internal runtime configuration parameter list.
}
\examples{
\dontrun{
test_with_dir("Quarantine side effects.", {
load_mtcars_example() # Get the code with drake_example("mtcars").
make(my_plan) # Run the project, build the targets.
# Retrieve the master internal configuration list from the cache.
read_drake_config()
})
}
}
\seealso{
\code{\link[=make]{make()}}
}
