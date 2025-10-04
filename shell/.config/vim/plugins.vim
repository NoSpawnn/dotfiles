" Credit to https://www.tonybtw.com/tutorial/vim/#plugins

let s:plugin_dir = expand('~/.config/vim/plugins')

function! s:ensure(repo)
  let name = split(a:repo, '/')[-1]
  let path = s:plugin_dir . '/' . name

  if !isdirectory(path)
    if !isdirectory(s:plugin_dir)
      call mkdir(s:plugin_dir, 'p')
    endif
    execute '!git clone --depth=1 https://github.com/' . a:repo . ' ' . shellescape(path)
  endif

  execute 'set runtimepath+=' . fnameescape(path)
endfunction

" fzf
call s:ensure('junegunn/fzf')
call s:ensure('junegunn/fzf.vim')

" lsp
call s:ensure('yegappan/lsp')

" color schemes
call s:ensure('shrikecode/kyotonight.vim')
