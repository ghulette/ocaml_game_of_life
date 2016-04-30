SOURCES = engine.ml life.mli life.ml main.ml
RESULT = life
PACKS = result tsdl

all : native-code

include OCamlMakefile
