lua << EOF
lvim.builtin.cmp.active = false
EOF

if empty(v:servername) && exists('*remote_startserver')
  call remote_startserver('VIM')
endif

" LateX-specfic configuration related to the VimTeX plugin

nmap <leader>i <plug>(vimtex-info)

nmap <leader>t <CMD>VimtexTocToggle<CR>

" Toggle shell escape on an off when using minted package
" ---------------------------------------------
" Toggles shell escape compilation on and off
function! s:TexToggleShellEscape() abort
  if g:vimtex_compiler_latexmk.options[0] ==# '-shell-escape'
    " Disable shell escape
    call remove(g:vimtex_compiler_latexmk.options, 0)
  else
    " Enable shell escape
    call insert(g:vimtex_compiler_latexmk.options, '-shell-escape', 0)
  endif
  VimtexReload
  VimtexClean
endfunction

nmap <leader>te <Plug>TexToggleShellEscape
nnoremap <script> <Plug>TexToggleShellEscape <SID>TexToggleShellEscape
nnoremap <SID>TexToggleShellEscape :call <SID>TexToggleShellEscape()<CR>

" When loading new buffers, search for references to minted package in the
" document preamble and enable shell escape if minted is detected.
silent execute '!head -n 20 ' . expand('%') . ' | grep "minted" > /dev/null'
if ! v:shell_error  " 'minted' found in preamble
  call insert(g:vimtex_compiler_latexmk.options, '-shell-escape', 0)
endif
" ---------------------------------------------

" Close viewers when VimTeX buffers are closed (see :help vimtex-events)
function! CloseViewers()
  if executable('xdotool')
        \ && exists('b:vimtex.viewer.xwin_id')
        \ && b:vimtex.viewer.xwin_id > 0
    call system('xdotool windowclose '. b:vimtex.viewer.xwin_id)
  endif
endfunction

let g:tex_flavor = 'latex'  " recognize tex files as latex
" Turn off automatic indenting in enumerated environments
let g:tex_indent_items=0

" Compilation
noremap <leader>c <Cmd>update<CR><Cmd>VimtexCompileSS<CR>
noremap <leader>r <Cmd>update<CR><Cmd>VimtexCompileSS<CR>

" Write the line "TEX" to the file "/tmp/inverse-search-target.txt".
" I use the file  "/tmp/inverse-search-target.txt" as part of making inverse 
" search work for both LaTeX and Lilypond LyTeX files.
call system(printf("echo %s > %s", "TEX", "/tmp/inverse-search-target.txt"))

" BEGIN FORWARD SHOW
" ---------------------------------------------
nmap <leader>v <plug>(vimtex-view)

let g:vimtex_view_enabled = 1

" Linux forward search implementation
if has('unix')
  let g:vimtex_view_method = 'zathura'
  " Get Vim's window ID for switching focus from Zathura to Vim using xdotool.
  " Only set this variable once for the current Vim instance.
  if !exists("g:vim_window_id")
    let g:vim_window_id = system("xdotool getactivewindow")
  endif

  function! s:TexFocusVim() abort
    sleep 200m  " Give window manager time to recognize focus moved to Zathura
    execute "!xdotool windowfocus " . expand(g:vim_window_id)
    redraw!
  endfunction

  augroup vimtex_event_focus
    au!
    au User VimtexEventView call s:TexFocusVim()
  augroup END
  
" macOS forward search implementation
elseif has('macunix')
  function! s:TexFocusVim() abort
    execute "!open -a Alacritty"
    redraw!
  endfunction

  augroup vimtex_event_focus
    au!
    au User VimtexEventViewReverse call s:TexFocusVim()
  augroup END
else
  echom "Error: forward show not supported on this OS"
endif
" ---------------------------------------------
" END COMPILATION AND PDF READER SUPPORT

augroup vimtex_event_close
  au!
  au User VimtexEventQuit call CloseViewers()
augroup END

" DEFINE MAPPINGS
" ---------------------------------------------
nmap dse <plug>(vimtex-env-delete)
nmap dsc <plug>(vimtex-cmd-delete)
nmap dsm <plug>(vimtex-env-delete-math)
nmap dsd <plug>(vimtex-delim-delete)
nmap cse <plug>(vimtex-env-change)
nmap csc <plug>(vimtex-cmd-change)
nmap csm <plug>(vimtex-env-change-math)
nmap csd <plug>(vimtex-delim-change-math)
nmap tsf <plug>(vimtex-cmd-toggle-frac)
nmap tsc <plug>(vimtex-cmd-toggle-star)
nmap tse <plug>(vimtex-env-toggle-star)
nmap tsd <plug>(vimtex-delim-toggle-modifier)
nmap tsD <plug>(vimtex-delim-toggle-modifier-reverse)
nmap tsm <plug>(vimtex-env-toggle-math)
imap ]] <plug>(vimtex-delim-close)

" Text objects in operator-pending mode
omap ac <plug>(vimtex-ac)
xmap ac <plug>(vimtex-ac)
omap ic <plug>(vimtex-ic)
xmap ic <plug>(vimtex-ic)

omap ad <plug>(vimtex-ad)
xmap ad <plug>(vimtex-ad)
omap id <plug>(vimtex-id)
xmap id <plug>(vimtex-id)

omap ae <plug>(vimtex-ae)
xmap ae <plug>(vimtex-ae)
omap ie <plug>(vimtex-ie)
xmap ie <plug>(vimtex-ie)

omap am <plug>(vimtex-a$)
xmap am <plug>(vimtex-a$)
omap im <plug>(vimtex-i$)
xmap im <plug>(vimtex-i$)

omap aP <plug>(vimtex-aP)
xmap aP <plug>(vimtex-aP)
omap iP <plug>(vimtex-iP)
xmap iP <plug>(vimtex-iP)

omap ai <plug>(vimtex-am)
xmap ai <plug>(vimtex-am)
omap ii <plug>(vimtex-im)
xmap ii <plug>(vimtex-im)

" nvo mode mappings
map %  <plug>(vimtex-%)
map ]] <plug>(vimtex-]])
map ][ <plug>(vimtex-][)
map [] <plug>(vimtex-[])
map [[ <plug>(vimtex-[[)

map ]m <plug>(vimtex-]m)
map ]M <plug>(vimtex-]M)
map [m <plug>(vimtex-[m)
map [M <plug>(vimtex-[M)

map ]n <plug>(vimtex-]n)
map ]N <plug>(vimtex-]N)
map [n <plug>(vimtex-[n)
map [N <plug>(vimtex-[N)

map ]r <plug>(vimtex-]r)
map ]R <plug>(vimtex-]R)
map [r <plug>(vimtex-[r)
map [R <plug>(vimtex-[R)

map ]/ <plug>(vimtex-]/
map ]* <plug>(vimtex-]star
map [/ <plug>(vimtex-[/
map [* <plug>(vimtex-[star
