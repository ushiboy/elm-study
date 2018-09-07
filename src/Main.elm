module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Messages exposing (..)
import Models exposing (Model, initialModel)
import Routing
import Todos.Commands exposing (commands)
import Update exposing (update)
import Url
import View exposing (view)


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        currentRoute =
            Routing.parseUrl url
    in
    ( initialModel currentRoute url key, Cmd.map TodosMsg (commands url currentRoute) )


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = \s -> Sub.none
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }
