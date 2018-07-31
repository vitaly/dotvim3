# Dotvim3

> **WARNING**: Work in progress, do not use yet ;)

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

### TBD

<a name=installation>

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

<a name=top>
## Contents

*   [Installation](#installation)

*   [Core Plugins](#core)
    *   [vimproc](#vimproc)