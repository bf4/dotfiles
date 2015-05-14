" Vim color file - inkpot
" Generated by http://bytefluent.com/vivify 2012-02-06
set background=dark

if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

let g:colors_name = "inkpot"

if !has("gui_running") && &t_Co != 88 && &t_Co != 256
	finish
endif

" functions {{{
" returns an approximate grey index for the given grey level
fun <SID>grey_number(x)
	if &t_Co == 88
		if a:x < 23
			return 0
		elseif a:x < 69
			return 1
		elseif a:x < 103
			return 2
		elseif a:x < 127
			return 3
		elseif a:x < 150
			return 4
		elseif a:x < 173
			return 5
		elseif a:x < 196
			return 6
		elseif a:x < 219
			return 7
		elseif a:x < 243
			return 8
		else
			return 9
		endif
	else
		if a:x < 14
			return 0
		else
			let l:n = (a:x - 8) / 10
			let l:m = (a:x - 8) % 10
			if l:m < 5
				return l:n
			else
				return l:n + 1
			endif
		endif
	endif
endfun

" returns the actual grey level represented by the grey index
fun <SID>grey_level(n)
	if &t_Co == 88
		if a:n == 0
			return 0
		elseif a:n == 1
			return 46
		elseif a:n == 2
			return 92
		elseif a:n == 3
			return 115
		elseif a:n == 4
			return 139
		elseif a:n == 5
			return 162
		elseif a:n == 6
			return 185
		elseif a:n == 7
			return 208
		elseif a:n == 8
			return 231
		else
			return 255
		endif
	else
		if a:n == 0
			return 0
		else
			return 8 + (a:n * 10)
		endif
	endif
endfun

" returns the palette index for the given grey index
fun <SID>grey_color(n)
	if &t_Co == 88
		if a:n == 0
			return 16
		elseif a:n == 9
			return 79
		else
			return 79 + a:n
		endif
	else
		if a:n == 0
			return 16
		elseif a:n == 25
			return 231
		else
			return 231 + a:n
		endif
	endif
endfun

" returns an approximate color index for the given color level
fun <SID>rgb_number(x)
	if &t_Co == 88
		if a:x < 69
			return 0
		elseif a:x < 172
			return 1
		elseif a:x < 230
			return 2
		else
			return 3
		endif
	else
		if a:x < 75
			return 0
		else
			let l:n = (a:x - 55) / 40
			let l:m = (a:x - 55) % 40
			if l:m < 20
				return l:n
			else
				return l:n + 1
			endif
		endif
	endif
endfun

" returns the actual color level for the given color index
fun <SID>rgb_level(n)
	if &t_Co == 88
		if a:n == 0
			return 0
		elseif a:n == 1
			return 139
		elseif a:n == 2
			return 205
		else
			return 255
		endif
	else
		if a:n == 0
			return 0
		else
			return 55 + (a:n * 40)
		endif
	endif
endfun

" returns the palette index for the given R/G/B color indices
fun <SID>rgb_color(x, y, z)
	if &t_Co == 88
		return 16 + (a:x * 16) + (a:y * 4) + a:z
	else
		return 16 + (a:x * 36) + (a:y * 6) + a:z
	endif
endfun

" returns the palette index to approximate the given R/G/B color levels
fun <SID>color(r, g, b)
	" get the closest grey
	let l:gx = <SID>grey_number(a:r)
	let l:gy = <SID>grey_number(a:g)
	let l:gz = <SID>grey_number(a:b)

	" get the closest color
	let l:x = <SID>rgb_number(a:r)
	let l:y = <SID>rgb_number(a:g)
	let l:z = <SID>rgb_number(a:b)

	if l:gx == l:gy && l:gy == l:gz
		" there are two possibilities
		let l:dgr = <SID>grey_level(l:gx) - a:r
		let l:dgg = <SID>grey_level(l:gy) - a:g
		let l:dgb = <SID>grey_level(l:gz) - a:b
		let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
		let l:dr = <SID>rgb_level(l:gx) - a:r
		let l:dg = <SID>rgb_level(l:gy) - a:g
		let l:db = <SID>rgb_level(l:gz) - a:b
		let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
		if l:dgrey < l:drgb
			" use the grey
			return <SID>grey_color(l:gx)
		else
			" use the color
			return <SID>rgb_color(l:x, l:y, l:z)
		endif
	else
		" only one possibility
		return <SID>rgb_color(l:x, l:y, l:z)
	endif
endfun

" returns the palette index to approximate the 'rrggbb' hex string
fun <SID>rgb(rgb)
	let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
	let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
	let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0
	return <SID>color(l:r, l:g, l:b)
endfun

" sets the highlighting for the given group
fun <SID>X(group, fg, bg, attr)
	if a:fg != ""
		exec "hi ".a:group." guifg=#".a:fg." ctermfg=".<SID>rgb(a:fg)
	endif
	if a:bg != ""
		exec "hi ".a:group." guibg=#".a:bg." guisp=#".a:bg." ctermbg=".<SID>rgb(a:bg)
	endif
	if a:attr != ""
		if a:attr == 'italic'
			exec "hi ".a:group." gui=".a:attr." cterm=none"
		else
			exec "hi ".a:group." gui=".a:attr." cterm=".a:attr
		endif
	endif
endfun
" }}}
call <SID>X("Boolean","808bed","","none")
call <SID>X("CTagsClass","e2e4e5","","none")
call <SID>X("CTagsGlobalConstant","e2e4e5","","none")
call <SID>X("CTagsGlobalVariable","e2e4e5","","none")
call <SID>X("CTagsImport","e2e4e5","","none")
call <SID>X("CTagsMember","e2e4e5","","none")
call <SID>X("Character","ffcd8b","","none")
call <SID>X("Comment","cd8b00","","none")
call <SID>X("Conditional","ff8bff","","none")
call <SID>X("Constant","ffcd8b","","none")
call <SID>X("Cursor","404040","8b8bff","none")
call <SID>X("CursorColumn","e2e4e5","","none")
call <SID>X("CursorLine","e2e4e5","","none")
call <SID>X("Debug","c080d0","","none")
call <SID>X("Define","409090","","none")
call <SID>X("DefinedName","e2e4e5","","none")
call <SID>X("Delimiter","c080d0","","none")
call <SID>X("DiffAdd","ffffcd","306d30","none")
call <SID>X("DiffChange","ffffcd","306b8f","none")
call <SID>X("DiffDelete","ffffcd","6d3030","none")
call <SID>X("DiffText","f0ad6d","","none")
call <SID>X("Directory","00ff8b","","none")
call <SID>X("EnumerationName","e2e4e5","","none")
call <SID>X("EnumerationValue","e2e4e5","","none")
call <SID>X("Error","ffffff","6e2e2e","none")
call <SID>X("ErrorMsg","ffffff","ce4e4e","none")
call <SID>X("Exception","ff8bff","","none")
call <SID>X("Float","f0ad6d","","none")
call <SID>X("FoldColumn","8b8bcd","2e2e2e","none")
call <SID>X("Folded","cfcfcd","4b208f","none")
call <SID>X("Function","ff8bff","","none")
call <SID>X("Identifier","ff8bff","","none")
call <SID>X("Ignore","e2e4e5","","none")
call <SID>X("IncSearch","303030","cd8b60","none")
call <SID>X("Include","409090","","none")
call <SID>X("Keyword","ff8bff","","none")
call <SID>X("Label","ff8bff","","none")
call <SID>X("LineNr","8b8bcd","2e2e2e","none")
call <SID>X("LocalVariable","e2e4e5","","none")
call <SID>X("Macro","409090","","none")
call <SID>X("MatchParen","404040","8fff8b","none")
call <SID>X("ModeMsg","7e7eae","","none")
call <SID>X("MoreMsg","7e7eae","","none")
call <SID>X("NonText","8b8bcd","","none")
call <SID>X("Normal","cfbfad","1e1e27","none")
call <SID>X("Number","f0ad6d","","none")
call <SID>X("Operator","ff8bff","","none")
call <SID>X("PMenu","eeeeee","4e4e8f","none")
call <SID>X("PMenuSbar","eeeeee","6e6eaf","none")
call <SID>X("PMenuSel","eeeeee","2e2e3f","none")
call <SID>X("PMenuThumb","eeeeee","6e6eaf","none")
call <SID>X("PreCondit","409090","","none")
call <SID>X("PreProc","409090","","none")
call <SID>X("Question","ffcd00","","none")
call <SID>X("Repeat","ff8bff","","none")
call <SID>X("Search","303030","cd8b60","none")
call <SID>X("SignColumn","e2e4e5","","none")
call <SID>X("Special","c080d0","","none")
call <SID>X("SpecialChar","c080d0","404040","none")
call <SID>X("SpecialComment","c080d0","","none")
call <SID>X("SpecialKey","ab60ed","","none")
call <SID>X("SpellBad","e2e4e5","","none")
call <SID>X("SpellCap","e2e4e5","","none")
call <SID>X("SpellLocal","e2e4e5","","none")
call <SID>X("SpellRare","e2e4e5","","none")
call <SID>X("Statement","808bed","","none")
call <SID>X("StatusLine","b9b9b9","3e3e5e","none")
call <SID>X("StatusLineNC","b9b9b9","3e3e5e","none")
call <SID>X("StorageClass","ff8bff","","none")
call <SID>X("String","ffcd8b","404040","none")
call <SID>X("Structure","ff8bff","","none")
call <SID>X("TabLine","e2e4e5","","none")
call <SID>X("TabLineFill","e2e4e5","","none")
call <SID>X("TabLineSel","e2e4e5","","none")
call <SID>X("Tag","c080d0","","none")
call <SID>X("Title","af4f4b","","none")
call <SID>X("Todo","303030","d0a060","none")
call <SID>X("Type","ff8bff","","none")
call <SID>X("Typedef","ff8bff","","none")
call <SID>X("Underlined","df9f2d","","none")
call <SID>X("Union","e2e4e5","","none")
call <SID>X("VertSplit","b9b9b9","3e3e5e","none")
call <SID>X("Visual","eeeeee","4e4e8f","none")
call <SID>X("VisualNOS","e2e4e5","","none")
call <SID>X("WarningMsg","ffffff","ce8e4e","none")
call <SID>X("WildMenu","eeeeee","6e6eaf","none")
call <SID>X("pythonBuiltin","cfbfad","","none")
call <SID>X("JavaScriptStrings","e2e4e5","","none")
call <SID>X("phpStringSingle","e2e4e5","","none")
call <SID>X("phpStringDouble","e2e4e5","","none")
call <SID>X("htmlString","cfbfad","","none")
call <SID>X("htmlTagName","cfbfad","","none")
" delete functions {{{
delf <SID>X
delf <SID>rgb
delf <SID>color
delf <SID>rgb_color
delf <SID>rgb_level
delf <SID>rgb_number
delf <SID>grey_color
delf <SID>grey_level
delf <SID>grey_number
" }}}


