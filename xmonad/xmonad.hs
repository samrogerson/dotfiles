import XMonad
--- Hooks
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.UrgencyHook
--- Actions
import XMonad.Actions.WithAll       -- act on all windows (killall)
import XMonad.Actions.GridSelect    -- fancy grid menus for all
import XMonad.Actions.CycleWS       -- cycle on / shift to workspaces
--- Layouts
import XMonad.Layout
import XMonad.Layout.Grid
import XMonad.Layout.IM
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ResizableTile
import XMonad.Layout.StackTile
import XMonad.Layout.Tabbed
import XMonad.Layout.Named
import XMonad.Layout.Simplest
import XMonad.Layout.Decoration
import XMonad.Layout.TabBarDecoration
import XMonad.Layout.ResizeScreen
--- System
---import System
---import System.Environment
---port System.IO
--- Utils
import XMonad.Util.EZConfig
import XMonad.Util.Dmenu
import XMonad.Util.NamedWindows
--- Data
import Data.Ratio ((%))
--- aliases
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import qualified XMonad.Prompt as P

main            = xmonad =<<
                  statusBar myBar myPP toggleStrutsKey (ewmh $ myUrgencyHook $ myConfig)

myUrgencyHook   = withUrgencyHook NoUrgencyHook

--XMOBAR
------------------------------------------------------------------------
myBar           = "xmobar"
myPP            = xmobarPP
                { ppCurrent = xmobarColor base0 "" . wrap "[" "]" 
                , ppVisible = wrap "(" ")"
                --, ppHidden  = wrap " " " "
                , ppUrgent  = xmobarColor red base03 . wrap "*" "*"
                , ppWsSep   = " "
                , ppTitle   = xmobarColor green "" . shorten 40 }
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)


--APPS
------------------------------------------------------------------------
myTerminal      = "urxvtc"
myBrowser       = "firefox"
myAltBrowser    = "chromium"
myMailClient    = "urxvtc -e mutt"
myVolume        = "urxvtc -e alsamixer"
myWifiManager   = "urxvtc -e wicd-curses"
myPerfMonitor   = "urxvtc -e htop"
myScreenshot    = "scrot -s"

-- | Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False


--THEME
------------------------------------------------------------------------
base03          = "#002b36"
base02          = "#073642"
base01          = "#586e75"
base00          = "#657b83"
base0           = "#839496"
base1           = "#93a1a1"
base2           = "#eee8d5"
base3           = "#fdf6e3"
yellow          = "#b58900"
orange          = "#cb4b16"
red             = "#dc322f"
magenta         = "#d33682"
violet          = "#6c71c4"
blue            = "#268bd2"
cyan            = "#2aa198"
green           = "#719e07"

myModMask       = mod1Mask
myBorderWidth   = 2
myBorder        = base02
myBorderFocus   = green
myFontSize s    = "xft:terminus:style=bold:pixelsize=" ++ show s
myFontBig       = myFontSize 16
myFont          = myFontSize 14
myFontSmall     = myFontSize 12

myTabTheme :: Theme
myTabTheme = defaultTheme
    { activeColor           = base03
    , inactiveColor         = base02
    , urgentColor           = yellow
    , activeBorderColor     = base03
    , inactiveBorderColor   = base03
    , urgentBorderColor     = yellow
    , activeTextColor       = base2
    , inactiveTextColor     = base01
    , urgentTextColor       = yellow
    , fontName              = myFontSmall
    }

--GRIDSELECT
------------------------------------------------------------------------
myGSConfig      = defaultGSConfig
                { gs_cellheight = 45
                , gs_cellwidth  = 200
                , gs_font = myFontBig
                }

--MANAGEHOOK
------------------------------------------------------------------------
myIgnores = ["Do"]
myFloats  = ["Canvas", "Browser", "Xfrun4", "Vlc", "net-sourceforge-jnlp-runtime-Boot"]
webApps   = ["Chromium", "Firefox"]
docApps   = ["Apvlv", "Zathura", "Evince"]
chatApps  = ["Irssi", "Skype", "Pidgin"]
mailApps  = ["Claws-mail", "Thunderbird"]

myManageHook =  composeAll . concat $
     [ [resource  =? c --> doIgnore        | c <- myIgnores ]
     , [className =? c --> doFloat         | c <- myFloats  ]
     , [className =? c --> moveTo "2:web"  | c <- webApps   ]
     , [className =? c --> moveTo "3:docs" | c <- docApps   ]
     , [className =? c --> moveTo "8:chat" | c <- chatApps  ]
     , [className =? c --> moveTo "9:mail" | c <- mailApps  ]
     , [name =? "mutt"  --> moveTo "9:mail" ]
     , [name =? "Vievo" --> doFloat ]
     , [isFullscreen    --> doFullFloat ]
     ]
     where moveTo = doF . W.shift
           role = stringProperty "WM_WINDOW_ROLE"
           name = stringProperty "WM_NAME"

-- Workspaces
------------------------------------------------------------------------
myWorkspaces = 
  ["1:work","2:web","3:docs","4:root","5:misc2","6:misc3","7:music","8:chat","9:mail" ]


--LAYOUT
------------------------------------------------------------------------
myLayout        =   avoidStruts $
                    smartBorders $ 
                    onWorkspace "8:chat" tabs $
                    (tiled ||| tabs ||| Mirror tiled ||| Full)
                        where
                        tiled   = Tall nmaster delta ratio
                        nmaster = 1
                        ratio   = 1/2
                        delta   = 3/100
                        tabs    = named "Tabbed"
                                  $ myTab $ Simplest
                        myTab l = tabBar shrinkText myTabTheme Top
                                  $ resizeVertical (fi $ decoHeight myTabTheme)
                                  $ l


--BINDINGS
------------------------------------------------------------------------
myKeys          = myKeymap myConfig
myKeymap conf   = [ ("S-M-c",               killAll                 )
                  , ("M-c",                 kill                    )
                  , ("M-<Right>",           moveTo Next NonEmptyWS  )
                  , ("M-<Left>",            moveTo Prev NonEmptyWS  )
                  , ("M4-b",                spawn myBrowser         )
                  , ("S-M4-b",              spawn myAltBrowser      )
                  , ("M4-m",                spawn myMailClient      )
                  , ("M4-v",                spawn myVolume          )
                  , ("M4-w",                spawn myWifiManager     )
                  , ("M4-t",                spawn myPerfMonitor     )
                  , ("M4-s",                spawn myScreenshot      )
                  , ("M4-x",                goToSelected myGSConfig )
                  , ("M3",                  spawn myBrowser         )
                  , ("M-<Backspace>",       focusUrgent             ) ]


--STARTUP
------------------------------------------------------------------------
myStartupHook   = do
                  ewmhDesktopsStartup
                  return () >> checkKeymap myConfig myKeys


--CONFIG
------------------------------------------------------------------------
myConfig        = defaultConfig
                  { borderWidth         = myBorderWidth
                  , normalBorderColor   = myBorder
                  , focusedBorderColor  = myBorderFocus
                  , focusFollowsMouse   = myFocusFollowsMouse
                  , layoutHook          = myLayout
                  , manageHook          = myManageHook
                  , workspaces          = myWorkspaces 
                  , modMask             = myModMask
                  , startupHook         = myStartupHook
                  , terminal            = myTerminal }
                  `additionalKeysP`     (myKeys)
