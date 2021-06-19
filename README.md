# [Dotvim3](https://dotvim.kushner.consulting/)

> **WARNING: MAJOR CHANGES MERGED (2020-10-22)**
>
> **BACKUP before you run configure or install**
>
> Quite a bit of the changes are not yet documented, as I just merged my local
> development version that I've been using for the last 2 years. I'll  work on
> docs but it will take some time.
>
> Some of the changes:
> - `leader-guide` replaced with `which-key`. `leader-guide` still exists as a
>   configuration option, but it will be removed soon.
> - multiple cursors support
> - one of the biggest changes is the new completion engine `COC`.
>   `YouCompleteMe` was removed, `deoplete` still remains as an option, but
>   since I don't use it, it might start breaking apart after a while. Let me
>   know of any problems. `COC` is the biggest part of the `ide` the branch was
>   about. in addition to completion it also provides language server
>   integration, refactorings, linting, etc.
> - `CtrlP` is no longer used by default. might be removed soon.
> - `syntastic` removed.
> - added `endwise` from `Tim Pope`.
> - `base16` support including shell integration (loading of
>   `~/.vimrc_background` from `base16-shell`). Old colorschemes were removed.
> - started working on `Dockerfile` to pack it all into an image.
> - a generic manifest of generated files is stored in `.files`. They are all
>   removed before each re-generation, starting from clean. Also, if the config
>   changes and the file is no longer generated, it won't be lingering around.
> - configuration choices are now available from inside vim.
>   e.g. `if get(g:, 'dotvim#completion_engine', '') == 'coc'`
> - local customizations moved from home directory into `local` subdirectory in
>   `.vim`
> - the loading order was simplified. all `gvimrc` files were removed.
> - `ruby`, `python`, and `nodejs` versioning and dependencies support.
>   required packages will be installed during `make install`.
> - autoformat toggle
> - major binding cleanup. the goal is to have most of the bindings to have
>   labels in similar format.
> - A ton of toggles. try `<SPACE>T`.


## What?

This is the 3rd incarnation of my dotvim configuration

V2 can be found [here](https://github.com/astrails/dotvim2)
V1 can be found [here](https://github.com/astrails/dotvim)

> **IMPORTANT:** Please be sure to read the [installation](#installation) section!

## Why V3?

About a year ago I tried Spacemacs, and I liked it so much that I actually
tried to switch away from vim. But in the end it didn't work out. The main
problem was that crashed for me several times a day.

I didn't want to wait until it gets fixed, or get myself into Emas development and fix it myself ;).

So, instead I decided to try to rework my Vim configuration to use same
hierarchical mnemonic key bindings.

I did find <https://spacevim.org> and <http://vim.liuchengxu.org> but didn't
like it enough to use as-is, thought I did re-use some of the ideas they had.

### My goals for this v3 release are:

* easier installation. just clone into ~/.vim and `make install`
* spacemacs-like bindings with discoverable menu
* easier local modifications using a git branch

### Status

dotvim3 is in the middle of development, I'm using it for a long time now, but big parts of my current config are not yet commited here.
If you **really** want to try out the latest with my own local overrides: <https://github.com/vitaly/dotvim3/tree/dev>

Also I switched to Nvim. I do try to configure it in a way that it should work
with Vim8 but I do not test it. If it doesn't work, please let me know.

## Major changes

### Vim-Plug

Dein was replaced with [Plug](https://github.com/junegunn/vim-plug).

### local customization files handling

instead of sourcing `~/.vimrc.after`, `~/.vimrc.plugins`, etc., we now source
`~/.vim/local/X` at the end of `~/.vimrc/X` for each of `vimrc`,
`vimrc.after`, `vimrc.plugins`, and `vimrc.bindings`.

`~/local/*` files are created but not managed, you can modify them to your
liking, they will not be overwritten during the installation.

If you want to restore the old functionality, you can manually source `~/.vimrc.after` from `~/.vim/local/vimrc.after`, etc.

> Note gvim.* files are no longer used, you can restore functionality manyally using `if has('gui_running') ...`


<a name="top" />

## Contents

*   [Installation](#toc-installation)
*   [Configuration](#toc-configuration)
*   [Load Order](#toc-load-order)
*   [Dotvim Plugins](#toc-dotvim-plugins)
*   [Global settings](#toc-globals)
    *   [WhichKey](#toc-which-key)
    *   TBD: vimbits
*   [General Plugins](#general)
    *   [vim-diminactive](#toc-diminactive)
    *   [greplace.vim](#toc-greplace)
    *   [vim-multiple-cursors](#toc-multi-cursors)
    *   [nerdtree](#toc-nerdtree)
    *   [nerdtree-git](#toc-nerdtree-git)
    *   [nerdtreetabs](#toc-nerdtreetabs)
    *   [nerdcommenter](#nerdcommenter)
    *   [vim-repeat](http://github.com/tpope/vim-repeat)
        Use the repeat command "." with supported plugins
    *   [vim-switch](#vim-switch)
        Simple Vim plugin to switch segments of text with predefined replacements.
    *   [tmux-navigator](#toc-tmux-navigator)
    *   [UndoTree](#toc-undotree)
    *   [Utl.vim](#toc-utl)
        url based hyperlinks for text files
    *   [xterm-color-table](#xterm-color-table)
*   [Completion](#completion)
*   [Git Intergration](#toc-git-integration)
*   [fuzzy search tools](#toc-fuzzy-search)
    *   [unite.vim](#toc-unite)
        *   TBD: other Unite plugins
        *   [unite outline](#toc-unite-outline)
        *   [unite-colorscheme](#toc-unite-colorscheme)
    *   [FZF](#fzf)
    *   [File search](#toc-fuzzy-files)
    *   [Buffer search](#fuzzy-buffers)
    *   [Quickfix search](#fuzzy-quickfix)
    *   [The Silver Search](#vim-ag)
        `ag` searching integration
    *   [Line search](#fuzzy-lines)
*   [Tags search](#fuzzy-tags)
    *   [Yank history search](#fuzzy-yank)
*   [Plugins for Developers](#devplugins)
    *   [delimitMate](#delimitMate)
        automatic closing of quotes, parenthesis, brackets, etc.
    *   [EasyAlign](#EasyAlign)
        A simple, easy-to-use Vim alignment plugin.
    *   [editorconfig](#editorconfig)
    *   [vim-endwise](#vim-endwise)
    *   [vim-surround](#vim-surround)
*   [Development languages and syntax support](#languages)
    *   [Ruby on Rails Support](#rails)
        *   [vim-rails](#vim-rails)
        *   [vim-rspec](#vim-rspec) lightweight Rspec runner for Vim
        *   [apidock.vim](#apidock.vim) apidock.com docs integration
        *   [vim-i18n](#i18n) Rails i18n extraction plugin
    *   [Vimscript](#vimscript)
    *   [Base16](#base16)

<a name="toc-installation" />

### Installation ([top](#top))

Clone this repository into `~/.vim`.

The installation is already configured with my default choices, you can review the configuration by running `make reconfigure` or `make edit`.

Run `make install`

<a name="toc-configuration" />

### Configuration ([top](#top))

Your configuration choices are stored in `.config` file. You can edit it
directly or just run `make edit`.

You will be asked quesions during the install only if the config file doesn't
already contain the answer.

`make reconfigure` will ask all questions all over again, with your previous
choices used as defaults.

During the installation this `README.md` file is re-generated with just the
information relevant to current configuration chocies.

<a name="toc-load-order" />

### Load order ([top](#top))

First the following scripts are sourced:

* vimrc
    * vimrc.plugins
        * local/vimrc.plugins
    * local/vimrc

Then, after plugins were loaded, the following scripts are sourced:

* after/plugin/after.vim
    * vimrc.bindings
        * local/vimrc.bindings
    * vimrc.after
        * local/vimrc.after


<a name="toc-dotvim-plugins" />

### Dotvim Plugings ([top](#top))

Each plugin can add content to files in the target vim directory by simply
having the corresponding files present in the `plugin/files` directory

E.g. if plugin foo has file `plugins/files/directory/files`, then this file's
content will be added to `~/.vim/directory/files`

Plugins found in the `plugins` subdirectory will be automatically loaded as
well.

To make sure each such files will be re-created appropriately upon each install
run, they have to be cleaned up.. `10-init/plugins/10-cleanup` plugin takes
care of the standard ones, if you need a new file, you need to clean it up
your self. place the cleanup code in a `00=-....` plugin directory to make sure it is called
before any other plugin tries to add content to it.

If a plugin has a `prompt.sh` file in the directory, its loading will be
conditioned on evaling this script.

If the script "fails" (i.e. non-zero exit code), then the plugin will not be loaded.

> IMPORTANT: The prompt script is evaled in the contenxt of the generator, so it has
> access to all the state and functions, e.g. it can run `ask...` functions, etc.

Note that prompt.sh should usually only ask simple question and return
true/false, if you want something more complex create an `install.sh` instead.

If a plugin has an `install.sh` file in the directory, it will be sourced.

The logic flow is as follows:

- check for `prompt.sh` and exit if it returns false
- copy files from `files` directory
- load all plugins in the `plugins` directory
- run `install.sh` if exists

#### plugin ordering

The plugins are loaded according to their sort order.

#### example file structure

- `plugins`
    - `simple_directory_plugin`
        - `files`
            - `file_to_copy`
    - `plugin with a prompt`
        - `files`
            - `some file`
        - `prompt.sh`
    - `plugin_with_install_script`
        - `files`
            - `file_to_copy`
        - `other_files`
            - `other_files_to_copy`
        - `install.sh`
        - `plugins`
            - `sub-plugin1`
              ...

<a name="toc-globals" />

### Global settings

TBD

*   <a name="toc-which-key" />[vim-which-key](http://github.com/liuchengxu/vim-which-key) ([top](#top))

    This plugin is the core of the discoverable key bindings of this setup.

    When you press `<leader>` or `<localleader` and wait a little, a menu will
    popup at the bottom of the screen to guide you through available key
    bindings.

    You should read the original docs.

    One additional mapping that I added is `<leader>sw`. if you press `<CR>`
    after that you will get a menu of all the root bindings.

    But you can also edit the suggested command line and get a list of mappings
    from any prefix. e.g. `<c-w>`, which you can't usually get throught
    `Which Key`, as there is no way to pass `<c-w>` as the next key press to
    the menu.

<a name="general" />

### "General" Plugins:

*   <a name="toc-diminactive" />[vim-diminactive](http://github.com/blueyed/vim-diminactive) ([top](#top))

    Vim plugin to dim inactive windows.

    Diminactive uses 2 methods for dimming: color column highlight, and syntax.

    A simple toggle is provided to **globally** cycle through those 2 methods and and 'off' state: `<plug>cycle(diminactive)`

    It is bound to `<leader>Td`.

    Diminactive does provide methods to manage it on a window or buffer level. See [documentation](http://github.com/blueyed/vim-diminactive).

*   <a name="toc-greplace" />[greplace.vim](http://github.com/vim-scripts/greplace.vim) ([top](#top))

    Replace a pattern across multiple files interactively

    Use `:Gsearch` to search for a pattern. Edit the result buffer to your
    liking, then `:Greplace` to incorporate your edits into the source files

    * `:Gsearch` - Search for a given pattern in the specified group of files
      and display the matches in the replace buffer.
    * `:Gbuffersearch` - Search for a given pattern in all the buffers in the Vim buffer list.
    * `:Greplace` - Incorporate the modifications from the replace buffer into
      the corresponding files.

*   <a name="toc-multi-cursors" />[vim-multiple-cursors](http://github.com/terryma/vim-multiple-cursors) ([top](#top))

    TBD: document and provide basic examples

*   <a name="toc-nerdtree" />[nerdtree](http://github.com/scrooloose/nerdtree) ([top](#top))

    vim script to give you a tree explorer

    * `<leader>ft` - toggle directory browser (**Note:** this is now handled by [nerdtree-tabs](#toc-nerdtreetabs) (see below))
    * `<leader>0` - to find and highlight the currently open file in the tree

*   <a name="toc-nerdtree-git" />[nerdtree-git-plugin](https://github.com/Xuyuanp/nerdtree-git-plugin) ([top](#top))

    A plugin of NERDTree showing git status flags. Works with the LATEST
    version of NERDTree.

    You can configure custom status symbols:

        let g:NERDTreeIndicatorMapCustom = {
            \ "Modified"  : "✹",
            \ "Staged"    : "✚",
            \ "Untracked" : "✭",
            \ "Renamed"   : "➜",
            \ "Unmerged"  : "═",
            \ "Deleted"   : "✖",
            \ "Dirty"     : "✗",
            \ "Clean"     : "✔︎",
            \ "Unknown"   : "?"
            \ }

*   <a name="toc-nerdtreetabs" />[nerdtree-tabs](https://github.com/jistr/vim-nerdtree-tabs) ([top](#top))

    NERDTree and tabs together in Vim, painlessly

    * `<leader>ft` - toggle directory browser
    * `<leader>0` - open directory browser and find the current file in it

*   <a name="nerdcommenter" />[nerdcommenter](http://github.com/scrooloose/nerdcommenter) ([top](#top))

    Vim plugin for intensely orgasmic commenting

    * `<leader>;` - toggle comment
    * `<leader>cc` - add commenting
    * `<leader>cu` - Uncomment
    * check docs for more

*   <a name="vim-switch" />[vim-switch](https://github.com/AndrewRadev/switch.vim) ([top](#top))

    Simple Vim plugin to switch segments of text with predefined replacements.

    It will switch `"foo"` to `'foo'` to `:foo`. or `{:foo => bar}` to `{foo: bar}`,
    etc. See `:h switch` for more.

    * `` ` `` - `:Switch<cr>`

*   <a name="toc-tmux-navigator" />[tmux-navigator](http://github.com/christoomey/vim-tmux-navigator) ([top](#top))

    tmux + vim = love

    to change default mappings define:

        let g:tmux_navigator_no_mappings = 1

    The default mappings are:

    *   `Ctrl-h` - `:TmuxNavigateLeft<cr>`
    *   `Ctrl-j` - `:TmuxNavigateDown<cr>`
    *   `Ctrl-k` - `:TmuxNavigateUp<cr>`
    *   `Ctrl-l` - `:TmuxNavigateRight<cr>`
    *   `Ctrl-\` - `:TmuxNavigatePrevious<cr>`

*   <a name="toc-undotree" />[Undo Tree](https://github.com/mbbill/undotree) ([top](#top))

    Graphs your vim undo tree in a side window.

    * `<leader>u` - toggle undo window

    * `:h undotree.txt` - more help

*   <a name="toc-utl" />[utl.vim](https://github.com/vim-scripts/utl.vim) ([top](#top))

    Utl.vim brings the benefits of URL-based hyperlinking to plain text,

    `:h utl` for help.

*   <a name="xterm-color-table" />[xterm-color-table](https://github.com/guns/xterm-color-table.vim) ([top](#top))

    `:XtermColorTable` to create a new buffer with xterm colors

    While in the xterm colors buffer:

    * `t` - toggle text visibility
    * `f` - set text color to the current color
    * `#` - yank current color

    `:h xterm-color-table.txt` for more help.

<a name="completion" />

### Completion

TBD

<a name="toc-git-integration" />

### Git Integration

*   [vim-fugitive](http://github.com/tpope/vim-fugitive) ([top](#top))

    A Git wrapper so awesome, it should be illegal

    *    `:G`

         Bring up the output of git-status in the preview
         window.  Press `-` to stage or unstage the file on the
         cursor line.  Press `p` to do so on a per hunk basis
         (--patch).  Press `C` to invoke :Gcommit.

    *    `:Gcommit [args]`

         A wrapper around git-commit.

    *    `:Ggrep [args]`

         :grep with git-grep as 'grepprg'.

    *    `<leader>gg`

         shortcut to run :Ggrep

    *   `<leader>gw`

        global git search for the word under the cursor for for selection (in visual mode)

    *   `:Gblame`

        Run git-blame on the file and open the results in a
        scroll bound vertical split. Press enter on a line to
        reblame the file as it was in that commit.

    Much more in the plugin's doc

*   [Merginal](http://github.com/vim-scripts/Merginal) ([top](#top))

    * `:Merginal` - open branch list window

    * `D`  - delete branch under cursor
    * `C`  - checkout branch under cursor
    * `M`  - merge branch under cursor
    * `rb` - rebase current branch against the branch under cursor
    * `rn` - rename branch agains the branch under cursor

    * `:h merginal-branch-list` to see more bindings.

    * `:h merginal` - to see the complete help

<a name="toc-fuzzy-search" />

### Fuzzy search tools

[unite]: https://github.com/Shougo/unite.vim
*   <a name="toc-unite" />[unite.vim][unite] ([top](#top))

    Search and display information from arbitrary sources like files, buffers,
    recently used files or registers.

    This plugins is too powerful to present here, read the [documentation][unite].

    See [unite-colorscheme](#toc-unite-colorschema) for example command to use
    Unite to choose a colorscheme.


    *   <a name="toc-unite-outline" />[unite outline](https://github.com/Shougo/unite-outline) ([top](#top))

        Unite source to display outline of the current file.

        * `<leader>O` - `:Unite outline` - show file outline

    *   <a name="toc-unite-colorscheme" />[unite-colorscheme](https://github.com/ujihisa/unite-colorscheme) ([top](#top))

        A [unite.vim](#unite.vim) plugin. Privides source to choose color schemes.

        Try:

        `:Unite -no-start-insert -auto-preview colorscheme`

        Then try to navigate up and down and see what happens ;)

        > Note: actually this command aliased as `:THEME`

*   <a name="fzf" />[FZF](https://github.com/junegunn/fzf) ([top](#top))

    * `<leader>ff` - `:Files` - fuzzy find files using FZF

*   <a name="toc-fuzzy-files" />File search ([top](#top))


*   <a name="fuzzy-buffers" />Buffer search ([top](#top))

    * `<leader>bb` - `:Buffers` - fuzzy search open buffers with [FSF](#fsf)

*   <a name="fuzzy-quickfix" />Quickfix search ([top](#top))

    * `<leader>sq` - `<Plug>(Search/Quickfix)` - fuzzy find within quickfix buffer

*   <a name="vim-ag" />[The Silver Searcher](https://github.com/ggreer/the_silver_searcher) ([top](#top))

    The Silver Searcher (ag) is a code-searching tool similar to ack, but faster..

    The actual vim integration is provided by [FZF](#fzf)

    * `<leader>/` - `:Ag ` - open prompt for entering search term


*   <a name="fuzzy-lines" />Line search ([top](#top))

    * `<leader>sl` - `<plug>(Search/Lines)` - fuzzy search lines in all opened buffers using FZF

*   <a name="fuzzy-tags" />Tags search ([top](#top))

    * `<leader>t` - `:Tags` - fuzzy find tag with FZF
    * `<leader>t` - `:Btags` - fuzzy find buffer tag with FZF

*   <a name="fuzzy-yank" />Yank history search ([top](#top))

    [YankRing.vim](http://github.com/vim-scripts/YankRing.vim) Maintains a history of previous yanks, changes and deletes

    * `<leader>sy` to show the yankring
    * `<leader>[`/`,]` - to cycle the just-pasted text though the yankring.
    * `:h yankring.txt` and `:h yankring-tutorial` for more

<a name="devplugins" />

### Plugins for Developers:

*   <a name="delimitMate" />[delimitMate](http://github.com/Raimondi/delimitMate) ([top](#top))

    auto-completion for quotes, parens, brackets, etc. in insert mode.

*   <a name="EasyAlign" />[EasyAlign](https://github.com/junegunn/vim-easy-align) ([top](#top))

    Press `ENTER` in visual selection mode to start interactive EasyAlign session. See docs for details.

*   <a name="editorconfig" />[editorconfig-vim](https://github.com/editorconfig/editorconfig-vim) ([top](#top))

    [.editorconfig](http://editorconfig.org) file support.

*   <a name="vim-endwise" />[vim-endwise](http://github.com/tpope/vim-endwise) ([top](#top))

    Wisely add "end" in ruby, endfunction/endif/more in vim script, etc

*   <a name="vim-surround" />[vim-surround](http://github.com/tpope/vim-surround) ([top](#top))

    Delete/change/add parentheses/quotes/XML-tags/much more with ease

    * `dsX` - delete surround X
    * `csXY` - change surround X with Y
    * `s/S` in visual mode - wrap selection
    * `ysMovementX` - surround movement with X

    You should REALLY read the docs if you want to use this one

<a name="languages" />

### Development languages and syntax support

<a name="rails" />

#### Ruby on Rails Support

*   <a name="vim-rails" />[vim-rails](http://github.com/tpope/vim-rails) ([top](#top))

    Ruby on Rails: easy file navigation, enhanced syntax highlighting, and more

    * `:AV` - open "alternate" file in a new vertical split
    * `:AS` - open "alternate" file in a new horizontal split
    * `:RV` - open "related" file in a new vertical split
    * `:RS` - open "related" file in a new horizontal split
    * `:Rextract` - extract partial (select text for extraction first)
    * `:Rinvert` - takes a self.up migration and writes a self.down.
    * `gf` - remapped to take context into account. recognizes models
      associations, partials etc.
    * `:h rails` for much more info ;)


*   <a name="apidock.vim" />[apidock.vim](https://github.com/alexandrov/apidock.vim) ([top](#top))

    Vim plugin that searches http://apidock.com Ruby, Rails, and RSpec docs from within Vim.

    * `RR` - Search the Rails docs for the word under the cursor.
    * `RB` - Search the Ruby docs for the word under the cursor.
    * `RS` - Search the RSpec docs for the word under the cursor.

*   <a name="vim-rspec" />[vim-rspec](https://github.com/josemarluedke/vim-rspec) ([top](#top))

    Lightweight Rspec runner for Vim.

    Commands are self explanatory:

    * `:call RunCurrentSpecFile()`
    * `:call RunNearestSpec()`
    * `:call RunLastSpec()`

    Bindings:

    * `<localleader>r` - `RunNearestSpec`

*   <a name="i18n" />[vim-i18n](https://github.com/stefanoverna/vim-i18n) ([top](#top))

    Extracts i18n strings from source files into .yml file.

    * `<leader>z` - extract selected string

*   <a name="vimscript" />[vimscript] ([top](#top))

    *   `,x` - to execute the current line of vimscript

*   <a name="base16" />Base16 ([top](#top))

    Base16 color themes are supported

    File `~/.vimrc_background` will be sourced if found. It can be created by
    using <https://github.com/chriskempson/base16-shell> with your shell.
