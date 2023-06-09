#!/usr/bin/env bash

set -e

# include common functions
. ./utils.sh

# DEBUG
# set -o xtrace

check_programs "icns2png" "composite" "convert" "png2icns" "icotool" "rsvg-convert" "bc" "pastel"

build_icon() { # {{{
  echo "- ${SHAPE_NAME}/${BG_NAME}/${COLOR_NAME}: ${COLOR_SET}"

  if [ "${COLOR_SET}" == "light" ]; then
      source "${COLOR_PATH}/normal.conf"

      COLOR_PRIMARY_400=$( pastel lighten 0.05 "${COLOR_PRIMARY_400}" )
      COLOR_PRIMARY_500=$( pastel lighten 0.05 "${COLOR_PRIMARY_500}" )
      COLOR_PRIMARY_700=$( pastel lighten 0.05 "${COLOR_PRIMARY_700}" )
      COLOR_PRIMARY_900=$( pastel lighten 0.05 "${COLOR_PRIMARY_900}" )
      COLOR_PRIMARY_950=$( pastel lighten 0.05 "${COLOR_PRIMARY_950}" )
    else
      source "${COLOR_PATH}/${COLOR_SET}.conf"
    fi

  # echo "COLOR_PRIMARY_400: ${COLOR_PRIMARY_400}"
  # echo "COLOR_PRIMARY_500: ${COLOR_PRIMARY_500}"
  # echo "COLOR_PRIMARY_700: ${COLOR_PRIMARY_700}"
  # echo "COLOR_PRIMARY_900: ${COLOR_PRIMARY_900}"
  # echo "COLOR_PRIMARY_950: ${COLOR_PRIMARY_950}"

  convert -size 2048x2048 canvas:transparent PNG32:"icon.png"

  if [ ! -z "${BG_FILENAME}" ]; then
    BG_KIND="${BG_FILENAME##*.}"

    if [ "${BG_KIND}" == "png" ]; then
      convert "${BG_PATH}/${BG_FILENAME}" -resize 2048x2048 "icon_bg.png"
    elif [ "${BG_KIND}" == "svg" ]; then
      rsvg-convert -w 2048 -h 2048 "${BG_PATH}/${BG_FILENAME}" -o "icon_bg.png"
    fi

    composite "icon_bg.png" -gravity center -background none -colorspace sRGB "icon.png" "icon.png"
  fi

  cp "${SHAPE_PATH}/main.svg" "icon_head.svg"

  replace "s|@@PRIMARY_400@@|${COLOR_PRIMARY_400}|g" "icon_head.svg"
  replace "s|@@PRIMARY_500@@|${COLOR_PRIMARY_500}|g" "icon_head.svg"
  replace "s|@@PRIMARY_700@@|${COLOR_PRIMARY_700}|g" "icon_head.svg"
  replace "s|@@PRIMARY_900@@|${COLOR_PRIMARY_900}|g" "icon_head.svg"
  replace "s|@@PRIMARY_950@@|${COLOR_PRIMARY_950}|g" "icon_head.svg"

  rsvg-convert -w "${BG_SHAPE_SIZE}" -h "${BG_SHAPE_SIZE}" "icon_head.svg" -o "icon_head.png"

  # echo "${BG_SHAPE_TOP};${BG_SHAPE_SHIFT};${SHAPE_SHIFT_LEFT}"

  if [ ! -z "${BG_SHAPE_TOP}" ]; then
    if [ "${BG_SHAPE_SHIFT}" == "on" ] && [ ! -z "${SHAPE_SHIFT_LEFT}" ]; then
      LEFT="$( bc <<< "${SHAPE_SHIFT_LEFT} + ${BG_SHAPE_LEFT}" )"

      # echo "${LEFT}"

      composite "icon_head.png" -geometry "+${LEFT}+${BG_SHAPE_TOP}" -background none -colorspace sRGB "icon.png" "icon.png"
    else
      composite "icon_head.png" -geometry "+${BG_SHAPE_LEFT}+${BG_SHAPE_TOP}" -background none -colorspace sRGB "icon.png" "icon.png"
    fi
  else
    composite "icon_head.png" -gravity center -background none -colorspace sRGB "icon.png" "icon.png"
  fi

  BUILT="yes"
} # }}}

build_darwin() { # {{{
  if [ ! -f "./icons/darwin/${BG_NAME}/${COLOR_NAME}/${SHAPE_NAME}.icns" ]; then
    if [ "${BUILT}" == "no" ]; then
      build_icon
    fi

    mkdir -p "./icons/darwin/${BG_NAME}/${COLOR_NAME}/"

    composite \( "icon.png" -resize 884x884 \) -gravity center -background none \( -size 1024x1024 canvas:transparent \) "icon_1024.png"

    convert "icon_1024.png" -resize 512x512 icon_512.png
    convert "icon_1024.png" -resize 256x256 icon_256.png
    convert "icon_1024.png" -resize 128x128 icon_128.png

    png2icns "./icons/darwin/${BG_NAME}/${COLOR_NAME}/${SHAPE_NAME}.icns" icon_512.png icon_256.png icon_128.png > /dev/null
  fi
} # }}}

build_linux() { # {{{
  if [ ! -f "./icons/linux/${BG_NAME}/${COLOR_NAME}/${SHAPE_NAME}.png" ]; then
    if [ "${BUILT}" == "no" ]; then
      build_icon
    fi

    mkdir -p "./icons/linux/${BG_NAME}/${COLOR_NAME}/"

    if [ -z "${BG_LINUX_SIZE}" ]; then
      BG_LINUX_SIZE="952"
    fi

    if [ -z "${BG_LINUX_TOP}" ]; then
      composite \( "icon.png" -resize "${BG_LINUX_SIZE}x${BG_LINUX_SIZE}" \) -gravity center -background none \( -size 1024x1024 canvas:transparent \) "./icons/linux/${BG_NAME}/${COLOR_NAME}/${SHAPE_NAME}.png"
    else
      LEFT="$( bc <<< "(1024 - ${BG_LINUX_SIZE}) / 2" )"
      TOP="$( bc <<< "${LEFT} + ${BG_LINUX_TOP}" )"

      # echo "+${LEFT}+${TOP}"

      composite \( "icon.png" -resize "${BG_LINUX_SIZE}x${BG_LINUX_SIZE}" \) -geometry "+${LEFT}+${TOP}" -background none \( -size 1024x1024 canvas:transparent \) "./icons/linux/${BG_NAME}/${COLOR_NAME}/${SHAPE_NAME}.png"
    fi
  fi
} # }}}

build_win32() { # {{{
  if [ ! -f "./icons/win32/${BG_NAME}/${COLOR_NAME}/${SHAPE_NAME}.ico" ]; then
    if [ "${BUILT}" == "no" ]; then
      build_icon
    fi

    mkdir -p "./icons/win32/${BG_NAME}/${COLOR_NAME}/"

    convert "icon.png" -define icon:auto-resize=256,128,96,64,48,32,24,20,16 "./icons/win32/${BG_NAME}/${COLOR_NAME}/${SHAPE_NAME}.ico"
  fi
} # }}}

for SHAPE_PATH in "./templates/shapes/"*
do
  SHAPE_NAME="${SHAPE_PATH/*\//}"
  SHAPE_NAME="${SHAPE_NAME%.*}"

  SHAPE_SHIFT_LEFT=""
  SHAPE_COLOR_SET=""
  SHAPE_LIMIT_BG=""
  SHAPE_LIMIT_COLOR=""

  source "${SHAPE_PATH}/main.conf"

  # if [ "${SHAPE_NAME}" == "cristiano20" ]; then
    for BG_PATH in "./templates/backgrounds/"*
    do
      BG_NAME="${BG_PATH/*\//}"
      BG_NAME="${BG_NAME%.*}"

      source "${BG_PATH}/main.conf"

      if [ ! -z "${SHAPE_COLOR_SET}" ]; then
        COLOR_SET="${SHAPE_COLOR_SET}"
      else
        COLOR_SET="${BG_COLOR_SET}"
      fi

      # if [ "${BG_NAME}" == "nobg" ]; then
        for COLOR_PATH in "./templates/colors/"*
        do
          COLOR_NAME="${COLOR_PATH/*\//}"
          COLOR_NAME="${COLOR_NAME%.*}"

          if [ ! -z "${SHAPE_LIMIT_BG}" ] || [ ! -z "${SHAPE_LIMIT_COLOR}" ]; then
            LIMITED="no"

            if [ ! -z "${SHAPE_LIMIT_BG}" ]; then
              for LIMIT_BG in "${SHAPE_LIMIT_BG[@]}";
              do
                if [ "${BG_NAME}" != "${LIMIT_BG}" ]; then
                  LIMITED="yes"
                fi
              done
            fi

            if [ ! -z "${SHAPE_LIMIT_COLOR}" ]; then
              for LIMIT_COLOR in "${SHAPE_LIMIT_COLOR[@]}";
              do
                if [ "${COLOR_NAME}" != "${LIMIT_COLOR}" ]; then
                  LIMITED="yes"
                fi
              done
            fi

            if [ "${LIMITED}" == "no" ]; then
              BUILT="no"

              build_darwin
              build_linux
              build_win32
            fi
          else
            BUILT="no"

            build_darwin
            build_linux
            build_win32
          fi
        done
      # fi
    done
  # fi
done

rm -f icon.png icon_bg.png icon_head.svg icon_head.png icon_1024.png icon_512.png icon_256.png icon_128.png
