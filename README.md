# otherworldspalettes

`otherworldspalettes` provides vivid qualitative colour palettes derived from
the *Other Worlds* art project. Colours are deliberately ordered so neighbouring
series jump across hue and lightness instead of forming clusters of similar
shades.

## Palettes

![All three Other Worlds palettes](man/figures/all-palettes.png)

The package contains three **nested sizes of one palette system**, rather than
three unrelated colour schemes:

- `nebula` contains 8 colours and is the recommended default for most figures.
- `stellar` contains the same 8 colours plus 4 additional colours, for 12 total.
- `cosmic` contains all `stellar` colours plus 8 additional colours, for 20 total.

This means a figure can grow from `nebula` to `stellar` or `cosmic` without
changing the colours already assigned to its existing groups. Within each
palette, the order jumps across hue and lightness to keep neighbouring groups
visually distinct.

## Installation

```r
# install.packages("pak")
pak::pak("aolow/otherworldspalettes")
```

## Use

```r
library(ggplot2)
library(otherworldspalettes)

otherworlds_palettes()

nebula <- otherworlds_palette(8, "nebula")
stellar <- otherworlds_palette(12, "stellar")
cosmic <- otherworlds_palette(20, "cosmic")

# Optional ggplot2 scales
ggplot(iris, aes(Sepal.Length, Sepal.Width, colour = Species)) +
  geom_point(size = 2) +
  scale_colour_otherworlds("Species", palette = "nebula")
```

The palettes are intended for qualitative data. For accessibility, do not rely
on colour alone when many groups are present: add direct labels, shapes, line
types, or facets. The 8-colour `nebula` palette is the preferred default for
figures that must remain easy to distinguish in print.
