#!/bin/bash

# Check if anything is already stage, if yes we cannot ammend
if ! git diff --cached --quiet; then
    echo "Staged changes detected. Won't amend commit."
    exit 1
fi

existing_msg=$(git log -1 --pretty=%B)

cleaned_msg=$(printf '%s\n' "$existing_msg" | sed '/^[Cc]o-[Aa]uthored-[Bb]y:/d')

if [ "$existing_msg" = "$cleaned_msg" ]; then
    echo "No co-authors found in the latest commit."
    exit 0
fi

git commit --amend -m "$cleaned_msg"