[Version]
Class=IEXPRESS
SEDVersion=3
[Options]
PackagePurpose=InstallApp
ShowInstallProgramWindow=0
HideExtractAnimation=1
UseLongFileName=1
InsideCompressed=0
CAB_FixedSize=0
CAB_ResvCodeSigning=0
RebootMode=N
InstallPrompt=%InstallPrompt%
DisplayLicense=%DisplayLicense%
FinishMessage=%FinishMessage%
TargetName=%TargetName%
FriendlyName=%FriendlyName%
AppLaunched=%AppLaunched%
PostInstallCmd=%PostInstallCmd%
AdminQuietInstCmd=%AdminQuietInstCmd%
UserQuietInstCmd=%UserQuietInstCmd%
SourceFiles=SourceFiles
[Strings]
InstallPrompt=Install PSGUI-dialogs?
DisplayLicense=
FinishMessage=Installation done!
TargetName=#InstallationFolder##ExecName#.exe
FriendlyName=PSGUI  by David das Neves
AppLaunched=cmd /c %temp%\IXP000.TMP\install.bat
PostInstallCmd=powershell.exe "C:\Temp\PSGUI\installDialogs.ps1"
AdminQuietInstCmd=
UserQuietInstCmd=
FILE0="PSGUI.zip"
FILE1="install.bat"
FILE2="InstallDialogs.ps1"
[SourceFiles]
SourceFiles0=#SourceFilesInstallationFolder#
[SourceFiles0]
%FILE0%=
%FILE1%=
%FILE2%=
