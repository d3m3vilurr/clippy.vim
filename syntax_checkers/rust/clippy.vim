" Vim syntastic plugin
" Language:     Rust
" Maintainer:   Sunguk Lee
"
" See for details on how to add an external Syntastic checker:
" https://github.com/scrooloose/syntastic/wiki/Syntax-Checker-Guide#external

if exists("g:loaded_syntastic_rust_clippy_checker")
    finish
endif

let g:loaded_syntastic_rust_clippy_checker = 1

if !exists('g:syntastic_rust_clippy_lib')
    let g:syntastic_rust_clippy_lib =
                \ expand('<sfile>:p:h:h') . '/../rust-clippy/target/release'
endif
if !exists('g:syntastic_rust_clippy_pedantic')
    let g:syntastic_rust_clippy_pedantic = 0
endif
if !exists('g:syntastic_rust_clippy_cargo')
    let g:syntastic_rust_clippy_cargo = 1
endif

let s:save_cpo = &cpo
set cpo&vim

function! SyntaxCheckers_rust_clippy_IsAvailable() dict
    return executable(self.getExec())
endfunction

function! SyntaxCheckers_rust_clippy_GetLocList() dict
    let errorformat =
                \ '%E%f:%l:%c: %\d%#:%\d%# %.%\{-}error:%.%\{-} %m,'   .
                \ '%W%f:%l:%c: %\d%#:%\d%# %.%\{-}warning:%.%\{-} %m,' .
                \ '%C%f:%l %m,' .
                \ '%-Z%.%#'

    let args =
                \ [
                \   '-L', g:syntastic_rust_clippy_lib,
                \   '-L', 'target/release/deps',
                \   '-lclippy',
                \   '-Zextra-plugins=clippy',
                \   '-Zno-trans',
                \ ]

    if g:syntastic_rust_clippy_pedantic == 1
        let args_after = ['-Dclippy', '-Wclippy_pedantic'],
    else
        let args_after = []
    endif

    if exists('g:syntastic_rust_clippy_cargo') && g:syntastic_rust_clippy_cargo != 0
        if g:syntastic_rust_clippy_cargo == 1
            let args_before = ['rustc', '--release', '--']
        else
            let args_before =
                        \ [
                        \   'rustc', '--release',
                        \   g:syntastic_rust_clippy_cargo,
                        \   '--',
                        \ ]
        endif

        let makeprg = self.makeprgBuild({
                    \ 'exe': 'cargo',
                    \ 'args_before': args_before,
                    \ 'args': args,
                    \ 'args_after': args_after,
                    \ 'fname': '' })
    else
        let makeprg = self.makeprgBuild({
                    \ 'exe': 'rustc',
                    \ 'args': args,
                    \ 'args_after': args_after })
    endif
    return SyntasticMake({
                \ 'makeprg': makeprg,
                \ 'errorformat': errorformat })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
            \ 'filetype': 'rust',
            \ 'name': 'clippy',
            \ 'exec': 'cargo' })

let &cpo = s:save_cpo
unlet s:save_cpo
