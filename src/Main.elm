module Main exposing (main)

import Browser
import Html exposing (Html, button, div, h1, img, text)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick)
import String exposing (fromInt)
import ContentTypes exposing (ScrollerContentType(..), toClass)


type alias Model =
    { count : Int
    , kittenPhotos : List String
    , puppyPhotos : List String
    , activePhoto : Maybe String
    , scrollStatus : ControlStatus
    }


initialModel : Model
initialModel =
    { count = 0
    , kittenPhotos =
        List.range 1 4
            |> List.map fromInt
            |> List.map (buildUrl Kitty)
    , puppyPhotos =
        List.range 1 4
            |> List.map fromInt
            |> List.map (buildUrl Puppy)
    , activePhoto = Nothing
    , scrollStatus = Play
    }


buildUrl : ScrollerContentType -> String -> String
buildUrl contentType num =
    case contentType of
        Puppy ->
            "https://frontendeval.com/images/puppy-" ++ num ++ ".jpeg"

        Kitty ->
            "https://frontendeval.com/images/kitten-" ++ num ++ ".jpeg"


type Msg
    = Increment
    | Decrement
    | ClickedPhoto String
    | ControlScroll


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }

        Decrement ->
            { model | count = model.count - 1 }

        ClickedPhoto tgt ->
            { model | activePhoto = Just tgt }

        ControlScroll ->
            { model | scrollStatus = toggleStatus model.scrollStatus }


view : Model -> Html Msg
view model =
    div [ class "main-container", class "container" ]
        [ h1 [] [ text "A Kitty and Puppy Scroller" ]
        , viewControls model
        , viewShowScroller Puppy model
        , viewShowScroller Kitty model
        , img [ class "focused-photo", src (Maybe.withDefault "" model.activePhoto) ] []
        ]




type ControlStatus
    = Play
    | Pause


toggleStatus : ControlStatus -> ControlStatus
toggleStatus status =
    case status of
        Play ->
            Pause

        Pause ->
            Play




viewControls : Model -> Html Msg
viewControls model =
    case model.scrollStatus of
        Play -> div [ class "control-container" ] [ button [ onClick ControlScroll ] [ text "Paws" ] ]
        Pause -> div [ class "control-container" ] [ button [ onClick ControlScroll ] [ text "Play" ] ]



viewShowScroller : ScrollerContentType -> Model -> Html Msg
viewShowScroller contentType model =
    div
        [ class "show-scroller"
        , toClass contentType
        ]
        (viewPhotos contentType model)


viewPhotos : ScrollerContentType -> Model -> List (Html Msg)
viewPhotos contentType model =
    case contentType of
        Kitty ->
            List.map viewPhoto model.kittenPhotos

        Puppy ->
            List.map viewPhoto model.puppyPhotos


viewPhoto : String -> Html Msg
viewPhoto url =
    img [ src url, onClick (ClickedPhoto url) ] []


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
