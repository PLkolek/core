module Mouse
    ( position, x, y
    , isDown, clicks
    , left, right
    ) where

{-| Library for working with mouse input.

# Representing mouse buttons
@docs MouseButton

# Specific buttons
@docs buttonLeft, buttonRight

# Position
@docs position, x, y

# Button Status
@docs isDown, clicks, left, right

-}

import Basics exposing (fst, snd, (==))
import Native.Mouse
import Signal exposing (Signal)
import Maybe exposing (Maybe(Just, Nothing))


{-| Integers represent [mouse buttons](https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/button).
-}
type alias MouseButton = Int

{-| -}
buttonLeft : MouseButton
buttonLeft = 0

{-| -}
buttonRight : MouseButton
buttonRight = 2

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

{-| Recently clicked mouse button. Event triggers on every mouse click. -}
clicks : Signal MouseButton
clicks =
  Native.Mouse.clicks

buttonClicks : Int -> Signal ()
buttonClicks button =
  let buttonFilter b = if b == button then Just () else Nothing
  in Signal.filterMap buttonFilter () clicks

{-| Always equal to unit. Event triggers on every left mouse button click. -}
left : Signal ()
left =
  buttonClicks buttonLeft

{-| Always equal to unit. Event triggers on every right mouse button click. -}
right : Signal ()
right =
  buttonClicks buttonRight
