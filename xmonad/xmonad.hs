import XMonad
import XMonad.Config.Desktop
import XMonad.Util.Run
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Util.EZConfig
-- import Graphics.X11.ExtraTypes.XF86
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

-- myLayoutHook = spacingRaw True (Border 0 0 0 0) True (Border 1 1 1 1) True $ myLayouts
myLayoutHook = myLayouts

main = do

  xmproc <- spawnPipe "$HOME/.config/xmonad/bin/xmonad-env.sh"

  spawn "/usr/bin/bash $HOME/.config/xmonad/bin/brightness.sh init"

  spawn "/usr/bin/bash $HOME/.config/xmonad/bin/mic.sh init"

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
    , ("M-<Backspace>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ("M-S--", spawn "pactl set-sink-volume @DEFAULT_SINK@ -1%")
    , ("M-S-=", spawn "pactl set-sink-volume @DEFAULT_SINK@ +1%")
    , ("M--", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
    , ("M-=", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
    , ("<Print>", spawn "flameshot gui")
    , ("M-p", spawn (
              "rofi -theme sidebar -font 'Terminus 12' -display-drun '' -display-run ''" ++
              " -show combi -combi-modi run,drun" ++
              "rofi -theme sidebar " ++
              "-font 'Terminus 12' " ++
              "-display-drun '' -display-run '' " ++
              "-show combi -combi-modi run,drun " ++
              "-theme-str " ++
              "'" ++
             "element selected normal {background-color: @green;}" ++ -- from 'sidebar' theme
              "#inputbar{children:[prompt,textbox-prompt-colon,entry,case-indicator];}" ++
              "#prompt{enabled:false;}" ++
              "#textbox-prompt-colon{text-color:inherit;expand:false;margin:0 0 0 0;str:\" \";}" ++
              "'"
              )
      )
    -- CycleWS
    , ("M-.", nextWS)
    , ("M-,", prevWS)
    , ("M-/", toggleWS)
    -- brightness
    , ("<XF86MonBrightnessUp>", spawn "bash $HOME/.config/xmonad/bin/brightness.sh up 5")
    , ("<XF86MonBrightnessDown>", spawn "bash $HOME/.config/xmonad/bin/brightness.sh down 5")
    , ("M-S-[", spawn "bash $HOME/.config/xmonad/bin/brightness.sh down 1")
    , ("M-S-]", spawn "bash $HOME/.config/xmonad/bin/brightness.sh up 1")
    , ("M-[", spawn "bash $HOME/.config/xmonad/bin/brightness.sh down 5")
    , ("M-]", spawn "bash $HOME/.config/xmonad/bin/brightness.sh up 5")
    -- microphone toggle
    , (("M-S-<Backspace>"), spawn "bash $HOME/.config/xmonad/bin/mic.sh toggle")
    ]
    `additionalKeys`
    [
      -- https://hackage.haskell.org/package/xmonad-0.15/docs/XMonad.html
      -- keyboard layout switcher
      ((0, xK_Insert), spawn "(setxkbmap -query | grep -q 'layout:\\s\\+us') && setxkbmap ru || setxkbmap us")
      --   ((mod4Mask, xK_Shift_L), spawn "setxkbmap -layout us")
      -- , ((mod4Mask, xK_Shift_R), spawn "setxkbmap -layout ru")
      -- poweroff
    , ((0, 0x1008FF2A), spawn "systemctl poweroff")
    ]
