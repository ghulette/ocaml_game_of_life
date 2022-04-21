open Tsdl

type t = {
  window : Sdl.window;
  renderer : Sdl.renderer;
  cell_size : int;
  width : int;
  height : int;
}

let ( >>= ) m f = match m with Error e -> Error e | Ok x -> f x
let return x = Ok x

let init w h title =
  Sdl.init Sdl.Init.(video + events) >>= fun () ->
  Sdl.create_window ~w ~h title Sdl.Window.windowed >>= fun window ->
  let flgs = Sdl.Renderer.(accelerated + presentvsync) in
  Sdl.create_renderer ~flags:flgs window >>= fun renderer ->
  let cell_size = 10 in
  return
    {
      window;
      renderer;
      cell_size;
      width = w / cell_size;
      height = h / cell_size;
    }

let clear eng =
  let r = eng.renderer in
  Sdl.set_render_draw_color r 50 50 50 255 |> ignore;
  Sdl.render_clear r |> ignore

let draw_cell eng xc yc =
  let r = eng.renderer in
  let x = xc * eng.cell_size in
  let y = yc * eng.cell_size in
  let w = eng.cell_size + 1 in
  let h = eng.cell_size + 1 in
  let rect = Sdl.Rect.create ~x ~y ~w ~h in
  Sdl.set_render_draw_color r 150 150 200 255 |> ignore;
  Sdl.render_draw_rect r (Some rect) |> ignore;
  Sdl.render_draw_point r (x + eng.cell_size) (y + eng.cell_size) |> ignore

let quit eng =
  Sdl.destroy_renderer eng.renderer;
  Sdl.destroy_window eng.window;
  Sdl.quit ()

let event = Sdl.Event.create ()

type info = {
  draw : t -> unit;
  update : t -> unit;
  click : t -> int -> int -> unit;
}

let rec loop inf paused eng =
  while Sdl.poll_event (Some event) do
    match Sdl.Event.(enum (get event typ)) with
    | `Quit ->
        quit eng;
        exit 0
    | `Mouse_button_down ->
        let x = Sdl.Event.(get event mouse_button_x) in
        let y = Sdl.Event.(get event mouse_button_y) in
        inf.click eng (x / eng.cell_size) (y / eng.cell_size)
    | `Key_down ->
        let k = Sdl.Event.(get event keyboard_keycode) in
        if k = Sdl.K.space then paused := not !paused
    | _ -> ()
  done;
  if not !paused then inf.update eng else Sdl.delay 100l;
  inf.draw eng;
  Sdl.render_present eng.renderer;
  loop inf paused eng
