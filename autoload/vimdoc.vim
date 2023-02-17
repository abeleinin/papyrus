" Title:        Vimdoc 
" Description:  Converts Markdown to PDF using Pandoc
" Last Change:  16 February 2023
" Maintainer:   Abe Leininger <https://github.com/abeleinin>

function! vimdoc#VimdocCompile()
  let current_md_file = expand("%")
  let pdf_file = substitute(current_md_file, '\.md$', '.pdf', '')
  let cmd = ('pandoc --pdf-engine=' . g:vimdoc_latex_engine . ' --template=' . g:vimdoc_template . ' -o ' . pdf_file . ' ' . current_md_file)
  if has('nvim')
    call jobstart(cmd, {'on_stdout': function('vimdoc#stdout'),
                      \ 'on_stderr': function('vimdoc#stderr'), 
                      \ 'on_exit': function('vimdoc#exit')})
  else 
    call job_start(cmd, {'out_cb': function('vimdoc#stdout'),
                       \ 'err_cb': function('vimdoc#stderr'), 
                       \ 'exit_cb': function('vimdoc#exitVim')})
  endif
endfunction

function! vimdoc#stdout(job_id, data, event)
endfunction

function! vimdoc#stderr(job_id, data, event)
  for msg in a:data
    echomsg msg
  endfor
endfunction

function! vimdoc#exitVim(job_id, exit_status)
  if a:exit_status == 0
    echo "Vimdoc: Compilation Succeeded!"
  else
    echo "Vimdoc: Compilation Failed with exit status: " . a:exit_status
  endif
endfunction

function! vimdoc#exit(job_id, exit_status, event)
  if a:exit_status == 0
    echo "Vimdoc: Compilation Succeeded!"
  else
    echo "Vimdoc: Compilation Failed with exit status: " . a:exit_status
  endif
endfunction

function! vimdoc#VimdocAutoCompile()
  autocmd BufWrite *.md :call vimdoc#VimdocCompile()
endfunction

function! vimdoc#VimdocOpen()
  let current_md_file = expand("%")
  let pdf_file = substitute(current_md_file, '\.md$', '.pdf', '')
  let cmd = (g:vimdoc_viewer . ' ' . pdf_file)
  if has('nvim')
    call jobstart(cmd)
  else
    call job_start(cmd)
  endif
endfunction

function! vimdoc#VimdocHeader()
  let cmd = expand($HOME) . "/.local/share/nvim/plugged/vimdoc/templates/md/" . g:vimdoc_template . ".md"
  let content = readfile(cmd)
  call append(0, content)
endfunction

function! vimdoc#VimdocNew()
  call vimdoc#VimdocHeader()
  call vimdoc#VimdocCompile()
  call vimdoc#VimdocOpen()
  call vimdoc#VimdocAutoCompile()
  w
endfunction

function! vimdoc#VimdocStart()
  call vimdoc#VimdocCompile()
  call vimdoc#VimdocOpen()
  call vimdoc#VimdocAutoCompile()
  w
endfunction

