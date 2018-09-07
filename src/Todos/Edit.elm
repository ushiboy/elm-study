module Todos.Edit exposing (todoForm, todoRemoveButton, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput, preventDefaultOn)
import Json.Decode as Decode
import Todos.Messages exposing (Msg(..))
import Todos.Models exposing (Model, Todo)


onSubmit : msg -> Attribute msg
onSubmit msg =
    preventDefaultOn "submit" (Decode.map alwaysPreventDefault (Decode.succeed msg))


alwaysPreventDefault : msg -> ( msg, Bool )
alwaysPreventDefault msg =
    ( msg, True )


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ todoForm model.draft
        ]


todoForm : Todo -> Html Msg
todoForm todo =
    div [ class "row" ]
        [ Html.form [ onSubmit (SaveTodo todo) ]
            [ div [ class "form-group" ]
                [ label [] [ text "Title" ]
                , input [ class "form-control", type_ "text", value todo.title, onInput UpdateTitle ] []
                ]
            , div [ class "form-group form-check" ]
                [ input [ class "form-check-input", type_ "checkbox", checked todo.complete, onClick ToggleComplete ] []
                , label [] [ text "Complete" ]
                ]
            , todoRemoveButton todo
            , button [ class "btn btn-primary" ] [ text "Save" ]
            , button [ type_ "button", class "btn btn-link", onClick ShowTodos ] [ text "Cancel" ]
            ]
        ]


todoRemoveButton : Todo -> Html Msg
todoRemoveButton todo =
    if todo.id > 0 then
        button [ type_ "button", class "btn btn-danger", onClick (RemoveTodo todo) ] [ text "Remove" ]

    else
        span [] []
