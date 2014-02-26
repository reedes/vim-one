" ============================================================================
" File:        plugin/one.vim
" Description: script for vim-one plugin
" Maintainer:  Reed Esau <github.com/reedes>
" Last Change: February 23, 2014
" License:     Same as that under which Vim is distributed
" ============================================================================

if exists('g:loaded_one') || &cp || v:version < 700 | finish | endif
let g:loaded_one = 1

" Save 'cpoptions' and set Vim default to enable line continuations.
let s:save_cpo = &cpo
set cpo&vim

if !exists('g:one#handleSwapfileConflicts')
  " by default, handle swap file conflicts
  let g:one#handleSwapfileConflicts = 1     " 0=disable, 1=enable (def)
endif

" Execute handler whenever swapfile is detected
if g:one#handleSwapfileConflicts &&
 \ has('autocmd') && 
 \ &swapfile
  augroup one_autoswap_detect
    autocmd!
    autocmd SwapExists * let v:swapchoice = one#handleSwapExistsEvent(expand('<afile>:p'))
  augroup END
endif

" Restore previous external compatibility options
let &cpo = s:save_cpo
unlet s:save_cpo

" vim:ts=2:sw=2:sts=2
