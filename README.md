# Papyrus

Automatically compile Markdown notes into beautiful Latex PDFs or other support pandoc formats!

![Screenshot example of Papyrus](https://github.com/abeleinin/papyrus/blob/main/examples/example.png?raw=true)

Theme: [material default-community](https://github.com/kaicataldo/material.vim)

Papyrus is a asynchronous Markdown conversion plugin that allows users to have a latex-like editing experience while writing Markdown. By utilizing the [Pandoc](https://pandoc.org/) universal document converter you can write both Markdown and Latex syntax in the same file and convert it into a PDF or other Pandoc supported document types.

**Features**

- Asynchronous compilation
- Ability to set custom Pandoc command-line arguments
- Optional templates

## Table of contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Configuration](#configuration)
- [Errors Messages](#error-messages)
- [Commands](#commands)
- [Templates](#templates)
- [Demo](#demo)

## Requirements

- [Pandoc](https://pandoc.org/installing.html)
- [Latex Engine](https://pandoc.org/MANUAL.html#option--pdf-engine)

Supported Engines: pdflatex, lualatex, xelatex, latexmk, tectonic, wkhtmltopdf, weasyprint, pagedjs-cli, prince, context, and pdfroff.

## Installation

### Vim Plugin

Add the following to your `.vimrc` or `init.vim` file to install the plugin using a plugin manager of your choice. Here are some examples:

```vim
" vim-plug
Plug 'abeleinin/papyrus'

" packer.nvim
use 'abeleinin/papyrus'

" vundle
Plugin 'abeleinin/papyrus'
```

I *strongly* recommend to also install the [vim-pandoc-syntax](https://github.com/vim-pandoc/vim-pandoc-syntax) plugin to visualize Latex special characters.

### Pandoc Templates

**Templates are optional** 

Move the Latex template files from wherever your plugin are installed (`~/papyrus/templates/latex/*`) to the pandoc templates folder. The pandoc template folder depends on the OS you're using:

- Unix, Linux, macOS: `$HOME/.local/share/pandoc/templates` or `$HOME/.pandoc/templates`
- Windows: `C:\$HOME\AppData\Roaming\pandoc\templates`

If the `templates` or `pandoc` folder doesn't exist then you need to create them and put the template files into the new directory. You can also find the default *User data directory* by checking `pandoc --version`.

## Configuration

After installation, copy the following configurations into your `.vimrc` or `init.vim` file to configure Papyrus to your specification.

```vim
" Specify a Latex Engine from the supported list above
let g:papyrus_latex_engine = 'xelatex'

" Specify any built-in pdf viewing option. It's recommended to use 
" a pdf viewer with automatic updates on save.
let g:papyrus_viewer = 'zathura'

" Recommened keybinding for compiling and viewing documents
" Adding optional formatings is also possible by 
map <leader>pc :PapyrusCompile<CR>
map <leader>pa :PapyrusAutoCompile<CR>
map <leader>pv :PapyrusView<CR>
map <leader>ps :PapyrusStart<CR>
```

### Optional

`g:papyrus_pandoc_args`: Add custom [pandoc compilation](https://pandoc.org/MANUAL.html#general-writer-options) arguments.

`g:papyrus_autocompile`: Default set to `BufWrite` alternative [autocmd events](https://neovim.io/doc/user/autocmd.html#autocmd-events) can be used to trigger auto-compilation.

`g:papyrus_output_path`: Set a custom output folder path in the format `/path/to/folder/`. Do not include `$HOME` or `~`.

`g:papyrus_output_format`: Default output format is set to `pdf` which can be changed to any supported pandoc output format which are listed when running `pandoc --list-output-formats`.

`g:papyrus_template`: Set a template from supported options. 

### Customization 

If a command has an [optional argument](#commands) you can can add custom mappings for different compilation formats. For example:

```vim
" Compile current file to pdf
map <leader>pcp :PapyrusCompile pdf<CR>

" Compile current file to html
map <leader>pch :PapyrusCompile html<CR>
```


## Error Messages

After every compilation either the message `Papyrus: Compilation Succeeded!` will appear at the bottom of the window or `Papyrus: Compilation Failed with exit status X`. After a failed compilation the **pandoc compilation errors are displayed in a quickfix list** which can be viewed using `:copen`.


## Commands

**Optional argument** allow you to change the current file output format. Possible output formats are listed when running `pandoc --list-output-formats`.

### :PapyrusCompile \<optional\>

Executes a `pandoc` command using `jobstart` to compile the current open `md` file into a `pdf` with the same name using either the `g:papyrus_pandoc_args` or `g:papyrus_template`. 

### :PapyrusAutoCompile \<optional\>

Executes an `autocmd` when the `g:papyrus_autocompile` event is triggered which runs `:PapyrusCompile`.

### :PapyrusView 

Opens the current file in the specified pdf viewer from the `g:papyrus_viewer` variable.

### :PapyrusStart \<optional\>

Runs `:PapyrusView` and `:PapyrusAutoCompile` to automatically start an editing environment.

### :PapyrusHeader

Copies the specified template file into the current file from `/templates/md/g:papyrus_template`.

### :PapyrusNew \<optional\>

Runs `:PapyrusHeader` and `:PapyrusStart` to create a new editing environment for the specified template. 


## Templates

Papyrus supports two templates which you can view in the [pdf directory](https://github.com/abeleinin/papyrus/tree/main/templates/pdf). Custom template files can be created using [pandoc-latex-templates](https://github.com/Wandmalfarbe/pandoc-latex-template). If you create a cool template feel free to submit a pull request!

```vim
" Specify the current template by its file name 
let g:papyrus_template = 'default'
```
 
### Default

https://user-images.githubusercontent.com/95333017/220019753-b45b7ae5-59a0-4ac0-85e5-c228ff35544c.mov


### Lecture 

https://user-images.githubusercontent.com/95333017/220019833-a01ba926-bfc8-4dd8-a6f3-d3f6bc611263.mov


## Demo

This is a demo from my notes on the [Book of Proof](https://www.people.vcu.edu/~rhammack/BookOfProof/Main.pdf). I'm using the [Vim Pandoc Syntax](https://github.com/vim-pandoc/vim-pandoc-syntax) plugin to automatically insert special characters and clean up the document. Also, in the demo you can see that pandoc supports the ability to insert Latex syntax inside the Markdown document.

https://user-images.githubusercontent.com/95333017/220041898-7326b76d-348e-4bf4-95dd-b4a879527ed5.mov


