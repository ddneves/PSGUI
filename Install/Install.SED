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
InstallPrompt=Installing PSGUI with GUI-Manager. Proceed?
DisplayLicense=
FinishMessage=Installation done!
TargetName=C:\OneDrive\_Projekte\PS\PSGUI\Install\Install_PSGUI.EXE
FriendlyName=PSGUI  by David das Neves
AppLaunched=cmd /c %temp%\IXP000.TMP\install.bat
PostInstallCmd=powershell.exe "C:\Temp\PSGUI\installPSGUI.ps1"
AdminQuietInstCmd=
UserQuietInstCmd=
FILE0="InstallPSGUI.ps1"
FILE1="PSGUI.zip"
FILE2="install.bat"
[SourceFiles]
SourceFiles0=C:\OneDrive\_Projekte\PS\PSGUI\Install\
[SourceFiles0]
%FILE0%=
%FILE1%=
%FILE2%=
