library(otherworldspalettes)

stopifnot(
  identical(
    otherworlds_palettes(),
    c(nebula = 8L, stellar = 12L, cosmic = 20L)
  )
)

x <- otherworlds_palette(8, "nebula")
stopifnot(
  length(x) == 8L,
  all(grepl("^#[0-9A-F]{6}$", x)),
  all(nzchar(names(x))),
  identical(otherworlds_palette(8, "nebula", -1), rev(x))
)

stopifnot(
  inherits(try(otherworlds_palette(21), silent = TRUE), "try-error"),
  inherits(try(otherworlds_palette(palette = "earth"), silent = TRUE), "try-error"),
  inherits(try(otherworlds_palette(direction = 0), silent = TRUE), "try-error")
)

stopifnot(
  identical(
    otherworlds_continuous_palettes(),
    c(emerald_void = 5L, blue_hour = 6L, red_giant = 6L,
      magenta_orbit = 6L, tidal_emerald = 6L, supernova = 6L,
      solar_tide = 3L, alien_bloom = 3L, cosmic_shore = 3L,
      signal_fire = 5L, ultraviolet = 5L, alien_heat = 5L)
  )
)

for (nm in c("signal_fire", "ultraviolet", "alien_heat")) {
  high_contrast <- otherworlds_continuous_palette(101, nm)
  stopifnot(
    length(unique(high_contrast)) > 95L,
    max(grDevices::col2rgb(high_contrast)) >= 240L,
    min(grDevices::col2rgb(high_contrast)) <= 10L
  )
}

anchors_are_preserved <- function(actual, expected) {
  max(abs(grDevices::col2rgb(actual) - grDevices::col2rgb(expected))) <= 1L
}
stopifnot(
  anchors_are_preserved(
    otherworlds_continuous_palette(3, "solar_tide"),
    c("#1859A9", "#F4C430", "#BE2E4A")
  ),
  anchors_are_preserved(
    otherworlds_continuous_palette(3, "alien_bloom"),
    c("#087F5B", "#F3D9A2", "#C13C91")
  ),
  anchors_are_preserved(
    otherworlds_continuous_palette(3, "cosmic_shore"),
    c("#51317A", "#9ED9E5", "#D94330")
  )
)

y <- otherworlds_continuous_palette(256, "tidal_emerald")
stopifnot(
  length(y) == 256L,
  all(grepl("^#[0-9A-F]{6}$", y)),
  identical(
    otherworlds_continuous_palette(11, "supernova", -1),
    rev(otherworlds_continuous_palette(11, "supernova"))
  ),
  inherits(try(otherworlds_continuous_palette(0), silent = TRUE), "try-error"),
  inherits(try(otherworlds_continuous_palette(palette = "earth"), silent = TRUE),
           "try-error")
)
