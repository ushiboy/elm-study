module Todos.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick, onWithOptions)
import Todos.Models exposing (Model, Todo)
import Todos.Messages exposing (Msg(UpdateTitle, ToggleComplete, SaveTodo, ShowTodos))
import Json.Decode as Decode


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ todoForm model.draft
        ]


todoForm : Todo -> Html Msg
todoForm todo =
    div [ class "row" ]
        [ Html.form [ onWithOptions "submit" { preventDefault = True, stopPropagation = False } (Decode.succeed (SaveTodo todo)) ]
            [ div [ class "form-group" ]
                [ label [] [ text "Title" ]
                , input [ class "form-control", type_ "text", value todo.title, onInput UpdateTitle ] []
                ]
            , div [ class "form-group form-check" ]
                [ input [ class "form-check-input", type_ "checkbox", checked todo.complete, onClick ToggleComplete ] []
                , label [] [ text "Complete" ]
                ]
            , button [ class "btn btn-primary" ] [ text "Save" ]
            , button [ class "btn btn-link", onClick ShowTodos ] [ text "Cancel" ]
            ]
        ]
