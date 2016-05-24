module Counter exposing (init, view, update, Model, Msg, Counter)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

--model
type alias Model = Int

init : Int -> Model
init count = count

--update
type Msg = Increase | Decrease
update: Msg -> Model -> Model
update msg model =
  case msg of
    Increase ->
      model + 1
    Decrease ->
      model - 1

--view
view : Model -> Html Msg
view model =
  div []
  [button [onClick Decrease] [text "-"]
  ,text (toString model)
  ,button [onClick Increase] [text "+"]
  ]
