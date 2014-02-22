# vim-one

> Launcher targeting server instances of Vim, optionally in a split or tab

_NOTE: this project is new and under active development. Features and
configuration may changed abruptly and without announcement._

# Features

Inspired by [Derek Wyatt’s][dw] “[One Vim ... just one][ov]” video, this
rewrite of the [mvim][mv] script enhances the use of Vim when invoked from
the command line.

Use _onevim_ to conveniently launch Vim with the features you need:

* Symlink _prefix_ drives how Vim is invoked (`g` or `m` prefix for gui mode, e.g.)
* Symlink _suffix_ drives how file is opened (`s` for split, `v` for vsplit, `t` for tab)
* Invoke against a gui or console mode
* Target a specific build of Vim through the `VIM_APP_DIR` environment variable

By design, invoking via _onevim_ will not typically create new instances,
but will instead use the ‘remote’ capability of Vim built with `+clientserver`:

* By default, all files open in a single default session (`--servername VIM`)
* Specify `--servername {name}` option to target specific remote session

Those users seeking to manage multiple server instances of Vim, such as on
the screens of multiple displays, can use an explicit `--servername`
option to target the desired instance. No `--remote` option is needed.

## Requirements

Currently requires a recent version of Vim built with `+clientserver`

## Installation

### Symlink creation

_onevim_ supports the same symlink naming convention as Vim itself, adding
three special suffix characters to control how your file(s) are loaded
into buffers.

An example of creating symlinks for _onevim_:

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

These `s`, `v`, and `t` suffixes provide a hint to _onevim_ to open your
file in `split`, `vsplit`, and in tabs, respectively. The `e` suffix is
a placeholder to avoid conflicting with existing names.

### Targeting a Vim instance

If you have more than one version of Vim installed, you can target the
desired version through the `VIM_APP_DIR` environment variable.

Example of an addition to `.bashrc` for MacVim users:

```
export VIM_APP_DIR=/usr/local/Cellar/macvim/7.4-72
```

Or for the X version of Vim:

```
export VIM_APP_DIR=/usr/local/Cellar/vim/7.4.161
```

### Window placement on splits

To control the placement of windows on splits, add to your `.vimrc`:

```
set splitbelow
set splitright
```

## See also

If you find _onevim_ useful, check out [@reedes][re]’s Vim plugins:

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
including porting to other platforms (Linux, Windows, etc.), please post
it to the github project issue page, or fork and offer a pull request.

## License

Copyright 2014 by Reed Esau. Because _onevim_ is derived from _mvim_, it
is distributed under the same license terms as Vim itself.
