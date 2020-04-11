module Username exposing (Error(..), Username, blur, empty, errorString, input)

import Field
import Html exposing (Html)


type Username
    = Username (Field.Field Error)


type Error
    = LengthTooLong
    | LengthTooShort


empty : Username
empty =
    Username <|
        Field.init "" <|
            \value ->
                if String.length value > 20 then
                    Err ( value, LengthTooLong )

                else if String.length value < 5 then
                    Err ( value, LengthTooShort )

                else
                    Ok value


input : (Username -> msg) -> msg -> Username -> Html msg
input onInputMsg onBlurMsg (Username field) =
    Field.input (onInputMsg << Username) onBlurMsg field


blur : Username -> Username
blur (Username field) =
    Username <| Field.blur field


errorString : Username -> Maybe String
errorString (Username field) =
    Field.mapErrorToString
        (\error ->
            case error of
                LengthTooShort ->
                    "Length is too short"

                LengthTooLong ->
                    "Length is too long"
        )
        field
