import XMonad
import qualified XMonad.StackSet as W
import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Actions.Navigation2D
import XMonad.Actions.FloatKeys
import Data.Monoid
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing

main = do
  xmproc <- spawnPipe "xmobar $XDG_CONFIG_HOME/xmobar/xmobarrc"
    
  xmonad $ ewmh def
    { terminal           = myTerminal
    , modMask            = myModMask
    , borderWidth        = myBorderWidth
    , focusedBorderColor = myFocusedBorderColor
    -- , borderColor = "#0055FF"
    , manageHook         = manageDocks <+> manageHook def
    , layoutHook         = myLayoutHook
    , handleEventHook    = handleEventHook def <+> docksEventHook
    , logHook            = myLogHook xmproc
    }
    `additionalKeysP`
    myKeybindings

myLogHook dest = dynamicLogWithPP def { ppOutput = hPutStrLn dest
                                      , ppVisible = wrap "(" ")"
                                      }
myFocusedBorderColor = "#10EEFF"
myModMask = mod4Mask
myBorderWidth = 2
myOuterGapWidth = 15
myInnerGapWidth = 5
myInnerGapBorder = Border myInnerGapWidth myInnerGapWidth myInnerGapWidth myInnerGapWidth
myLayoutHook = avoidStruts $ spacingRaw False myInnerGapBorder True myInnerGapBorder True
  $ layoutHook def
-- myLayoutHook = gaps [(U, myOuterGapWidth), (R, myOuterGapWidth), (D, myOuterGapWidth), (L, myOuterGapWidth)] $ Tall 1 (3/100) (1/2) ||| Full

myKeybindings :: [(String, X ())]
myKeybindings =
  [
    ("M-j",            windows W.focusUp)
  , ("M-k",            windows W.focusDown)
  , ("M-J",            windows W.swapDown)
  , ("M-K",            windows W.swapUp)
  , ("M-W",            withFocused (keysMoveWindow ( 0, -1)))
  , ("M-S",            withFocused (keysMoveWindow ( 0,  1)))
  , ("M-A",            withFocused (keysMoveWindow (-1,  0)))
  , ("M-D",            withFocused (keysMoveWindow ( 1,  0))) 
  -- , ("M-M1-W",         withFocused (keysResizeWindow ( 0, -1) ( 0,  0)))
  -- , ("M-M1-S",         withFocused (keysResizeWindow ( 0,  1) ( 0,  0)))
  -- , ("M-M1-A",         withFocused (keysResizeWindow (-1, -0) ( 0,  1)))
  -- , ("M-M1-D",         withFocused (keysResizeWindow ( 1,  0) ( 0,  0)))
  , ("M-=",            incScreenWindowSpacing 1)
  , ("M--",            incScreenWindowSpacing (-1))
  , ("M-<Home>",       setScreenWindowSpacing myInnerGapWidth)
  , ("M-<KP_Home>",    setScreenWindowSpacing myInnerGapWidth)

  -- , ("M-\\=", incScreenWindowSpacing 1)
  -- , ("M-\\-", incScreenWindowSpacing (-1))
  -- , ("M-<Home>", setScreenWindowSpacing myInnerGapWidth)
  -- , ("M-<KP_Home>", setScreenWindowSpacing myInnerGapWidth)
  ]
myTerminal = "st"

-- myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
-- myManageHook = composeAll
     -- -- 'doFloat' forces a window to float.  Useful for dialog boxes and such.
     -- -- using 'doShift ( myWorkspaces !! 7)' sends program to workspace 8!
     -- -- I'm doing it this way because otherwise I would have to write out the full
     -- -- name of my workspaces and the names would be very long if using clickable workspaces.
     -- [ className =? "confirm"         --> doFloat
     -- , className =? "file_progress"   --> doFloat
     -- , className =? "dialog"          --> doFloat
     -- , className =? "download"        --> doFloat
     -- , className =? "error"           --> doFloat
     -- , className =? "Gimp"            --> doFloat
     -- , className =? "notification"    --> doFloat
     -- , className =? "pinentry-gtk-2"  --> doFloat
     -- , className =? "splash"          --> doFloat
     -- , className =? "toolbar"         --> doFloat
     -- , title =? "Oracle VM VirtualBox Manager"  --> doFloat
     -- , title =? "Mozilla Firefox"     --> doShift ( myWorkspaces !! 1 )
     -- , className =? "brave-browser"   --> doShift ( myWorkspaces !! 1 )
     -- , className =? "qutebrowser"     --> doShift ( myWorkspaces !! 1 )
     -- , className =? "mpv"             --> doShift ( myWorkspaces !! 7 )
     -- , className =? "Gimp"            --> doShift ( myWorkspaces !! 8 )
     -- , className =? "VirtualBox Manager" --> doShift  ( myWorkspaces !! 4 )
     -- , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialog
     -- ] <+> namedScratchpadManageHook myScratchPads
