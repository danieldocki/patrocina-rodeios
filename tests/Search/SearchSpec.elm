module Search.SearchSpec exposing (..)
import Search.View exposing (search)
import Search.Update as Update
import Msgs
import Html.Attributes as Attributes
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Test.Html.Event as Event

tests : Test
tests =
    describe "Search"
        [ test "that search renders an text input with the given term" <|
            \() ->
            Query.has [ Selector.attribute <| Attributes.value "Cruel Company" ] <|
            Query.find [ Selector.tag "input" ] <|
            Query.fromHtml <|
                search <|
                    { term = "Cruel Company" }
        , test "that search throw the search input event when user types" <|
            \() ->
            Event.expect ((Msgs.Search << Update.Input) "a") <|
            Event.simulate (Event.input "a") <|
            Query.find [ Selector.tag "input" ] <|
            Query.fromHtml <|
                search { term = "" }
        ]