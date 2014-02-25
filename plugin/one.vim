" ============================================================================
" File:        plugin/one.vim
" Description: script for vim-one plugin
" Maintainer:  Reed Esau <github.com/reedes>
" Last Change: February 23, 2014
" License:     Same as that under which Vim is distributed
" ============================================================================

" Hat tip to:
" * Bram Moolenaar's EditExisting.vim
" * Damian Conway's swapfile handler which he placed in the public domain.

if exists('g:loaded_one') || &cp || v:version < 700 | finish | endif
let g:loaded_one = 1

" Save 'cpoptions' and set Vim default to enable line continuations.
let s:save_cpo = &cpo
set cpo&vim

if !exists('g:one#handleSwapfileConflicts')
  " by default, handle swap file conflicts
  let g:one#handleSwapfileConflicts = 1     " 0=disable, 1=enable (def)
endif

if g:one#handleSwapfileConflicts
  " Execute handler whenever swapfile is detected
  if &swapfile
    augroup one_autoswap_detect
      autocmd!
      autocmd SwapExists * let v:swapchoice = s:handleSwapExistsEvent(expand('<afile>:p'))
    augroup END
  endif
endif

" Print a message after the autocommand completes
" (so you can see it, but don't have to hit <ENTER> to continue)...
"
function! s:delayedMsg (msg)
    " A sneaky way of injecting a message when swapping into the new buffer...
    augroup one_autoswap_msg
        autocmd!
        " Print the message on finally entering the buffer...
        autocmd BufWinEnter *  echohl WarningMsg
  exec 'autocmd BufWinEnter *  echon "\r'.printf("%-60s", a:msg).'"'
        autocmd BufWinEnter *  echohl NONE

        " And then remove these autocmds, so it's a "one-shot" deal...
        autocmd BufWinEnter *  augroup one_autoswap_msg
        autocmd BufWinEnter *  autocmd!
        autocmd BufWinEnter *  augroup END
    augroup END
endfunction

function! s:handleSwapExistsEvent (pathname)
  " if swapfile is older than file itself, just get rid of it...
  if getftime(v:swapname) < getftime(a:pathname)
      call s:delayedMsg("Old swapfile detected...and deleted")
      call delete(v:swapname)
      return 'e'

  " Is file in buffer on another Vim server?
  " If so, switch to it
  else
    let l:pathname_e = substitute(a:pathname, "'", "''", "g")
    for l:servername in split(serverlist(), '\n')
      if l:servername ==? v:servername | continue | endif       " skip myself

      if remote_expr( l:servername, "bufloaded('" . l:pathname_e . "')" )

        if has('win32') | call remote_foreground(l:servername) | endif
        call remote_expr(l:servername, "foreground()")

        if remote_expr(l:servername, "exists('*one#EditExisting')")
          " Make sure the file is visible in a window (not hidden).
          " If v:swapcommand exists and is set, send it to the server.
          call remote_expr(
            \ l:servername,
            \ "one#EditExisting('" .
              \ l:pathname_e .
              \ "', '" .
              \ (exists("v:swapcommand") ? substitute(v:swapcommand, "'", "''", "g") : '') .
              \ "')")
        endif

        return 'q'
      endif
    endfor
  endif
  return ''
endfunction

" Function used on the server to make the file visible and possibly execute a
" command.
function! one#EditExisting(fname, command)
  " Get the window number of the file in the current tab page.
  let l:winnr = bufwinnr(a:fname)
  if l:winnr <= 0
    " Not found, look in other tab pages.
    let l:bufnr = bufnr(a:fname)
    for l:i in range(tabpagenr('$'))
      if index(tabpagebuflist(l:i + 1), l:bufnr) >= 0
        " Make this tab page the current one and find the window number.
        exe 'tabnext ' . (l:i + 1)
        let l:winnr = bufwinnr(a:fname)
        break
      endif
    endfor
  endif

  if l:winnr > 0
    exe l:winnr . "wincmd w"
  elseif exists('*fnameescape')
    exe "edit " . fnameescape(a:fname)
  else
    exe "edit " . escape(a:fname, " \t\n*?[{`$\\%#'\"|!<")
  endif

  if a:command != ''
    exe "normal " . a:command
  endif

  redraw
endfunction

" Restore previous external compatibility options
let &cpo = s:save_cpo
unlet s:save_cpo

" vim:ts=2:sw=2:sts=2
