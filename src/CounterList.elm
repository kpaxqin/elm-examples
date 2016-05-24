module CounterList exposing (..)
import Html exposing (Html, text, button, div)
import Html.App as App
import Counter exposing (Counter)
import Html.Events exposing (onClick)

--model
type alias IndexedCounter =
  {id: Int, model: Counter.Model}

type alias Model =
  {uid: Int, counters: List IndexedCounter}

--update
type Msg =
  Insert
  | Remove
  | Modify Int Counter.Msg

update: Msg-> Model-> Model
update msg ({uid, counters} as model) =
  case msg of
    Insert ->
      let
        id = uid + 1
      in
        {uid = id, counters = {id = id, model= 0} :: counters}
    Remove ->
      {model| counters = List.drop 1 counters}
    Modify id msg ->
      {model
      |counters = List.map (updateCounter id msg) counters
      }

updateCounter: Int -> Counter.Msg -> IndexedCounter -> IndexedCounter
updateCounter id msg counter=
  if counter.id == id then {counter| model = Counter.update msg counter.model} else counter

--view
view: Model -> Html Msg
view ({counters} as model) =
  div []
    [
    button [onClick Insert] [text "Insert"]
    ,button [onClick Remove] [text "Remove"]
    , div [] (List.map showCounter counters)
    ]

showCounter: IndexedCounter -> Html Msg
showCounter ({id, model} as counter) =
  App.map (\msg-> Modify id msg) (Counter.view model)
