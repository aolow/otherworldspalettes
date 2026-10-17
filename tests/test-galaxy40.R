# Galaxy 40 is qualitative: preserve the previous 20 and validate both 40-color choices.
library(otherworldspalettes)

original <- otherworlds_palette(20L, "cosmic")
compatible <- otherworlds_palette(40L, "galaxy40")
optimized <- otherworlds_palette(40L, "galaxy40_max")
stopifnot(
  identical(compatible[seq_len(20L)], original),
  length(compatible) == 40L,
  length(optimized) == 40L,
  length(unique(unname(compatible))) == 40L,
  length(unique(unname(optimized))) == 40L,
  identical(unname(otherworlds_palette(40L, "galaxy40", -1L)), rev(unname(compatible))),
  identical(unname(otherworlds_palette(40L, "galaxy40_max", -1L)), rev(unname(optimized))),
  all(grepl("^#[A-F0-9]{6}$", compatible)),
  all(grepl("^#[A-F0-9]{6}$", optimized)),
  all(nzchar(names(compatible))),
  all(nzchar(names(optimized))),
  inherits(try(otherworlds_palette(41L, "galaxy40"), silent = TRUE), "try-error"),
  inherits(try(otherworlds_palette(41L, "galaxy40_max"), silent = TRUE), "try-error")
)

# Test the plotting scale on the actual 40-category case.
if (requireNamespace("ggplot2", quietly = TRUE)) {
  df <- data.frame(
    x = seq_len(40L),
    y = rep(1, 40L),
    category = factor(sprintf("G%02d", seq_len(40L)))
  )
  for (pal in c("galaxy40", "galaxy40_max")) {
    p <- ggplot2::ggplot(df, ggplot2::aes(x, y, colour = category)) +
      ggplot2::geom_point(size = 2) +
      scale_colour_otherworlds(palette = pal)
    built <- ggplot2::ggplot_build(p)
    stopifnot(
      inherits(built, "ggplot_built"),
      length(unique(built$data[[1]]$colour)) == 40L
    )
  }
}
