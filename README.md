# Dotvim3

> WARNING: Work in progress, do not (yet) use ;)

## What?

This is the third incarnation of my dotvim configuration

V2 can be found [here](https://github.com/astrails/dotvim2)
V1 can be found [here](https://github.com/astrails/dotvim)

> **IMPORTANT:** Please be sure to read the [installation](#installation) section!

## Why

Over the years V1 became too bloated, and hard to update and fix. Once
something went-in, its hard to remove it, since somebody might be using it.

Also, people kept sending me patches with their favorite plugins, which might
not necessarily be useful for everybody.

The result is that the configuration became way too big and slow.

So my goals for this v2 release are:

* easy customization and extensibility. It should be easy to add **optional**
  functionality, plugins, bindings etc.  with dotvim v1 its easy to make any
  plugin conditionally loadable, any value to be configurable (and have a
  default), etc.

* upgradeability. Your customizations should easily survive version upgrades. If
  you decided that you don't need 'ruby support', you should still have it
  'off' next time you upgrade the version. But it should be trivial to bring it
  back if you ever need to.

* minimal boilerplate. You can always achieve configurability by defining a ton
  of vim variables and checking them with 'ifs' all over the place. This is
  ugly and not productive. Dotvim2 uses a shell library to keep, update, and
  merge your "choices" in a shell script file `.config`. More info TBD.

## Status

dotvim2 seems to be stable enough at this point, I'll probably release 1.0 soon.

Note that not all plugins from v1 made it into v2, if you are missing anything
major, please let me know ;)

## Major changes

### Modularity

The number 1 major feature is that its all very modular now. Many parts are
optional, and its actually trivial to make most any other part optional too.

The modularity is achieved by switching from configuration files to
configuration file templates and generators. You no longer use the project
as-is, instead you run `make` in it, to generate your actual configuration in
your directory of choice. You can (and its recommended to) keep this generated
directory content in git as well, so that after every upgrade or configuration
change you can see the exact difference.

> Note: while the idea is to have this very customizable, there are still many
> parts and plugins that are hard-coded. Those are mostly those plugins and
> settings that I consider to be essential, ans so I didn't bother (yet) to
> allow for customization. That being said, its very easy to make any part of
> setup configurable. Just look at any `prompt.sh` file inside `plugins`
> directory. Oh, and **pull requests are welcome ;)**.

### Vim-Plug

NeoBundle was replaced with dein. Which was now replaced with vim-plug.

### TBD

<a name=installation>
## Installation

Clone this repository and run `make`.

Installation will ask you a ton of questions and then **generate** your vim
configuration in the `VIM_DIR` directory. The default is `./dist`, but you can
pass it anything through environment or arguments. e.g.:

    VIM_DIR=~/.vim make

if you use a directory other then `~/.vim` you will need to link it so that vim can find it, e.g.:

    ln -sfn YOUR_VIMDIR_PATH ~/.vim

> Note: Depending on your version of vim you might also have to link `~/.vimrc` => `YOUR_VIMDIR_PATH/vimrc`.
> Newer versions can use `~/.vim/vimrc`, but older versions will only look for `~/.vimrc`

Once your configuration is generated and linked you can run `vim`, it will
detect missing plugins and install them on the first run.

### Configuration

Your configuration choices are stored in `VIM_DIR/.config`. You can edit it
directly or just run `make edit`.

You will be asked quesions during the install only if the config file doesn't
already contain the answer.

`make reconfigure` will ask all questions all over again, with your previous
choices used as defaults.

During the installation a README file is generated in the destination
directory with just the information relevant to your own configuration chocies.

The README file in the project repository was generated with my own
configuration ;).

###  YouCompleteMe

Dotvim2 (optionally) uses YouCompleteMe for code completion (v1 used AutoComplPop).

It is a quite a bit more complex and not without its problems, but it seems to
be **the** completion plugin to use at this time.

> Note: You will need `cmake` installed if you want this to work.

> **IMPORTANT:** YouCompleteMe installation seems to be quite problematic. One
> particular problem that happened to me a lot is git failing to featch all the
> submodules from github. In case of such a failure you can try to run `make
> completion`, which will retry YouCompleteMe installation. you might
> need to run it seveal time until it succeeds.

## TBD

# load order

* vimrc
    * vimrc.plugins
        * ~/.vimrc.plugins
        * gvimrc.plugins
            * ~/.gvimrc.plugins
    * << here all plugins are actually loaded >>
    * after/plugin/after.vim
        * vimrc.after
            * ~/.vimrc.after
            * gvimrc.after
                * ~/.gvimrc.after

Each plugin can add content to files in the target vim directory by simply
having the corresponding files present in the `plugin/files` directory

E.g. if plugin foo has file `plugins/files/directory/files`, then this file's
content will be added to `~/.vim/directory/files`

Plugins found in the `plugins` subdirectory will be automatically loaded as
well.

To make sure each such files will be re-created appropriately upon each install
run, they have to be cleaned up.. `10-init/plugins/10-cleanup` plugin takes
care of the standard ones, if you need a new one, you might need to clean it up
your self. place it in `000=-....` plugin directory to make sure it is called
before any other plugin tries to add content to it.

If a plugin has a `prompt.sh` file in the directory, its loading will be
conditioned on evaling this script.

If the script "fails" (i.e. non-zero exit code), then the plugin will not be loaded.

> IMPORTANT: The prompt script is evaled in the contenxt of the generator, so it has
> access to all the state and functions, so it can run `ask...` functions, etc.

Note that prompt.sh should usually only ask simple question and return
true/false, if you want something more complex create an `install.sh` instead.

If a plugin has an `install.sh` file in the directory, it will be sourced.

so the logic flow is as follows:

- check for `prompt.sh` and exit if it returns false
- copy files from `files` directory
- load all plugins in the `plugins` directory
- run `install.sh` if exists

TBD.

# examples

TBD

## example files structure

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

## plugin ordering

The plugins are loaded according to their sort order.

<a name=top>
## Contents

*   [Installation](#installation)

*   [Core Plugins](#core)
    *   [vimproc](#vimproc)

*   [Global settings](#globals)
    *   TBD: vimbits

*   [General Plugins](#general)
    *   [greplace.vim](#greplace.vim)
    *   [nerdtree](#nerdtree)
    *   [nerdtree-git](#nerdtree-git)
    *   [nerdtreetabs](#nerdtreetabs)
    *   [nerdcommenter](#nerdcommenter)
    *   [vim-repeat](http://github.com/tpope/vim-repeat)
        Use the repeat command "." with supported plugins
    *   [vim-session](#vim-session)
        Extended session management for Vim (:mksession on steroids)
    *   [vim-switch](#vim-switch)
        Simple Vim plugin to switch segments of text with predefined replacements.
    *   [UndoTree](#undotree)
    *   [Utl.vim](#utl.vim)
        url based hyperlinks for text files
    *   [xterm-color-table](#xterm-color-table)

*   [Completion](#completion)
    *   [YouCompleteMe](#youcompleteme)

*   [fuzzy search tools](#fuzzy-search)
    *   [unite.vim](#unite.vim)
        *   TBD: other Unite plugins
        *   [unite outline](#unite-outline)
        *   [unite-colorscheme](#unite-colorscheme)
    *   [CtrlP](#ctrlp)
    *   [FZF](#fzf)
    *   [File search](#fuzzy-files)
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
    *   [editorconfig](#editorconfig)
    *   [vim-endwise](#vim-endwise)
    *   [vim-fugitive](#vim-fugitive)
    *   [vim-merginal](#vim-merginal)
    *   [vim-gitgutter](#gitgutter)
        git diff in the gutter (sign column) and stages/reverts hunks
    *   [vim-surround](#vim-surround)
    *   [tmux-navigator](#tmux-navigator)

*   [Development languages and syntax support](#languages)

        *   [Ruby on Rails Support](#rails)
            *   [vim-rails](#vim-rails)
            *   [vim-rspec](#vim-rspec) lightweight Rspec runner for Vim
            *   [apidock.vim](#apidock.vim) apidock.com docs integration
            *   [vim-i18n](#i18n) Rails i18n extraction plugin

    *   [Vimscript](#vimscript)
    *   [Themes](#themes)


<a name=installation>
### Installation

TBD


<a name=core>
### "Core" Plugins:

*   <a name=vimproc>vimproc

    TBD


<a name=globals>
## Global settings

TBD


<a name=general>
## "General" Plugins:

*   <a name=greplace.vim>[greplace.vim](http://github.com/vim-scripts/greplace.vim) ([top](#top))

    Replace a pattern across multiple files interactively

    Use `:Gsearch` to search for a pattern. Edit the result buffer to your
    liking, then `:Greplace` to incorporate your edits into the source files

    * `:Gsearch` - Search for a given pattern in the specified group of files
      and display the matches in the replace buffer.
    * `:Gbuffersearch` - Search for a given pattern in all the buffers in the Vim buffer list.
    * `:Greplace` - Incorporate the modifications from the replace buffer into
      the corresponding files.

*   <a name=nerdtree>[nerdtree](http://github.com/scrooloose/nerdtree) ([top](#top))

    vim script to give you a tree explorer

    * `<leader>ft` - toggle directory browser (**Note:** this is now handled by
      [nerdtree-tabs](#nerdtreetabs) (see below))
    * `<leader>0` - to find and highlight the currently open file in the tree

*   <a name=nerdtree-git>[nerdtree-git-plugin](https://github.com/Xuyuanp/nerdtree-git-plugin) ([top](#top))

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

*   <a name=nerdtreetabs>[nerdtree-tabs](https://github.com/jistr/vim-nerdtree-tabs) ([top](#top))

    NERDTree and tabs together in Vim, painlessly

    * `<leader>ft` - toggle directory browser
    * `<leader>0` - open directory browser and find the current file in it

*   <a name=nerdcommenter>[nerdcommenter](http://github.com/scrooloose/nerdcommenter) ([top](#top))

    Vim plugin for intensely orgasmic commenting

    * `<leader>;` - toggle comment
    * `<leader>cc` - add commenting
    * `<leader>cu` - Uncomment
    * check docs for more

*   <a name=vim-session>[vim-session](https://github.com/xolox/vim-session) ([top](#top))

    Extended session management for Vim (`:mksession` on steroids)

    * `<leader>SS` - `:SaveSession`
    * `<leader>SO` - `:OpenSession`


    When runnin in a graphical vim:

    * `:RestartVim<CR>` - This command saves your current editing session, restarts Vim and restores your editing session.

*   <a name=vim-switch>[vim-switch](https://github.com/AndrewRadev/switch.vim) ([top](#top))

    Simple Vim plugin to switch segments of text with predefined replacements.

    It will switch `"foo"` to `'foo'` to `:foo`. or `{:foo => bar}` to `{foo: bar}`,
    etc. See `:h switch` for more.

    * `\`` - `:Switch<cr>`

*   <a name=undotree>[Undo Tree](https://github.com/mbbill/undotree) ([top](#top))

    Graphs your vim undo tree in a side window.

    * `<leader>u` - toggle undo window

    * `:h undotree.txt` - more help

*   <a name=utl.vim>[utl.vim](https://github.com/vim-scripts/utl.vim) ([top](#top))

    Utl.vim brings the benefits of URL-based hyperlinking to plain text,

    `:h utl` for help.

*   <a name=xterm-color-table>[xterm-color-table](https://github.com/guns/xterm-color-table.vim) ([top](#top))

    `:XtermColorTable` to create a new buffer with xterm colors

    While in the xterm colors buffer:

    * `t` - toggle text visibility
    * `f` - set text color to the current color
    * `#` - yank current color

    `:h xterm-color-table.txt` for more help.


<a name=completion>
## Completion


<a name=fuzzy-search>
## Fuzzy search tools

[unite]: https://github.com/Shougo/unite.vim
*   <a name=unite.vim>[unite.vim][unite] ([top](#top))

    Search and display information from arbitrary sources like files, buffers,
    recently used files or registers.

    This plugins is too powerful to present here, read the [documentation][unite].

    See [unite-colorscheme](#unite-colorschema) for example command to use
    Unite to choose a colorscheme.


    *   <a name=unite-outline>[unite outline](https://github.com/Shougo/unite-outline) ([top](#top))

        Unite source to display outline of the current file.

        * `<leader>O` - `:Unite outline` - show file outline

    *   <a name=unite-colorscheme>[unite-colorscheme](https://github.com/ujihisa/unite-colorscheme) ([top](#top))

        A [unite.vim](#unite.vim) plugin. Privides source to choose color schemes.

        Try:

        `:Unite -no-start-insert -auto-preview colorscheme`

        Then try to navigate up and down and see what happens ;)

        > Note: actually this command aliased as `:THEME`


*   <a name=ctrlp>[CtrlP](https://github.com/ctrlpvim/ctrlp.vim) ([top](#top))

    Fuzzy file, buffer, mru, tag, etc finder.

    This plugin has lots of options, see `:h ctrlp` for more.

*   <a name=fzf>[FZF](https://github.com/junegunn/fzf) ([top](#top))


*   <a name=fuzzy-files>File search ([top](#top))

    * `<leader>ff` - `:Files` - fuzzy find files using FZF


*   <a name=fuzzy-buffers>Buffer search ([top](#top))

    * `<leader>bb` - `:Unite buffer` - fuzzy search open buffers

*   <a name=fuzzy-quickfix>Quickfix search ([top](#top))

    * `<leader>sq` - `:CtrlPQuickfix` - fuzzy find within quickfix buffer

*   <a name=vim-ag>[The Silver Searcher](https://github.com/ggreer/the_silver_searcher) ([top](#top))

    The Silver Searcher (ag) is a code-searching tool similar to ack, but faster..

    The actual vim integration is provided by [FZF](#fzf)

    * `<leader>/` - `:Ag ` - open prompt for entering search term


*   <a name=fuzzy-lines>Line search ([top](#top))

    * `<leader>sl` - `:Lines` - fuzzy search lines in all opened buffers using FZF

*   <a name=fuzzy-tags>Tags search ([top](#top))

    * `<leader>t` - `:Tags` - fuzzy find tag with FZF
    * `<leader>t` - `:Btags` - fuzzy find buffer tag with FZF

*   <a name=fuzzy-yank>Yank history search ([top](#top))

    [YankRing.vim](http://github.com/vim-scripts/YankRing.vim) Maintains a history of previous yanks, changes and deletes

    * `<leader>sy` to show the yankring
    * `<leader>[`/`,]` - to cycle the just-pasted text though the yankring.
    * `:h yankring.txt` and `:h yankring-tutorial` for more


<a name=devplugins>
## Plugins for Developers:

*   <a name=delimitMate>[delimitMate](http://github.com/Raimondi/delimitMate) ([top](#top))

    auto-completion for quotes, parens, brackets, etc. in insert mode.

*   <a name=editorconfig>[editorconfig-vim](https://github.com/editorconfig/editorconfig-vim) ([top](#top))

    [.editorconfig](http://editorconfig.org) file support.

*   <a name=vim-endwise>[vim-endwise](http://github.com/tpope/vim-endwise) ([top](#top))

    Wisely add "end" in ruby, endfunction/endif/more in vim script, etc

*   <a name=vim-fugitive>[vim-fugitive](http://github.com/tpope/vim-fugitive) ([top](#top))

    A Git wrapper so awesome, it should be illegal

    *    `:Gstatus`

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

*   <a name=vim-merginal>[Merginal](http://github.com/vim-scripts/Merginal) ([top](#top))

    * `:Merginal` - open branch list window

    * `D`  - delete branch under cursor
    * `C`  - checkout branch under cursor
    * `M`  - merge branch under cursor
    * `rb` - rebase current branch against the branch under cursor
    * `rn` - rename branch agains the branch under cursor

    * `:h merginal-branch-list` to see more bindings.

    * `:h merginal` - to see the complete help

*   <a name=gitgutter>[Vim Git Gutter](https://github.com/airblade/vim-gitgutter) ([top](#top))

    A Vim plugin which shows a git diff in the 'gutter' (sign column).
    It shows whether each line has been added, modified, and where lines have been removed.

    ![screenshot](https://raw.github.com/airblade/vim-gitgutter/master/screenshot.png)

    In the screenshot above you can see:

    * Line 15 has been modified.
    * Lines 21-24 are new.
    * A line or lines were removed between lines 25 and 26.

    Commands:

    * `:GitGutterDisable`
    * `:GitGutterEnable`
    * `:GitGutterToggle`
    * `:GitGutterSignsEnable`
    * `:GitGutterSignsDisable`
    * `:GitGutterSignsToggle`
    * `:GitGutterLineHighlightsEnable`
    * `:GitGutterLineHighlightsDisable`
    * `:GitGutterLineHighlightsToggle`

    Bindings:

    * `]c` - jump to next hunk
    * `<localleader>n` - jump to next hunk
    * `[c` - jump to previous hunk
    * `<localleader>p` - jump to previous hunk
    * `<leader>hs` - stage hunk
    * `<leader>hr` - revert hunk

    There are quite some customization options. see help.

*   <a name=vim-surround>[vim-surround](http://github.com/tpope/vim-surround) ([top](#top))

    Delete/change/add parentheses/quotes/XML-tags/much more with ease

    * `dsX` - delete surround X
    * `csXY` - change surround X with Y
    * `s/S` in visual mode - wrap selection
    * `ysMovementX` - surround movement with X

    You should REALLY read the docs if you want to use this one

*   <a name=tmux-navigator>[tmux-navigator](http://github.com/christoomey/vim-tmux-navigator) ([top](#top))

    tmux + vim = love

    to change default mappings define:

        let g:tmux_navigator_no_mappings = 1

    The default mappings are:

    *   `Ctrl-h` - `:TmuxNavigateLeft<cr>`
    *   `Ctrl-j` - `:TmuxNavigateDown<cr>`
    *   `Ctrl-k` - `:TmuxNavigateUp<cr>`
    *   `Ctrl-l` - `:TmuxNavigateRight<cr>`
    *   `Ctrl-\` - `:TmuxNavigatePrevious<cr>`


<a name=languages>
## Development languages and syntax support

<a name=rails>
#### Ruby on Rails Support

*   <a name=vim-rails>[vim-rails](http://github.com/tpope/vim-rails) ([top](#top))

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


*   <a name=apidock.vim>[apidock.vim](https://github.com/alexandrov/apidock.vim) ([top](#top))

    Vim plugin that searches http://apidock.com Ruby, Rails, and RSpec docs from within Vim.

    * `RR` - Search the Rails docs for the word under the cursor.
    * `RB` - Search the Ruby docs for the word under the cursor.
    * `RS` - Search the RSpec docs for the word under the cursor.

*   <a name=vim-rspec>[vim-rspec](https://github.com/josemarluedke/vim-rspec) ([top](#top))

    Lightweight Rspec runner for Vim.

    Commands are self explanatory:

    * `:call RunCurrentSpecFile()`
    * `:call RunNearestSpec()`
    * `:call RunLastSpec()`

    Bindings:

    * `<localleader>r` - `RunNearestSpec`

*   <a name=i18n>[vim-i18n](https://github.com/stefanoverna/vim-i18n) ([top](#top))

    Extracts i18n strings from source files into .yml file.

    * `<leader>z` - extract selected string

*   <a name=vimscript>[vimscript] ([top](#top))

    *   `,x` - to execute the current line of vimscript

*   <a name=themes>Themes ([top](#top))

    The following colorschemes are available:

    * solarized
    * tomorrow
    * vividchalk
    * TBD
