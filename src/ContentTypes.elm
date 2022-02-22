module ContentTypes exposing (ScrollerContentType(..), toClass)

import Html exposing (Attribute)
import Html.Attributes exposing (class)


type ScrollerContentType
    = Kitty
    | Puppy


toString : ScrollerContentType -> String
toString contentType =
    case contentType of
        Kitty ->
            "Kitty"

        Puppy ->
            "Puppy"


toClass : ScrollerContentType -> Attribute msg
toClass contentType =
    case contentType of
        Kitty ->
            class "kitty-scroller"

        Puppy ->
            class "puppy-scroller"
