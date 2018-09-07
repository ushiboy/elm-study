module Update exposing (update)

import Browser
import Browser.Navigation as Nav
import Messages exposing (Msg(..))
import Models exposing (..)
import Routing exposing (parseUrl)
import Todos.Commands exposing (commands)
import Todos.Update
import Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TodosMsg subMsg ->
            let
                ( updateTodoModel, cmd ) =
                    Todos.Update.update subMsg model.todoModel model.hostname model.key
            in
            ( { model | todoModel = updateTodoModel }, Cmd.map TodosMsg cmd )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            let
                route =
                    parseUrl url
            in
            ( { model | route = route }, Cmd.map TodosMsg (commands url route) )
