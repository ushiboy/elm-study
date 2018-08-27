module View exposing (..)

import Html exposing (Html, div, text)
import Models exposing (Model)
import Messages exposing (Msg(..))
import Todos.List
import Todos.Edit
import Todos.Models exposing (TodoId)
import Routing exposing (Route(..))


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        TodosRoute ->
            Debug.log "todos route" Html.map TodosMsg (Todos.List.view model.todoModel)

        NewTodoRoute _ ->
            Debug.log "new todos route" Html.map TodosMsg (Todos.Edit.view model.todoModel)

        TodoRoute id ->
            Debug.log "edit todos route" Html.map TodosMsg (Todos.Edit.view model.todoModel)

        NotFoundRoute ->
            Debug.log "not found route" notFoundView


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not Found."
        ]
