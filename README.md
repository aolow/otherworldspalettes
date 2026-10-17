# otherworldspalettes

`otherworldspalettes` provides qualitative and continuous colour palettes
derived from the *Other Worlds* art project. Discrete colours are deliberately
ordered so neighbouring series jump across hue and lightness; continuous maps
move smoothly through deep-space shadows into luminous atmospheric colour.

## From the artwork to the palettes

*Other Worlds* grew out of my original paintings and drawings of imagined
landscapes, strange skies, and cosmic light. Those images also inspired
[*Other Worlds*, my coloring and creative activity book](https://www.olaolowart.com/other-worlds),
which invites readers to explore color, texture, light, and atmosphere in
their own way.

I work in both art and science, and this R package brings those two interests
together. The palettes translate the mood and color relationships of the
artwork into a practical vocabulary for scientific graphics. They are
artist-directed adaptations for visualization, not exact reproductions of
individual book pages or a claim of universal perceptual uniformity.

## Palettes

![All three Other Worlds palettes](man/figures/all-palettes.png)

The package contains three **nested sizes of one palette system**, rather than
three unrelated colour schemes:

- `nebula` contains 8 colours and is the recommended default for most figures.
- `stellar` contains the same 8 colours plus 4 additional colours, for 12 total.
- `cosmic` contains all `stellar` colours plus 8 additional colours, for 20 total.

Because the palettes are nested, you can expand from `nebula` to `stellar`
or `cosmic` without changing the existing palette entries. Within each
palette, the order jumps across hue and lightness to keep neighbouring groups
visually distinct.

For consistent group-to-color assignments across figures, also keep the
category or factor level order fixed in your plotting code. The package's
accessors and ggplot2 scales default to `cosmic`; explicitly select
`palette = "nebula"` for the recommended eight-color starting point.

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

## Continuous palettes

![Six sequential Other Worlds palettes](man/figures/continuous-palettes.png)

The package also includes six continuous, dark-to-light palettes. The first
four explore a focused hue family; the final two move across hues in the spirit
of perceptually smooth scientific colour maps.

- `emerald_void` — mineral greens and luminous emerald.
- `blue_hour` — midnight indigo through atmospheric cyan.
- `red_giant` — oxblood, nebula red, and warm stellar light.
- `magenta_orbit` — deep violet through ion pink.
- `tidal_emerald` — blue-black through tidal blue and emerald to alien light.
- `supernova` — shock blue through dusty violet, nebula coral, and ejecta gold
  to an icy ionized core.

Three additional palettes are designed for heatmaps and centered data. Each
passes through a bright middle colour drawn from the paintings rather than a
generic white midpoint.

![Three painting-derived heatmap palettes](man/figures/three-colour-heatmaps.png)

- `solar_tide` — deep blue through sun yellow to nebula red.
- `alien_bloom` — emerald through warm cream to orbit magenta.
- `cosmic_shore` — royal purple through atmospheric cyan to vermilion.

For dense heatmaps, three higher-contrast options use darker poles, luminous
centers, and more saturated transitions:

- `signal_fire` — deep space and electric blue through solar yellow to flare
  orange and dark red.
- `ultraviolet` — violet-black and electric violet through ion cyan to hot
  magenta and deep wine.
- `alien_heat` — forest void and emerald through acid yellow to orbit magenta
  and deep plum.

![High-contrast heatmap palettes](man/figures/high-contrast-heatmaps.png)

For centered, signed data (such as changes relative to a baseline), set
symmetric color limits around zero if zero should align with the middle
color. These artist-inspired gradients have not been established as
perceptually uniform or color-vision-deficiency-safe; for quantitative
interpretation, check the rendered figure and consider labels or a
validated scientific colormap as a comparison.

See `vignette("heatmaps", package = "otherworldspalettes")` for side-by-side
examples and guidance on choosing a palette.

```r
otherworlds_continuous_palettes()
cols <- otherworlds_continuous_palette(100, "tidal_emerald")

ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
  geom_raster() +
  scale_fill_otherworlds_c(palette = "supernova")

# Three-colour heatmap
heatmap(volcano, col = otherworlds_continuous_palette(101, "solar_tide"))
```
