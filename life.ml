type world = {
    width : int;
    height : int;
    cells : bool array array
  }

let make_empty_world w h =
  { width = w; height = h; cells = Array.make_matrix w h false }

let make_random_world w h =
  let earth = make_empty_world w h in
  for j = 0 to h-1 do
    for i = 0 to w-1 do
      earth.cells.(i).(j) <- Random.bool ()
    done
  done;
  earth

let flip_cell earth x y =
  earth.cells.(x).(y) <- not earth.cells.(x).(y)

let is_alive earth x y =
  let xi = (earth.width + x) mod earth.width in
  let yi = (earth.height + y) mod earth.height in
  earth.cells.(xi).(yi)

let with_living earth f =
  for j = 0 to earth.height-1 do
    for i = 0 to earth.width-1 do
      if is_alive earth i j then f i j
    done
  done

let neighbors earth xi yi =
  let idxs = [(-1,-1);(0,-1);(1,-1);
              (-1, 0);       (1, 0);
              (-1, 1);(0, 1);(1, 1)]
  in
  List.fold_left (fun n (x,y) -> n + (if is_alive earth (xi+x) (yi+y) then 1 else 0)) 0 idxs

let rule x = function
  | 0 | 1 -> false
  | 2 -> x
  | 3 -> true
  | 4 | _ -> false

let step earth =
  let earth' = make_empty_world earth.width earth.height in
  for j = 0 to earth.height-1 do
    for i = 0 to earth.width-1 do
      let x = is_alive earth i j in
      let n = neighbors earth i j in
      earth'.cells.(i).(j) <- rule x n
    done
  done;
  earth'
