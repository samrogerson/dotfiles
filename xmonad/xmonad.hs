import XMonad
--- Configs
import XMonad.Config.Xfce
--- Hooks
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
--- Layouts
import XMonad.Layout
import XMonad.Layout.Grid
import XMonad.Layout.IM
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ResizableTile
import XMonad.Layout.StackTile
import XMonad.Layout.Tabbed
--- System
import System
import System.Environment
import System.IO
--- Utils
import XMonad.Util.EZConfig
--- Data
import Data.Ratio ((%))
--- aliases
import qualified Data.Map as M
import qualified XMonad.StackSet as W



myIgnores = ["Do"]
myFloats  = ["Canvas", "Browser", "Xfrun4"]
webApps   = ["Chromium"]
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
     , [className =? "Claws-mail" <&&> role  =? "compose"         --> doFloat]
     , [className =? "Claws-mail" <&&> title =? "Discard message" --> doFloat]
     , [isFullscreen   --> doFullFloat ]
     ]
     where moveTo = doF . W.shift
           role = stringProperty "WM_WINDOW_ROLE"

--- Workspaces
myWorkspaces = 
  ["1:work","2:web","3:docs","4:root","5:misc2","6:misc3","7:music","8:chat","9:mail" ]

-- Layouts
myLayout = avoidStruts $ onWorkspace "8:chat" imLayout $ 
                         standardLayouts
  where
    -- define the list of standardLayouts
    standardLayouts = tiled ||| Mirror tiled ||| Full ||| simpleTabbed

    -- notice withIM is acting on it
    imLayout        = withIM (1%7) skypeRoster Grid

    -- default tiling algorithm partitions the screen into two panes
    tiled   = Tall nmaster delta ratio

    -- The default number of windows in the master pane
    nmaster = 1

    -- Default proportion of screen occupied by master pane
    ratio   = 1/2

    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

    skypeRoster     = (ClassName "Skype") `And` (Not (Title "Options")) `And` (Not (Role "Chats")) `And` (Not (Role "CallWindowForm"))

main = do
    xmonad $ xfceConfig
     { 
      terminal = "urxvt"
     ,manageHook = manageHook xfceConfig <+> myManageHook
     ,workspaces = myWorkspaces 
     ,layoutHook = smartBorders (myLayout) 
    }
