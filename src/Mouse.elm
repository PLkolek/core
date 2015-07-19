module Mouse
    ( position, x, y
    , isDown, clicks
    , left, right
    ) where

{-| Library for working with mouse input.

# Position
@docs position, x, y

# Button Status
@docs isDown, clicks, left, right

-}

import Basics exposing (fst, snd, (==))
import Native.Mouse
import Signal exposing (Signal)
import Maybe exposing (Maybe(Just, Nothing))


{-| The current mouse position. -}
position : Signal (Int,Int)
position =
  Native.Mouse.position


{-| The current x-coordinate of the mouse. -}
x : Signal Int
x =
  Signal.map fst position


{-| The current y-coordinate of the mouse. -}
y : Signal Int
y =
  Signal.map snd position


{-| The current state of the left mouse-button.
True when the button is down, and false otherwise. -}
isDown : Signal Bool
isDown =
  Native.Mouse.isDown

{-| Recently clicked [mouse button](https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/button).
Event triggers on every mouse click. -}
clicks : Signal Int
clicks =
  Native.Mouse.clicks

buttonClicks : Int -> Signal ()
buttonClicks button =
  let buttonFilter b = if b == button then Just () else Nothing
  in Signal.filterMap buttonFilter () clicks

{-| Always equal to unit. Event triggers on every left mouse button click. -}
left : Signal ()
left =
  buttonClicks 0

  {-| Always equal to unit. Event triggers on every right mouse button click. -}
right : Signal ()
right =
  buttonClicks 2
