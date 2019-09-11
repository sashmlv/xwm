import XMonad
import XMonad.Config.Desktop
import XMonad.Util.Run
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Util.EZConfig
import Graphics.X11.ExtraTypes.XF86

main = do
  xmonad $ docks $ defaultConfig {
    modMask              = mod4Mask         -- set 'Mod' to windows key
    , terminal           = "gnome-terminal" -- for Mod + Shift + Enter
    , borderWidth        = 0
    , focusedBorderColor = "#00FF00"
    , manageHook         = composeAll [
        manageDocks
        , isFullscreen --> doFullFloat
          -- className =? "vlc" --> doFloat,
        , manageHook defaultConfig
        ]
    , layoutHook         = avoidStruts  $  layoutHook defaultConfig -- fix xmobar overlap
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
    ]
