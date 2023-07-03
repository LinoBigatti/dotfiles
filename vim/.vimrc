set encoding=utf-8
let mapleader="."

if &compatible
    set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')

    call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
    call dein#add('Shougo/deoplete.nvim')
    if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
    endif

    call dein#add('preservim/nerdtree')
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')
    call dein#add('preservim/nerdcommenter')
    call dein#add('frazrepo/vim-rainbow')
    call dein#add('jiangmiao/auto-pairs')
    call dein#add('Yggdroot/indentLine')
    call dein#add('tpope/vim-sleuth')
    call dein#add('ryanoasis/vim-devicons')
    call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')
    call dein#add('neoclide/coc.nvim', { 'merged': 0 })
    call dein#add('honza/vim-snippets')
    call dein#add('airblade/vim-gitgutter')
    call dein#add('vim-scripts/taglist.vim')
    call dein#add('voldikss/vim-floaterm')
    call dein#add('vim-scripts/dfrankutil')
    call dein#add('vim-scripts/vimprj')
    call dein#add('NoahTheDuke/vim-just')

    " Consider start using
    call dein#add('tpope/vim-fugitive')

    call dein#end()
    call dein#save_state()
endif

" Autoinstall new plugins
if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable


" Font config
set guifont=UbuntuMono\ Nerd\ Font\ 13


" NERDTreeDevicons config
let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
let g:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile = 1

" whether or not to show the nerdtree brackets around flags
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''

set conceallevel=3


" Move between splits
nmap <silent> <C-Up> :wincmd k<CR>
nmap <silent> <C-Down> :wincmd j<CR>
nmap <silent> <C-Left> :wincmd h<CR>
nmap <silent> <C-Right> :wincmd l<CR>

" Use tab to edit indentation
vmap <Tab> >gv
vmap <S-Tab> <gv
nmap <Tab> >l
nmap <S-Tab> <l

" Map ç and Ç to < and >
imap ç <
imap Ç >


" Floaterm config
let g:floaterm_width=0.8
let g:floaterm_height=0.9
let g:floaterm_opener='tabe'

" Command wrappers
command! Fzf FloatermNew --disposable fzf
command! Rg  FloatermNew --disposable rg -

" Terminal keybindings
nnoremap <silent> <F7>  :FloatermNew<CR>
tnoremap <silent> <F7>  <C-\><C-n>:FloatermNew<CR>
nnoremap <silent> <F8>  :FloatermToggle<CR>
tnoremap <silent> <F8>  <C-\><C-n>:FloatermToggle<CR>
nnoremap <silent> <F9>  :call BuildProject()<CR>
nnoremap <silent> <F10> :call TestProject()<CR>
nnoremap <silent> <C-h> :FloatermPrev<CR>
tnoremap <silent> <C-h> <C-\><C-n>:FloatermPrev<CR>
nnoremap <silent> <C-l> :FloatermNext<CR>
tnoremap <silent> <C-l> <C-\><C-n>:FloatermNext<CR>
nnoremap <silent> f     :Fzf<CR>
nnoremap <silent> <C-f> :Rg<CR>

" Redefine this function on your vimprj to launch a floating terminal with your
" build steps.
function! BuildProject()
  echo "Error: BuildProject() wasnt redefined. Please add your build steps to .vimprj" 
endfunction

" Redefine this function on your vimprj to launch a floating terminal with your
" tests.
function! TestProject()
  echo "Error: TestProject() wasnt redefined. Please add your test setup to .vimprj" 
endfunction


" NERDTree config
let g:nerdtree_enabled = 0
nnoremap <silent> <S-t> :let g:nerdtree_enabled = !g:nerdtree_enabled<CR>

augroup nerd_tree
autocmd!
  " Start NERDTree and put the cursor back in the other window.
  autocmd VimEnter * silent g:nerdtree_enabled ? NERDTreeVCS | wincmd p :
  
  " Open the existing NERDTree on each newtab.
  autocmd BufWinEnter * silent g:nerdtree_enabled ? NERDTreeToggleVCS :
  autocmd TerminalWinOpen * silent NERDTreeClose

  " Exit Vim if NERDTree is the only window left.
  autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
      \ quit | endif

  " Exit NERDTree if its the last split on a tab
  autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
      \ silent NERDTreeClose | endif
augroup END

" Directory stuff
let g:NERDTreeDirArrowExpandable = '>'
let g:NERDTreeDirArrowCollapsible = 'v'


" Rainbow brackets
let g:rainbow_active = 1


" NERDCommenter handler
function Comment()
  if mode() ==? 'v'
    call nerdcommenter#Comment('x', 'toggle')
  elseif mode() == 'CTRL-V'
    call nerdcommenter#Comment('x', 'toggle')
  elseif mode() == 'n'
    call nerdcommenter#Comment('n', 'toggle')
  endif
endfunction

map cc :call Comment()<CR>


" Airline config
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1


" CoC configuration

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=200

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" CoC keybindings

" Use tab for trigger completion with characters ahead, snippets and navigation.
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Use <S-space> to trigger completion.
"if has('nvim')
  "inoremap <silent><expr> <S-space> coc#refresh()
"else
  "inoremap <silent><expr> <S-@> coc#refresh()
"endif

" Use Enter to autocomplete with the selected result
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight the symbol, its references and its signature when holding the cursor.
augroup coc_symbol
autocmd!
  autocmd CursorHold * silent call CocActionAsync('highlight')
  autocmd CursorHoldI * silent call CocActionAsync('showSignatureHelp')
augroup END

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Airline integration
let g:airline#extensions#coc#enabled = 1

" CoC menu colors
hi Pmenu term=reverse ctermbg=8 ctermfg=7

" Use <C-j> and <C-k> to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <C-k> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-j> <Plug>(coc-diagnostic-next)

" Use <C-s> for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Snippet support
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'


" Taglist config
nnoremap <silent> t :TlistToggle<CR>
let Tlist_GainFocus_On_ToggleOpen = 1
