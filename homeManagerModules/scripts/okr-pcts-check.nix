{
  pkgs,
  lib,
  ...
}:

pkgs.writeShellApplication {
  name = "okr-pcts-check";
  runtimeInputs = with pkgs; [
    github-cli
    jq
  ];
  excludeShellChecks = [
    "SC2181"
  ];
  text = ''
    # ==============================================================================
    # Script Name: check_renovate.sh
    # Purpose: Checks specific GitHub repos for open Renovate PRs missing a specific label.
    # ==============================================================================

    # 1. Configuration
    # ----------------
    # The specific label you are looking for
    REQUIRED_LABEL="Update Blocked"

    # The author name for the Renovate bot.
    # Standard App is "app/renovate". If you use the legacy bot, use "renovate[bot]"
    BOT_AUTHOR="app/renovate"

    # 3. Main Logic
    # -------------
    echo "🔍 Checking for open PRs by '$BOT_AUTHOR' missing the label '$REQUIRED_LABEL'..."

    for REPO in "$@"; do
      echo ""
      echo "---------------------------------------------------"
      echo "📂 Repository: $REPO"

      # We use 'gh pr list' to get the data in JSON format for easy parsing.
      # We fetch number, title, url, and labels.
      # We filter by state=open and the specific bot author.
      PRS_JSON=$(${lib.getExe pkgs.gh} pr list \
        --repo "$REPO" \
        --state open \
        --author "$BOT_AUTHOR" \
        --json number,title,url,labels 2>/dev/null)

      # Check if the command was successful (e.g., repo exists)
      if [ $? -ne 0 ]; then
        echo "⚠️  Could not access repository $REPO. Please check the name and permissions."
        continue
      fi

      # Use jq to filter the JSON.
      # Logic: Select items where the list of label names does NOT contain the REQUIRED_LABEL
      NON_COMPLIANT=$(echo "$PRS_JSON" | ${lib.getExe pkgs.jq} -r --arg LABEL "$REQUIRED_LABEL" \
        '.[] | select(.labels | map(.name) | index($LABEL) | not) | "   ❌ [\(.number)] \(.title)\n      \(.url)"')

      if [ -z "$NON_COMPLIANT" ]; then
        echo "   ✅ All Renovate PRs comply (or none found)."
      else
        echo "   ⚠️ Found non-compliant PRs:"
        echo "$NON_COMPLIANT"
      fi
    done

    echo ""
    echo "Done."
  '';
}
