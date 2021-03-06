% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hooks.R
\name{output_sink_hook}
\alias{output_sink_hook}
\title{An example \code{hook} argument to
\code{make()} that redirects output messages to files.}
\usage{
output_sink_hook(code)
}
\arguments{
\item{code}{code to run to build the target.}
}
\value{
A function that you can supply to the \code{hook} argument
of \code{\link[=make]{make()}}.
}
\description{
Most users do not need to micromanage hooks.
}
\examples{
\dontrun{
test_with_dir("Quarantine side effects.", {
# Test out the output sink hook on its own.
try(
  output_sink_hook({
    cat(1234)
    stop(5678)
  }),
  silent = FALSE
)
# Create a new workflow plan.
x <- drake_plan(loud = cat(1234), bad = stop(5678))
# Run the project. Standard output (via cat() and print())
# should be suppressed, but messages should persist.
try(make(x, hook = output_sink_hook), silent = FALSE)
})
}
}
\seealso{
\code{\link[=make]{make()}}, \code{\link[=silencer_hook]{silencer_hook()}},
\code{\link[=message_sink_hook]{message_sink_hook()}}
}
