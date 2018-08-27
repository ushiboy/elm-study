module Routing exposing (..)

import Navigation exposing (Location)
import Todos.Models exposing (TodoId)
import UrlParser exposing (..)


type Route
    = TodosRoute
    | NewTodoRoute String
    | TodoRoute TodoId
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map TodosRoute top
        , map TodoRoute (s "todos" </> int)
        , map NewTodoRoute (s "todos" </> string)
        , map TodosRoute (s "todos")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute
