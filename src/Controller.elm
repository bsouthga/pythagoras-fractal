module Controller exposing (Model, Msg, init, update, subscriptions)

import Mouse
import Window
import Task


type Msg
    = Position Int Int
    | Size Int Int


type alias Model =
    { x : Int
    , y : Int
    , width : Int
    , height : Int
    }


initialSizeCmd : Cmd Msg
initialSizeCmd =
    Task.perform sizeToMsg Window.size


sizeToMsg : Window.Size -> Msg
sizeToMsg size =
    Size size.width size.height


init : ( Model, Cmd Msg )
init =
    ( { x = 0, y = 0, width = 1280, height = 600 }, initialSizeCmd )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Position x y ->
            ( { model | x = x, y = y }, Cmd.none )

        Size w h ->
            ( { model | height = h - 7, width = w }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Mouse.moves (\{ x, y } -> Position x y)
        , Window.resizes sizeToMsg
        ]
