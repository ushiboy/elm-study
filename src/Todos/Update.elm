module Todos.Update exposing (..)

import Navigation
import Todos.Messages exposing (Msg(..))
import Todos.Models exposing (Todo, TodoId, Model)
import Todos.Commands exposing (saveTodo)


update : Msg -> Model -> String -> ( Model, Cmd Msg )
update msg model hostname =
    case msg of
        OnFetchAll (Ok newTodos) ->
            ( { model | todos = newTodos }, Cmd.none )

        OnFetchAll (Err error) ->
            ( model, Cmd.none )

        OnFetchOne (Ok newTodo) ->
            ( { model | draft = newTodo }, Cmd.none )

        OnFetchOne (Err error) ->
            ( model, Cmd.none )

        OnSave (Ok savedTodo) ->
            ( { model | draft = savedTodo }, Cmd.none )

        OnSave (Err error) ->
            ( model, Cmd.none )

        UpdateTitle title ->
            let
                oldDraft =
                    model.draft

                newDraft =
                    { oldDraft | title = title }
            in
                ( { model | draft = newDraft }, Cmd.none )

        ToggleComplete ->
            let
                oldDraft =
                    model.draft

                newDraft =
                    { oldDraft | complete = not oldDraft.complete }
            in
                ( { model | draft = newDraft }, Cmd.none )

        SaveTodo todo ->
            ( model, (saveTodo hostname todo) )

        ShowTodos ->
            ( model, Navigation.newUrl "#todos" )

        ShowTodo id ->
            ( model, Navigation.newUrl ("#todos/" ++ (toString id)) )
