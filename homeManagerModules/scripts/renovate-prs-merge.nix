{
  pkgs,
  lib,
  ...
}:

pkgs.writeShellApplication {
  name = "renovate-prs-merge";
  runtimeInputs = with pkgs; [
    github-cli
    jq
    coreutils # Includes things like date
  ];
  excludeShellChecks = [
    "SC2086"
  ];
  text = ''
    # ==============================================================================
    # Purpose: Finds open PRs created by Renovate, ensures they are up-to-date 
    #          with the base branch, and merges them if pipelines are successful.
    # ==============================================================================

    # Optional: Set repo if passed as an argument (e.g., ./merge_renovate.sh owner/repo)
    REPO_ARG=""
    if [ -n "$1" ]; then
        REPO_ARG="--repo $1"
    fi

    echo "Starting continuous merge process..."

    while true; do
        echo "------------------------------------------------------------"
        echo "Fetching open Renovate PRs..."

        # Use GitHub CLI to search for open PRs by Renovate bots
        # We request specific JSON fields to evaluate the merge state and CI pipeline status
        PRS_JSON=$(${lib.getExe pkgs.github-cli} pr list $REPO_ARG \
            --search "is:pr is:open author:app/renovate author:renovate[bot]" \
            --json number,title,mergeStateStatus,statusCheckRollup)

        # Exit gracefully if no PRs are found
        if [ "$PRS_JSON" == "[]" ]; then
            echo "No open Renovate PRs found. All done!"
            exit 0
        fi

        # Track if there is still ongoing work (updates, pending CI) to know if we should sleep or exit
        WORK_PENDING=false

        # Iterate over the JSON array of PRs using process substitution to keep variable scope
        while read -r pr; do
            PR_NUMBER=$(echo "$pr" | ${lib.getExe pkgs.jq} -r '.number')
            PR_TITLE=$(echo "$pr" | ${lib.getExe pkgs.jq} -r '.title')
            
            # mergeStateStatus tells us if it's CLEAN, BEHIND, DIRTY (conflicts), etc.
            MERGE_STATUS=$(echo "$pr" | ${lib.getExe pkgs.jq} -r '.mergeStateStatus')
            
            # statusCheckRollup tells us the overall CI/CD pipeline state (SUCCESS, PENDING, FAILURE)
            CHECKS_STATE=$(echo "$pr" | ${lib.getExe pkgs.jq} -r '
              if .statusCheckRollup == null or (.statusCheckRollup | length) == 0 then
                "NO_PIPELINE"
              elif .statusCheckRollup | type == "object" then
                .statusCheckRollup.state // "UNKNOWN"
              elif .statusCheckRollup | type == "array" then
                .statusCheckRollup | map(
                  if .state != null and .state != "" then .state
                  elif .status == "IN_PROGRESS" or .status == "QUEUED" or .status == "PENDING" then "PENDING"
                  elif .conclusion != null and .conclusion != "" then .conclusion
                  else "UNKNOWN" end
                ) | 
                if any(. == "FAILURE" or . == "ERROR" or . == "ACTION_REQUIRED" or . == "CANCELLED" or . == "TIMED_OUT" or . == "STARTUP_FAILURE") then
                  "FAILURE"
                elif any(. == "PENDING" or . == "EXPECTED") then
                  "PENDING"
                else
                  "SUCCESS"
                end
              else
                "UNKNOWN"
              end
            ')

            echo "  -> Evaluating PR #$PR_NUMBER: $PR_TITLE"
            echo "     Merge Status: $MERGE_STATUS | Pipeline State: $CHECKS_STATE"

            # REQUIREMENT 1: Never be behind when merged
            if [ "$MERGE_STATUS" == "BEHIND" ]; then
                echo "     [ACTION] PR is behind the base branch. Triggering branch update..."
                ${lib.getExe pkgs.github-cli} pr update "$PR_NUMBER" $REPO_ARG || echo "     [NOTE] Update already in progress."
                echo "     [NOTE] Update triggered. CI will re-run. Skipping merge for now."
                WORK_PENDING=true
                continue
            fi

            # REQUIREMENT 2: Merge only if pipelines are OK and branch is up-to-date
            if [ "$CHECKS_STATE" == "SUCCESS" ] && [ "$MERGE_STATUS" == "CLEAN" ]; then
                echo "     [ACTION] PR is fully up-to-date and pipelines passed. Merging..."
                
                # Merge the PR (squash merge) and delete the remote branch to keep things clean
                ${lib.getExe pkgs.github-cli} pr merge "$PR_NUMBER" $REPO_ARG --squash --delete-branch
                
                echo "     [SUCCESS] Merged PR #$PR_NUMBER"
                
                WORK_PENDING=true
            elif [ "$MERGE_STATUS" == "DIRTY" ]; then
                echo "     [WARNING] PR has merge conflicts. Needs manual resolution."
            elif [ "$CHECKS_STATE" == "FAILURE" ] || [ "$CHECKS_STATE" == "ERROR" ]; then
                echo "     [WARNING] CI Pipelines failed. Skipping."
            else
                echo "     [NOTE] PR is not ready to merge yet (Tests might be running or state unknown)."
                WORK_PENDING=true
            fi
        done < <(echo "$PRS_JSON" | ${lib.getExe pkgs.jq} -c '.[]')

        if [ "$WORK_PENDING" = false ]; then
            echo "------------------------------------------------------------"
            echo "No more automated work can be done. Remaining PRs likely need manual intervention."
            break
        fi

        echo "------------------------------------------------------------"
        echo "Waiting 60 seconds for pipelines/updates to complete before checking again..."
        sleep 60
    done

    echo "Done."
  '';
}
