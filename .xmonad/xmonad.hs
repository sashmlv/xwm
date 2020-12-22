import XMonad
import XMonad.Config.Desktop
import XMonad.Util.Run
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Util.EZConfig
import Graphics.X11.ExtraTypes.XF86
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog
import XMonad.Layout.Grid
import XMonad.Layout.MultiColumns

myLayouts = avoidStruts (layoutFull ||| layoutTall ||| layoutMirror ||| layoutGrid ||| layoutMultiCol) -- avoidStruts fixes xmobar overlap
  where
    layoutFull = Full
    layoutTall = Tall 1 (3/100) (1/2)
    layoutMirror = Mirror (Tall 1 (3/100) (1/2))
    layoutGrid = Grid
    layoutMultiCol = multiCol [1] 1 0.01 (-0.5)

main = do

  -- xmproc <- spawnPipe "xmobar ~/.xmonad/.xmobarrc"
  xmproc <- spawnPipe "xmobar ~/.xmonad/.xmobarrc"

  -- no Caps-Lock
  -- spawn "setxkbmap -option ''"
  spawn "setxkbmap -option 'ctrl:nocaps'"

  -- transparency
  spawn "picom --experimental-backends --config ~/.xmonad/picom.conf &"
  -- spawn "compton -b"
  -- xcompmgr -n &

  -- wallpaper
  spawn "feh --bg-fill ~/Pictures/Wallpapers/Wallpaper.jpg"

  -- xresources
  spawn "xrdb -merge -I$HOME ~/.xmonad/.xresources"

  -- brightness fifo
  spawn "bash ~/.xmonad/bin/brightness.sh init"

  -- mic fifo
  spawn "bash ~/.xmonad/bin/mic.sh init"

  xmonad $ docks $ defaultConfig {
    modMask              = mod4Mask         -- set 'Mod' to windows key
    -- , terminal           = "gnome-terminal" -- for Mod + Shift + Enter
    , terminal           = "alacritty -e fish" -- for Mod + Shift + Enter
    , borderWidth        = 0
    , focusedBorderColor = "#00FF00"
    , focusFollowsMouse  = False
    , manageHook         = composeAll [
        manageDocks
        , isFullscreen --> doFullFloat
        -- , className =? "vlc" --> doFloat
        -- , className =? "Rrpm" --> doFloat
        , manageHook defaultConfig
        ]
    , layoutHook         = myLayouts
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
    , ("M-S--", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
    , ("M-S-=", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
    , ("M--", spawn "pactl set-sink-volume @DEFAULT_SINK@ -1%")
    , ("M-=", spawn "pactl set-sink-volume @DEFAULT_SINK@ +1%")
    , ("<Print>", spawn "flameshot gui")
    , ("M-p", spawn "rofi -display-drun '' -display-run '' -theme Arc-Dark -modi combi -show combi -combi-modi run,drun -theme-str '#inputbar{children:[prompt,textbox-prompt-colon,entry,case-indicator];}#prompt{enabled:false;}#textbox-prompt-colon{text-color:inherit;expand:false;margin:0 0 0 0;str:\" \";}'")
    -- CycleWS
    , ("M-.", nextWS)
    , ("M-,", prevWS)
    , ("M-/", toggleWS)
    -- brightness
    , ("<XF86MonBrightnessUp>", spawn "bash ~/.xmonad/bin/brightness.sh up 5")
    , ("<XF86MonBrightnessDown>", spawn "bash ~/.xmonad/bin/brightness.sh down 5")
    , ("M-S-[", spawn "bash ~/.xmonad/bin/brightness.sh down 1")
    , ("M-S-]", spawn "bash ~/.xmonad/bin/brightness.sh up 1")
    , ("M-[", spawn "bash ~/.xmonad/bin/brightness.sh down 5")
    , ("M-]", spawn "bash ~/.xmonad/bin/brightness.sh up 5")
    -- microphone toggle
    , (("M-S-<Backspace>"), spawn "bash ~/.xmonad/bin/mic.sh toggle")
    ]
    `additionalKeys`
    [
      -- keyboard layout switcher
      ((mod4Mask, xK_Shift_L), spawn "setxkbmap -layout us")
    , ((mod4Mask, xK_Alt_L), spawn "setxkbmap -layout ru")
      -- poweroff
    , ((0, 0x1008FF2A), spawn "systemctl poweroff")
    ]
