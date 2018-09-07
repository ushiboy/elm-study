module Routing exposing (Route(..), matchers, parseUrl)

import Todos.Models exposing (TodoId)
import Url
import Url.Parser exposing ((</>), Parser, int, map, oneOf, parse, s, string, top)


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


parseUrl : Url.Url -> Route
parseUrl url =
    Maybe.withDefault NotFoundRoute (parse matchers url)
