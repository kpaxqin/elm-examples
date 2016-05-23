module Index exposing (..)
import Html exposing (..)
import Html.App as App
import Counter as Counter
import CounterList as CounterList

--model
type alias Model =
  {counter: Counter.Model, counterList: CounterList.Model}

--update
type Msg = CounterMsg Counter.Msg | CounterListMsg CounterList.Msg

update : Msg -> Model-> Model
update msg model =
  case msg of
    CounterListMsg counterListMsg ->
      {model | counterList = CounterList.update counterListMsg model.counterList}
    CounterMsg counterMsg ->
      {model | counter = Counter.update counterMsg model.counter}

--view
view : Model -> Html Msg
view model =
  div [] [
    section [] [
      h2 [] [text "counterList"],
      showCounterList model
    ],
    section [] [
      h2 [] [text "Counter"],
      showCounter model
    ]
  ]

showCounterList: Model -> Html Msg
showCounterList model =
  App.map (\msg -> CounterListMsg msg) (CounterList.view model.counterList)

showCounter: Model -> Html Msg
showCounter model =
  App.map (\msg -> CounterMsg msg) (Counter.view model.counter)

initCounterList = {uid= 0, counters=[{id= 0, model= 2}]}

main = App.beginnerProgram {model= {counter = 1, counterList = initCounterList}, view=view, update=update}
