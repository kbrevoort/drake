% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read.R
\name{loadd}
\alias{loadd}
\title{Load one or more targets or imports from the drake cache.}
\usage{
loadd(..., list = character(0), imported_only = FALSE,
  path = getwd(), search = TRUE, cache = drake::get_cache(path =
  path, search = search, verbose = verbose), namespace = NULL,
  envir = parent.frame(), jobs = 1,
  verbose = drake::default_verbose(), deps = FALSE, lazy = "eager",
  graph = NULL, replace = TRUE, show_source = FALSE)
}
\arguments{
\item{...}{targets to load from the cache: as names (symbols),
character strings, or \code{dplyr}-style \code{tidyselect}
commands such as \code{starts_with()}.}

\item{list}{character vector naming targets to be loaded from the
cache. Similar to the \code{list} argument of \code{\link[=remove]{remove()}}.}

\item{imported_only}{logical, whether only imported objects
should be loaded.}

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

\item{namespace}{character scalar,
name of an optional storr namespace to load from.}

\item{envir}{environment to load objects into. Defaults to the
calling environment (current workspace).}

\item{jobs}{number of parallel jobs for loading objects. On
non-Windows systems, the loading process for multiple objects
can be lightly parallelized via \code{parallel::mclapply()}.
just set jobs to be an integer greater than 1. On Windows,
\code{jobs} is automatically demoted to 1.}

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

\item{deps}{logical, whether to load any cached
dependencies of the targets
instead of the targets themselves.
This is useful if you know your
target failed and you want to debug the command in an interactive
session with the dependencies in your workspace.
One caveat: to find the dependencies,
\code{\link[=loadd]{loadd()}} uses information that was stored
in a \code{\link[=drake_config]{drake_config()}} list and cached
during the last \code{\link[=make]{make()}}.
That means you need to have already called \code{\link[=make]{make()}}
if you set \code{deps} to \code{TRUE}.}

\item{lazy}{either a string or a logical. Choices:
\itemize{
\item \code{"eager"}: no lazy loading. The target is loaded right away
with \code{\link[=assign]{assign()}}.
\item \code{"promise"}: lazy loading with \code{\link[=delayedAssign]{delayedAssign()}}
\item \code{"bind"}: lazy loading with active bindings:
\code{\link[bindr:populate_env]{bindr::populate_env()}}.
\item \code{TRUE}: same as \code{"promise"}.
\item \code{FALSE}: same as \code{"eager"}.
}}

\item{graph}{optional igraph object, representation
of the workflow network for getting dependencies
if \code{deps} is \code{TRUE}. If none is supplied,
it will be read from the cache.}

\item{replace}{logical. If \code{FALSE},
items already in your environment
will not be replaced.}

\item{show_source}{logical, option to show the command
that produced the target or indicate that the object
was imported (using \code{\link[=show_source]{show_source()}}).}
}
\value{
\code{NULL}
}
\description{
Loads the object(s) into the
current workspace (or environment \code{envir} if given). Defaults
to loading the entire cache if you do not supply anything
to arguments \code{...} or \code{list}.
}
\details{
\code{loadd()} excludes foreign imports:
R objects not originally defined in \code{envir}
when \code{\link[=make]{make()}} last imported them.
To get these objects, use \code{\link[=readd]{readd()}}.
}
\examples{
\dontrun{
test_with_dir("Quarantine side effects.", {
load_mtcars_example() # Get the code with drake_example("mtcars").
make(my_plan) # Run the projects, build the targets.
loadd(small) # Load target 'small' into your workspace.
small
# For many targets, you can parallelize loadd()
# using the 'jobs' argument.
loadd(list = c("small", "large"), jobs = 2)
ls()
# How about tidyselect?
loadd(starts_with("summ"))
ls()
# Load the dependencies of the target, coef_regression2_small
loadd(coef_regression2_small, deps = TRUE)
ls()
# Load all the imported objects/functions.
# Note: loadd() excludes foreign imports
# (R objects not originally defined in `envir`
# when `make()` last imported them).
loadd(imported_only = TRUE)
ls()
# Load all the targets listed in the workflow plan
# of the previous `make()`.
# Be sure your computer has enough memory.
loadd()
ls()
# With files, you just get the fingerprint.
loadd(list = file_store("report.md"))
ls() # Should include "\\"report.md\\"".
get(file_store("report.md"))
})
}
}
\seealso{
\code{\link[=readd]{readd()}}, \code{\link[=cached]{cached()}}, \code{\link[=built]{built()}},
\code{\link[=imported]{imported()}}, \code{\link[=drake_plan]{drake_plan()}}, \code{\link[=make]{make()}},
}
