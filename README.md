# Vimdoc

![Screenshot example of Vimdoc](https://github.com/abeleinin/vimdoc/blob/main/example.png?raw=true)

Theme: [material default-community](https://github.com/kaicataldo/material.vim)

Vimdoc is a markdown to PDF conversion plugin that allows users to convert a markdown file into a Latex styled PDF document. By utilizing the [Pandoc](https://pandoc.org/) library it allows users to create beautiful PDF documents while only using markdown syntax.


## Table of contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Configuration](#configuration)
- [Templates](#Templates)

## Requirements

- [Pandoc](https://pandoc.org/installing.html)
- [Python 3.9 +](https://www.python.org/downloads/)
- [Latex Distribution](https://miktex.org/download)

## Installation

```vim
" vim-plug
Plug 'abeleinin/vimdoc'

" packer.nvim
use 'abeleinin/vimdoc'

" vundle
Plugin 'abeleinin/vimdoc'
```


## Configuration

```vim
" Viewer option
let g:vimdoc_viewer = 'zathura'

" Template option
let g:vimdoc_template = 'notes.latex'

" Easy access keybinding for compiling and viewing documents
map <leader>vc :VimdocCompile<CR>
map <leader>va :VimdocAutoCompile<CR>
map <leader>vo :VimdocOpen<CR>
```

## Templates


