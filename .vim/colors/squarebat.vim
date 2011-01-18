" Author: SquareHimself
" Theme: squarebat

" Description: 
"       Modified version of the wombat theme.
"       Includes custom colors and support for
"       256-color terminals.


set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "squarebat"


" Vim >= 7.0 specific colors
if version >= 700
  hi CursorLine         guibg=#2d2d2d ctermbg=237
  hi CursorColumn       guibg=#2d2d2d ctermbg=237
"  hi MatchParen         guifg=#f6f3e8 guibg=#857b6f gui=bold ctermfg=253 ctermbg=238
  hi MatchParen         guifg=#f6f3e8 guibg=#857b6f gui=bold ctermfg=253 ctermbg=238 cterm=bold
  hi Pmenu 		guifg=#f6f3e8 guibg=#444444 ctermfg=253 ctermbg=238
  hi PmenuSel 	        guifg=#000000 guibg=#cae682 ctermfg=16 ctermbg=107
endif

" General colors
hi Cursor 		guifg=NONE    guibg=#656565 gui=none ctermbg=241
hi Normal 		guifg=#f6f3e8 guibg=#1f1f1f gui=none ctermfg=252 ctermbg=234
hi NonText 		guifg=#808080 guibg=#303030 gui=none ctermfg=244 ctermbg=236
hi LineNr 		guifg=#857b6f guibg=#000000 gui=none ctermfg=242 ctermbg=16
hi StatusLine 	        guifg=#f6f3e8 guibg=#444444 gui=italic ctermbg=238
hi StatusLineNC         guifg=#857b6f guibg=#444444 gui=none ctermfg=59 ctermbg=238
hi VertSplit    	guifg=#444444 guibg=#444444 gui=none ctermfg=238 ctermbg=238
hi Folded 		guibg=#384048 guifg=#a0a8b0 gui=none ctermfg=17 ctermbg=67
"hi Title		guifg=#f6f3e8 guibg=NONE    gui=bold ctermfg=253
hi Title		guifg=#f6f3e8 guibg=NONE    gui=bold ctermfg=253 cterm=bold
hi Visual		guifg=#f6f3e8 guibg=#444444 gui=none ctermfg=252 ctermbg=238
hi SpecialKey	        guifg=#626282 guibg=NONE    gui=none ctermfg=60

" Syntax highlighting
hi Comment 		guifg=#235466 gui=italic ctermfg=23
hi Todo 		guifg=#8f8f8f gui=italic ctermfg=245
hi Constant     	guifg=#e5786d gui=none ctermfg=167
hi String 		guifg=#95e454 gui=none ctermfg=113
hi Identifier   	guifg=#cae682 gui=none ctermfg=150
"hi Function 	        guifg=#ffffff gui=bold ctermfg=208
hi Function             guifg=#ffffff gui=bold ctermfg=255 cterm=bold
hi Type 		guifg=#cae682 gui=none ctermfg=150
hi Statement    	guifg=#8aa6f2 gui=none ctermfg=67
hi Keyword		guifg=#8ac6f2 gui=none ctermfg=69
hi PreProc 		guifg=#e5786d gui=none ctermfg=167
hi Number		guifg=#e5786d gui=none ctermfg=167
hi Special		guifg=#e7f6da gui=none ctermfg=157

