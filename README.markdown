# vim-one

> Open file in single server instance of Vim, optionally in a split or tab

_NOTE: _onevim_ should be considered BETA quality at least until the
end of March as it will see substantial changes. Contributions are welcome
to improve it, including support for invoking Vim on other platforms
(Linux, Windows, etc.)_

# Features

* Builds on the [mvim][mv] script that ships with MacVim
* Symlink _prefix_ drives how Vim is invoked (as with _mvim_)
* Symlink _suffix_ drives how file is opened (normal, tab, split, vsplit)
* Manages single remote session by default
* Specify `--servername` option to target specific remote session

Inspired by [Derek Wyatt’s][dw] “[One Vim ... just one][ov]” video, this
enhancement of the [mvim][mv] script will open your files in a single
server instance (default `--servername` is `VIM`). This addresses
a persistent problem faced by many MacVim users: inadvertently spawning
multiple instances, when it’s not always clear where one’s buffer might be
located.

Those users seeking to manage multiple server instances, such as on the
screens of multiple displays, can use an explicit `--servername` option to
target the desired instance. No `--remote` option is needed, and you’re
insulated from the idiosyncrasies of the remote options.

## Requirements

Currently requires a recent version of MacVim built with `+clientserver`

## Invoking _onevim_

Those who have examined [mvim][mv] will have seen its versatility in
invoking the many different facets of Vim based on the naming convention
of a symlinked command. For example, a homebrew installation of Vim on 
OS X will create the following symlinks:

```
gview    -> /usr/local/Cellar/macvim/7.4-72/bin/mvim
gvim     -> /usr/local/Cellar/macvim/7.4-72/bin/mvim
gvimdiff -> /usr/local/Cellar/macvim/7.4-72/bin/mvim
gvimex   -> /usr/local/Cellar/macvim/7.4-72/bin/mvim
mview    -> /usr/local/Cellar/macvim/7.4-72/bin/mvim
mvimdiff -> /usr/local/Cellar/macvim/7.4-72/bin/mvim
mvimex   -> /usr/local/Cellar/macvim/7.4-72/bin/mvim
```

where `gview` will invoke Vim in read-only GUI mode, as if invoked with
`vim -Rg`. For more details on this behavior, see

```
:help view
```

_onevim_ supports the same symlink naming convention as _mvim_. In
addition it supports three special suffix characters to control how your
file(s) are loaded:

```
$ ln -s ~/.vim/bundle/vim-one/bin/onevim ~/bin/mvime   # gui open with edit (default)
$ ln -s ~/.vim/bundle/vim-one/bin/onevim ~/bin/mvims   # gui open in split
$ ln -s ~/.vim/bundle/vim-one/bin/onevim ~/bin/mvimv   # gui open in vsplit
$ ln -s ~/.vim/bundle/vim-one/bin/onevim ~/bin/mvimt   # gui open in tab(s)
```

These `s`, `v`, and `t` suffixes provide a hint to _onevim_ to open your
file in `split`, `vsplit`, and in tabs, respectively. 

You can choose names of your own, even replacing the MacVim defaults, so
long as you conform to the prefix and suffix conventions.

## Configuration tips

To control the placement of windows on splits, add to your `.vimrc`:

```
set splitbelow
set splitright
```

## See also

* “[One Vim ... just one][ov]” video by [Derek Wyatt][dw] - along with his
  recent video on Scala programming with Vim, an inspiration for this
  script

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

Supports Mac OS X in GUI mode now. Any help in porting to other platforms
(Linux, Windows, etc.) will be welcomed. Please fork and offer pulls of
tested modifications. 

In addition, it’s not clear yet if non-GUI invocations of Vim can be
supported in the same way. If you have any ideas on getting it working,
please let me know.

If you’ve spotted a problem or have an idea on improving this plugin,
please post it to the github project issue page, or fork and offer a
pull request for consideration.

## License

Copyright 2014 by Reed Esau. Because _onevim_ is derived from _mvim_, it
is distributed under the same license terms as Vim itself.
