import gleam/dict
import gleam/int
import gleam/io
import lustre
import lustre/attribute.{class}
import lustre/effect
import lustre/element.{text}
import lustre/element/html.{button, div, p}
import lustre/event.{on_click}

pub fn main() {
  let app = lustre.simple(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)
  let assert Ok(_) = setup()

  Nil
}

fn init(_flags) {
  0
}

type Msg {
  Incr
  Decr
}

fn update(model, msg) {
  case msg {
    Incr -> model + 1
    Decr -> model - 1
  }
}

fn view(model) {
  let count = int.to_string(model)

  div([], [
    button([class("button"), on_click(Incr)], [text(" + ")]),
    element.element("my-button", [], []),
    p([], [text(count)]),
    button([on_click(Decr)], [text(" - ")]),
  ])
}

pub fn setup() {
  lustre.component(
    fn(_) { #(Nil, effect.none()) },
    fn(model, msg) { #(model, effect.none()) },
    fn(_) { button([class("button")], [text("example")]) },
    dict.new(),
  )
  |> lustre.register("my-button")
}
