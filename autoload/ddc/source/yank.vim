let s:register = []

function ddc#source#yank#get() abort
  return s:register
endfunction

let s:map = #{ char: 'v', line: 'V', block: "\<C-v>" }

function ddc#source#yank#register(type) abort
  let data = getregion(getpos("'["), getpos("']"), #{ type: s:map[a:type] })->map('trim(v:val)')
  call extend(s:register, data)
  echo len(data) .. ' lines yanked'
endfunction

function ddc#source#yank#clear() abort
  let s:register = []
  echo 'register cleared'
endfunction
