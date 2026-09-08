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
      magenta_orbit = 6L, tidal_emerald = 6L, supernova = 7L)
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
