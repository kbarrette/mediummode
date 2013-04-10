" Vim medium mode - allow character-wise navigation, but only a little bit
"
" https://github.com/kbarrette/mediummode
"

if exists('g:mediummode_loaded')
  finish
endif
let g:mediummode_loaded = 1

" Set a variable unless it exists
function! s:set(name, value)
  if !exists(a:name)
    exec 'let' a:name '=' string(a:value)
  endif
endfunction

" Should medium mode be enabled
call s:set('g:mediummode_enabled', 1)

" The number of motions allowed before medium mode stop them
call s:set('g:mediummode_allowed_motions', 2)

" Message printed when a motion is disallowed
call s:set('g:mediummode_disallowed_message', 'You can do better than that!')

" The list of motions that medium mode will consider
call s:set('g:mediummode_motion_keys', ['h', 'j', 'k', 'l', '<Left>', '<Right>', '<Up>', '<Down>'])

" The list of autocmd events that will reset medium mode's motion count
call s:set('g:mediummode_reset_events', ['InsertLeave', 'BufEnter', 'CursorHold'])

" Internal count of motions made
call s:set('s:motion_count', 0)

" Check if the motion is allowed and either perform the motion, or scold the user
function! s:MediumModeMotion(motion)
  if s:motion_count < g:mediummode_allowed_motions
    let s:motion_count += 1
    return a:motion
  else
    echo g:mediummode_disallowed_message
    return ''
  endif
endfunction

" Reset the motion count
function! s:MediumModeResetCount()
  let s:motion_count = 0
  echo ''
endfunction

" Enable/disable functions
function! s:MediumModeEnable(...)
  if !g:mediummode_enabled || (a:0 > 0 && a:1)
    for key in g:mediummode_motion_keys
      exec 'nnoremap <expr>' key '<SID>MediumModeMotion("' . key . '")'
      exec 'vnoremap <expr>' key '<SID>MediumModeMotion("' . key . '")'
    endfor

    augroup MediumMode
      autocmd!
      exec 'autocmd' join(g:mediummode_reset_events, ',') '*' 'call <SID>MediumModeResetCount()'
    augroup END

    let g:mediummode_enabled = 1
  endif
endfunction

function! s:MediumModeDisable()
  if g:mediummode_enabled
    for key in g:mediummode_motion_keys
      exec 'nunmap' key
      exec 'vunmap' key
    endfor

    augroup MediumMode
      autocmd!
    augroup END

    let g:mediummode_enabled = 0
  endif
endfunction

function! s:MediumModeToggle()
  if g:mediummode_enabled
    call s:MediumModeDisable()
  else
    call s:MediumModeEnable()
  endif
endfunction

" Command set up
command! -nargs=0 MediumModeEnable call s:MediumModeEnable()
command! -nargs=0 MediumModeDisable call s:MediumModeDisable()
command! -nargs=0 MediumModeToggle call s:MediumModeToggle()

" Initialize
if g:mediummode_enabled
  call s:MediumModeEnable(1)
endif

