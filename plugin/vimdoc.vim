" Title:        Vimdoc 
" Description:  Converts Markdown to PDF using Pandoc
" Last Change:  2 February 2023
" Maintainer:   Abe Leininger <https://github.com/abeleinin>

" Prevents the plugin from being loaded multiple times. If the loaded
" variable exists, do nothing more. Otherwise, assign the loaded
" variable and continue running this instance of the plugin.
if exists("g:loaded_vimdoc")
    finish
endif
let g:loaded_vimdoc = 1

" Exposes the plugin's functions for use as commands in Vim.
command! -nargs=0 VimdocCompile execute vimdoc#VimdocCompile()
command! -nargs=0 VimdocAutoCompile execute vimdoc#VimdocAutoCompile()
command! -nargs=0 VimdocOpen execute vimdoc#VimdocOpen()
  
