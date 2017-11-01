-- See /usr/share/xmonad/man/xmonad.hs for reference.
-- * Imports

import XMonad
import XMonad.Config.Azerty     (azertyKeys)
import XMonad.Layout.NoBorders  (noBorders)
import XMonad.Hooks.DynamicLog  (statusBar, xmobarPP)
import XMonad.Hooks.ManageDocks (avoidStruts)
import XMonad.Hooks.UrgencyHook (withUrgencyHook, NoUrgencyHook(..))

import Data.Monoid (mempty)
import System.Exit (exitSuccess)

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- * Basic settings

-- The preferred terminal program (used below and by some contrib modules).
myTerminal = "urxvt"

myFocusFollowsMouse = False     -- Focus doesn't follows the mouse pointer.
myClickJustFocuses  = False     -- Clicking on a window to focus also passes the click to the window
myBorderWidth       = 1         -- Width of the window border in pixels.
myModMask           = mod4Mask  -- Use the "Windows key" as modkey.

-- The default number of workspaces (virtual screens) and their names.
myWorkspaces :: [WorkspaceId]
myWorkspaces = map show [1 .. 9 :: Int]

-- Border colors for unfocused and focused windows, respectively.
myNormalBorderColor  = "#cccccc"
myFocusedBorderColor = "#00ff00"

-- * Key bindings

-- See man 1 scrot for details.
screenshotFmt = "~/screenshot_%Y-%m-%d-%H-%M-%S.png"

-- Toggle the status bar gap.
toggleStrutsKey XConfig {XMonad.modMask = modm} = (modm, xK_b)

myKeys conf@XConfig {XMonad.modMask = modm} = M.fromList
-- ** Programs shortcuts

    -- Terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- Launcher
    , ((modm,               xK_p     ), spawn "dmenu_run")

    -- Screenshot
    --
    -- XXX: for `--select` a short sleep seems needed, I don't understand why :/
    -- Source: https://www.reddit.com/r/xmonad/comments/6ynn6m/i_have_a_spawn_scrot_that_silently_fails_help/
    , ((modm,               xK_Print ), spawn $ "scrot " ++ screenshotFmt)
    , ((modm .|. shiftMask, xK_Print ), spawn $ "sleep 0.2; scrot --select  " ++ screenshotFmt)

    -- Lockscreen
    , ((modm,               xK_Pause ), spawn "hslock")

-- ** Windows management

    -- Close focused window.
    , ((modm .|. shiftMask, xK_c     ), kill)
    -- Resize viewed windows to the correct size.
    , ((modm,               xK_n     ), refresh)
    -- Push window back into tiling.
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

-- *** Focus

    -- Move focus to the next window.
    , ((modm,               xK_Tab   ), windows W.focusDown)
    -- Move focus to the next window.
    , ((modm,               xK_j     ), windows W.focusDown)
    -- Move focus to the previous window.
    , ((modm,               xK_k     ), windows W.focusUp  )
    -- Move focus to the master window.
    , ((modm,               xK_m     ), windows W.focusMaster)
    -- Swap the focused window and the master window.
    , ((modm,               xK_Return), windows W.swapMaster)
    -- Swap the focused window with the next window.
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
    -- Swap the focused window with the previous window.
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

-- *** Master area

    -- Shrink the master area.
    , ((modm,               xK_h     ), sendMessage Shrink)
    -- Expand the master area.
    , ((modm,               xK_l     ), sendMessage Expand)
    -- Increment the number of windows in the master area.
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
    -- Deincrement the number of windows in the master area.
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

-- ** Layout

    -- Cycle through the available layout algorithms.
    , ((modm,               xK_space ), sendMessage NextLayout)
    -- Reset the layouts on the current workspace to default.
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

-- ** XMonad

    -- Quit XMonad.
    , ((modm .|. shiftMask, xK_q     ), io exitSuccess)
    -- Restart XMMonad.
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    ]

-- ** Workspace

    -- I use `azertyKeys` in `myConfig`:
    --
    -- mod-[1..9]         Switch to workspace N.
    -- mod-shift-[1..9]   Move client to workspace N.
    -- mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3.
    -- mod-shift-{w,e,r}  Move client to screen 1, 2, or 3.
    --
    -- See XMonad.Config.Azerty for the details

-- * Mouse bindings

-- I don't use the mouse.
myMouseBindings XConfig {XMonad.modMask = modm} = M.fromList []

-- * Layouts

-- This is the default (I keep it here as documentation).
myLayout = avoidStruts (tiled ||| Mirror tiled ||| noBorders Full)
    where
        -- Default tiling algorithm partitions the screen into two panes.
        tiled   = Tall nmaster delta ratio
        -- The default number of windows in the master pane.
        -- Can be modified on-the-fly with `Mod-,` and `Mod-;`.
        nmaster = 1
        -- Default proportion of screen occupied by master pane.
        ratio   = 1/2
        -- Percent of screen to increment by when resizing panes.
        delta   = 3/100

-- * Hooks

-- Window rules
--
-- Execute actions and WindowSet manipulations when managing a new window.
--
-- To find the properties associated with a program, use `xprop`.
-- See XMonad.ManageHook for more details.
myManageHook = composeAll
    [ className =? "Emacs"     --> doShift "4"
    , className =? "Keepassx"  --> doShift "7"
    , className =? "Firefox"   --> doShift "9"
    , className =? "mpv     "  --> doFloat]


-- For now I have no use for the following hooks, but I keep them around to
-- remember that they exist.

-- Event handling
--
-- Defines a custom handler function for X Events.
-- Can be configured to support EWMH hints (see XMonad.Hooks.EwmhDesktops).
myEventHook = mempty

-- Status bars and logging
--
-- Perform an arbitrary action on each internal state change or X event.
myLogHook = return ()

-- Startup hook
--
-- Perform an arbitrary action each time xmonad starts or is restarted.
myStartupHook = return ()

-- * Main

-- Run XMonad (and xmobar) with my config.
main = xmonad =<< statusBar "xmobar" xmobarPP toggleStrutsKey config
    -- Enable urgency hint support.
    where config = withUrgencyHook NoUrgencyHook myConfig

-- My XMonad configuration.
myConfig = def {
        -- Basic settings.
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        -- Keys/mouse bindings.
        keys               = azertyKeys <+> myKeys,
        mouseBindings      = myMouseBindings,
        -- Layout
        layoutHook         = myLayout,
        -- Hooks
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
