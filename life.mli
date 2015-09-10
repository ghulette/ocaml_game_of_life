type world

val make_empty_world : int -> int -> world
val make_random_world : int -> int -> world
val flip_cell : world -> int -> int -> unit
val is_alive : world -> int -> int -> bool
val with_living : world -> (int -> int -> unit) -> unit
val neighbors : world -> int -> int -> int
val step : world -> world
