SOURCES = engine.ml life.mli life.ml main.ml
RESULT = life
PACKS = tsdl

all : native-code

include OCamlMakefile
