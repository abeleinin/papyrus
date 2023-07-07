" Title:        Papyrus
" Description:  Converts Markdown to PDF using Pandoc
" Last Change:  07 July 2023
" Maintainer:   Abe Leininger <https://github.com/abeleinin>

if exists('g:loaded_papyrus')
    finish
endif
let g:loaded_papyrus = 1

if !exists('g:papyrus_template')
  let g:papyrus_template = ''
endif

if !exists('g:papyrus_pandoc_args')
  let g:papyrus_pandoc_args = ''
endif

if !exists('g:papyrus_autocompile')
  let g:papyrus_autocompile = 'BufWrite'
endif

if !exists('g:papyrus_output_format')
  let g:papyrus_output_format = 'pdf'
endif

if !exists('g:papyrus_output_path')
  let g:papyrus_output_path = ''
endif

command! -nargs=* PapyrusCompile call papyrus#PapyrusCompile(<q-args>)
command! -nargs=* PapyrusAutoCompile call papyrus#PapyrusAutoCompile(<q-args>)
command! -nargs=0 PapyrusView call papyrus#PapyrusView()
command! -nargs=0 PapyrusHeader call papyrus#PapyrusHeader()
command! -nargs=0 PapyrusNew call papyrus#PapyrusNew()
command! -nargs=* PapyrusStart call papyrus#PapyrusStart(<q-args>)

