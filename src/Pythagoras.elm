module Pythagoras exposing (pythagoras, baseArgs)

import Svg exposing (Svg, g, rect)
import Svg.Attributes exposing (transform, fill, stroke, x, y, width, height)
import Visualization.Scale exposing (linear, convert)
import Basics exposing (sqrt, atan, pi)
import Controller exposing (Msg)


type alias PythagorasArgs =
    ( Float, Float, Float, Float, Float, Bool, Bool, Float, Float )


rectColor : String
rectColor =
    "#4DA6C2"


borderColor : String
borderColor =
    "#C2694D"


baseWidth : Float
baseWidth =
    80


realMax : Float
realMax =
    11


degrees : Float -> Float
degrees r =
    r * (180 / pi)


baseArgs : ( Float, Float, Float, Float ) -> PythagorasArgs
baseArgs ( xpos, ypos, svgWidth, svgHeight ) =
    let
        scaleFactor =
            linear ( svgHeight, 0 ) ( 0, 0.8 )

        scaleLean =
            linear ( 0, svgWidth ) ( 0.5, -0.5 )

        w =
            baseWidth

        x =
            svgWidth / 2 - baseWidth / 2

        y =
            svgHeight - baseWidth

        heightFactor =
            convert scaleFactor ypos

        lean =
            convert scaleLean xpos
    in
        ( w, x, y, heightFactor, lean, False, False, 0, realMax )


calculate : ( Float, Float, Float ) -> ( Float, Float, Float, Float )
calculate ( w, heightFactor, lean ) =
    let
        positiveLean =
            (w * (0.5 + lean))

        negativeLean =
            (w * (0.5 - lean))

        trigH =
            heightFactor * w

        nextRight =
            sqrt (trigH ^ 2 + positiveLean ^ 2)

        nextLeft =
            sqrt (trigH ^ 2 + negativeLean ^ 2)

        aside =
            degrees (atan (trigH / negativeLean))

        bside =
            degrees (atan (trigH / positiveLean))
    in
        ( aside, bside, nextRight, nextLeft )


pythagoras : PythagorasArgs -> Svg Msg
pythagoras ( w, xpos, ypos, heightFactor, lean, left, right, lvl, maxlvl ) =
    if (lvl >= maxlvl || w < 1) then
        g [] []
    else
        let
            ( aside, bside, nextRight, nextLeft ) =
                calculate ( w, heightFactor, lean )

            wStr =
                (toString w)

            rotation =
                if left then
                    "rotate(" ++ (toString (-aside)) ++ " 0 " ++ wStr ++ ")"
                else if right then
                    "rotate(" ++ (toString (bside)) ++ " " ++ wStr ++ " " ++ wStr ++ ")"
                else
                    ""

            leftArgs =
                ( nextLeft, 0, -nextLeft, heightFactor, lean, True, False, lvl + 1, maxlvl )

            rightArgs =
                ( nextRight, w - nextRight, -nextRight, heightFactor, lean, False, True, lvl + 1, maxlvl )
        in
            g [ transform ("translate(" ++ (toString xpos) ++ " " ++ (toString ypos) ++ ") " ++ rotation) ]
                [ rect [ stroke borderColor, fill rectColor, x (toString 0), y (toString 0), width (toString w), height (toString w) ] []
                , pythagoras leftArgs
                , pythagoras rightArgs
                ]
