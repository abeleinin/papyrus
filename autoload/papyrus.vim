" Title:        Papyrus
" Description:  Converts Markdown to PDF using Pandoc
" Last Change:  22 February 2023
" Maintainer:   Abe Leininger <https://github.com/abeleinin>

function! papyrus#PapyrusCompile()
  let current_md_file = expand('%')
  let pdf_file = substitute(current_md_file, '\.md$', '.pdf', '') 
  if g:papyrus_template == ''
    let cmd = ('pandoc --pdf-engine=' . g:papyrus_latex_engine . ' ' . g:papyrus_pandoc_args . ' -o ' . pdf_file . ' ' . current_md_file)
  else
    let cmd = ('pandoc --pdf-engine=' . g:papyrus_latex_engine . ' --template=' . g:papyrus_template . ' -o ' . pdf_file . ' ' . current_md_file)
  endif
  if has('nvim')
    call setqflist([], 'r')
    call jobstart(cmd, {'on_stderr': function('papyrus#stderr_nvim'), 
                      \ 'on_exit': function('papyrus#exit_nvim')})
  else 
    call setqflist([], 'r')
    call job_start(cmd, {'err_cb': function('papyrus#stderr_vim'), 
                       \ 'exit_cb': function('papyrus#exit_vim')})
  endif
endfunction

function! papyrus#stderr_vim(job_id, data)
    let qf_list = []
  let text = split(a:data, '\n')
  for l:item in text
    call add(qf_list, {'text': l:item, 'type': 'E'})
  endfor
  call setqflist(qf_list, 'a')
endfunction

function! papyrus#stderr_nvim(job_id, data, event)
  let qf_list = []
  for l:item in a:data
    call add(qf_list, {'text': l:item, 'type': 'E'})
  endfor
  call setqflist(qf_list, 'a')
endfunction

function! papyrus#exit_vim(job_id, exit_status)
  if a:exit_status == 0
    echo 'Papyrus: Compilation Succeeded!'
    if s:papyrus_await_view == 1
      call papyrus#PapyrusView()
      let s:papyrus_await_view = 0
    endif
  else
    echo 'Papyrus: Compilation Failed with exit status ' . a:exit_status
  endif
endfunction

function! papyrus#exit_nvim(job_id, exit_status, event)
  if a:exit_status == 0
    echo 'Papyrus: Compilation Succeeded!'
    if s:papyrus_await_view == 1
      call papyrus#PapyrusView()
      let s:papyrus_await_view = 0
    endif
  else
    echo 'Papyrus: Compilation Failed with exit status ' . a:exit_status
  endif
endfunction

function! papyrus#PapyrusAutoCompile()
  execute 'autocmd ' . g:papyrus_autocompile . ' *.md :call papyrus#PapyrusCompile()'
endfunction

function! papyrus#PapyrusView()
  let current_md_file = expand('%')
  let pdf_file = substitute(current_md_file, '\.md$', '.pdf', '')
  let cmd = (g:papyrus_viewer . ' ' . pdf_file)
  if filereadable(pdf_file)
    if has('nvim')
      call jobstart(cmd)
    else
      call job_start(cmd)
    endif
  else
    echo 'Papyrus: ' . pdf_file 'not found.'
  endif
endfunction

function! papyrus#PapyrusHeader()
  if g:papyrus_template == ''
    echo 'Papyrus: Template is not set. Set g:papyrus_template variable to use the :PapyrusHeader function'
  else
    let plugin_path = expand('<script>:p:h:h')
    let template_path = plugin_path . '/templates/md/' . g:papyrus_template . '.md' 
    let header = readfile(template_path)
    call append(0, header)
    w
  endif
endfunction

let s:papyrus_await_view = 0

function! papyrus#PapyrusNew()
  let s:papyrus_await_view = 1
  call papyrus#PapyrusHeader()
  call papyrus#PapyrusCompile()
  call papyrus#PapyrusAutoCompile()
endfunction

function! papyrus#PapyrusStart()
  let s:papyrus_await_view = 1
  call papyrus#PapyrusCompile()
  call papyrus#PapyrusAutoCompile()
endfunction

