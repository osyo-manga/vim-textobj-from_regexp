scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

let s:counter = 0
let s:map = {}


function! s:number_to_alpha(num)
	let alpha = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j']
	return alpha[a:num / 100 % 10] .  alpha[a:num / 10 % 10] . alpha[a:num % 10]
endfunction


function! s:make_map(name, pattern)
	call textobj#user#plugin(a:name, {
\		'-': {
\			'pattern': a:pattern,
\			"select" : ""
\		},
\	})
	return "\<Plug>(textobj-" . a:name . ")"
endfunction


let s:cache = {}
function! textobj#from_regexp#mapexpr(pattern)
	if has_key(s:cache, a:pattern)
		return s:cache[a:pattern]
	endif
	let name = s:number_to_alpha(len(s:cache))
	let s:cache[a:pattern] = s:make_map(name, a:pattern)
	return s:cache[a:pattern]
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
