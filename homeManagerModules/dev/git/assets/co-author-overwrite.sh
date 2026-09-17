#!/bin/bash
# from SO: https://stackoverflow.com/a/54261882/317605 (by https://stackoverflow.com/users/8207842/dols3m)
# and also from: https://gist.github.com/sergiofbsilva/099172ea597657b0d0008dc367946953
function prompt_for_multiselect {

    # little helpers for terminal print control and key input
    ESC=$( printf "\033")
    cursor_blink_on()   { printf "$ESC[?25h"; }
    cursor_blink_off()  { printf "$ESC[?25l"; }
    cursor_to()         { printf "$ESC[$1;${2:-1}H"; }
    print_inactive()    { printf "$2   $1 "; }
    print_active()      { printf "$2  $ESC[7m $1 $ESC[27m"; }
    get_cursor_row()    { IFS=';' read -sdR -p $'\E[6n' ROW COL; echo ${ROW#*[}; }
    key_input()         {
      local key
      IFS= read -rsn1 key 2>/devnull >&2
      if [[ $key = ""      ]]; then echo enter; fi;
      if [[ $key = $'\x20' ]]; then echo space; fi;
      if [[ $key = $'\x1b' ]]; then
        read -rsn2 key
        if [[ $key = [A ]]; then echo up;    fi;
        if [[ $key = [B ]]; then echo down;  fi;
      fi 
    }
    toggle_option()    {
      local arr_name=$1
      eval "local arr=(\"\${${arr_name}[@]}\")"
      local option=$2
      if [[ ${arr[option]} == true ]]; then
        arr[option]=
      else
        arr[option]=true
      fi
      eval $arr_name='("${arr[@]}")'
    }

    local retval=$1
    local options
    local defaults

    IFS=';' read -r -a options <<< "$2"
    if [[ -z $3 ]]; then
      defaults=()
    else
      IFS=';' read -r -a defaults <<< "$3"
    fi
    local selected=()

    for ((i=0; i<${#options[@]}; i++)); do
      selected+=("${defaults[i]:-false}")
      printf "\n"
    done

    # determine current screen position for overwriting the options
    local lastrow=`get_cursor_row`
    local startrow=$(($lastrow - ${#options[@]}))

    # ensure cursor and input echoing back on upon a ctrl+c during read -s
    trap "cursor_blink_on; stty echo; printf '\n'; exit" 2
    cursor_blink_off

    local active=0
    while true; do
        # print options by overwriting the last lines
        local idx=0
        for option in "${options[@]}"; do
            local prefix="[ ]"
            if [[ ${selected[idx]} == true ]]; then
              prefix="[x]"
            fi

            cursor_to $(($startrow + $idx))
            if [ $idx -eq $active ]; then
                print_active "$option" "$prefix"
            else
                print_inactive "$option" "$prefix"
            fi
            ((idx++))
        done

        # user key control
        case `key_input` in
            space)  toggle_option selected $active;;
            enter)  break;;
            up)     ((active--));
                    if [ $active -lt 0 ]; then active=$((${#options[@]} - 1)); fi;;
            down)   ((active++));
                    if [ $active -ge ${#options[@]} ]; then active=0; fi;;
        esac
    done

    # cursor position back to normal
    cursor_to $lastrow
    printf "\n"
    cursor_blink_on

    eval $retval='("${selected[@]}")'
}

# Check if anything is already staged; if yes, we cannot amend safely
if ! git diff --cached --quiet; then
    echo "Staged changes detected. Won't amend commit."
    exit 1
fi

OPTIONS_LABELS=("Claude" "Copilot" "Cursor" "Devin" "OpenCode")
OPTIONS_VALUES=("Claude <noreply@anthropic.com>" "Copilot <copilot@github.com>" "Cursor <cursor@cursor.com>" "Devin AI <devin-ai[bot]@users.noreply.github.com>" "OpenCode <noreply@opencode.ai>")

OPTIONS_STRING=""
for i in "${!OPTIONS_VALUES[@]}"; do
    OPTIONS_STRING+="${OPTIONS_VALUES[$i]} (${OPTIONS_LABELS[$i]});"
done

prompt_for_multiselect SELECTED "$OPTIONS_STRING"

CHECKED=()
for i in "${!SELECTED[@]}"; do
    if [ "${SELECTED[$i]}" == "true" ]; then
        CHECKED+=("${OPTIONS_VALUES[$i]}")
    fi
done

if [ ${#CHECKED[@]} -ne 1 ]; then
    echo "Please select exactly ONE AI agent to set as the main author."
    exit 1
fi

NEW_AUTHOR="${CHECKED[0]}"

ORIG_NAME=$(git log -1 --format="%an")
ORIG_EMAIL=$(git log -1 --format="%ae")
ORIG_AUTHOR="${ORIG_NAME} <${ORIG_EMAIL}>"

EXISTING_MSG=$(git log -1 --format="%B")

CO_AUTHOR_LINE="Co-authored-by: ${ORIG_AUTHOR}"

# Check if the original author is already listed as a co-author to prevent duplicates
if echo "$EXISTING_MSG" | grep -Fq "$CO_AUTHOR_LINE"; then
    NEW_MSG="$EXISTING_MSG"
else
    # Remove trailing empty lines and append the new trailer
    CLEAN_MSG=$(printf '%s' "$EXISTING_MSG" | sed -e :a -e '/^\n*$/{$d;N;ba}')
    NEW_MSG=$(printf "%s\n\n%s\n" "$CLEAN_MSG" "$CO_AUTHOR_LINE")
fi

# Amend the commit: swap the main author and update the message
git commit --amend --author="$NEW_AUTHOR" -m "$NEW_MSG"