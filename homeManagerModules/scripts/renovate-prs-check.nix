{
  pkgs,
  lib,
  ...
}:

pkgs.writeShellApplication {
  name = "renovate-prs-check";
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
    # Purpose: Checks specific GitHub repos for open Renovate PRs missing a specific label,
    #          and reports their CI pipeline status.
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
      # Added 'statusCheckRollup' to fetch the CI pipeline states.
      PRS_JSON=$(${lib.getExe pkgs.gh} pr list \
        --repo "$REPO" \
        --state open \
        --author "$BOT_AUTHOR" \
        --json number,title,url,labels,statusCheckRollup 2>/dev/null)

      # Check if the command was successful (e.g., repo exists)
      if [ $? -ne 0 ]; then
        echo "⚠️  Could not access repository $REPO. Please check the name and permissions."
        continue
      fi

      # Use jq to filter the JSON and evaluate the CI status.
      # Logic: 
      # 1. Define 'get_status' to parse the statusCheckRollup array into a single PASS/FAIL/PENDING state.
      # 2. Select items where the list of label names does NOT contain the REQUIRED_LABEL
      # 3. Format the output to include the new CI status.
      NON_COMPLIANT=$(echo "$PRS_JSON" | ${lib.getExe pkgs.jq} -r --arg LABEL "$REQUIRED_LABEL" '
        def get_status:
          if .statusCheckRollup == null or (.statusCheckRollup | length) == 0 then
            "⚪ No checks found"
          else
            [ .statusCheckRollup[] |
              if .state == "FAILURE" or .state == "ERROR" or .conclusion == "FAILURE" or .conclusion == "ACTION_REQUIRED" or .conclusion == "TIMED_OUT" then
                "FAIL"
              elif .state == "PENDING" or .state == "EXPECTED" or .status == "IN_PROGRESS" or .status == "QUEUED" then
                "PEND"
              else
                "PASS"
              end
            ] |
            if contains(["FAIL"]) then "❌ Failed"
            elif contains(["PEND"]) then "⏳ Pending / Running"
            else "✅ Passed"
            end
          end;

        .[] 
        | select(.labels | map(.name) | index($LABEL) | not) 
        | "   🚨 [\(.number)] \(.title)\n      🔗 \(.url)\n      ⚙️ CI Status: \(get_status)\n"
      ')

      if [ -z "$NON_COMPLIANT" ]; then
        echo "   ✅ All Renovate PRs comply (or none found)."
      else
        echo "$NON_COMPLIANT"
      fi
    done

    echo ""
    echo "Done."
  '';
}
