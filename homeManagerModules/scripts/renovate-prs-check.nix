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
    coreutils # Includes things like date
  ];
  excludeShellChecks = [
    "SC2181"
    "SC2054"
  ];
  text =
    let
      dateExe = lib.getExe' pkgs.coreutils "date";
    in
    ''
      show_help() {
        echo "Usage: renovate-prs-check [OPTIONS] [REPO...]"
        echo ""
        echo "Checks specified GitHub repos for open Renovate PRs missing the 'Update Blocked' label,"
        echo "and reports their CI pipeline status."
        echo ""
        echo "Options:"
        echo "  --all         Show all open Renovate PRs (Default)"
        echo "  --this-week   Show PRs opened since the most recent Saturday"
        echo "  --last-week   Show PRs opened from the previous Saturday up to Friday"
        echo "  -h, --help    Show this help message and exit"
        echo ""
        echo "Example:"
        echo "  renovate-prs-check --this-week puzzle/okr puzzle/pcts"
      }

      # ==============================================================================
      # 1. Argument Parsing
      # ==============================================================================
      MODE="--all"
      REPOS=()

      while [[ $# -gt 0 ]]; do
        case "$1" in
          -h|--help)
            show_help
            exit 0
            ;;
          --all|--last-week|--this-week)
            MODE="$1"
            shift
            ;;
          *)
            REPOS+=("$1")
            shift
            ;;
        esac
      done

      # Calculate current day of the week (1=Monday ... 7=Sunday)
      DOW=$(${dateExe} +%u)

      CREATED_QUERY=""
      case "$MODE" in
        --last-week)
          # From last week's Monday to last week's Sunday
          START=$(${dateExe} -d "-$(( DOW + 8 )) days" +%Y-%m-%d)
          END=$(${dateExe} -d "-$DOW days" +%Y-%m-%d)
          CREATED_QUERY="created:$START..$END"
          ;;
        --this-week)
          # From this week's Monday to today
          START=$(${dateExe} -d "-$(( DOW - 1 )) days" +%Y-%m-%d)
          CREATED_QUERY="created:>=$START"
          ;;
      esac

      # ==============================================================================
      # 2. Configuration
      # ==============================================================================
      REQUIRED_LABEL="Update Blocked"
      BOT_AUTHOR="app/renovate"

      echo "🔍 Checking for open PRs ($MODE) by '$BOT_AUTHOR' missing the label '$REQUIRED_LABEL'..."

      # If no repos passed, warn user
      if [ ''${#REPOS[@]} -eq 0 ]; then
        echo "⚠️  No repositories provided. Usage: renovate-prs-check [--all|--last-week|--this-week] repo1 repo2..."
        exit 1
      fi

      # ==============================================================================
      # 3. Main Logic
      # ==============================================================================
      for REPO in "''${REPOS[@]}"; do
        echo ""
        echo "---------------------------------------------------"
        echo "📂 Repository: $REPO"

        # Build the argument array for gh pr list
        GH_ARGS=(
          --repo "$REPO"
          --state open
          --author "$BOT_AUTHOR"
          --json number,title,url,labels,statusCheckRollup,createdAt
        )

        # Only append the --search flag if we actually have a date filter
        if [ -n "$CREATED_QUERY" ]; then
          GH_ARGS+=( --search "$CREATED_QUERY" )
        fi

        # Execute gh with the dynamic arguments
        PRS_JSON=$(${lib.getExe pkgs.gh} pr list "''${GH_ARGS[@]}" 2>/dev/null)

        if [ $? -ne 0 ]; then
          echo "⚠️  Could not access repository $REPO."
          continue
        fi

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
          | "   🚨 [\(.number)] \(.title)\n      🔗 \(.url)\n      📅 Opened: \(.createdAt | split("T")[0])\n      ⚙️ CI Status: \(get_status)\n"
        ')

        if [ -z "$NON_COMPLIANT" ]; then
          echo "   ✅ All Renovate PRs comply (or none found)."
        else
          echo "$NON_COMPLIANT"
        fi
      done
    '';
}
