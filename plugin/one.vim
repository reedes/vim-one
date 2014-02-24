" ============================================================================
" File:        plugin/one.vim
" Description: script for vim-one plugin
" Maintainer:  Reed Esau <github.com/reedes>
" Last Change: February 23, 2014
" License:     Same as that under which Vim is distributed
" ============================================================================

" Hat tip to Damian Conway's automated response to swapfiles
" which he placed in the public domain.

if exists('g:loaded_one') || &cp | finish | endif
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
      autocmd SwapExists * call s:handleSwapConflictEvent(expand('<afile>:p'))
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

function! s:handleSwapConflictEvent (pathname)
  " if swapfile is older than file itself, just get rid of it...
  if getftime(v:swapname) < getftime(a:pathname)
      call s:delayedMsg("Old swapfile detected...and deleted")
      call delete(v:swapname)
      let v:swapchoice = 'e'

  " Is file in buffer on another Vim server?
  " If so, switch to it, bringing to foreground (if OS allows)
  else
    let l:found = 0
    for l:server_name in split(serverlist(), '\n')
      if l:server_name !=? v:servername &&
       \ remote_expr( l:server_name, "bufexists('" . a:pathname . "')" )
        " escape pathname
        let l:e_pathname = substitute(a:pathname, ' ', '<space>', 'g')
        call remote_send( l:server_name,
          \ '<c-\><c-n>:cal<space>foreground()|b<space>' . l:e_pathname . '<CR>' )
        "call s:delayedMsg("Selected buffer found on server " . l:server_name)
        let v:swapchoice = 'q'
        let l:found = 1
        break
      endif
    endfor
    if !l:found
      call s:delayedMsg("Sorry, buffer with swap file not found; opening read-only as a precaution")
      let v:swapchoice = 'o'
    endif
  endif
endfunction

" Restore previous external compatibility options
let &cpo = s:save_cpo
unlet s:save_cpo

" vim:ts=2:sw=2:sts=2
