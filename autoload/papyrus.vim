" Title:        Papyrus
" Description:  Converts Markdown to PDF using Pandoc
" Last Change:  22 February 2023 Maintainer:   Abe Leininger <https://github.com/abeleinin>

function! papyrus#PapyrusCompile(output_format)
  if !empty(a:output_format)
    let g:papyrus_output_format = a:output_format
  endif
  let current_md_file = expand('%')
  let s:output_file = substitute(current_md_file, '\.md$', '.' . g:papyrus_output_format, '') 
  if g:papyrus_output_path == ''
    let path_to_file = s:output_file 
  else
    let path_to_file = $HOME . g:papyrus_output_path . s:output_file 
  endif
  if g:papyrus_template == ''
    let cmd = ('pandoc --pdf-engine=' . g:papyrus_latex_engine . ' ' . g:papyrus_pandoc_args . ' -o ' . path_to_file . ' ' . current_md_file)
  else
    let cmd = ('pandoc --pdf-engine=' . g:papyrus_latex_engine . ' --template=' . g:papyrus_template . ' -o ' . path_to_file . ' ' . current_md_file)
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

function! papyrus#PapyrusAutoCompile(output_format)
  if !empty(a:output_format)
    let g:papyrus_output_format = a:output_format
  endif
  execute 'autocmd ' . g:papyrus_autocompile . " *.md :call papyrus#PapyrusCompile('" . g:papyrus_output_format . "')"
endfunction

function! papyrus#PapyrusView()
  let current_md_file = expand('%')
  let output_file = substitute(current_md_file, '\.md$', '.' . g:papyrus_output_format, '')
  if g:papyrus_output_path == ''
    let path_to_file = output_file 
  else
    let path_to_file = $HOME . g:papyrus_output_path . output_file 
  endif
  let cmd = (g:papyrus_viewer . ' ' . path_to_file)
  if filereadable(path_to_file)
    if has('nvim')
      call jobstart(cmd)
    else
      call job_start(cmd)
    endif
  else
    if g:papyrus_output_path == ''
      echo 'Papyrus: ' . output_file 'not found in current directory.'
    else
      echo 'Papyrus: ' . output_file 'not found in ' . g:papyrus_output_path 
    endif 
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
  call papyrus#PapyrusCompile(g:papyrus_output_format)
  call papyrus#PapyrusAutoCompile(g:papyrus_output_format)
endfunction

function! papyrus#PapyrusStart(output_format)
  let s:papyrus_await_view = 1
  call papyrus#PapyrusCompile(a:output_format)
  call papyrus#PapyrusAutoCompile(a:output_format)
endfunction

