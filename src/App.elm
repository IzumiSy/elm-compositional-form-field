module App exposing (main)

import Browser
import Html exposing (Html, div, text)
import Username


type alias Model =
    { username : Username.Username }


init : Model
init =
    { username = Username.empty }


type Msg
    = UsernameInputted Username.Username
    | UsernameBlurred


update : Msg -> Model -> Model
update msg model =
    case msg of
        UsernameInputted username ->
            { username = username }

        UsernameBlurred ->
            { username = Username.blur model.username }


view : Model -> Html Msg
view model =
    let
        error =
            model.username
                |> Username.errorString
                |> Maybe.withDefault ""
    in
    div
        []
        [ Username.input UsernameInputted UsernameBlurred model.username
        , div [] [ text error ]
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
