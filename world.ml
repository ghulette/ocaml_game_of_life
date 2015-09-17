let enumf f =
  let rec aux acc = function
    | 0 -> acc
    | x -> aux (f x :: acc) (x - 1)
  in
  aux []

module Pt = struct
    type t = int * int

    let compare = compare
    let add (x1,y1) (x2,y2) = (x1 + x2, y1 + y2)
    let grid n m = List.concat (enumf (fun j -> enumf (fun i -> i,j) n) m)
  end

module Pts = Set.Make (Pt)

type t = {
    width : int;
    height : int;
    alive : Pts.t
  }

let make w h cells =
  { width = w; height = h; alive = Pts.of_list cells }

let empty w h = make w h []

let random w h =
  let rpts = List.filter (fun _ -> Random.bool ()) (Pt.grid w h) in
  make w h rpts

let is_alive o x y =
  Pts.mem (x,y) o.alive

let kill o x y =
  { o with alive = Pts.remove (x,y) o.alive }

let spawn o x y =
  { o with alive = Pts.add (x,y) o.alive }

let flip o x y =
  if is_alive o x y then kill o x y else spawn o x y
