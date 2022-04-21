type t

val init : int -> int -> string -> (t, [ `Msg of string ]) result
val clear : t -> unit
val draw_cell : t -> int -> int -> unit
val quit : t -> unit

type info = {
  draw : t -> unit;
  update : t -> unit;
  click : t -> int -> int -> unit;
}

val loop : info -> bool ref -> t -> 'a
