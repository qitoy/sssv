function s:sssv() abort
  tabedit

  setlocal filetype=sssv
  setlocal nonumber

  let s:ls = &laststatus
  set laststatus=0
  let s:stal = &showtabline
  set showtabline=0
  let s:fcs = &fillchars
  set fillchars=eob:\ 
  let s:t_ve = &t_ve
  set t_ve=

  let s:cursor = [1, 1]
  let s:direction = [1, 1]
  let s:height = &lines
  let s:width = &columns

  nnoremap <buffer> q <cmd>call <SID>exit()<CR>

  call timer_start(50, 's:move', #{ repeat: -1 })
endfunction

function s:move(timer) abort
  if &filetype !=# 'sssv'
    call timer_stop(a:timer)
    return
  endif

  call popup_create(
  \ ['＿人人人人人人人＿', '＞　それはそう　＜', '￣Y^Y^Y^Y^Y^Y^Y￣'], #{
  \ line: s:cursor[0],
  \ col: s:cursor[1],
  \ highlight: 'Normal',
  \ time: 50,
  \})

  let s:cursor[0] += s:direction[0]
  let s:cursor[1] += s:direction[1]

  if s:cursor[0] == 1 || s:cursor[0] == s:height - 2
    let s:direction[0] *= -1
  endif
  if s:cursor[1] == 1 || s:cursor[1] == s:width - 17
    let s:direction[1] *= -1
  endif
endfunction

function s:exit() abort
  wincmd q
  let &laststatus = s:ls
  let &showtabline = s:stal
  let &fillchars = s:fcs
  let &t_ve = s:t_ve
endfunction

command! SSSV call <SID>sssv()
