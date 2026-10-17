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
  ),
  galaxy40 = c(
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
    vermilion = "#D94330",
    galaxy_21 = "#08523D",
    galaxy_22 = "#FD89A2",
    galaxy_23 = "#405000",
    galaxy_24 = "#6F3B53",
    galaxy_25 = "#8F1000",
    galaxy_26 = "#5B7857",
    galaxy_27 = "#B78576",
    galaxy_28 = "#D414FE",
    galaxy_29 = "#AF7993",
    galaxy_30 = "#F966D4",
    galaxy_31 = "#1B7675",
    galaxy_32 = "#FF2078",
    galaxy_33 = "#167706",
    galaxy_34 = "#98AE88",
    galaxy_35 = "#7F0A76",
    galaxy_36 = "#4050FF",
    galaxy_37 = "#AC6809",
    galaxy_38 = "#5C4D74",
    galaxy_39 = "#F8746A",
    galaxy_40 = "#0000EF"
  ),
  galaxy40_max = c(
    galaxy_01 = "#8145AF",
    galaxy_02 = "#3EC30A",
    galaxy_03 = "#604000",
    galaxy_04 = "#FF7070",
    galaxy_05 = "#12B9F3",
    galaxy_06 = "#147769",
    galaxy_07 = "#AF1040",
    galaxy_08 = "#FF70EF",
    galaxy_09 = "#8F8457",
    galaxy_10 = "#F69307",
    galaxy_11 = "#04C1AB",
    galaxy_12 = "#CF3B01",
    galaxy_13 = "#A9748E",
    galaxy_14 = "#097AF0",
    galaxy_15 = "#1C7411",
    galaxy_16 = "#683554",
    galaxy_17 = "#D60797",
    galaxy_18 = "#8383B2",
    galaxy_19 = "#895E4B",
    galaxy_20 = "#98AE88",
    galaxy_21 = "#209CA8",
    galaxy_22 = "#CF20FF",
    galaxy_23 = "#205030",
    galaxy_24 = "#43496C",
    galaxy_25 = "#B07805",
    galaxy_26 = "#990305",
    galaxy_27 = "#F70664",
    galaxy_28 = "#009F50",
    galaxy_29 = "#EF8FAF",
    galaxy_30 = "#B38AFD",
    galaxy_31 = "#CF9F80",
    galaxy_32 = "#005861",
    galaxy_33 = "#BB9CC6",
    galaxy_34 = "#084AFA",
    galaxy_35 = "#EF7040",
    galaxy_36 = "#B35D60",
    galaxy_37 = "#638C04",
    galaxy_38 = "#ACA754",
    galaxy_39 = "#097296",
    galaxy_40 = "#8C027C"
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
#' @param palette One of `"nebula"`, `"stellar"`, `"cosmic"`,\n#'   `"galaxy40"`, or `"galaxy40_max"`.
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
