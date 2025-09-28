"""
A script to interactively guide the user through creating a
conventional commit message using keyboard navigation.

This script requires the 'questionary' library.
Install it using: pip install questionary
"""

import questionary as q
import sys
import subprocess


def get_commit_type():
    """
    Prompts the user to select a commit type using keyboard navigation.
    """
    commit_type = q.select(
        "Select the type of change you're committing:",
        choices=[
            "feat:     A new feature",
            "fix:      A bug fix",
            "docs:     Documentation only changes",
            "style:    Changes that do not affect the meaning of the code",
            "refactor: A change that neither fixes a bug or adds a feature",
            "perf:     A change that improves performance",
            "test:     Adding missing tests or correcting existing tests",
            "build:    Changes that affect the build system or dependencies",
            "ci:       Changes to our CI configuration files and scripts",
            "chore:    Other changes that don't modify src or test files",
            "revert:   Reverts a previous commit",
        ],
        use_indicator=True,
    ).ask()

    if commit_type is None:
        sys.exit(0)  # User pressed Ctrl+C

    return commit_type.split(":")[0].strip()


def get_scope():
    """
    Prompts the user to select or enter a scope.
    """
    scope = q.select(
        "What is the scope of this change?",
        choices=[
            "[ none ]",
            "[ custom ]",
            "api",
            "ui",
            "db",
            "auth",
            "config",
            "hooks",
        ],
        use_indicator=True,
    ).ask()

    if scope is None:
        sys.exit(0)

    if scope == "[ none ]":
        return ""
    elif scope == "[ custom ]":
        custom_scope = q.text("Enter custom scope:").ask()
        if custom_scope is None:
            sys.exit(0)
        return custom_scope.strip()
    return scope


def is_breaking_change():
    """Asks the user if this is a breaking change."""
    is_breaking = q.confirm("Is this a BREAKING CHANGE?", default=False).ask()
    if is_breaking is None:
        sys.exit(0)
    return is_breaking


def get_description():
    """
    Prompts the user for a short description.
    """
    description = q.text(
        "Write a short, description of the change:",
        validate=lambda text: True if len(text) > 0 else "Cannot be empty.",
    ).ask()

    if description is None:
        sys.exit(0)
    return description.strip()


def get_ticket_number():
    """
    Prompts the user for an optional ticket number.
    """
    ticket_number = q.text(
        "Enter ticket/issue number (optional, just the number):",
        validate=lambda text: text.isdigit() or text == "",
        qmark="[?]",
    ).ask()

    if ticket_number is None:
        sys.exit(0)
    return ticket_number.strip()


def main():
    """
    Main function to orchestrate the commit message creation.
    """
    try:
        commit_type = get_commit_type()
        scope = get_scope()
        is_breaking = is_breaking_change()
        description = get_description()
        ticket_number = get_ticket_number()

        commit_message = f"{commit_type}"
        if scope:
            commit_message += f"({scope})"
        if is_breaking:
            commit_message += "!"
        commit_message += f": {description}"

        if ticket_number:
            commit_message += f" #{ticket_number}"

        print("\n" + "=" * 50)
        print("      Your Conventional Commit Message")
        print("=" * 50)
        print(commit_message)
        print("=" * 50)

        create_commit = q.confirm(
            "Do you want to create this commit now?", default=True
        ).ask()

        if create_commit:
            try:
                # Use subprocess to run the git commit command
                result = subprocess.run(
                    ["git", "commit", "-m", commit_message],
                    check=True,
                    capture_output=True,
                    text=True,
                )
                print("\n✅ Commit created successfully!")
                print("\n--- Git Output ---")
                print(result.stdout)
            except subprocess.CalledProcessError as e:
                print("\n❌ Error: 'git commit' failed.")
                print("\n--- Git Error ---")
                print(e.stderr)
        else:
            print("\nCommit not created. Copy the message above manually.")

    except KeyboardInterrupt:
        print("\n\nOperation cancelled by user. Exiting.")
        sys.exit(0)
    except Exception as e:
        # This will catch cases where the user presses Ctrl+C
        if "NoneType" in str(e):
            print("\n\nOperation cancelled by user. Exiting.")
            sys.exit(0)
        else:
            print(f"An unexpected error occurred: {e}")
            sys.exit(1)


if __name__ == "__main__":
    main()
