# kak-harpoon

Quickly switch between your most important Kakoune files.

Based on [Harpoon](https://github.com/ThePrimeagen/harpoon) for Neovim.

## Installation

Source `harpoon.kak` in your `kakrc`, or use a plugin manager.

## Usage

> Assumes that you are using the default keybindings by calling `harpoon-add-bindings`.

Harpoon files by calling `:harpoon-add <index>` or via the user mode (see `Configuration`). Harpooned files are accessible by calling `:harpoon-nav <index>` or by pressing `<a-<index>>`.

For example, add your main file with `:harpoon-add 1`, then return to it at any time by pressing `<a-1>`.

You can have as many harpoons as you like, though you shouldn't need more than three or four at a given time.

Call `:harpoon-list` to list all of the harpooned files, and `:harpoon-remove <index>` to remove a harpooned file. You can also call `:harpoon-add-or-nav <index>` to navigate to the given file or add it if it does not exist.

## Configuration

The plugin provides a `harpoon` user mode:

```kak
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
