import XMonad
import XMonad.Config.Desktop
import XMonad.Wallpaper

main = do
  setRandomWallpaper [ "$HOME/Pictures" ]
  xmonad $ defaultConfig {
    modMask              = mod4Mask         -- set 'Mod' to windows key
    , terminal           = "gnome-terminal" -- for Mod + Shift + Enter
    , borderWidth        = 0
    , focusedBorderColor = "#00FF00"
    }
