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
