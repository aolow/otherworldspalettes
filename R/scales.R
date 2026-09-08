#' Other Worlds discrete colour scales
#'
#' Apply an art-inspired qualitative palette to a discrete 'ggplot2' scale.
#'
#' @param ... Arguments passed to [ggplot2::discrete_scale()].
#' @param palette One of `"nebula"`, `"stellar"`, or `"cosmic"`.
#' @param direction Use `1` for the original order or `-1` to reverse it.
#' @param aesthetics Character vector of aesthetics to scale.
#'
#' @return A 'ggplot2' scale object.
#' @export
#' @examples
#' if (requireNamespace("ggplot2", quietly = TRUE)) {
#'   ggplot2::ggplot(iris, ggplot2::aes(Sepal.Length, Sepal.Width,
#'     colour = Species)) +
#'     ggplot2::geom_point(size = 2) +
#'     scale_colour_otherworlds(palette = "nebula")
#' }
scale_colour_otherworlds <- function(..., palette = "cosmic", direction = 1,
                                     aesthetics = "colour") {
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Package 'ggplot2' is required for this scale.", call. = FALSE)
  }
  values <- otherworlds_palette(NULL, palette, direction)
  palette_function <- function(n) {
    if (n > length(values)) {
      stop("The '", palette, "' palette supports at most ", length(values),
           " discrete values; requested ", n, ".", call. = FALSE)
    }
    unname(values[seq_len(n)])
  }
  ggplot2::discrete_scale(aesthetics, name = palette,
                          palette = palette_function, ...)
}

#' @rdname scale_colour_otherworlds
#' @export
scale_color_otherworlds <- scale_colour_otherworlds

#' @rdname scale_colour_otherworlds
#' @export
scale_fill_otherworlds <- function(..., palette = "cosmic", direction = 1,
                                   aesthetics = "fill") {
  scale_colour_otherworlds(..., palette = palette, direction = direction,
                           aesthetics = aesthetics)
}

#' Other Worlds continuous colour scales
#'
#' Apply a deep-space-inspired continuous palette to a 'ggplot2' scale.
#'
#' @param ... Arguments passed to [ggplot2::continuous_scale()].
#' @param palette Name of a continuous Other Worlds palette. See
#'   [otherworlds_continuous_palettes()].
#' @param direction Use `1` for dark-to-light or `-1` to reverse the palette.
#' @param aesthetics Character vector of aesthetics to scale.
#'
#' @return A 'ggplot2' scale object.
#' @export
scale_colour_otherworlds_c <- function(..., palette = "tidal_emerald",
                                       direction = 1,
                                       aesthetics = "colour") {
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Package 'ggplot2' is required for this scale.", call. = FALSE)
  }
  palette_function <- function(x) {
    ramp <- grDevices::colorRamp(
      otherworlds_continuous_palette(256, palette, direction), space = "Lab"
    )
    colours <- rep(NA_character_, length(x))
    keep <- !is.na(x)
    colours[keep] <- grDevices::rgb(ramp(x[keep]), maxColorValue = 255)
    colours
  }
  ggplot2::continuous_scale(aesthetics, name = palette,
                            palette = palette_function, ...)
}

#' @rdname scale_colour_otherworlds_c
#' @export
scale_color_otherworlds_c <- scale_colour_otherworlds_c

#' @rdname scale_colour_otherworlds_c
#' @export
scale_fill_otherworlds_c <- function(..., palette = "tidal_emerald",
                                     direction = 1, aesthetics = "fill") {
  scale_colour_otherworlds_c(..., palette = palette, direction = direction,
                             aesthetics = aesthetics)
}
