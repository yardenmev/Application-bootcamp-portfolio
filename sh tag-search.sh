#!/bin/bash

# str=$(git tag -l v*)
# echo $str | tail -n2
git fetch --tags
str=$(git tag -l v* | tail -1)
# echo $str
major=$(echo $str | tr -d "v" | sed 's/\..*//')
minor=$(echo $str | tr -d "v" | sed 's/.*\.//')
# echo $major
# echo $minor
new_major=$((major+1))
new_minor=$((minor+1))
new_tag=v$major.$new_minor
echo $new_tag
# export NEW_TAG=$new_tag