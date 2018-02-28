; -- Example1.iss --
; Demonstrates copying 3 files and creating an icon.

; SEE THE DOCUMENTATION FOR DETAILS ON CREATING .ISS SCRIPT FILES!

[Setup]
AppName=GiveSG
AppVersion=1.0
DefaultDirName={pf}\GiveSG
DefaultGroupName=GiveSG
UninstallDisplayIcon={app}\givesg.jar
Compression=lzma2
SolidCompression=yes
OutputDir=userdocs:Inno Setup Examples Output

[Files]
Source: "givesg.jar"; DestDir: "{app}"
Source: "givesg.bat"; DestDir: "{app}"
Source: "CLIPSJNI\*"; DestDir: "{app}\CLIPSJNI"; Flags: ignoreversion recursesubdirs

[Icons]
Name: "{group}\GiveSG"; Filename: "{app}\givesg.bat"

[Run]
Filename: {app}\{cm:AppName}.bat; Description: {cm:LaunchProgram,{cm:AppName}}; Flags: nowait postinstall skipifsilent

[CustomMessages]
AppName=givesg
LaunchProgram=Start GiveSG after finishing installation
