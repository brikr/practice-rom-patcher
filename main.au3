#include <GUIConstants.au3>

; Basic wrapper around custom assembly files and bass.exe
; Special thanks to abitalive, atmpas, and circumark994 for assembly/tools

$gui = GUICreate("Practice ROM Patcher", 300, 310)

GUICtrlCreateTab(0, 0, 300, 260)

; Efficient Practice
$practiceTab = GUICtrlCreateTabItem("Efficient Practice")

; Custom save files
GUICtrlCreateLabel("File A", 20, 30)
$practiceFileACombo = GUICtrlCreateCombo("", 20, 50, 125, 20)
GUICtrlCreateLabel("File B", 155, 30)
$practiceFileBCombo = GUICtrlCreateCombo("", 155, 50, 125, 20)
GUICtrlCreateLabel("File C", 20, 80)
$practiceFileCCombo = GUICtrlCreateCombo("", 20, 100, 125, 20)
GUICtrlCreateLabel("File D", 155, 80)
$practiceFileDCombo = GUICtrlCreateCombo("", 155, 100, 125, 20)

$practiceFileString = "Empty|120 Star|74 Star (Up RTA)|103 Star (Tippy RTA)"
GUICtrlSetData($practiceFileACombo, $practiceFileString, "Empty")
GUICtrlSetData($practiceFileBCombo, $practiceFileString, "Empty")
GUICtrlSetData($practiceFileCCombo, $practiceFileString, "120 Star")
GUICtrlSetData($practiceFileDCombo, $practiceFileString, "74 Star (Up RTA)")

; Infinite lives
$infiniteLivesCheckbox = GUICtrlCreateCheckbox("Infinite lives", 20, 130)
GUICtrlSetState($infiniteLivesCheckbox, $GUI_CHECKED)

; Level reset with camera fix
$levelResetCheckbox = GUICtrlCreateCheckbox("Level reset with camera fix", 20, 150)
GUICtrlSetState($levelResetCheckbox, $GUI_CHECKED)
GUICtrlSetTip($levelResetCheckbox, "Press L to restart the level")

; Star select
$starSelectCheckbox = GUICtrlCreateCheckbox("Star select", 20, 180)
GUICtrlSetState($starSelectCheckbox, $GUI_CHECKED)
GUICtrlSetTip($starSelectCheckbox, "Press L+R to return to the star select screen")

GUIStartGroup()
$thiTinyRadio = GUICtrlCreateRadio("THI resets to tiny island", 100, 170)
$thiHugeRadio = GUICtrlCreateRadio("THI resets to huge island", 100, 190)
GUICtrlSetState($thiTinyRadio, $GUI_CHECKED)

; Savestates
$savestatesCheckbox = GUICtrlCreateCheckbox("Savestates 3.0", 20, 210)
GUICtrlSetState($savestatesCheckbox, $GUI_CHECKED)
GUICtrlSetTip($savestatesCheckbox, "Press Start to save state. Press all four C-buttons to load state")

; Level select
$levelSelectCheckbox = GUICtrlCreateCheckbox("Level Select", 20, 230)
GUICtrlSetState($levelSelectCheckbox, $GUI_CHECKED)

$levelSelectInfoButton = GUICtrlCreateIcon(@SystemDir & "\shell32.dll", -278, 100, 230, 20, 20)

; Timer
$timerTab = GUICtrlCreateTabItem("Timer")

; Timer enable
$enableTimerCheckbox = GUICtrlCreateCheckbox("Enable Timer", 20, 30)
GUICtrlSetState($enableTimerCheckbox, $GUI_CHECKED)
GUICtrlSetTip($enableTimerCheckbox, "Enables in-game timer without TIME text. Timer resets automatically on star select, or when L is pressed. Includes slide timer fix.")

; Show in castle
$showTimerInCastleCheckbox = GUICtrlCreateCheckbox("Show timer in castle", 20, 50)

; Centiseconds
$centisecondsCheckbox = GUICtrlCreateCheckbox("Show centiseconds", 20, 70)
GUICtrlSetState($centisecondsCheckbox, $GUI_CHECKED)
GUICtrlSetTip($centisecondsCheckbox, "Displays centiseconds on timer and moves the timer slightly left. Note: Because of the game's framerate, the only hundreths digit values you will see are 0, 3, and 6.")

; Stop on
$stopTimerOnLabel = GUICtrlCreateLabel("Stop timer on:", 20, 103)
GUIStartGroup()
$stopOnStarGrabRadio = GUICtrlCreateRadio("Star grab", 100, 90)
$stopOnXCamRadio = GUICtrlCreateRadio("X-Cam", 100, 110)
GUICtrlSetState($stopOnXCamRadio, $GUI_CHECKED)

; Display when
$displayTimerLabel = GUICtrlCreateLabel("Display timer:", 20, 138)
GUICtrlSetTip($displayTimerLabel, "When to show the timer in HUD. Showing the timer early can cause lag frames")
$timerDisplayCombo = GUICtrlCreateCombo("", 100, 135)
GUICtrlSetData($timerDisplayCombo, "Star grab|X-Cam|Always", "X-Cam")

; HUD
$hudTab = GUICtrlCreateTabItem("HUD")

; Lag frame counter
$enableLagCounterCheckbox = GUICtrlCreateCheckbox("Enable lag frame counter", 20, 30)
GUICtrlSetState($enableLagCounterCheckbox, $GUI_CHECKED)
GUICtrlSetTip($enableLagCounterCheckbox, "Enables lag frame counter without BUF text. Counter resets automatically on star select, or when L is pressed. Displaying this can cause lag frames")

; As lives
$lagCounterAsLivesCheckbox = GUICtrlCreateCheckbox("Display lag counter as lives count", 20, 50)

; Speed display
$enableSpeedDisplayCheckbox = GUICtrlCreateCheckbox("Enable speed display", 20, 70)
GUICtrlSetTip($enableSpeedDisplayCheckbox, "Enables speed display. Displaying this can cause lag frames")

; As stars
$speedDisplayAsStarsCheckbox = GUICtrlCreateCheckbox("Display speed as star count", 20, 90)
GUICtrlSetState($speedDisplayAsStarsCheckbox, $GUI_DISABLE)

; Cosmetic
$cosmeticTab = GUICtrlCreateTabItem("Cosmetic")

; No music
$musicCheckbox = GUICtrlCreateCheckbox("Music", 20, 30)
GUICtrlSetTip($musicCheckbox, "Whether to play in-game music. Changing this does not affect lag")

; All stars unobtained
$allStarsUnobtainedCheckbox = GUICtrlCreateCheckbox("All stars appear unobtained", 20, 50)
GUICtrlSetState($allStarsUnobtainedCheckbox, $GUI_CHECKED)
GUICtrlSetTip($allStarsUnobtainedCheckbox, "All stars appear as though they haven't been collected")

; Miscellaneous
$miscTab = GUICtrlCreateTabItem("Misc")

; Soft Reset
$softResetCheckbox = GUICtrlCreateCheckbox("Soft Reset", 20, 30)
GUICtrlSetState($softResetCheckbox, $GUI_CHECKED)
GUICtrlSetTip($softResetCheckbox, "Pressing A+B+Z+Start resets the game")

; Always spawn MIPS
$alwaysSpawnMIPSCheckbox = GUICtrlCreateCheckbox("Always spawn MIPS", 20, 50)
GUICtrlSetState($alwaysSpawnMIPSCheckbox, $GUI_CHECKED)

; Always spawn sub in DDD
$alwaysSpawnSubCheckbox = GUICtrlCreateCheckbox("Always spawn sub in DDD", 20, 70)
GUICtrlSetState($alwaysSpawnSubCheckbox, $GUI_CHECKED)

; Always spawn unpressed cap switches
$alwaysSpawnUnpressedSwitchesCheckbox = GUICtrlCreateCheckbox("Always spawn unpressed cap switches", 20, 90)
GUICtrlSetState($alwaysSpawnUnpressedSwitchesCheckbox, $GUI_CHECKED)

; Always spawn toad stars
$alwaysSpawnToadStarsCheckbox = GUICtrlCreateCheckbox("Always spawn stars from Toad", 20, 110)
GUICtrlSetState($alwaysSpawnToadStarsCheckbox, $GUI_CHECKED)

; Allow fat penguin to spawn in CCM
$allowFatPenguinCheckbox = GUICtrlCreateCheckbox("Allow fat penguin to spawn in CCM", 20, 130)
GUICtrlSetTip($allowFatPenguinCheckbox, "If you have 120 stars, the penguin in CCM is larger and faster than normal")

; Adjustable TTC clock speed
$adjustableTTCSpeedCheckbox = GUICtrlCreateCheckbox("Adjustable TTC clock speed", 20, 150)
GUICtrlSetState($adjustableTTCSpeedCheckbox, $GUI_CHECKED)
GUICtrlSetTip($adjustableTTCSpeedCheckbox, "L+C-Up sets to fast time moving. L+C-Down sets to time stopped")

; Adjustable WDW water level
$adjustableWDWlevelCheckbox = GUICtrlCreateCheckbox("Adjustable WDW water level", 20, 170)
GUICtrlSetState($adjustableWDWlevelCheckbox, $GUI_CHECKED)
GUICtrlSetTip($adjustableWDWlevelCheckbox, "L+D-Up sets to high. L+D-Right sets to medium, L+D-Down sets to low")

; Always display 50 star text box
$displayFiftyStarCheckbox = GUICtrlCreateCheckbox("Always display 50 star text box when exiting a level", 20, 190)
GUICtrlSetTip($displayFiftyStarCheckbox, "Useful for practicing 50-star MIPS when exiting LLL")

; Non-stop
$nonStopCheckbox = GUICtrlCreateCheckbox("Non-stop", 20, 210)
GUICtrlSetTip($nonStopCheckbox, "Collecting a star doesn't cause you to leave the level")

GUICtrlCreateTabItem("")

$patchButton = GUICtrlCreateButton("Patch", 0, 260, 300, 50)

GUISetState()
While 1
  Switch GUIGetMsg()
    Case $GUI_EVENT_CLOSE
      ExitLoop
    Case $starSelectCheckbox
      If GUICtrlRead($starSelectCheckbox) == $GUI_UNCHECKED Then
        GUICtrlSetState($thiTinyRadio, $GUI_DISABLE)
        GUICtrlSetState($thiHugeRadio, $GUI_DISABLE)
      Else
        GUICtrlSetState($thiTinyRadio, $GUI_ENABLE)
        GUICtrlSetState($thiHugeRadio, $GUI_ENABLE)
      EndIf
    Case $levelSelectInfoButton
      MsgBox(0, "Level Select Info", "Enter any of the following button combinations, then press Star Select (L+R) to go to a new level:" & @CRLF & _
        "D-Up + C-Up: Bob-omb Battlefield" & @CRLF & _
        "D-Up + C-Right: Whomp's Fortress" & @CRLF & _
        "D-Up + C-Down: Jolly Roger Bay" & @CRLF & _
        "D-Up + C-Left: Cool Cool Mountain" & @CRLF & _
        "D-Up + A: Tower of the Wing Cap" & @CRLF & _
        "D-Up + B: Cavern of the Metal Cap" & @CRLF & _
        "D-Right + C-Up: Big Boo's Haunt" & @CRLF & _
        "D-Right + C-Right: Hazy Maze Cave" & @CRLF & _
        "D-Right + C-Down: Lethal Lava Land" & @CRLF & _
        "D-Right + C-Left: Shifting Sand Land" & @CRLF & _
        "D-Right + A: Vanish Cap Under the Moat" & @CRLF & _
        "D-Right + B: The Secret Aquarium" & @CRLF & _
        "D-Down + C-Up: Dire Dire Docks" & @CRLF & _
        "D-Down + C-Right: Snowman's Land" & @CRLF & _
        "D-Down + C-Down: Wet Dry World" & @CRLF & _
        "D-Down + C-Left: Tall Tall Mountain" & @CRLF & _
        "D-Down + A: Wing Mario over the Rainbow" & @CRLF & _
        "D-Down + B: Princess' Secret Slide" & @CRLF & _
        "D-Left + C-Up: Tiny Huge Island" & @CRLF & _
        "D-Left + C-Right: Tick Tock Clock" & @CRLF & _
        "D-Left + C-Down: Rainbow Ride" & @CRLF & _
        "D-Left + C-Left: Bowser in the Dark World" & @CRLF & _
        "D-Left + A: Bowser in the Fire Sea" & @CRLF & _
        "D-Left + B: Bowser in the Sky")
      Case $enableTimerCheckbox
        If GUICtrlRead($enableTimerCheckbox) == $GUI_UNCHECKED Then
          GUICtrlSetState($showTimerInCastleCheckbox, $GUI_DISABLE)
          GUICtrlSetState($centisecondsCheckbox, $GUI_DISABLE)
          GUICtrlSetState($stopTimerOnLabel, $GUI_DISABLE)
          GUICtrlSetState($stopOnStarGrabRadio, $GUI_DISABLE)
          GUICtrlSetState($stopOnXCamRadio, $GUI_DISABLE)
          GUICtrlSetState($displayTimerLabel, $GUI_DISABLE)
          GUICtrlSetState($timerDisplayCombo, $GUI_DISABLE)
        Else
          GUICtrlSetState($showTimerInCastleCheckbox, $GUI_ENABLE)
          GUICtrlSetState($centisecondsCheckbox, $GUI_ENABLE)
          GUICtrlSetState($stopTimerOnLabel, $GUI_ENABLE)
          GUICtrlSetState($stopOnStarGrabRadio, $GUI_ENABLE)
          GUICtrlSetState($stopOnXCamRadio, $GUI_ENABLE)
          GUICtrlSetState($displayTimerLabel, $GUI_ENABLE)
          GUICtrlSetState($timerDisplayCombo, $GUI_ENABLE)
        EndIf
      Case $enableLagCounterCheckbox
        If GUICtrlRead($enableLagCounterCheckbox) == $GUI_UNCHECKED Then
          GUICtrlSetState($lagCounterAsLivesCheckbox, $GUI_DISABLE)
        Else
          GUICtrlSetState($lagCounterAsLivesCheckbox, $GUI_ENABLE)
        EndIf
      Case $enableSpeedDisplayCheckbox
        If GUICtrlRead($enableSpeedDisplayCheckbox) == $GUI_UNCHECKED Then
          GUICtrlSetState($speedDisplayAsStarsCheckbox, $GUI_DISABLE)
        Else
          GUICtrlSetState($speedDisplayAsStarsCheckbox, $GUI_ENABLE)
        EndIf
  EndSwitch
WEnd
