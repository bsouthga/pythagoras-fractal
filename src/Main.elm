module Main exposing (..)

import Html exposing (program)
import View exposing (view)
import Controller exposing (Model, Msg, init, update, subscriptions)


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
