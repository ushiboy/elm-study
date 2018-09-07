module Models exposing (Model, initialModel)

import Browser.Navigation as Nav
import Routing
import Todos.Models exposing (Todo)
import Url


type alias Model =
    { key : Nav.Key
    , hostname : String
    , route : Routing.Route
    , todoModel : Todos.Models.Model
    }


initialModel : Routing.Route -> Url.Url -> Nav.Key -> Model
initialModel route url key =
    { key = key
    , hostname = url.host
    , route = route
    , todoModel = Todos.Models.initialModel
    }
