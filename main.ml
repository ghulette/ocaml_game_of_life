let earth = ref (Life.make_random_world 64 48)

let click eng x y =
  Life.flip_cell !earth x y

let draw eng =
  Engine.clear eng;
  Life.with_living !earth (Engine.draw_cell eng);
  earth := Life.step !earth

let () =
  let eng = Engine.init 640 480 "Conway's Game of Life" in
  Engine.clear eng;
  Engine.loop draw click eng
