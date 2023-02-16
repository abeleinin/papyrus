function! vimdoc#VimdocCompile()
  let current_md_file = expand("%")
  let pdf_file = substitute(current_md_file, '\.md$', '.pdf', '')
  let cmd = ('pandoc --pdf-engine=xelatex --template=' . g:vimdoc_template . ' -o ' . pdf_file . ' ' . current_md_file)
  call jobstart(cmd, {'on_stdout': function('vimdoc#stdout'),
                    \ 'on_stderr': function('vimdoc#stderr'), 
                    \ 'on_exit': function('vimdoc#exit')})
endfunction

function! vimdoc#stdout(job_id, data, event)
  echomsg a:data
endfunction

function! vimdoc#stderr(job_id, data, event)
  for msg in a:data
    echomsg msg
  endfor
endfunction

function! vimdoc#exit(job_id, data, event)
  if a:data == 0
    echo "Vimdoc: Compilation Succeeded!"
  else
    echo "Vimdoc: Compilation Failed with exit status: " . a:data
  endif
endfunction

function! vimdoc#VimdocAutoCompile()
  autocmd BufWrite *.md :call vimdoc#VimdocCompile()
endfunction

function! vimdoc#VimdocOpen()
  let current_md_file = expand("%")
  let pdf_file = substitute(current_md_file, '\.md$', '.pdf', '')
  let cmd = (g:vimdoc_viewer . ' ' . pdf_file)
  call jobstart(cmd)
endfunction

