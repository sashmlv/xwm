import XMonad
import XMonad.Config.Desktop
import XMonad.Util.Run
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Util.EZConfig
import Graphics.X11.ExtraTypes.XF86
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog

main = do

  -- xmproc <- spawnPipe "xmobar ~/.xmonad/.xmobarrc"
  xmproc <- spawnPipe "xmobar ~/.xmonad/.xmobarrc"

  -- keyboard layout switcher
  -- spawn "setxkbmap -layout us,ru -option ''"
  spawn "setxkbmap -layout us,ru -option 'grp:lctrl_lwin_toggle,grp_led:scroll,ctrl:nocaps'" -- lctrl_lwin_toggle, alt_space_toggle, win_space_toggle

  -- transparency
  spawn "compton -b"
  -- xcompmgr -n &

  -- wallpaper
  spawn "feh --bg-fill ~/Pictures/Wallpapers/Wallpaper.jpg"

  -- xresources
  spawn "xrdb -merge -I$HOME ~/.xmonad/.xresources"

  -- mount disks
  -- use this command for disk search: lsblk -f
  spawn "udisksctl mount -b /dev/sdb1"
  spawn "udisksctl mount -b /dev/sdc1"

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
        , manageHook defaultConfig
        ]
    , layoutHook         = avoidStruts $ layoutHook defaultConfig -- fix xmobar overlap
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

    , ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -2%")
    , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +2%")
    , ("M-<Backspace>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ("M--", spawn "pactl set-sink-volume @DEFAULT_SINK@ -2%")
    , ("M-=", spawn "pactl set-sink-volume @DEFAULT_SINK@ +2%")

    , ("<Print>", spawn "flameshot gui")

    , ("M-p", spawn "dmenu_run -b -fn 'Office Code Pro-9' -l 12 -sb '#AAA' -sf '#000' -nb '#000' -nf '#FFF'")

    -- CycleWS
    , ("M-.", nextWS)
    , ("M-,", prevWS)
    , ("M-/", toggleWS)
    ]
