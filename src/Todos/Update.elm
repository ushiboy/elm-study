module Todos.Update exposing (redirectTodos, update)

import Browser.Navigation as Nav
import Todos.Commands exposing (removeTodo, saveTodo)
import Todos.Messages exposing (Msg(..))
import Todos.Models exposing (Model, Todo, TodoId)


update : Msg -> Model -> String -> Nav.Key -> ( Model, Cmd Msg )
update msg model hostname key =
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
            ( { model | draft = savedTodo }, redirectTodos key )

        OnSave (Err error) ->
            ( model, Cmd.none )

        OnRemove (Ok savedTodo) ->
            ( { model | draft = savedTodo }, redirectTodos key )

        OnRemove (Err error) ->
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
            ( model, saveTodo hostname todo )

        RemoveTodo todo ->
            ( model, removeTodo hostname todo )

        ShowTodos ->
            ( model, redirectTodos key )

        ShowTodo id ->
            ( model, Nav.pushUrl key ("/todos/" ++ String.fromInt id) )

        CreateTodo ->
            ( { model | draft = { id = -1, title = "", complete = False } }, Nav.pushUrl key "/todos/new" )


redirectTodos : Nav.Key -> Cmd Msg
redirectTodos key =
    Nav.pushUrl key "/todos"
