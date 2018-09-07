module Todos.List exposing (list, todoRow, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Todos.Messages exposing (..)
import Todos.Models exposing (Model, Todo)


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ list model.todos
        ]


list : List Todo -> Html Msg
list todos =
    div [ class "row" ]
        [ table [ class "table table-hover" ]
            [ thead []
                [ tr []
                    [ th [] [ text "Id" ]
                    , th [] [ text "Title" ]
                    , th [] []
                    ]
                ]
            , tbody []
                (List.map todoRow todos)
            ]
        , button [ class "btn btn-primary", onClick CreateTodo ] [ text "Create Todo" ]
        ]


todoRow : Todo -> Html Msg
todoRow todo =
    tr []
        [ td [] [ text (String.fromInt todo.id) ]
        , td [] [ text todo.title ]
        , td []
            [ button [ class "btn btn-primary btn-sm", onClick (ShowTodo todo.id) ] [ text "Edit" ]
            ]
        ]
