" Title:        Papyrus
" Description:  Converts Markdown to PDF using Pandoc
" Last Change:  19 February 2023
" Maintainer:   Abe Leininger <https://github.com/abeleinin>

function! papyrus#PapyrusCompile()
  let current_md_file = expand("%")
  let pdf_file = substitute(current_md_file, '\.md$', '.pdf', '')
  let cmd = ('pandoc --pdf-engine=' . g:papyrus_latex_engine . ' --template=' . g:papyrus_template . ' -o ' . pdf_file . ' ' . current_md_file)
  if has('nvim')
    call jobstart(cmd, {'on_stdout': function('papyrus#stdout'),
                      \ 'on_stderr': function('papyrus#stderr'), 
                      \ 'on_exit': function('papyrus#exitnvim')})
  else 
    call job_start(cmd, {'out_cb': function('papyrus#stdout'),
                       \ 'err_cb': function('papyrus#stderr'), 
                       \ 'exit_cb': function('papyrus#exitvim')})
  endif
endfunction

function! papyrus#stdout(job_id, data, event)
endfunction

function! papyrus#stderr(job_id, data, event)
  for msg in a:data
    echomsg msg
  endfor
endfunction

function! papyrus#exitvim(job_id, exit_status)
  if a:exit_status == 0
    echo "Papyrus: Compilation Succeeded!"
  else
    echo "Papyrus: Compilation Failed with exit status: " . a:exit_status
  endif
endfunction

function! papyrus#exitnvim(job_id, exit_status, event)
  if a:exit_status == 0
    echo "Papyrus: Compilation Succeeded!"
  else
    echo "Papyrus: Compilation Failed with exit status: " . a:exit_status
  endif
endfunction

function! papyrus#PapyrusAutoCompile()
  autocmd BufWrite *.md :call papyrus#PapyrusCompile()
endfunction

function! papyrus#PapyrusOpen()
  let current_md_file = expand("%")
  let pdf_file = substitute(current_md_file, '\.md$', '.pdf', '')
  let cmd = (g:papyrus_viewer . ' ' . pdf_file)
  if has('nvim')
    call jobstart(cmd)
  else
    call job_start(cmd)
  endif
endfunction

function! papyrus#PapyrusHeader()
  let cmd = expand($HOME) . "/.local/share/nvim/plugged/papyrus/templates/md/" . g:papyrus_template . ".md"
  let content = readfile(cmd)
  call append(0, content)
  w
endfunction

function! papyrus#PapyrusNew()
  call papyrus#PapyrusHeader()
  call papyrus#PapyrusCompile()
  sleep 2500m
  call papyrus#PapyrusOpen()
  call papyrus#PapyrusAutoCompile()
endfunction

function! papyrus#PapyrusStart()
  call papyrus#PapyrusCompile()
  call papyrus#PapyrusOpen()
  call papyrus#PapyrusAutoCompile()
  w
endfunction

