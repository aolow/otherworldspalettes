\name{otherworlds_continuous_palette}
\alias{otherworlds_continuous_palette}
\title{Retrieve a Continuous Other Worlds Colour Palette}
\usage{
otherworlds_continuous_palette(n = 256, palette = "tidal_emerald",
  direction = 1)
}
\arguments{
\item{n}{Number of colours to return.}
\item{palette}{Name of a continuous Other Worlds palette. See
\code{otherworlds_continuous_palettes()}.}
\item{direction}{Use 1 for dark-to-light or -1 to reverse the palette.}
}
\value{A character vector of hexadecimal colours.}
\description{Interpolates art-inspired anchors in CIE Lab space to create
smooth sequential or three-colour diverging palettes for continuous data.}
\examples{
otherworlds_continuous_palette(8, "tidal_emerald")
image(volcano, col = otherworlds_continuous_palette(100, "supernova"))
}
