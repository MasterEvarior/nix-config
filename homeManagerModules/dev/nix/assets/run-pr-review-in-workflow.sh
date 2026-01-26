gh search prs --state=open --review-requested=@me --repo NixOS/nixpkgs \
  --json title,number \
  --jq '.[] | "\(.number)\t\(.title)"' | \
while IFS=$'\t' read -r number title; do
  echo "------------------------------------------------"
  echo "Found PR #$number: $title"
  
  read -r -p "Run review workflow for this PR? [y/N] " run_answer < /dev/tty
  if [[ ! "$run_answer" =~ ^[Yy]$ ]]; then
    echo "Skipping..."
    continue
  fi

  read -r -p "  > Should I APPROVE if the review succeeds? [y/N] " approve_answer < /dev/tty
  if [[ "$approve_answer" =~ ^[Yy]$ ]]; then
    success_action="approve"
  else
    success_action="nothing"
  fi

  read -r -p "  > Post the result comment on the PR? [Y/n] " post_answer < /dev/tty
  if [[ "$post_answer" =~ ^[Nn]$ ]]; then
    post_bool=false
  else
    post_bool=true
  fi

  echo "Dispatching workflow..."

  gh workflow run review.yml \
    --repo MasterEvarior/nixpkgs-review-gha \
    -f pr="$number" \
    -f on-success="$success_action" \
    -F post-result=$post_bool
done