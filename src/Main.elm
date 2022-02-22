module Main exposing (main)

import Browser
import Html exposing (Attribute, Html, div, text)
import Html.Attributes exposing (class)
import Html exposing (h1)


type alias Model =
    { count : Int }


initialModel : Model
initialModel =
    { count = 0 }


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }

        Decrement ->
            { model | count = model.count - 1 }


view : Model -> Html Msg
view model =
    div [ class "main-container", class "container" ]
        [ h1 [] [text "A Kitty and Puppy Scroller"]
        , viewShowScroller Puppy model
        , viewShowScroller Kitty model
        , div [ class "focused-photo" ] [ text "Active Photo" ]
        ]


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


toClass : ScrollerContentType -> Attribute Msg
toClass contentType =
    case contentType of
        Kitty ->
            class "kitty-scroller"

        Puppy ->
            class "puppy-scroller"


viewShowScroller : ScrollerContentType -> Model -> Html Msg
viewShowScroller contentType _ =
    div
        [ class "show-scroller"
        , toClass contentType
        ]
        [ text <| "First Row of " ++ toString contentType ++ " Photos" ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
