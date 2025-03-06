#!/bin/bash

num=3652
stat="P"
repo_state=

if [ -n "$(git status --untracked-files=no --porcelain)" ]; then
    repo_state="(dirty)"
    stat="D"
fi

revision=$(git tag --points-at HEAD | grep '^rev' | cut -b4-)
if [ -z "$revision" ]; then
    stat="D"
    revision=$(git tag --points-at HEAD | grep '^drev' | cut -b5-)
    if [ -z "$revision" ]; then
        revision="commit_$(git rev-parse --short HEAD)"
    fi
fi
revision="${revision}${repo_state}"
shortname="${stat}${num}"

echo "generate ${stat}${num}R${revision}"

bikeshed --md-status="${stat}" --md-shortname="${shortname}" --md-revision="${revision}" spec
