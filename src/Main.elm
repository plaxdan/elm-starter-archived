port module Main exposing (..)

import Html exposing (Html, h1, div, hr, text, button, input)
import Html.Attributes exposing (value, placeholder)
import Html.Events exposing (onClick, onInput)
import Hello.World exposing (hello)


type alias Model =
    { question : String
    , answer : String
    }


type Msg
    = SetQuestion String
    | AskQuestion
    | ReceiveAnswer String


init : ( Model, Cmd Msg )
init =
    ( Model "" "", Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text hello ]
        , input
            [ onInput SetQuestion
            , value model.question
            , placeholder "What is your question?"
            ]
            []
        , button [ onClick AskQuestion ] [ text "Ask JavaScript!" ]
        , hr [] []
        , text <| toString model
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetQuestion str ->
            ( Model str model.answer, Cmd.none )

        AskQuestion ->
            ( model, sendPrompt model.question )

        ReceiveAnswer str ->
            ( Model model.question str, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    receivePrompt ReceiveAnswer


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


port receivePrompt : (String -> msg) -> Sub msg


port sendPrompt : String -> Cmd msg
