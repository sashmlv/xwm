import XMonad
import XMonad.Config.Desktop
import XMonad.Util.Run
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Util.EZConfig
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog
import XMonad.Layout.Grid
import XMonad.Layout.MultiColumns
import XMonad.Layout.Spacing

myLayouts = avoidStruts (layoutFull ||| layoutTall ||| layoutMirror ||| layoutGrid ||| layoutMultiCol) -- avoidStruts fixes xmobar overlap
  where
    layoutFull     = spacingRaw False (Border 0 0 0 0) True (Border 0 1 0 0) True $ Full
    layoutTall     = spacingRaw True  (Border 1 0 1 0) True (Border 0 1 0 1) True $ Tall 1 (3/100) (1/2)
    layoutMirror   = spacingRaw True  (Border 1 0 0 1) True (Border 0 1 1 0) True $ Mirror (Tall 1 (3/100) (1/2))
    layoutGrid     = spacingRaw True  (Border 1 0 0 1) True (Border 0 1 1 0) True $ Grid
    layoutMultiCol = spacingRaw True  (Border 1 0 0 1) True (Border 0 1 1 0) True $ multiCol [1] 1 0.01 (-0.5)

myLayoutHook = myLayouts

main = do

  xmproc <- spawnPipe "$HOME/.xmonad/bin/xmonad-env.sh"

  spawn "/usr/bin/bash $HOME/.xmonad/bin/brightness.sh init"

  spawn "/usr/bin/bash $HOME/.xmonad/bin/mic.sh init"

  xmonad $ docks $ def {
    modMask              = mod4Mask         -- set 'Mod' to windows key
    -- , terminal           = "gnome-terminal" -- for Mod + Shift + Enter
    , terminal           = "alacritty -e fish" -- for Mod + Shift + Enter
    , borderWidth        = 0
    , focusedBorderColor = "#00FF00"
    , normalBorderColor  = "#AAAAAA"
    , focusFollowsMouse  = False
    , manageHook         = composeAll [
        manageDocks
        , isFullscreen --> doFullFloat
        -- , className =? "vlc" --> doFloat
        , manageHook def
        ]
    , layoutHook         = myLayoutHook
    , logHook = dynamicLogWithPP $ xmobarPP {
          ppTitle     = \x -> ""
          , ppCurrent = wrap "<fn=2>" "</fn>" . xmobarColor "white" "black"
          , ppLayout  = const "" -- to disable the layout info on xmobar
          , ppOutput  = hPutStrLn xmproc
          }
    }
    `additionalKeysP`
    [
      ("M-b", sendMessage ToggleStruts)
    , ("M-<Backspace>", spawn "/usr/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ("M-S--", spawn "/usr/bin/pactl set-sink-volume @DEFAULT_SINK@ -1%")
    , ("M-S-=", spawn "/usr/bin/pactl set-sink-volume @DEFAULT_SINK@ +1%")
    , ("M--", spawn "/usr/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%")
    , ("M-=", spawn "/usr/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%")
    , ("<Print>", spawn "/usr/bin/flameshot gui")
    , ("M-p", spawn (
              "/usr/bin/rofi -run-command \"/bin/bash -i -c '{cmd}'\" " ++ -- to get env init
              "-theme sidebar " ++
              "-font 'Terminus 12' " ++
              "-display-drun '' -display-run '' " ++
              "-show combi -combi-modi run,drun " ++
              "-theme-str " ++
              "'" ++
              "* {text-color: #CFCFCF;} inputbar {background-color: #00000088;}" ++ -- from 'sidebar' theme
              "mainbox {background-color: #000000AA;} element selected normal {background-color: #33333399;}" ++ -- from 'sidebar' theme
              "#inputbar{children:[prompt,textbox-prompt-colon,entry,case-indicator];}" ++
              "#prompt{enabled:false;} #entry{text-color: #CFCFCF;}" ++
              "#textbox-prompt-colon{text-color:inherit;expand:false;margin:0 0 0 0;str:\" \";}" ++
              "'"
              )
      )
    -- CycleWS
    , ("M-.", nextWS)
    , ("M-,", prevWS)
    , ("M-/", toggleWS)
    -- brightness
    , ("<XF86MonBrightnessUp>", spawn "/usr/bin/bash $HOME/.xmonad/bin/brightness.sh up 5")
    , ("<XF86MonBrightnessDown>", spawn "/usr/bin/bash $HOME/.xmonad/bin/brightness.sh down 5")
    , ("M-S-[", spawn "/usr/bin/bash $HOME/.xmonad/bin/brightness.sh down 1")
    , ("M-S-]", spawn "/usr/bin/bash $HOME/.xmonad/bin/brightness.sh up 1")
    , ("M-[", spawn "/usr/bin/bash $HOME/.xmonad/bin/brightness.sh down 5")
    , ("M-]", spawn "/usr/bin/bash $HOME/.xmonad/bin/brightness.sh up 5")
    -- microphone toggle
    , (("M-S-<Backspace>"), spawn "/usr/bin/bash $HOME/.xmonad/bin/mic.sh toggle")
    ]
    `additionalKeys`
    [
      -- keyboard layout switcher
        ((shiftMask, xK_Shift_R), spawn "/usr/bin/setxkbmap -layout ru")
      , ((shiftMask, xK_Shift_L), spawn "/usr/bin/setxkbmap -layout us")
      -- poweroff
      , ((0, 0x1008FF2A), spawn "/usr/bin/systemctl poweroff")
    ]
