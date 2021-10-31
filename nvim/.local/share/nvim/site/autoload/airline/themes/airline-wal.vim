" WAL THEME

source ~/.cache/wal/colors-wal.vim
echo 'eblan'

let g:airline#themes#airline_wal#palette = {}

let s:guibg = g:background
let s:guibg2 = g:color0
let s:termbg = 232
let s:termbg2= 234

let s:N1 = [ s:guibg , g:color2 , s:termbg , 45 ]
let s:N2 = [ g:color1 , s:guibg2, 202 , s:termbg2 ]
let s:N3 = [ g:color6 , s:guibg, 243 , s:termbg]
let g:airline#themes#airline_wal#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#airline_wal#palette.normal_modified = {
      \ 'airline_c': [ '#df0000' , s:guibg, 160     , s:termbg    , ''     ] ,
      \ }


let s:I1 = [ s:guibg, g:color9, s:termbg , 82 ]
let s:I2 = [ g:color1 , s:guibg2, 202 , s:termbg2 ]
let s:I3 = [ g:color6, s:guibg, 243 , s:termbg ]
let g:airline#themes#airline_wal#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#airline_wal#palette.insert_modified = copy(g:airline#themes#airline_wal#palette.normal_modified)
let g:airline#themes#airline_wal#palette.insert_paste = {
      \ 'airline_a': [ s:I1[0]   , '#d78700' , s:I1[2] , 172     , ''     ] ,
      \ }


let g:airline#themes#airline_wal#palette.replace = {
      \ 'airline_a': [ s:I1[0]   , '#af0000' , s:I1[2] , 124     , ''     ] ,
      \ }
let g:airline#themes#airline_wal#palette.replace_modified = copy(g:airline#themes#airline_wal#palette.normal_modified)


let s:V1 = [ s:guibg  , g:color7 , s:termbg , 184 ]
let s:V2 = [ g:color1 , s:guibg2 , 202      , s:termbg2 ]
let s:V3 = [ g:color6 , s:guibg  , 243      , s:termbg ]
let g:airline#themes#airline_wal#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#airline_wal#palette.visual_modified = copy(g:airline#themes#airline_wal#palette.normal_modified)


let s:IA  = [ g:color5 , s:guibg  , 239 , s:termbg  , '' ]
let s:IA2 = [ g:color5 , s:guibg2 , 239 , s:termbg2 , '' ]
let g:airline#themes#airline_wal#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA2, s:IA2)
let g:airline#themes#airline_wal#palette.inactive_modified = {
      \ 'airline_c': [ '#df0000', '', 160, '', '' ] ,
      \ }
