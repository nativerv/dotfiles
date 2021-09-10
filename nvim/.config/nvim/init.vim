"     _____   _____________    ________  ___
"    /  _/ | / /  _/_  __/ |  / /  _/  |/  /
"    / //  |/ // /  / /  | | / // // /|_/ /
"  _/ // /|  // /  / /  _| |/ // // /  / /
" /___/_/ |_/___/ /_/  (_)___/___/_/  /_/

" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

" Text edit
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'

" Text navigation
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'bkad/CamelCaseMotion'
Plug 'easymotion/vim-easymotion'

" Syntax
Plug 'kevinoid/vim-jsonc'

" File navigation
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plug 'christoomey/vim-tmux-navigator'
Plug 'rbgrouleff/bclose.vim'
Plug 'francoiscabrol/ranger.vim'

" Color schemes
Plug 'pprovost/vim-ps1'
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'tomasiser/vim-code-dark'
Plug '~/pr/wal.vim'

" Visuals
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'yggdroot/indentline'
" Other
Plug 'metakirby5/codi.vim'
Plug 'puremourning/vimspector'
Plug 'OmniSharp/omnisharp-vim'
Plug 'baskerville/vim-sxhkdrc'
Plug 'neomake/neomake'

call plug#end()

""" Settings 

" Theme
" colorscheme gruvbox
" colorscheme onedark
colorscheme wal

" Leader
nnoremap <Space> <Nop>
nmap <Space> <Leader>
let g:mapleader = " "

" CamelCaseMotion
let g:camelcasemotion_key = '<leader>'

" Ranger
let g:ranger_map_keys = 0

" Neomake
" normal mode (after 500ms; no delay when writing).
call neomake#configure#automake('nrwi', 500)

" outer world 
set mouse=a
set clipboard=unnamedplus
set titlestring="%F - NeoVim"
set title
set titleold=

" inner world
set termguicolors
" set t_Co=16
set number relativenumber
set smarttab
set ignorecase
set cindent
set tabstop=2
set shiftwidth=2
set cursorline 
set expandtab         " always uses spaces instead of tab characters
" set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
" set langmap=QЙ,WЦ,EУ,RК,TЕ,YН,UГ,IШ,OЩ,PЗ,{Х,}Ъ,AФ,SЫ,DВ,FА,GП,HР,JО,KЛ,LД,:Ж,"Э,|/,ZЯ,XЧ,CС,VМ,BИ,NТ,MЬ,<Б,>Ю,?\,,qй,wц,eу,rк,tе,yн,uг,iш,oщ,pз,[х,]ъ,aф,sы,dв,fа,gп,hр,jо,kл,lд,;ж,'э,zя,xч,cс,vм,bи,nт,mь,\,б,.ю,/.
" set langmap=ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭ/ЯЧСМИТЬБЮ\,йцукенгшщзхъфывапролджэячсмитьбю.;QWERTYUIOP{}ASDFGHJKL:"|ZXCVBNM<>?qwertyuiop[]asdfghjkl;'zxcvbnm\,./
" set langmap=ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭ\ЯЧСМИТЬБЮ,йцукенгшщзхъфывапролджэ\ячсмитьбю.\;QWERTYUIOP{}ASDFGHJKL:"|ZXCVBNM<>?qwertyuiop[]asdfghjkkl;'\zxcvbnm,./
" set langmap=ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭ\\ЯЧСМИТЬБЮ\,йцукенгшщзхъфывапролджэ\\ячсмитьбю.;QWERTYUIOP{}ASDFGHJKL:\"\|ZXCVBNM<>?qwertyuiop[]asdfghjkl\;'\\zxcvbnm\,./
" set langmap=ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭ/ЯЧСМИТЬБЮ\,йцукенгшщзхъфывапролджэячсмитьбю.
" set langmap="ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х{,Ъ},ФA,ЫS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж:,Э\",/\\,ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б<,Ю>,\,?,йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ъ],фa,ыs,вd,аf,пg,рh,оj,лk,дl,ж;,э',яz,чx,сc,мv,иb,тn,ьm,б,,ю.,./"
" set langmap=ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х{,Ъ},ФA,ЫS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж:,Э\\\",/\\|,ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б<,Ю>,,?,йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ъ],фa,ыs,вd,аf,пg,рh,оj,лk,дl,ж\\;,э',\\\\\\,яz,чx,сc,мv,иb,тn,ьm,б\\,,ю.,./
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
" set langmap=ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭ\ЯЧСМИТЬБЮ,йцукенгшщзхъфывапролджэ\ячсмитьбю.
            " QWERTYUIOP{}ASDFGHJKL:"|ZXCVBNM<>?qwertyuiop[]asdfghjkl;'\zxcvbnm,./

" The 'langmap' option is a list of parts, separated with commas.  Each
" part can be in one of two forms:
" 1.  A list of pairs.  Each pair is a "from" character immediately
"    followed by the "to" character.  Examples: "aA", "aAbBcC".
" 2.  A list of "from" characters, a semi-colon and a list of "to"
"    characters.  Example: "abc;ABC"
" Example: "aA,fgh;FGH,cCdDeE"
" Special characters need to be preceded with a backslash.  These are
" ";", ',', '"', '|' and backslash itself.

""" Plugins world

" nvim-colorizer
lua require'colorizer'.setup()

" Nerdtree
let NERDSpaceDelims = 1

" Airline theme
"let g:airline_theme = 'codedark'
let g:airline_theme = 'wal'

" onedark.vim override: Don't set a background color when running in a terminal;
" just use the terminal's background color
" `gui` is the hex color code used in GUI mode/nvim true-color mode
" `cterm` is the color code used in 256-color mode
" `cterm16` is the color code used in 16-color mode
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
  augroup END
endif

let g:onedark_color_overrides = {
\ "cursor_grey": {"gui": "#2c1a1c", "cterm": "235", "cterm16": "0" },
\}

" #b0607a
" #2c1a1c
" #050303


" Needed there cuz airline colors is wrong (not wal) without it
colorscheme onedark

let g:codedark_term256 = 1

" If hidden is not set, TextEdit might fail.
set hidden " Some servers have issues with backup files, see #649 set nobackup set nowritebackup " Better display for messages set cmdheight=2 " You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" Don't give |ins-completion-menu| messages.
set shortmess+=c

" Always show signcolumns
set signcolumn=yes

autocmd FileType * set formatoptions-=o

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


""" Remaps 

" Make db adequate (not actually works in this form)
"nnoremap db ldb

" Make p in VISUAL adequate
vnoremap p "_dP
vnoremap P "_dP
vnoremap <Leader>p ""p
vnoremap <Leader>P ""P

"" Ranger
map <silent> <leader>v :Ranger<CR>

"" gb's
let g:VM_maps = {}
let g:VM_maps['Find Under']         = 'gb'           " replace C-n
let g:VM_maps['Find Subword Under'] = 'gb'           " replace C-n visual

"" vim-surround
" surround word
nmap S ysiw

" Identify highlight group under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

"" Explorer pane
nmap <C-b> :NERDTreeToggle<CR>

"" GitGutter
nmap gz <Plug>(GitGutterPreviewHunk)
nmap g[ <Plug>(GitGutterPrevHunk)
nmap g] <Plug>(GitGutterNextHunk)

"" Easymotion

" To word bidirectional
nmap f <Plug>(easymotion-bd-w)

" " map <silent> <Space> <leader><leader><leader>bdw

" " nmap <leader>f <plug>(easymotion-prefix)

" " <Leader>f{char} to move to {char}
" map  <Leader>f <Plug>(easymotion-bd-f)
" nmap <Leader>f <Plug>(easymotion-overwin-f)

" " s{char}{char} to move to {char}{char}
" nmap s <Plug>(easymotion-overwin-f2)
" nmap <Leader>f <Leader><Leader><Leader>bdw


" " Move to line
" map <Leader>L <Plug>(easymotion-bd-jk)
" nmap <Leader>L <Plug>(easymotion-overwin-line)

" nmap <Leader>w <Plug>(easymotion-overwin-w)

" NERDComenter Comments
vmap <C-_> <plug>NERDCommenterToggle
nmap <C-_> <plug>NERDCommenterToggle

" Alt-Move lines
nnoremap <C-A-j> :m .+1<CR>==
nnoremap <C-A-k> :m .-2<CR>==
inoremap <C-A-j> <Esc>:m .+1<CR>==gi
inoremap <C-A-k> <Esc>:m .-2<CR>==gi
vnoremap <C-A-j> :m '>+1<CR>gv=gv
vnoremap <C-A-k> :m '<-2<CR>gv=gv

" Alt-Dublicate lines
nnoremap <A-J> :t .<CR>==
nnoremap <A-K> :t .-1<CR>==
inoremap <A-J> <Esc>:t .<CR>==gi
inoremap <A-K> <Esc>:t .-1<CR>==gi
vnoremap <A-J> :t '><CR>gv=gv
vnoremap <A-K> :t '<-1<CR>gv=gv

" Airline


" Ctrl+P
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
" let g:ctrlp_custom_ignore = 'node_modules'
" let g:ctrlp_custom_ignore = {
  " \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  " \ 'node_modules': 'node_modules',
  " \ 'file': '\v\.(exe|so|dll)$',
  " \ 'link': 'some_bad_symbolic_links',
  " \ }
" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Using CocList
" Show all diagnostics
" nnoremap <silent> <Space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions
" nnoremap <silent> <Space>e  :<C-u>CocList extensions<cr>
" " Show commands
" nnoremap <silent> <Space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document
" nnoremap <silent> <Space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols
" nnoremap <silent> <Space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <Space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <Space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent> <Space>p  :<C-u>CocListResume<CR>

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [ <Plug>(coc-diagnostic-prev)
nmap <silent> ] <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> gh :call <SID>show_documentation()<CR>

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"nmap <silent> <C-d> <Plug>(coc-range-select)
"xmap <silent> <C-d> <Plug>(coc-range-select)

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" Clear search highlight
nmap <silent> <C-n> :noh<CR>

" open NERDTree automatically
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * NERDTree

let g:NERDTreeGitStatusWithFlags = 1
"let g:WebDevIconsUnicodeDecorateFolderNodes = 1
"let g:NERDTreeGitStatusNodeColorization = 1
"let g:NERDTreeColorMapCustom = {
    "\ "Staged"    : "#0ee375",  
    "\ "Modified"  : "#d9bf91",  
    "\ "Renamed"   : "#51C9FC",  
    "\ "Untracked" : "#FCE77C",  
    "\ "Unmerged"  : "#FC51E6",  
    "\ "Dirty"     : "#FFBD61",  
    "\ "Clean"     : "#87939A",   
    "\ "Ignored"   : "#808080"   
    "\ }                         

let g:NERDTreeIgnore = ['^node_modules$']


""" vim-prettier formatOnSave

"let g:prettier#quickfix_enabled = 0
"let g:prettier#quickfix_auto_focus = 0
" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" run prettier on save
"let g:prettier#autoformat = 0
"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ ]


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Refresh `wal` theme on SIGUSR1
autocmd Signal SIGUSR1 call RefreshWalTheme()
function RefreshWalTheme()
  source ~/.cache/wal/colors-wal.vim
  :AirlineTheme wal 
  :redraw
endfunction

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

