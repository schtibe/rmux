" Basic initialization for RMUX change if need, add your settings
set nocp
let &rtp .= expand(",$HOME/.rmux-$RMUXID/vim,$HOME/.rmux-$RMUDID/vim/after")
let $PYTHONPATH .= expand(":$HOME/.rmux-$RMUX/jedi")

call pathogen#infect()
call pathogen#helptags()

syntax on
filetype plugin on


" If you do not change above chances are good you can merge any upstream
" changes
"
" Your settings
