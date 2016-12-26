module Controller exposing (Model, Msg, init, update, subscriptions)

import Mouse exposing (moves)


type Msg
    = Position Int Int


type alias Model =
    { x : Int
    , y : Int
    }


init : ( Model, Cmd Msg )
init =
    ( { x = 0, y = 0 }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Position x y ->
            ( { model | x = x, y = y }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    moves (\{ x, y } -> Position x y)
