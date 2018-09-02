module Todos.Messages exposing (..)

import Http
import Todos.Models exposing (TodoId, Todo)


type Msg
    = OnFetchAll (Result Http.Error (List Todo))
    | OnFetchOne (Result Http.Error Todo)
    | OnSave (Result Http.Error Todo)
    | OnRemove (Result Http.Error Todo)
    | UpdateTitle String
    | ToggleComplete
    | SaveTodo Todo
    | RemoveTodo Todo
    | ShowTodos
    | ShowTodo TodoId
    | CreateTodo
