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
            Html.map TodosMsg (Todos.List.view model.todoModel)

        TodoRoute id ->
            Html.map TodosMsg (Todos.Edit.view model.todoModel)

        NotFoundRoute ->
            Html.map TodosMsg (Todos.List.view model.todoModel)


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not Found."
        ]
