module Main exposing (..)

import Html exposing (..)
import Msgs exposing (..)
import Model exposing (..)
import Update exposing (..)
import Companies.Service as CompaniesService
import Router.View
import Router.Msg
import Router.Model
import Search.Filters
import Search.Init
import Layout.Header.Init
import Router.Init
import Navigation


-- MODEL


model : Model
model =
    { header = Layout.Header.Init.init
    , search = Search.Init.init
    , loadingCompaniesFile = True
    , companies =
        []
    , router = Router.Init.init
    }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        routerModel =
            { page = Router.Model.locationToPage location }
    in
        ( { model | router = routerModel }, CompaniesService.getCompanies )



-- VIEW


view : Model -> Html Msg
view model =
    Router.View.renderPage model



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Model Msg
main =
    Navigation.program
        (Msgs.Router
            << Router.Msg.UrlChange
        )
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
