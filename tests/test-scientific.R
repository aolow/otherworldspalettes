# Regression tests for scientific palettes and ggplot2 scales.
library(otherworldspalettes)

scientific <- c("ion_balance", "stellar_balance", "ember_balance")
stopifnot(all(scientific %in% names(otherworlds_continuous_palettes())))
for (nm in scientific) {
  x <- otherworlds_continuous_palette(101, nm)
  stopifnot(length(x) == 101L, all(grepl("^#[0-9A-F]{6}$", x)))
  stopifnot(identical(rev(x), otherworlds_continuous_palette(101, nm, -1)))
  center <- grDevices::col2rgb(x[51])
  stopifnot(max(center) - min(center) < 10L, min(center) >= 230L)
}
stopifnot(identical(otherworlds_palette(8, "nebula"), otherworlds_palette(8, "stellar")))
stopifnot(identical(otherworlds_palette(12, "stellar"), otherworlds_palette(12, "cosmic")))

if (requireNamespace("ggplot2", quietly = TRUE)) {
  df <- data.frame(x = 1:4, y = 1:4, grp = c("A","B","C","D"), val = c(-1, 0, 0.5, 1))
  p <- ggplot2::ggplot(df, ggplot2::aes(x, y, colour = grp)) +
    ggplot2::geom_point() + scale_colour_otherworlds(palette = "nebula")
  stopifnot(inherits(ggplot2::ggplot_build(p), "ggplot_built"))
  q <- ggplot2::ggplot(df, ggplot2::aes(x, y, fill = val)) +
    ggplot2::geom_tile() +
    scale_fill_otherworlds_c(palette = "ion_balance", limits = c(-1, 1))
  stopifnot(inherits(ggplot2::ggplot_build(q), "ggplot_built"))
  p_many <- ggplot2::ggplot(
    data.frame(x = 1:21, group = factor(1:21)),
    ggplot2::aes(x, fill = group)
  ) + ggplot2::geom_bar() + scale_fill_otherworlds(palette = "cosmic")
  stopifnot(inherits(try(ggplot2::ggplot_build(p_many),
                         silent = TRUE), "try-error"))
}
