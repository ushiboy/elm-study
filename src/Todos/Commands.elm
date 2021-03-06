module Todos.Commands exposing (collectionDecoder, commands, fetchAll, fetchAllUrl, fetchOne, memberDecoder, memberEncoded, oneTodoUrl, removeRequest, removeTodo, removeUrl, saveRequest, saveTodo, saveUrl)

import Http
import Json.Decode as Decode exposing (field)
import Json.Encode as Encode
import Routing exposing (Route(..))
import Todos.Messages exposing (Msg(..))
import Todos.Models exposing (Todo, TodoId)
import Url


commands : Url.Url -> Route -> Cmd Msg
commands url route =
    case route of
        TodosRoute ->
            fetchAll url.host

        TodoRoute id ->
            fetchOne url.host id

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
    "http://" ++ hostname ++ ":4000/todos/" ++ String.fromInt id


saveTodo : String -> Todo -> Cmd Msg
saveTodo hostname todo =
    saveRequest hostname todo
        |> Http.send OnSave


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
        "http://" ++ hostname ++ ":4000/todos/" ++ String.fromInt id

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
        |> Http.send OnRemove


removeRequest : String -> Todo -> Http.Request Todo
removeRequest hostname todo =
    Http.request
        { body = Http.emptyBody
        , expect = Http.expectStringResponse << always <| Ok todo
        , headers = []
        , method = "DELETE"
        , timeout = Nothing
        , url = removeUrl hostname todo.id
        , withCredentials = False
        }


removeUrl : String -> TodoId -> String
removeUrl hostname id =
    "http://" ++ hostname ++ ":4000/todos/" ++ String.fromInt id
