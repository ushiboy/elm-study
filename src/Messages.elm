module Messages exposing (..)

import Navigation exposing (Location)
import Todos.Messages


type Msg
    = TodosMsg Todos.Messages.Msg
    | OnLocationChange Location
