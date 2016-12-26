module View exposing (view)

import Html exposing (Html, div)
import Svg exposing (svg)
import Svg.Attributes exposing (width, height, style)
import Controller exposing (Msg, Model)
import Pythagoras exposing (pythagoras, baseArgs)


svgWidth : number
svgWidth =
    1280


svgHeight : number
svgHeight =
    600


view : Model -> Html Msg
view model =
    div []
        [ svg [ width (toString svgWidth), height (toString svgHeight), style "border: 1px solid lightgray" ]
            [ pythagoras (baseArgs ( toFloat model.x, toFloat model.y, svgWidth, svgHeight ))
            ]
        ]
