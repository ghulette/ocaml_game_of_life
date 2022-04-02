# ocaml-game-of-life

Conway's Game of Life written in OCaml and using SDL via the tsdl binding.

## To build:

```
$ opam switch create . --deps-only
$ eval $(opam env)
$ dune build
```

## To run:

```
$ dune exec life
```

This should work fine in Linux on desktop. If you (like me) are running WSL
you will need an X server running in Windows. Ping me if you would like help
getting this working.
