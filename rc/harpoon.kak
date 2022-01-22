declare-option str-to-str-map harpoon_buffers

define-command harpoon-nav \
-params 1..2 \
-docstring "harpoon-nav <index> [<add-if-empty>]: Navigate to the harpoon at <index>, or optionally add it if it's empty" \
%{
    evaluate-commands %sh{
        selected=$1
        add=$2
        eval "set -- $kak_quoted_opt_harpoon_buffers"
        while [ $# -gt 0 ]; do
            index=${1%%=*}
            if [ "$index" = "$selected" ]; then
                echo "edit ${1#*=}"
                echo "echo 'Opened harpoon at index $selected'"
                return
            fi
            shift
        done

        if [ "$add" = true ]; then
            echo "harpoon-add $selected"
        else
            echo "fail 'No harpoon defined at index $selected'"
        fi
    }
}

define-command harpoon-add \
-params 1 \
-docstring "harpoon-add <index>: Harpoon the current file at <index>" \
%{
    evaluate-commands %sh{
        bufname=$(echo "$kak_bufname" | sed "s/@/@@/g")
        echo "set-option -add global harpoon_buffers %@$1=$bufname@"
        echo "echo 'Added current file at index $1'"
    }
}

define-command harpoon-remove \
-params ..1 \
-docstring "harpoon-remove [<index>]: Remove the harpoon at <index>, or all harpoons" \
%{
    evaluate-commands %sh{
        if [ -n "$1" ]; then
            echo "set-option -remove global harpoon_buffers '$1='"
            echo "echo 'Removed harpoon at index $1'"
        else
            echo "set-option global harpoon_buffers"
            echo "echo 'Removed all harpoons'"
        fi
    }
}

define-command harpoon-list \
-docstring "List harpoons in an infobox" \
%{
    evaluate-commands %sh{
        output=""
        eval "set -- $kak_quoted_opt_harpoon_buffers"
        while [ $# -gt 0 ]; do
            index=${1%%=*}
            filename=${1#*=}
            # Add newline if it's not the first one
            if [ -n "$output" ]; then
                output="$output
$index: $filename"
            else
                output="$index: $filename"
            fi
            shift
        done
        output=$(echo "$output" | sed "s/@/@@/g" | sort)

        if [ -n "$output" ]; then
            echo "info -title harpoons %@$output@"
        else
            echo "fail 'There are no harpoons'"
        fi
    }
}

declare-user-mode harpoon
map global harpoon l ": harpoon-list<ret>" -docstring "List harpoons"
map global harpoon 1 ": harpoon-add 1<ret>" -docstring "Add file at 1"
map global harpoon 2 ": harpoon-add 2<ret>" -docstring "Add file at 2"
map global harpoon 3 ": harpoon-add 3<ret>" -docstring "Add file at 3"
map global harpoon 4 ": harpoon-add 4<ret>" -docstring "Add file at 4"
map global harpoon 5 ": harpoon-add 5<ret>" -docstring "Add file at 5"
map global harpoon 6 ": harpoon-add 6<ret>" -docstring "Add file at 6"
map global harpoon 7 ": harpoon-add 7<ret>" -docstring "Add file at 7"
map global harpoon 8 ": harpoon-add 8<ret>" -docstring "Add file at 8"
map global harpoon 9 ": harpoon-add 9<ret>" -docstring "Add file at 9"

define-command harpoon-add-bindings -docstring "Add convenient keybindings for navigating harpoons" %{
    map global normal <c-1> ": harpoon-nav 1<ret>"
    map global normal <c-2> ": harpoon-nav 2<ret>"
    map global normal <c-3> ": harpoon-nav 3<ret>"
    map global normal <c-4> ": harpoon-nav 4<ret>"
    map global normal <c-5> ": harpoon-nav 5<ret>"
    map global normal <c-6> ": harpoon-nav 6<ret>"
    map global normal <c-7> ": harpoon-nav 7<ret>"
    map global normal <c-8> ": harpoon-nav 8<ret>"
    map global normal <c-9> ": harpoon-nav 9<ret>"

    map global user h ": enter-user-mode harpoon<ret>" -docstring "harpoon..."
}
