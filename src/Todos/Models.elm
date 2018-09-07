module Todos.Models exposing (Model, Todo, TodoId, initialModel)


type alias Model =
    { todos : List Todo
    , draft : Todo
    }


initialModel : Model
initialModel =
    { todos = []
    , draft =
        { id = -1
        , title = ""
        , complete = False
        }
    }


type alias TodoId =
    Int


type alias Todo =
    { id : TodoId
    , title : String
    , complete : Bool
    }
