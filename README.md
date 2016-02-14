# clippy.vim
This is a vim plugin for [rust-clippy][rust-clippy].

This project based [cargo.vim][cargo.vim],
[jFransham's work][jfransham_rust.vim] and [cargo-clippy][cargo-clippy].

[rust-clippy]: https://github.com/Manishearth/rust-clippy
[cargo.vim]: https://github.com/Nonius/cargo.vim
[jfransham_rust.vim]: https://github.com/jFransham/rust.vim
[cargo-clippy]: https://github.com/arcnmx/cargo-clippy

## Prerequired
* rust nightly version
* [syntastic](https://github.com/scrooloose/syntastic),

## Install
This plugin require builed rust-clippy library.

```
cd ~/.vim/bundle/clippy.vim
./install.sh
```

If you use `NeoBundle`, just add the following to vimrc:

```
NeoBundle 'd3m3vilurr/clippy.vim', {
    \   'build': {
    \     'linux': './install.sh'
    \   }
    \ }
```

And syntastic configure add to vimrc:

```
let g:syntastic_rust_checkers = ['rustc', 'clippy']
```

## Config variables
* let g:syntastic_rust_clippy_lib - Path of libclippy.so
* let g:syntastic_rust_clippy_pedantic - Pedantic mode flag; default 0
* let g:syntastic_rust_clippy_cargo - rust-clippy build mode; default 1
  - 0: Single file mode, direct use `rustc` command
  - 1: Simple cargo mode, use `cargo rustc` command
  - other: Complex mode, use `cargo rustc <user_set_string>`
    eg. If you set `--bin=abcd`, it will run `cargo rustc --bin=abcd`

## License

`clippy.vim` is primarily distributed under the terms of both the MIT license
and the Apache License (Version 2.0).

See LICENSE-APACHE and LICENSE-MIT for details.
