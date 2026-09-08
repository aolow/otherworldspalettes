\name{scale_colour_otherworlds}
\alias{scale_colour_otherworlds}
\alias{scale_color_otherworlds}
\alias{scale_fill_otherworlds}
\title{Other Worlds Discrete Colour Scales}
\usage{
scale_colour_otherworlds(..., palette = "cosmic", direction = 1,
  aesthetics = "colour")

scale_color_otherworlds(..., palette = "cosmic", direction = 1,
  aesthetics = "colour")

scale_fill_otherworlds(..., palette = "cosmic", direction = 1,
  aesthetics = "fill")
}
\arguments{
\item{...}{Arguments passed to \code{ggplot2::discrete_scale()}.}
\item{palette}{One of \code{"nebula"}, \code{"stellar"}, or \code{"cosmic"}.}
\item{direction}{Use 1 for the original order or -1 to reverse it.}
\item{aesthetics}{Character vector of aesthetics to scale.}
}
\value{A \pkg{ggplot2} scale object.}
\description{Applies an art-inspired qualitative palette to a discrete ggplot2 scale.}
\examples{
if (requireNamespace("ggplot2", quietly = TRUE)) {
  ggplot2::ggplot(iris, ggplot2::aes(Sepal.Length, Sepal.Width,
    colour = Species)) +
    ggplot2::geom_point() +
    scale_colour_otherworlds(palette = "nebula")
}
}
