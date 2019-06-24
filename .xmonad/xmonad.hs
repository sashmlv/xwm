import XMonad
import XMonad.Config.Desktop
import XMonad.Util.Run
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Util.EZConfig

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
    `additionalKeys`
    [ ((mod4Mask, xK_b), sendMessage ToggleStruts) ]
