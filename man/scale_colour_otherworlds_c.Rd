\name{scale_colour_otherworlds_c}
\alias{scale_colour_otherworlds_c}
\alias{scale_color_otherworlds_c}
\alias{scale_fill_otherworlds_c}
\title{Other Worlds Continuous Colour Scales}
\usage{
scale_colour_otherworlds_c(..., palette = "tidal_emerald", direction = 1,
  aesthetics = "colour")

scale_color_otherworlds_c(..., palette = "tidal_emerald", direction = 1,
  aesthetics = "colour")

scale_fill_otherworlds_c(..., palette = "tidal_emerald", direction = 1,
  aesthetics = "fill")
}
\arguments{
\item{...}{Arguments passed to \code{ggplot2::continuous_scale()}.}
\item{palette}{Name of a continuous Other Worlds palette. See
\code{otherworlds_continuous_palettes()}.}
\item{direction}{Use 1 for dark-to-light or -1 to reverse the palette.}
\item{aesthetics}{Character vector of aesthetics to scale.}
}
\value{A \pkg{ggplot2} scale object.}
\description{Applies a deep-space-inspired continuous palette to a ggplot2
scale.}
