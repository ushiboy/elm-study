module Messages exposing (Msg(..))

import Browser
import Todos.Messages
import Url


type Msg
    = TodosMsg Todos.Messages.Msg
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
