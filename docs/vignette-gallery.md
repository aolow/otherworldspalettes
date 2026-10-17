# Visual vignette gallery

**View figures directly on GitHub**, without needing R or opening the `.Rhtml` source files.

These browser-viewable **SVG visual previews** recreate the plots using the same stored palette hex colors and synthetic-data recipes. They are **illustrative representations**, not images exported from the installed R vignette engine. The original Rhtml files remain executable sources, and their exact random draws can differ.

## Space figures

### 1. Hertzsprung–Russell-style diagram

The three colored classes are simulated stellar populations, not observations.

![Synthetic H-R-style diagram](previews/hr-diagram.svg)

### 2. All-sky density field

An equirectangular synthetic Galactic band and central bulge, using a Supernova-inspired sequential gradient.

![Synthetic all-sky density](previews/sky-density.svg)

### 3. Exoplanet-style scatterplot

Simulated exoplanet detections on logarithmic axes, grouped by method.

![Synthetic exoplanet scatterplot](previews/exoplanets.svg)

### 4. Galaxy 40 comparison

The exact stored colors in both 40-category palettes on the same synthetic cluster geometry.

![Galaxy 40 compatibility versus maximized distinction](previews/galaxy40.svg)

[Executable space-figures vignette](../vignettes/space-figures.Rhtml) · [Executable Galaxy 40 vignette](../vignettes/galaxy40.Rhtml)

## Dark slides

### 5. Scatterplot on charcoal

![Dark-background scatter](previews/dark-scatter.svg)

### 6. Lines on navy

![Dark-background lines](previews/dark-lines.svg)

### 7. Full dark color family

![Eclipse, Afterglow and Deepfield](../man/figures/dark-palettes.svg)

[Executable dark-slides vignette](../vignettes/dark-slides.Rhtml)

---

**Design caveats:** These palettes are not certified for color-vision accessibility or calibrated quantitative inference. Use direct labels, consider line types and shapes, and inspect plots in the intended viewing environment. Dark discrete colors do not replace sequential or diverging numeric colormaps.
