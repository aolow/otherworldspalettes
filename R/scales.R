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
