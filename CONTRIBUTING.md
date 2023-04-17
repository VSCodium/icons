Contributing
============

Dependencies
------------

- bash
- icns2png
- imagemagick
- png2icns
- icotool
- librsvg
- bc
- pastel

Shapes Templates
--------------

The templates for the shape can be found at [`./templates/shapes/`](./templates/shapes/).

The template is composed of:
- `main.conf`: the configuration variables
- `main.svg`: the icon in SVG format

### `main.conf`

The variables are:

- `SHAPE_SHIFT_LEFT`: value used to shift the icon to the left; if empty, no shift occurs

### `main.svg`

The SVG must use the following variables as its colors:

- `@@PRIMARY@@`
- `@@MEDIAN1@@`
- `@@MEDIAN2@@`
- `@@FLOOR@@`

Background Templates
--------------------

The templates for the background can be found at [`./templates/backgrounds/`](./templates/backgrounds/).

The template is composed of:
- `main.conf`: the configuration variables
- `main.(png|svg)`: the background

### `main.conf`

All sizes and positions are in `px` with a target size of `2048x2048`.

- `BG_FILENAME`: the file to use as background
- `BG_COLOR_SET`: `normal` or `light` (`light` = `lighten 0.05`)
- `BG_SHAPE_SIZE`: the size of the shape
- `BG_SHAPE_TOP`: the top position of the shape; if empty, the shape is centered
- `BG_SHAPE_LEFT`: the left position of the shape; if empty, the shape is centered
- `BG_SHAPE_SHIFT`: `on` or `off`; if `on`,  the shape is shifted by the values defined in the icon template
- `BG_LINUX_SIZE`: the size of the background for Linux
- `BG_LINUX_TOP`: the top position of the background for Linux; if empty, the shape is centered

Color Templates
---------------

The templates for the color scheme can be found at [`./templates/colors/`](./templates/colors/).

The template is composed of only 1 file:

### `normal.conf`

```bash
COLOR_PRIMARY="#62A0EA"
COLOR_MEDIAN1="#3584E4"
COLOR_MEDIAN2="#1C71D8"
COLOR_FLOOR="#1A5FB4"
```

Currently, the color `COLOR_MEDIAN1` is the color `COLOR_PRIMARY` but darkened 2 times (`pastel darken 0.1 $COLOR_PRIMARY`)
