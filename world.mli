type t

(** Create a new empty world *)
val empty : int -> int -> t

(** Create a new random world (each cell has a 50% chance of being
alive *)
val random : int -> int -> t

(** Testing cells, and turning them on and off *)
val is_alive : t -> int -> int -> bool
val kill : t -> int -> int -> t
val spawn : t -> int -> int -> t
val flip : t -> int -> int -> t
