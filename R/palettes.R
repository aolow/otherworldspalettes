.otherworlds_palettes <- list(
  nebula = c(
    tidal_teal = "#009E91",
    nebula_red = "#BE2E4A",
    atmosphere = "#9ED9E5",
    sun_yellow = "#F4C430",
    slate = "#60758C",
    tangerine = "#F58231",
    sky_blue = "#4E91D8",
    olive = "#7A8B22"
  ),
  stellar = c(
    tidal_teal = "#009E91",
    nebula_red = "#BE2E4A",
    atmosphere = "#9ED9E5",
    sun_yellow = "#F4C430",
    slate = "#60758C",
    tangerine = "#F58231",
    sky_blue = "#4E91D8",
    olive = "#7A8B22",
    orbit_magenta = "#C13C91",
    emerald = "#00A65A",
    lunar_lavender = "#A68AD5",
    chartreuse = "#A7C636"
  ),
  cosmic = c(
    tidal_teal = "#009E91",
    nebula_red = "#BE2E4A",
    atmosphere = "#9ED9E5",
    sun_yellow = "#F4C430",
    slate = "#60758C",
    tangerine = "#F58231",
    sky_blue = "#4E91D8",
    olive = "#7A8B22",
    orbit_magenta = "#C13C91",
    emerald = "#00A65A",
    lunar_lavender = "#A68AD5",
    chartreuse = "#A7C636",
    deep_blue = "#1859A9",
    ancient_umber = "#8C5A3C",
    royal_purple = "#8046B2",
    cream = "#F3D9A2",
    night_ink = "#25314F",
    dune_sand = "#D5A267",
    bright_cyan = "#00B9D8",
    vermilion = "#D94330"
  )
)

#' List available Other Worlds palettes
#'
#' @return A named integer vector containing the maximum number of colours in
#'   each palette.
#' @export
#' @examples
#' otherworlds_palettes()
otherworlds_palettes <- function() {
  vapply(.otherworlds_palettes, length, integer(1))
}

#' Retrieve an Other Worlds colour palette
#'
#' @param n Number of colours to return. Defaults to every colour in the
#'   selected palette.
#' @param palette One of `"nebula"`, `"stellar"`, or `"cosmic"`.
#' @param direction Use `1` for the original order or `-1` to reverse it.
#'
#' @return A named character vector of hexadecimal colours.
#' @export
#' @examples
#' otherworlds_palette()
#' otherworlds_palette(5, "nebula")
#' barplot(rep(1, 8), col = otherworlds_palette(8, "nebula"), border = NA)
otherworlds_palette <- function(n = NULL, palette = "cosmic", direction = 1) {
  if (length(palette) != 1L || !is.character(palette) ||
      !palette %in% names(.otherworlds_palettes)) {
    stop("`palette` must be one of: ",
         paste(names(.otherworlds_palettes), collapse = ", "), call. = FALSE)
  }
  if (length(direction) != 1L || !direction %in% c(-1, 1)) {
    stop("`direction` must be 1 or -1.", call. = FALSE)
  }

  values <- .otherworlds_palettes[[palette]]
  if (is.null(n)) {
    n <- length(values)
  }
  if (length(n) != 1L || !is.numeric(n) || is.na(n) ||
      n != as.integer(n) || n < 1L || n > length(values)) {
    stop("`n` must be a whole number between 1 and ", length(values),
         " for palette '", palette, "'.", call. = FALSE)
  }

  values <- values[seq_len(as.integer(n))]
  if (direction == -1) rev(values) else values
}
