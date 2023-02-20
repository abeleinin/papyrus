# Papyrus

Easily convert Markdown notes into beautiful Latex PDF's

![Screenshot example of Papyrus](https://github.com/abeleinin/papyrus/blob/main/examples/example.png?raw=true)

Theme: [material default-community](https://github.com/kaicataldo/material.vim)

Papyrus is a markdown to PDF conversion plugin that allows users to convert a markdown file into a Latex styled PDF document. By utilizing the [Pandoc](https://pandoc.org/) library it allows users to create beautiful PDF documents while only using markdown syntax.

## Table of contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Configuration](#configuration)
- [Templates](#templates)
- [Commands](#commands)

## Requirements

- [Pandoc 2.x](https://pandoc.org/installing.html)
- [Python 3](https://www.python.org/downloads/)
- [Latex Engine](https://pandoc.org/MANUAL.html#option--pdf-engine)
  - Supported Engines: pdflatex, lualatex, xelatex, latexmk, tectonic, wkhtmltopdf, weasyprint, pagedjs-cli, prince, context, and pdfroff.

## Installation

Add the following to your `.vimrc` or `init.vim` file to install the plug in using any plugin manager.

```vim
" vim-plug
Plug 'abeleinin/papyrus'

" packer.nvim
use 'abeleinin/papyrus'

" vundle
Plugin 'abeleinin/papyrus'
```

For template support it's necessary to move the template files from `$PWD/papyrus/templates/latex` into the `$HOME/.local/share/pandoc/templates`. Either do this manually or run the following bash command:

```bash
bash install.sh
```

## Configuration

After installation, copy the following configurations into your `.vimrc` or `init.vim` file to configure Papyrus to your specifications.

```vim
" Specify a Latex Engine from the supported list above:
let g:papyrus_latex_engine = 'xelatex'

" Specify any built-in pdf viewing option. It's recommended to use 
" a pdf viewer with automatic updates on save.
let g:papyrus_viewer = 'zathura'

" Specify a Template option from the supported templates
let g:papyrus_template = 'lecture'

" Recommened keybinding for compiling and viewing documents
map <leader>pc :PapyrusCompile<CR>
map <leader>pa :PapyrusAutoCompile<CR>
map <leader>po :PapyrusOpen<CR>
map <leader>ps :PapyrusStart<CR>
```

## Templates

Currently, Papyrus supports two templates which you can view in the [pdf directory](https://github.com/abeleinin/papyrus/tree/main/templates/pdf). However, custom template files can be created using [pandoc-latex-templates](https://github.com/Wandmalfarbe/pandoc-latex-template). If you create a cool template feel free to submit a pull request!
 
### Default

![Default Notes Template](https://drive.google.com/file/d/1Sb21ZZzGyPPVsLazesxSIxbQiTguYL2C/view?usp=sharing)

### Lecture 

![Lecture Notes Template](https://drive.google.com/file/d/1RuoRXyQvpiVZEQMVOw75ii20ctQxmbrt/view?usp=sharing)


## Commands

### :PapyrusCompile

Executes a terminal command to compile the current open `md` file into a `pdf` with the same name.

### :PapyrusAutoCompile

Executes a `autocmd` command that automatically runs `:PapyrusCompile` whenever the file is saved.

### :PapyrusOpen 

Opens the current file in the specified pdf viewer from the `g:papyrus_viewer` variable.

### :PapyrusStart

Runs `:PapyrusOpen` and `:PapyrusAutoCompile` 

### :PapyrusHeader

Copies the specified template file from the `md` templates for the specified template that is set using the `g:papyrus_template` variable.

### :PapyrusNew

Runs `:PapyrusHeader` and `:PapyrusStart` to create a new editing environment from the specified header.


