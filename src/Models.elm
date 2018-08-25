module Models exposing (..)

import Navigation exposing (Location)
import Todos.Models exposing (Todo)
import Routing


type alias Model =
    { hostname : String
    , route : Routing.Route
    , todoModel : Todos.Models.Model
    }


initialModel : Routing.Route -> Location -> Model
initialModel route location =
    { hostname = location.hostname
    , route = route
    , todoModel = Todos.Models.initialModel
    }
