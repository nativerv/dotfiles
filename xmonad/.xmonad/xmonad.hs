import XMonad
import XMonad.Actions.Navigation2D
import XMonad.Actions.FloatKeys
import XMonad.Actions.CycleWS
import System.Exit
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import Data.Monoid
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.DynamicLog
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Layout.ResizableTile
import XMonad.Config.Desktop
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig
import XMonad.Util.Cursor
import System.IO

main = do
  xmobarProc <- spawnPipe "killall; xmobar $HOME/.config/xmobar/xmobarrc"
    
  xmonad $ desktopConfig
    { terminal           = myTerminal
    , modMask            = myModMask
    , keys               = myKeybindings
    , borderWidth        = myBorderWidth
    , focusedBorderColor = myFocusedBorderColor
    , manageHook         = myManageHook
    , workspaces         = myWorkspaces
    , layoutHook         = myLayoutHook
    , handleEventHook    = myHandleEventHook
    , logHook            = myLogHook xmobarProc
    , startupHook        = myStartupHook
    }
    `additionalKeysP`
    myEzKeybindings

myTerminal = "st"
myModMask = mod4Mask
myBorderWidth = 0
myOuterGapWidth = 15
myInnerGapWidth = 5

myLogHook dest = dynamicLogWithPP xmobarPP
  { ppOutput = hPutStrLn dest
  , ppVisible = wrap "(" ")"
  , ppCurrent = wrap "[" "]"
  }
myFocusedBorderColor = "#10EEFF"
-- , borderColor = "#0055FF"

xmobarEscape = concatMap doubleLts
  where doubleLts '<' = "<<"
        doubleLts x   = [x]

modMaskName :: KeyMask -> String
modMaskName modMask
  | modMask == mod1Mask = "alt"
  | modMask == mod2Mask = "Num_Lock"
  | modMask == mod3Mask = undefined
  | modMask == mod4Mask = "super"
  | modMask == mod5Mask = undefined

myWorkspaces :: [String]        
myWorkspaces = clickable . (map xmobarEscape) $ ["www", ">_", "vid", "game", "tool"]
  where                                                                       
    -- clickable l = [ "<action=xdotool key super+" ++ show (n) ++ ">" ++ ws ++ "</action>" |
                             -- (i,ws) <- zip [1..5] l, let n = i
                  -- ]
    clickable workspaceList = 
      [
        concat [ "<action=xdotool key "
                , modMaskName myModMask
                , "+"
                , show index
                , ">"
                , workspace
                , "</action>" 
               ] |
        (index, workspace) <- zip [1..5] workspaceList 
      ]

myInnerGapBorder :: Border
myInnerGapBorder = Border myInnerGapWidth myInnerGapWidth myInnerGapWidth myInnerGapWidth

-- myLayoutHook :: ModifiedLayout
myLayoutHook = avoidStruts
  $ spacingRaw False myInnerGapBorder True myInnerGapBorder True
  $ tallLayout ||| Full  
  where
    --                         MasterCount ResizeAmount MasterSize SomeShit
    tallLayout = ResizableTall 1           (1/30)       0.5        []

-- myLayoutHook = gaps [(U, myOuterGapWidth), (R, myOuterGapWidth), (D, myOuterGapWidth), (L, myOuterGapWidth)] $ Tall 1 (3/100) (1/2) ||| Full


myHandleEventHook :: Event -> X All
myHandleEventHook = handleEventHook def <+> docksEventHook

myEzKeybindings :: [(String, X ())]
myEzKeybindings =
  [
    -- Focus hotkeys
    ("M-h",            windows W.focusUp)
  , ("M-l",            windows W.focusDown)

  -- Workspace Cycling hotkeys
  , ("M-j",            moveTo Prev NonEmptyWS)
  , ("M-k",            moveTo Next NonEmptyWS)

  -- Window Swap hotkeys
  , ("M-C-j",          windows W.swapDown)
  , ("M-C-k",          windows W.swapUp)


  -- Window Resize hotkeys
  , ("M-S-h",          sendMessage Shrink)
  , ("M-S-l",          sendMessage Expand)
  , ("M-S-j",          sendMessage MirrorShrink)
  , ("M-S-k",          sendMessage MirrorExpand)

  -- Window Movement hotkeys
  , ("M-S-w",          withFocused (keysMoveWindow ( 0, -3)))
  , ("M-S-s",          withFocused (keysMoveWindow ( 0,  3)))
  , ("M-S-a",          withFocused (keysMoveWindow (-3,  0)))
  , ("M-S-d",          withFocused (keysMoveWindow ( 3,  0))) 

  -- Window Floating Movement Hotkey
  , ("M-M1-S-w",       withFocused (keysResizeWindow ( 0, -1) ( 0,  0)))
  , ("M-M1-S-s",       withFocused (keysResizeWindow ( 0,  1) ( 0,  0)))
  , ("M-M1-S-a",       withFocused (keysResizeWindow (-1, -0) ( 0,  1)))
  , ("M-M1-S-d",       withFocused (keysResizeWindow ( 1,  0) ( 0,  0)))

  -- Spacing hotkeys
  , ("M--",            incScreenWindowSpacing 1)
  , ("M-=",            incScreenWindowSpacing (-1))
  , ("M-<Home>",       setScreenWindowSpacing myInnerGapWidth)

  -- Screenshot hotkeys
  , ("<Print>",    spawn "flameshot full --clipboard")
  , ("C-<Print>",  spawn "flameshot gui")

  -- Poweroff hotkeys
  , ("M-q l",          spawn "lock")
  , ("M-q q",          spawn "poweroff-ask")
  , ("M-q r",          spawn "reboot-ask")
  , ("M-q s",          spawn "suspend-ask")
  , ("M-q h",          spawn "hibernate-ask")

  -- Debug hotkeys
  , ("M-d r",          spawn "xmonad-restart")
  , ("M-d c",          spawn "xmonad-recompile && xmonad-restart")
  ]

myStartupHook :: X ()
myStartupHook = do
    setDefaultCursor xC_left_ptr
    -- spawnOnce "lxsession &"
    spawnOnce "feh --randomize --bg-fill ~/pix/wall/* &"
    spawnOnce "unclutter &"
    spawnOnce "dunst &"
    spawnOnce "picom --config $HOME/.config/picom/picom.jonaburg.conf &"
    spawnOnce "nm-applet &"
    spawnOnce "volumeicon &"
    spawnOnce "flameshot &"
    -- spawnOnce "conky -c $HOME/.config/conky/xmonad.conkyrc"
    spawn "killall trayer; trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --monitor 1 --transparent true --alpha 0 --tint 0x33373F --height 18"
    -- spawnOnce "/usr/bin/emacs --daemon &" -- emacs daemon for the emacsclient
    -- spawnOnce "kak -d -s mysession &"  -- kakoune daemon for better performance
    -- spawnOnce "urxvtd -q -o -f &"      -- urxvt daemon for better performance

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
-- myManageHook = composeAll
myManageHook = 
     -- 'doFloat' forces a window to float.  Useful for dialog boxes and such.
     -- using 'doShift ( myWorkspaces !! 7)' sends program to workspace 8!
     -- I'm doing it this way because otherwise I would have to write out the full
     -- name of my workspaces and the names would be very long if using clickable workspaces.
     composeAll
     [ className =? "confirm"         --> doCenterFloat
     , className =? "file_progress"   --> doCenterFloat
     , className =? "dialog"          --> doCenterFloat
     , className =? "Dragon-drag-and-drop"          --> doCenterFloat
     , className =? "Zenity"          --> doCenterFloat
     , stringProperty "WM_WINDOW_ROLE" =? "gimp-message-dialog"  --> doCenterFloat
     , stringProperty "WM_WINDOW_ROLE" =? "GtkFileChooserDialog" --> doRectFloat (W.RationalRect 0 0 0.6 0.6)
     , stringProperty "WM_WINDOW_ROLE" =? "GtkFileChooserDialog" --> doCenterFloat
     , className =? "download"        --> doCenterFloat
     , className =? "error"           --> doCenterFloat
     -- , className =? "Gimp"            --> doFloat
     , className =? "notification"    --> doCenterFloat
     , className =? "pinentry-gtk-2"  --> doFloat
     , className =? "splash"          --> doCenterFloat
     , className =? "toolbar"         --> doFloat
     , title =? "Oracle VM VirtualBox Manager"  --> doCenterFloat
     , title =? "Media viewer" 
       <&&>
       className =? "TelegramDesktop" --> doFullFloat
     -- , title =? "Mozilla Firefox"     --> doShift ( myWorkspaces !! 1 )
     -- , className =? "brave-browser"   --> doShift ( myWorkspaces !! 1 )
     -- , className =? "qutebrowser"     --> doShift ( myWorkspaces !! 1 )
     -- , className =? "mpv"             --> doShift ( myWorkspaces !! 7 )
     -- , className =? "Gimp"            --> doShift ( myWorkspaces !! 8 )
     , className  =? "feh"            --> doFullFloat
     , className  =? "sxiv"           --> doFullFloat
     ]  <+> manageDocks <+> manageHook def
     -- <+> namedScratchpadManageHook myScratchPads

-- All default keybindings from XMonad source code
-- Pasted here as api reference
myKeybindings :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeybindings conf @ XConfig { XMonad.modMask = modMask } = M.fromList $
    -- launching and killing programs
    [ ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf) -- %! Launch terminal
    , ((modMask,               xK_p     ), spawn "dmenu_run") -- %! Launch dmenu
    , ((modMask .|. shiftMask, xK_p     ), spawn "gmrun") -- %! Launch gmrun
    , ((modMask .|. shiftMask, xK_c     ), kill) -- %! Close the focused window

    , ((modMask,               xK_space ), sendMessage NextLayout) -- %! Rotate through the available layout algorithms
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf) -- %!  Reset the layouts on the current workspace to default

    , ((modMask,               xK_n     ), refresh) -- %! Resize viewed windows to the correct size

    -- move focus up or down the window stack
    , ((modMask,               xK_Tab   ), windows W.focusDown) -- %! Move focus to the next window
    , ((modMask .|. shiftMask, xK_Tab   ), windows W.focusUp  ) -- %! Move focus to the previous window
    , ((modMask,               xK_j     ), windows W.focusDown) -- %! Move focus to the next window
    , ((modMask,               xK_k     ), windows W.focusUp  ) -- %! Move focus to the previous window
    , ((modMask,               xK_m     ), windows W.focusMaster  ) -- %! Move focus to the master window

    -- modifying the window order
    , ((modMask,               xK_Return), windows W.swapMaster) -- %! Swap the focused window and the master window
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  ) -- %! Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    ) -- %! Swap the focused window with the previous window

    -- resizing the master/slave ratio
    , ((modMask,               xK_h     ), sendMessage Shrink) -- %! Shrink the master area
    , ((modMask,               xK_l     ), sendMessage Expand) -- %! Expand the master area

    -- floating layer support
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink) -- %! Push window back into tiling

    -- increase or decrease number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1)) -- %! Increment the number of windows in the master area
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1))) -- %! Deincrement the number of windows in the master area

    -- quit, or restart
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess)) -- %! Quit xmonad
    , ((modMask              , xK_q     ), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi") -- %! Restart xmonad

    -- Commented as `help` is not available
    -- , ((modMask .|. shiftMask, xK_slash ), helpCommand) -- %! Run xmessage with a summary of the default keybindings (useful for beginners)
    -- -- repeat the binding for non-American layout keyboards
    -- , ((modMask              , xK_question), helpCommand) -- %! Run xmessage with a summary of the default keybindings (useful for beginners)
    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    -- mod-{w,e,r} %! Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r} %! Move client to screen 1, 2, or 3
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
  -- where
    -- helpCommand :: X ()
    -- helpCommand = spawn ("printf " ++ show help ++ " | xmessage -file -")
