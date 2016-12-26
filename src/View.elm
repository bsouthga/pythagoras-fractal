module View exposing (view)

import Html exposing (Html, div)
import Svg exposing (svg)
import Svg.Attributes exposing (width, height, style)
import Controller exposing (Msg, Model)
import Pythagoras exposing (pythagoras, baseArgs)


view : Model -> Html Msg
view model =
    div [ style "overflow: hidden" ]
        [ svg [ width (toString model.width), height (toString model.height), style "overflow: hidden; border: 1px solid lightgray" ]
            [ pythagoras (baseArgs ( toFloat model.x, toFloat model.y, toFloat model.width, toFloat model.height ))
            ]
        ]
