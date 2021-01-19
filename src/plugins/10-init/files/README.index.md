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


<a name="top" />

## Contents

*   [Installation](#toc-installation)
*   [Configuration](#toc-configuration)
*   [Load Order](#toc-load-order)
*   [Dotvim Plugins](#toc-dotvim-plugins)
