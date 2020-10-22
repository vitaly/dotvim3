# [Dotvim3](https://dotvim.kushner.consulting/)

> **WARNING: MAJOR CHANGES MERGED (2020-10-22)**
>
> **BACKUP before you run configure or install**
>
> I have a confession to make... for more then 2 years I was running the `ide`
> branch of `dotvim3`. Initially I wanted to make a lot of changes and I didn't
> want everyone dealing with breaking changes every week.
>
> I moved fast and broke things... The plan was to clean everything up and
> merge back into master once it becomes stable. Problem is, it did become
> stable long time ago but I really had no time to spend on a major cleanup and
> documentation effort.
>
> So there it was, much better then the current `master`,
> but with a ton of undocumented changes and with my personal local
> customizations.
>
> I still have no time for the full cleanup ;). But I decided to merge it
> anyway, only removing my own personal local changes.
>
> I'll start working on documenting the changes, if you spot any disparency
> between code and doc, please let me know.
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

## My goals for this v3 release are:

* easier installation. just clone into ~/.vim and `make install`
* spacemacs-like bindings with discoverable menu
* easier local modifications using a git branch

## Status

dotvim3 is in the middle of development, I'm using it for a long time now, but big parts of my current config are not yet commited here.
If you **really** want to try it out, you'll need my local vim override files from here: <https://github.com/vitaly/dotfiles/tree/vitaly/home>

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

### TBD

<a name="installation">

## Installation

Clone this repository into `~/.vim`.

The installation is already configured with my default choices, you can review the configuration by running `make reconfigure` or `make edit`.

Run `make install`

### Configuration

Your configuration choices are stored in `.config` file. You can edit it
directly or just run `make edit`.

You will be asked quesions during the install only if the config file doesn't
already contain the answer.

`make reconfigure` will ask all questions all over again, with your previous
choices used as defaults.

During the installation this `README.md` file is re-generated with just the
information relevant to current configuration chocies.

###  DEOPLETE

## TBD


# Load order

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


# Contributing

## TBD


## HOW-TO

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

<a name="top">
## Contents

*   [Installation](#installation)

*   [Core Plugins](#core)
    *   [vimproc](#vimproc)
