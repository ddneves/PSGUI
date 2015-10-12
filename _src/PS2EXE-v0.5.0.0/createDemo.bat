cd C:\Users\pSyKo\OneDrive\_Projekte\PS\PSGUI\PS2EXE-v0.5.0.0
powershell.exe -command "&'.\ps2exe.ps1' test.ps1, test.exe"


call "callPS2EXE.bat" "test.ps1" "test.exe" "PS2EXE.ico"
pause
call "callPS2EXE.bat" "test.ps1" "test_x64.exe" -x64

call "callPS2EXE.bat" "test.ps1" "test_x86.exe" -x86

call "callPS2EXE.bat" "test.ps1" "test_20_STA.exe" -sta -runtime20 -iconFile PS2EXE.ico

call "callPS2EXE.bat" "test.ps1" "test_30_MTA.exe" -mta -runtime30

call "callPS2EXE.bat" "test.ps1" "test_30_NOCONSOLE.exe" -noconsole -runtime30

call "callPS2EXE.bat" "test.ps1" "test_20_NOCONSOLE.exe" -noconsole -runtime20

call "callPS2EXE.bat" "test.ps1" "test_40.exe" -runtime40

pause