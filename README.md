# harpoon.kak

Quickly switch between your most important Kakoune buffers.

Based on [Harpoon](https://github.com/ThePrimeagen/harpoon) for Neovim.

## Installation

Requires [luar](https://github.com/gustavo-hms/luar). This plugin will automatically require the `luar` module.

Make sure you have [Lua](https://www.lua.org/) installed on your `PATH`.

### [plug.kak](https://github.com/andreyorst/plug.kak)

```kak
plug "gustavo-hms/luar" %{
    plug "raiguard/harpoon.kak" %{
        # Add default keybindings
        harpoon-add-bindings
    }
}
```

### [cork.kak](https://github.com/topisani/cork.kak)

```kak
cork luar "https://github.com/gustavo-hmo/luar" %{
    cork harpoon.kak "https://github.com/raiguard/harpoon.kak" %{
        # Add default keybindings
        harpoon-add-bindings
    }
}
```

### Manually

Stick `harpoon.kak` in your autoload or source it manually.

## Usage

> Assumes that you are using the default keybindings by calling `harpoon-add-bindings`.

Harpoon files by calling `:harpoon-add` or via the user mode (see `Configuration`). Harpooned files are accessible by calling `:harpoon-nav <index>` or by pressing `<c-<index>>`.

For example, add your main file with `:harpoon-add 1`, then return to it at any time by pressing `<c-1>`.

You can have as many harpoons as you like, though you shouldn't need more than three or four at a given time.

Call `:harpoon-list` to list all of the harpooned files, and `:harpoon-remove <index>` to remove a harpooned file.

## Configuration

The plugin provides a `harpoon` user mode:

```kak
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
```

Calling `harpoon-add-bindings` will make this accessible via `,h`, and will add the `<c-<index>>` bindings for quick jumping in normal mode.

## Roadmap

- Persist harpoons per-session
- Add interactive harpoons buffer for reordering and deletion
