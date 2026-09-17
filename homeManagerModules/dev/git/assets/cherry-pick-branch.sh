echo "=================================================================="
echo "          Bulk Cherry-Pick from Branch"
echo "=================================================================="
echo "What this does:"
echo "This script copies all the unique commits from a branch you specify"
echo "and applies them to your CURRENT branch."
echo "=================================================================="
echo ""

# Ask for the branch name
read -p "Please enter the branch name: " BRANCH

# Check if the user actually typed something
if [ -z "$BRANCH" ]; then
    echo "Error: You didn't enter a branch name. Exiting."
    exit 1
fi

echo ""
echo "Running: git cherry-pick \$(git merge-base main $BRANCH)..$BRANCH"
echo "..."

# Execute the command
git cherry-pick $(git merge-base main "$BRANCH").."$BRANCH"

# Check if the cherry-pick was successful
if [ $? -eq 0 ]; then
    echo "✅ Successfully cherry-picked commits from $BRANCH!"
else
    echo "❌ Cherry-pick failed or encountered conflicts. Please resolve them."
fi