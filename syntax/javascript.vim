" Vim syntax file
"      Language: JavaScript
"    Maintainer: Jose Elera Campana <https://github.com/jelera>
" Last Modified: Mon 09 Dec 2013 01:20:46 PM CST
"       Version: 0.8.1
"       Changes: Go to https://github.com/jelera/vim-javascript-syntax for
"                recent changes.
"       Credits: Zhao Yi, Claudio Fleiner, Scott Shattuck (This file is based
"                on their hard work), gumnos (From the #vim IRC Channel in
"                Freenode)

if !exists("main_syntax")
	if version < 600
		syntax clear
	elseif exists("b:current_syntax")
		finish
	endif
	let main_syntax = 'javascript'
endif

"" Remove dollar sign from identifier when embedded in a PHP file
if &filetype == 'javascript'
	setlocal iskeyword+=$
endif

syntax sync fromstart

" Comments
syntax keyword javaScriptCommentTodo      TODO FIXME XXX TBD contained
syntax match   javaScriptLineComment      "\/\/.*" contains=@Spell,javaScriptCommentTodo
syntax match   javaScriptCommentSkip      "^[ \t]*\*\($\|[ \t]\+\)"
syntax region  javaScriptComment          start="/\*"  end="\*/" contains=@Spell,javaScriptCommentTodo

" " Strings, Numbers and Regex Highlight {{{
syntax match   javaScriptSpecial          "\\\d\d\d\|\\."
syntax region  javaScriptString	          start=+"+  skip=+\\\\\|\\"+  end=+"\|$+	contains=javaScriptSpecial,@htmlPreproc
syntax region  javaScriptString	          start=+'+  skip=+\\\\\|\\'+  end=+'\|$+	contains=javaScriptSpecial,@htmlPreproc

syntax match   javaScriptSpecialCharacter "'\\.'"
" syntax match   javaScriptNumber           "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syntax region  javaScriptRegexpString     start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gim]\{0,2\}\s*$+ end=+/[gim]\{0,2\}\s*[;.,)\]}]+me=e-1 contains=@htmlPreproc oneline
syntax match   javaScriptFloat          /\<-\=\%(\d\+\.\d\+\|\d\+\.\|\.\d\+\)\%([eE][+-]\=\d\+\)\=\>/

" ES6 String Interpolation {{{
syntax match  javaScriptTemplateDelim    "\${\|}" contained
syntax region javaScriptTemplateVar      start=+${+ end=+}+                        contains=javaScriptTemplateDelim keepend
syntax region javaScriptTemplateString   start=+`+  skip=+\\\(`\|$\)+  end=+`+     contains=javaScriptTemplateVar,javaScriptSpecial keepend

if main_syntax == "javascript"
	syntax sync clear
	syntax sync ccomment javaScriptComment minlines=200
endif

" }}}
" Highlight links {{{
" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_javascript_syn_inits")
	if version < 508
		let did_javascript_syn_inits = 1
		command -nargs=+ HiLink hi link <args>
	else
		command -nargs=+ HiLink hi def link <args>
	endif
	HiLink javaScriptComment                Comment
	HiLink javaScriptLineComment            Comment
	HiLink javaScriptDocComment             Comment
	HiLink javaScriptCommentTodo            Todo
	" HiLink javaScriptString                 String
	" HiLink javaScriptRegexpString           String

	" HiLink javaScriptNumber                 Number
	" HiLink javaScriptFloat                  Number
	delcommand HiLink
endif

let b:current_syntax = "javascript"
if main_syntax == 'javascript'
	unlet main_syntax
endif
