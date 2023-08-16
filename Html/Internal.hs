-- Html.Internal.hs

module Html.Internal where

-- * Types

newtype Html = Html String
  
newtype Structure = Structure String

type Title = String 

-- * EDSL

html_ :: Title -> Structure -> Html
html_ title (Structure content) = 
   Html (el "head" (el "title" (escape title)) <> el "body" content)

h1_ :: String -> Structure
h1_ = Structure . el "h1" . escape

p_ :: String -> Structure
p_ = Structure . el "p" . escape

append_ :: Structure -> Structure -> Structure
append_ (Structure a) (Structure b) = Structure (a <> b)
-- append_ a b =
--   Structure (getStructureString a <> getStructureString b)

ul_ :: [Structure] -> Structure
ul_ =
    Structure . el "ul" . concat . map (el "li" . getStructureString)

ol_ :: [Structure] -> Structure
ol_ =
    Structure . el "ol" . concat . map (el "li" . getStructureString)    

code_ :: String -> Structure
code_ = Structure . el "pre" . escape
-- * Render

render :: Html -> String
render (Html html) = html
-- render html =
--   case html of
--     Html str -> str

-- * Utilities

el :: String -> String -> String
el tag content =  
    "<" <> tag <> ">" <> content <> "</" <> tag <> ">"

getStructureString :: Structure -> String
getStructureString (Structure s) = s
-- getStructureString content =
--   case content of
--     Structure str -> str

escape :: String -> String
escape =
    let
        escapeChar c =
            case c of
                '<' -> "&lt;"
                '>' -> "&gt;"
                '&' -> "&amp;"
                '"' -> "&quot;"
                '\'' -> "&#39;"
                _ -> [c]
    in
        concat . map escapeChar
