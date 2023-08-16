import Html
main = putStrLn (render myhtml)

myhtml :: Html
myhtml = 
    html_ 
    "lhbg"
    (append_(h1_ "Hello, world!") (p_ "Let's learn about Haskell!"))
