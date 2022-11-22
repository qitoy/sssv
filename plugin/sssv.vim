function s:sssv() abort
  tabedit sssv://sssv

  let s:cursor = [1, 1]
  let s:direction = [1, 1]
  let s:height = &lines
  let s:width = &columns

  nnoremap <buffer> q <cmd>wq<CR>

  call timer_start(50, 's:move', #{ repeat: -1 })
endfunction

function s:move(timer) abort
  call popup_clear()

  if expand('%') !=# 'sssv://sssv'
    call timer_stop(a:timer)
    return
  endif

  let l:popup = popup_create(
  \ ['＿人人人人人人人＿', '＞　それはそう　＜', '￣Y^Y^Y^Y^Y^Y^Y￣'], #{
  \ line: s:cursor[0],
  \ col: s:cursor[1],
  \ highlight: 'Normal',
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

command! SSSV call <SID>sssv()
