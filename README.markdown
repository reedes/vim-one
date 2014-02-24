# vim-one

> Because Vim’s +clientserver is awesome

![demo](screenshots/demo.gif)

# Features

Inspired by [Derek Wyatt’s][dw] “[One Vim ... just one][ov]” video, this
rewrite of the [mvim][mv] script builds on Vim’s `+clientserver` capability to
better manage remote server sessions.

_onevim’s_ features:

* Command line launch script to invoke Vim in any of its various startup modes
  (gui, console, etc.)
* From the command line, load a file into a split or tab
* Manages single server instance by default, avoiding the inadvertent creation
  of multiple forked gui instances
* Supports multiple servers through the `--servername {name}` option
* Attempting to load a file that is already present in another server instance
  will bring the latter to the foreground

## Requirements

Currently requires a recent version of Vim built with `+clientserver`

Note that this plugin was developed and tested on Mac OS X. See the ‘future
development’ section below for support under Linux and Windows.

## Installation

### Symlink creation

Create symlinks to the _onevim_ launcher script to invoke Vim with the
capabilities you need. The prefix and suffix of the symlink are
significant:

* _prefix_ drives Vim’s startup mode (`g` or `m` prefix for gui mode, e.g.)
* _suffix_ drives how a file is opened (`s` for split, `v` for vsplit, `t` for tab)

Choose a string as a filler between the prefix and suffix. In the example
creation of symlinks below, I’m using ‘vim’:

```
$ ln -s ~/.vim/bundle/vim-one/bin/onevim ~/bin/mvime   # gui open with edit (default)
$ ln -s ~/.vim/bundle/vim-one/bin/onevim ~/bin/mvims   # gui open in split
$ ln -s ~/.vim/bundle/vim-one/bin/onevim ~/bin/mvimv   # gui open in vsplit
$ ln -s ~/.vim/bundle/vim-one/bin/onevim ~/bin/mvimt   # gui open in tab(s)
$ ln -s ~/.vim/bundle/vim-one/bin/onevim ~/bin/vime    # console open with edit (default)
$ ln -s ~/.vim/bundle/vim-one/bin/onevim ~/bin/vims    # console open in split
$ ln -s ~/.vim/bundle/vim-one/bin/onevim ~/bin/vimv    # console open in vsplit
$ ln -s ~/.vim/bundle/vim-one/bin/onevim ~/bin/vimt    # console open in tab(s)
```

The `e` suffix is merely a placeholder to avoid conflicting with existing commands.

For more details on how Vim uses prefixes to drive its startup mode, see:

```
:help view
```

### Targeting a specific Vim version

If you have more than one version of Vim installed, you can target the
desired version through the `VIM_APP_DIR` environment variable.

This will also be necessary if _onevim_ cannot find your Vim directory.

Example of an addition to `.bashrc` for MacVim users:

```
export VIM_APP_DIR=/usr/local/Cellar/macvim/7.4-72
```

Or for the X version of Vim:

```
export VIM_APP_DIR=/usr/local/Cellar/vim/7.4.161
```

## Configuration

### Automatic focus switching on swapfile conflicts

If swapfile is enabled and you request that a file be loaded that is
already loaded on another server instance, _onevim_ will automatically
switch to that latter server instance. 

In most cases this avoids the annoying ‘E325 ATTENTION’ warning message to
resolve swapfile conflicts.

If you want to retain Vim’s default behavior on swapfile handling, set the
following value to `0` in your `.vimrc`:

```
let g:one#handleSwapfileConflicts = 1     " 0=disable, 1=enable (def)
```

### Window placement on splits

To control the placement of windows on splits, add to your `.vimrc`:

```
set splitbelow
set splitright
```

## Usage

Invoking via _onevim_ will manage server instance(s) using Vim’s
_+clientserver_ ‘remote’ capability:

* By default, all files open in a single default session (`--servername
  VIM`)
* Specify an explicit server name through `--servername {name}` option to
  target a remote session

The latter feature is for users seeking to manage multiple server
instances of Vim, such as those that are project-specific on the screens
of multiple displays. 

There’s no need to specify a `--remote` option. But if you do, _onevim_
will pass all of your options through to Vim, no longer managing the
server(s).

## See also

If you find _onevim_ useful, check out [@reedes][re]’s other Vim plugins:

* [vim-colors-pencil][cp] - color scheme for Vim inspired by IA Writer
* [vim-lexical][lx] - building on Vim’s spell-check and thesaurus/dictionary completion
* [vim-litecorrect][lc] - lightweight auto-correction for Vim
* [vim-pencil][pn] - Rethinking Vim as a tool for writers
* [vim-textobj-quote][qu] - extends Vim to support typographic (‘curly’) quotes
* [vim-textobj-sentence][ts] - improving on Vim's native sentence motion command
* [vim-thematic][th] - modify Vim’s appearance to suit your task and environment 
* [vim-wheel][wh] - screen-anchored cursor movement for Vim
* [vim-wordy][wo] - uncovering usage problems in writing 

[mv]: https://github.com/b4winckler/macvim/blob/master/src/MacVim/mvim
[ov]: http://vimeo.com/4446112
[dw]: https://github.com/derekwyatt
[re]: http://github.com/reedes
[cp]: http://github.com/reedes/vim-colors-pencil
[pn]: http://github.com/reedes/vim-pencil
[lx]: http://github.com/reedes/vim-lexical
[lc]: http://github.com/reedes/vim-litecorrect
[qu]: http://github.com/reedes/vim-textobj-quote
[ts]: http://github.com/reedes/vim-textobj-sentence
[th]: http://github.com/reedes/vim-thematic
[wo]: http://github.com/reedes/vim-wordy
[wh]: http://github.com/reedes/vim-wheel

## Future development

If you’ve spotted a problem or have an idea on improving this plugin,
please post to the github project issue page. Or better yet, fork and
offer a pull request. Ports to other platforms (Linux, Windows, etc.) are
welcome.

## License

Copyright 2014 by Reed Esau. Because _onevim_ is derived from _mvim_, it
is distributed under the same license terms as Vim itself.
