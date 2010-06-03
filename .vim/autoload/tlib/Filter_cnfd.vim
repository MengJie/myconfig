" Filter_cnfd.vim
" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created:     2008-11-25.
" @Last Change: 2009-02-15.
" @Revision:    0.0.32

let s:save_cpo = &cpo
set cpo&vim


let s:prototype = tlib#Filter_cnf#New({'_class': ['Filter_cnfd'], 'name': 'cnfd'}) "{{{2

" The same as |tlib#FilterCNF#New()| but a dot is expanded to '\.\{-}'. 
" As a consequence, patterns cannot match dots.
" The pattern is a '/\V' very no-'/magic' regexp pattern.
function! tlib#Filter_cnfd#New(...) "{{{3
    let object = s:prototype.New(a:0 >= 1 ? a:1 : {})
    return object
endf


" :nodoc:
function! s:prototype.SetFrontFilter(world, pattern) dict "{{{3
    let pattern = substitute(a:pattern, '\.', '\\.\\{-}', 'g')
    let a:world.filter[0] = reverse(split(pattern, '\s*|\s*')) + a:world.filter[0][1 : -1]
endf


" :nodoc:
function! s:prototype.PushFrontFilter(world, char) dict "{{{3
    let a:world.filter[0][0] .= a:char == 46 ? '\.\{-}' : nr2char(a:char)
endf


" :nodoc:
function! s:prototype.ReduceFrontFilter(world) dict "{{{3
    let flt = a:world.filter[0][0]
    if flt =~ '\\\.\\{-}$'
        let a:world.filter[0][0] = flt[0:-7]
    else
        let a:world.filter[0][0] = flt[0:-2]
    endif
endf

" :nodoc:
function! s:prototype.CleanFilter(filter) dict "{{{3
    return substitute(a:filter, '\\.\\{-}', '.', 'g')
endf


let &cpo = s:save_cpo
unlet s:save_cpo
