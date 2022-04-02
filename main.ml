let earth = ref (Life.make_random_world 64 48)
let click _ x y = Life.flip_cell !earth x y
let update _ = earth := Life.step !earth

let draw eng =
  Engine.clear eng;
  Life.with_living !earth (Engine.draw_cell eng)

let () =
  match Engine.init 640 480 "Conway's Game of Life" with
  | Ok eng ->
      Engine.clear eng;
      let inf = Engine.{ draw; update; click } in
      Engine.loop inf (ref false) eng
  | Error (`Msg msg) ->
      Printf.fprintf stderr "Error: %s\n" msg;
      exit 1
