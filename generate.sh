#!/bin/bash

num=xxxx
stat="P"
repo_state=

if [ -n "$(git status --untracked-files=no --porcelain)" ]; then
    repo_state="(dirty)"
    stat="D"
fi

revision=$(git tag --points-at HEAD | grep '^rev' | cut -b4-)
if [ -z "$revision" ]; then
    revision="commit_$(git rev-parse --short HEAD)"
    stat="D"
fi
revision="${revision}${repo_state}"
shortname="${stat}${num}"

echo "generate ${stat}${num}R${revision}"

bikeshed --md-status="${stat}" --md-shortname="${shortname}" --md-revision="${revision}" spec
