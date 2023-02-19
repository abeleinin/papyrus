# Vimdoc

![Screenshot example of Vimdoc](https://github.com/abeleinin/vimdoc/blob/main/example.png?raw=true)

Theme: [material default-community](https://github.com/kaicataldo/material.vim)

Vimdoc is a markdown to PDF conversion plugin that allows users to convert a markdown file into a Latex styled PDF document. By utilizing the [Pandoc](https://pandoc.org/) library it allows users to create beautiful PDF documents while only using markdown syntax.


## Table of contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Configuration](#configuration)
- [Templates](#templates)
- [Commands](#commands)

## Requirements

- [Pandoc](https://pandoc.org/installing.html)
- [Python 3.9 +](https://www.python.org/downloads/)
- [Latex Engine](https://pandoc.org/MANUAL.html#option--pdf-engine)
  - Supported Engines: pdflatex, lualatex, xelatex, latexmk, tectonic, wkhtmltopdf, weasyprint, pagedjs-cli, prince, context, and pdfroff.

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
" Specify a Latex Engine from the supported list above:
let g:vimdoc_latex_engine = 'xelatex'

" Viewer option
let g:vimdoc_viewer = 'zathura'

" Template option
let g:vimdoc_template = 'lecture'

" Easy access keybinding for compiling and viewing documents
map <leader>vc :VimdocCompile<CR>
map <leader>va :VimdocAutoCompile<CR>
map <leader>vo :VimdocOpen<CR>
map <leader>vs :VimdocStart<CR>
```

## Templates

Currently, Vimdoc supports two templates. However, custom template files can be created using [pandoc-latex-templates](https://github.com/Wandmalfarbe/pandoc-latex-template). 
 
### Default


### Lecture 


## Commands

`:VimdocCompile`: Executes a terminal command to compile the current open `md` file into a `pdf` with the same name.

`:VimdocAutoCompile`: Executes a `autocmd` command that automatically runs `:VimdocCompile` whenever the file is saved.

`:VimdocOpen`: Opens the current file in the specified pdf viewer from the `g:vimdoc_viewer` variable.

`:VimdocStart`: Runs `:VimdocOpen` and `:VimdocAutoCompile` 

`:VimdocHeader`: Copies the specified template file from the `md` templates for the specified template that is set using the `g:vimdoc_template` variable.

`:VimdocNew`: Runs `:VimdocHeader` and `:VimdocStart` to create a new editing environment from the specified header.

