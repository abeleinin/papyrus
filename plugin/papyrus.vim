" Title:        Papyrus
" Description:  Converts Markdown to PDF using Pandoc
" Last Change:  19 February 2023
" Maintainer:   Abe Leininger <https://github.com/abeleinin>

" Prevents the plugin from being loaded multiple times. If the loaded
" variable exists, do nothing more. Otherwise, assign the loaded
" variable and continue running this instance of the plugin.
if exists("g:loaded_papyrus")
    finish
endif
let g:loaded_papyrus = 1

" Exposes the plugin's functions for use as commands in Vim.
command! -nargs=0 PapyrusCompile execute papyrus#PapyrusCompile()
command! -nargs=0 PapyrusAutoCompile execute papyrus#PapyrusAutoCompile()
command! -nargs=0 PapyrusOpen execute papyrus#PapyrusOpen()
command! -nargs=0 PapyrusHeader execute papyrus#PapyrusHeader()
command! -nargs=0 PapyrusNew execute papyrus#PapyrusNew()
command! -nargs=0 PapyrusStart execute papyrus#PapyrusStart()
  
