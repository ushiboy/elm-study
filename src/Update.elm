module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (..)
import Todos.Update
import Routing exposing (parseLocation)
import Todos.Commands exposing (commands)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TodosMsg subMsg ->
            let
                ( updateTodoModel, cmd ) =
                    Todos.Update.update subMsg model.todoModel model.hostname
            in
                ( { model | todoModel = updateTodoModel }, Cmd.map TodosMsg cmd )

        OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.map TodosMsg (commands location newRoute) )
