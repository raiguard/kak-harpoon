require-module luar

declare-option str-to-str-map harpoon_buffers

define-command -params 1 -docstring "Navigate to the file at the specified index" harpoon-nav %{
    lua %arg{1} %opt{harpoon_buffers} %{
        -- Parse arguments
        local to_index = args()
        local buffers = {}
        for i = 2, #arg do
            local index, bufname = string.match(arg[i], "(%d+)=(.*)")
            index = tonumber(index)
            table.insert(buffers, index, bufname)
        end

        if buffers[to_index] then
            kak.edit(buffers[to_index])
            kak.echo("Opened file at index "..to_index)
        else
            kak.echo("-markup", "{Error}No file defined at index "..to_index)
        end
    }
}

define-command -params ..1 -docstring "Add the current file to the list at the index or at the end" harpoon-add %{
    lua %arg{1} %val{bufname} %opt{harpoon_buffers} %{
        local index, bufname = args()
        -- Index is optional
        if not index or (type(index) == "string" and #index == 0) then
            -- Find the lowest available index
            local buffers = {}
            for i = 3, #arg do
                local index, bufname = string.match(arg[i], "(%d+)=(.*)")
                index = tonumber(index)
                table.insert(buffers, index, bufname)
            end
            -- This will handle gaps in the list as well, since # will return the first contiguous section
            index = #buffers + 1
        end

        kak.set_option("-add", "global", "harpoon_buffers", index.."="..bufname)
        kak.echo("Added current file at index "..index)
    }
}

define-command -params 1 -docstring "Remove the file at the specified index" harpoon-remove %{
    lua %arg{1} %{
        local index = args()
        if not index or #index == 0 then
            kak.set_option("global", "harpoon_buffers" "")
        else
            kak.set_option("-remove", "global", "harpoon_buffers", index.."=foo")
        end
    }
}

define-command -params 1 -docstring "Add or navigate to the file at the specified index" harpoon-add-or-nav %{
    lua %arg{1} %opt{harpoon_buffers} %{
        local buffers = {}
        for i = 2, #arg do
            local index, bufname = string.match(arg[i], "(%d+)=(.*)")
            index = tonumber(index)
            table.insert(buffers, index, bufname)
        end

        local index = args()
        if buffers[index] then
            kak.harpoon_nav(index)
        else
            kak.harpoon_add(index)
        end
    }
}

define-command -docstring "List harpoon files in an infobox" harpoon-list %{
    lua %opt{harpoon_buffers} %{
        if #arg == 0 then
            kak.echo("-markup", "{Error}There are no harpooned files")
        else
            local output = {}
            for i, file in pairs(arg) do
                output[i] = string.gsub(file, "=", ": ")
            end
            kak.info("-title", "harpoons", table.concat(output, "\n"))
        end
    }
}

declare-user-mode harpoon
map global harpoon a ": harpoon-add<ret>" -docstring "Add file to end"
map global harpoon l ": harpoon-list<ret>" -docstring "List files"
map global harpoon 1 ": harpoon-add 1<ret>" -docstring "Add file to 1"
map global harpoon 2 ": harpoon-add 2<ret>" -docstring "Add file to 2"
map global harpoon 3 ": harpoon-add 3<ret>" -docstring "Add file to 3"
map global harpoon 4 ": harpoon-add 4<ret>" -docstring "Add file to 4"
map global harpoon 5 ": harpoon-add 5<ret>" -docstring "Add file to 5"
map global harpoon 6 ": harpoon-add 6<ret>" -docstring "Add file to 6"
map global harpoon 7 ": harpoon-add 7<ret>" -docstring "Add file to 7"
map global harpoon 8 ": harpoon-add 8<ret>" -docstring "Add file to 8"
map global harpoon 9 ": harpoon-add 9<ret>" -docstring "Add file to 9"

define-command -docstring "Add convenient keybindings for navigating harpoons" harpoon-add-bindings  %{
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
