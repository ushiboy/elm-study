module Todos.Update exposing (..)

import Navigation
import Todos.Messages exposing (Msg(..))
import Todos.Models exposing (Todo, TodoId, Model)
import Todos.Commands exposing (saveTodo, removeTodo)


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
            ( { model | draft = savedTodo }, redirectTodos )

        OnSave (Err error) ->
            ( model, Cmd.none )

        OnRemove (Ok savedTodo) ->
            Debug.log "onremove ok" ( { model | draft = savedTodo }, redirectTodos )

        OnRemove (Err error) ->
            Debug.log "onremove error" ( model, Cmd.none )

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

        RemoveTodo todo ->
            ( model, (removeTodo hostname todo) )

        ShowTodos ->
            ( model, redirectTodos )

        ShowTodo id ->
            ( model, Navigation.newUrl ("#todos/" ++ (toString id)) )

        CreateTodo ->
            ( { model | draft = { id = -1, title = "", complete = False } }, Navigation.newUrl "#todos/new" )


redirectTodos : Cmd Msg
redirectTodos =
    Navigation.newUrl "#todos"
