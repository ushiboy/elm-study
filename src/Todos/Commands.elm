module Todos.Commands exposing (..)

import Http
import Json.Decode as Decode exposing (field)
import Json.Encode as Encode
import Todos.Models exposing (TodoId, Todo)
import Todos.Messages exposing (Msg(..))
import Routing exposing (Route(..))
import Navigation exposing (Location)


commands : Location -> Route -> Cmd Msg
commands location route =
    case route of
        TodosRoute ->
            fetchAll location.hostname

        TodoRoute id ->
            fetchOne location.hostname id

        NewTodoRoute _ ->
            Cmd.none

        NotFoundRoute ->
            Cmd.none


fetchAll : String -> Cmd Msg
fetchAll hostname =
    Http.get (fetchAllUrl hostname) collectionDecoder
        |> Http.send OnFetchAll


fetchAllUrl : String -> String
fetchAllUrl hostname =
    "http://" ++ hostname ++ ":4000/todos"


collectionDecoder : Decode.Decoder (List Todo)
collectionDecoder =
    Decode.list memberDecoder


memberDecoder : Decode.Decoder Todo
memberDecoder =
    Decode.map3 Todo
        (field "id" Decode.int)
        (field "title" Decode.string)
        (field "complete" Decode.bool)


fetchOne : String -> TodoId -> Cmd Msg
fetchOne hostname id =
    Http.get (oneTodoUrl hostname id) memberDecoder
        |> Http.send OnFetchOne


oneTodoUrl : String -> TodoId -> String
oneTodoUrl hostname id =
    "http://" ++ hostname ++ ":4000/todos/" ++ (toString id)


saveTodo : String -> Todo -> Cmd Msg
saveTodo hostname todo =
    saveRequest hostname todo
        |> Http.send OnFetchOne


saveRequest : String -> Todo -> Http.Request Todo
saveRequest hostname todo =
    Http.request
        { body = memberEncoded todo |> Http.jsonBody
        , expect = Http.expectJson memberDecoder
        , headers = []
        , method =
            if todo.id > 0 then
                "PUT"
            else
                "POST"
        , timeout = Nothing
        , url = saveUrl hostname todo.id
        , withCredentials = False
        }


saveUrl : String -> TodoId -> String
saveUrl hostname id =
    if id > 0 then
        "http://" ++ hostname ++ ":4000/todos/" ++ (toString id)
    else
        "http://" ++ hostname ++ ":4000/todos/"


memberEncoded : Todo -> Encode.Value
memberEncoded todo =
    let
        list =
            [ ( "title", Encode.string todo.title )
            , ( "complete", Encode.bool todo.complete )
            ]
    in
        list
            |> Encode.object


removeTodo : String -> Todo -> Cmd Msg
removeTodo hostname todo =
    removeRequest hostname todo
        |> Http.send OnFetchOne


removeRequest : String -> Todo -> Http.Request Todo
removeRequest hostname todo =
    Http.request
        { body = Http.emptyBody
        , expect = Http.expectJson memberDecoder
        , headers = []
        , method = "DELETE"
        , timeout = Nothing
        , url = removeUrl hostname todo.id
        , withCredentials = False
        }


removeUrl : String -> TodoId -> String
removeUrl hostname id =
    "http://" ++ hostname ++ ":4000/todos/" ++ (toString id)
