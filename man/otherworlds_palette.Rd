\name{otherworlds_palette}
\alias{otherworlds_palette}
\title{Retrieve an Other Worlds Colour Palette}
\usage{
otherworlds_palette(n = NULL, palette = "cosmic", direction = 1)
}
\arguments{
\item{n}{Number of colours to return. Defaults to the full palette.}
\item{palette}{One of \code{"nebula"}, \code{"stellar"}, or \code{"cosmic"}.}
\item{direction}{Use 1 for the original order or -1 to reverse it.}
}
\value{A named character vector of hexadecimal colours.}
\description{Returns colours from a high-contrast, art-inspired qualitative palette.}
\examples{
otherworlds_palette()
otherworlds_palette(5, "nebula")
barplot(rep(1, 8), col = otherworlds_palette(8, "nebula"), border = NA)
}
