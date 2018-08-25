module Main exposing (main)

import Messages exposing (..)
import Models exposing (Model, initialModel)
import View exposing (view)
import Update exposing (update)
import Routing
import Navigation exposing (Location)
import Todos.Commands exposing (commands)


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( initialModel currentRoute location, Cmd.map TodosMsg (commands location currentRoute) )


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = (\s -> Sub.none)
        }
