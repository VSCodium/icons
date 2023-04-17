#!/usr/bin/env bash

# {{{ shapes
echo "[]" > "./previewer/config/shapes.json"

for MY_PATH in "./templates/shapes/"*
do
  MY_NAME="${MY_PATH/*\//}"
  MY_NAME="${MY_NAME%.*}"

  echo "$( cat "./previewer/config/shapes.json" | jq --arg name "${MY_NAME}" '. += [{
    "value": $name,
    "label": $name,
  }]' )" > "./previewer/config/shapes.json"
done
# }}}

# {{{ backgrounds
echo "[]" > "./previewer/config/backgrounds.json"

for MY_PATH in "./templates/backgrounds/"*
do
  MY_NAME="${MY_PATH/*\//}"
  MY_NAME="${MY_NAME%.*}"

  echo "$( cat "./previewer/config/backgrounds.json" | jq --arg name "${MY_NAME}" '. += [{
    "value": $name,
    "label": $name,
  }]' )" > "./previewer/config/backgrounds.json"
done
# }}}

# {{{ shapes
echo "[]" > "./previewer/config/colors.json"

for MY_PATH in "./templates/colors/"*
do
  MY_NAME="${MY_PATH/*\//}"
  MY_NAME="${MY_NAME%.*}"

  echo "$( cat "./previewer/config/colors.json" | jq --arg name "${MY_NAME}" '. += [{
    "value": $name,
    "label": $name,
  }]' )" > "./previewer/config/colors.json"
done
# }}}
