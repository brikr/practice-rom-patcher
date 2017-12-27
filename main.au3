#include <GUIConstants.au3>

; Basic wrapper around custom assembly files and bass.exe
; Special thanks to abitalive, atmpas, and circumark994 for assembly/tools

$gui = GUICreate("Practice ROM Patcher by minikori", 400, 600)

GUISetState()
While 1
  Switch GUIGetMsg()
    Case $GUI_EVENT_CLOSE
      ExitLoop
  EndSwitch
WEnd
