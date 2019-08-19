SpaceVim
========

Fork from: <https://github.com/SpaceVim/SpaceVim>, since v1.0.0


## Installation

```
apt-get intall cowsay fortunes neovim
```

or you can install the lasted neovim from <https://github.com/neovim/neovim/releases>.


## Layers

TODO

All layers are disabled by default. You should enable manually.


---


## FAQ

1. How do I enable YouCompleteMe?
>
  I do not recommend using YouCompleteMe.
  It is too big as a vim plugin. Also, I do not like using submodules in a vim
  plugin. It is hard to manage with a plugin manager.

  Step 1: Add `let g:spacevim_enable_ycm = 1` to custom_config. By default
  it should be `~/.SpaceVim.d/init.vim`.

  Step 2: Get into the directory of YouCompleteMe's author. By default it
  should be `~/.cache/vimfiles/repos/github.com/Valloric/`. If you find the
  directory `YouCompleteMe` in it, go into it. Otherwise clone
  YouCompleteMe repo by
  `git clone https://github.com/Valloric/YouCompleteMe.git`. After cloning,
  get into it and run `git submodule update --init --recursive`.

  Step 3: Compile YouCompleteMe with the features you want. If you just want
  C family support, run `./install.py --clang-completer`.
<

2. How to add custom snippet?
>
  SpaceVim uses neosnippet as the default snippet engine. If you want to add
  a snippet for a vim filetype, open a vim file and run `:NeoSnippetEdit`
  command. A buffer will be opened and you can add your custom snippet.
  By default this buffer will be save in `~/.SpaceVim/snippets`.
  If you want to use another directory:

  let g:neosnippet#snippets_directory = '~/path/to/snip_dir'

  For more info about how to write snippet, please
  read |neosnippet-snippet-syntax|.
<

3. Where is `<c-f>` in cmdline-mode?
>
  `<c-f>` is the default value of |cedit| option, but in SpaceVim we use that
  binding as `<Right>`, so maybe you can change the `cedit` option or use
  `<leader>+<c-f>`.
<

4. How to use `<Space>` as `<Leader>`?
>
  Add `let mapleader = "\<Space>"` to `~/.SpaceVim.d/init.vim`
<
