.otherworlds_continuous_palettes <- list(
  emerald_void = c(
    deep_space = "#071B1A",
    shadow_emerald = "#0B3D35",
    mineral_green = "#117A65",
    luminous_emerald = "#41B883",
    atmospheric_mint = "#C9F2CD"
  ),
  blue_hour = c(
    midnight = "#080B2B",
    deep_blue = "#142B5F",
    stellar_blue = "#185A9D",
    atmosphere = "#2E8BC0",
    ice_cyan = "#78C6D0",
    moonlight = "#D7F2E9"
  ),
  red_giant = c(
    eclipse = "#19080F",
    oxblood = "#4A1024",
    nebula_red = "#8A1C32",
    flare = "#C43A3F",
    solar_coral = "#EA7555",
    warm_starlight = "#FFD0A6"
  ),
  magenta_orbit = c(
    night_violet = "#160A25",
    deep_orbit = "#3C145E",
    cosmic_violet = "#77207D",
    orbit_magenta = "#B82E86",
    ion_pink = "#E75A9B",
    rose_moon = "#F7BCD0"
  ),
  tidal_emerald = c(
    blue_black = "#081126",
    distant_blue = "#173B6C",
    tidal_blue = "#1C6F91",
    deep_teal = "#169A88",
    emerald = "#55BF78",
    alien_light = "#D5E887"
  ),
  supernova = c(
    void_plum = "#190B2C",
    royal_purple = "#5A176E",
    orbit_magenta = "#A62072",
    nebula_red = "#D63A55",
    vermilion = "#EF7041",
    solar_gold = "#F6B45B",
    star_core = "#F4E6A2"
  )
)

#' List available continuous Other Worlds palettes
#'
#' @return A named integer vector containing the number of colour anchors in
#'   each continuous palette.
#' @export
#' @examples
#' otherworlds_continuous_palettes()
otherworlds_continuous_palettes <- function() {
  vapply(.otherworlds_continuous_palettes, length, integer(1))
}

#' Retrieve a continuous Other Worlds colour palette
#'
#' Interpolates art-inspired colour anchors in CIE Lab space to create smooth
#' sequential palettes for continuous data.
#'
#' @param n Number of colours to return.
#' @param palette Name of a continuous Other Worlds palette. See
#'   [otherworlds_continuous_palettes()].
#' @param direction Use `1` for dark-to-light or `-1` to reverse the palette.
#'
#' @return A character vector of hexadecimal colours.
#' @export
#' @examples
#' otherworlds_continuous_palette(8, "tidal_emerald")
#' image(volcano, col = otherworlds_continuous_palette(100, "supernova"))
otherworlds_continuous_palette <- function(n = 256, palette = "tidal_emerald",
                                           direction = 1) {
  if (length(palette) != 1L || !is.character(palette) ||
      !palette %in% names(.otherworlds_continuous_palettes)) {
    stop("`palette` must be one of: ",
         paste(names(.otherworlds_continuous_palettes), collapse = ", "),
         call. = FALSE)
  }
  if (length(direction) != 1L || !direction %in% c(-1, 1)) {
    stop("`direction` must be 1 or -1.", call. = FALSE)
  }
  if (length(n) != 1L || !is.numeric(n) || is.na(n) ||
      n != as.integer(n) || n < 1L) {
    stop("`n` must be a positive whole number.", call. = FALSE)
  }

  anchors <- unname(.otherworlds_continuous_palettes[[palette]])
  if (direction == -1) {
    anchors <- rev(anchors)
  }
  grDevices::colorRampPalette(anchors, space = "Lab")(as.integer(n))
}

