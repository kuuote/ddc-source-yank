let s:register = []

function ddc#source#yank#get() abort
  return s:register
endfunction

function ddc#source#yank#register(type) abort
  let a = getpos("'[")
  let b = getpos("']")
  let data = getline(a[1], b[1])
  if a:type ==# 'char'
    let data[-1] = data[-1][:b[2] - 1]
    let data[0] = data[0][a[2] - 1:]
  endif
  if a:type ==# 'block'
    call map(data, 'v:val[:b[2] - 1][a[2] - 1:]')
  endif
  call extend(s:register, data)
  echo len(data) .. ' lines yanked'
endfunction

function ddc#source#yank#clear() abort
  let s:register = []
  echo 'register cleared'
endfunction

finish
nnoremap cd <Cmd>call ddc#source#yank#clear()<CR>
nnoremap cy <Cmd>set operatorfunc=ddc#source#yank#register<CR>g@
nnoremap cycy <Cmd>set operatorfunc=ddc#source#yank#register<CR>g@_
onoremap cy <Cmd>set operatorfunc=ddc#source#yank#register<CR>g@
xnoremap Y <Cmd>set operatorfunc=ddc#source#yank#register<CR>g@
