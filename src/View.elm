module View exposing (notFoundView, page, view)

import Browser
import Html exposing (Html, a, button, div, li, nav, span, text, ul)
import Html.Attributes exposing (..)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Routing exposing (Route(..))
import Todos.Edit
import Todos.List
import Todos.Models exposing (TodoId)


view : Model -> Browser.Document Msg
view model =
    { title = "Elm SPA Todo"
    , body =
        [ nav [ class "navbar navbar-expand-lg navbar-light bg-light" ]
            [ a [ class "navbar-brand" ] [ text "Elm Study" ]
            , button [ class "navbar-toggler", type_ "button" ]
                [ span [ class "navbar-toggler-icon" ] []
                ]
            , div [ class "collapse navbar-collapse" ]
                [ ul [ class "navbar-nav mr-auto" ]
                    [ li [ class "nav-item active" ]
                        [ a [ class "nav-link", href "/todos" ]
                            [ text "Home"
                            , span [ class "sr-only" ] [ text "(current)" ]
                            ]
                        ]
                    ]
                ]
            ]
        , div [] [ page model ]
        ]
    }


page : Model -> Html Msg
page model =
    case model.route of
        TodosRoute ->
            Html.map TodosMsg (Todos.List.view model.todoModel)

        NewTodoRoute _ ->
            Html.map TodosMsg (Todos.Edit.view model.todoModel)

        TodoRoute id ->
            Html.map TodosMsg (Todos.Edit.view model.todoModel)

        NotFoundRoute ->
            notFoundView


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not Found."
        ]
