; BERK Programming Language - Inno Setup Script
; Version 1.0.0

#define MyAppName "BERK Programming Language"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "Mustafa Barış Arslantaş"
#define MyAppURL "https://github.com/ArslantasM/berk"
#define MyAppExeName "berk-lang.exe"

[Setup]
; Unique application ID
AppId={{B3RK-L4NG-2025-V100-INST}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}/releases
DefaultDirName={autopf}\BERK
DefaultGroupName=BERK Programming Language
AllowNoIcons=yes
; Output settings
OutputDir=.
OutputBaseFilename=BERK-v1.0.0-Setup-x64
SetupIconFile=..\berk-lang\assets\berk-icon.ico
UninstallDisplayIcon={app}\berk-lang.exe
Compression=lzma2/ultra64
SolidCompression=yes
; Windows version requirements
MinVersion=10.0
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
; Privileges
PrivilegesRequired=admin
; Wizard style
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "turkish"; MessagesFile: "compiler:Languages\Turkish.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "addtopath"; Description: "Add BERK to system PATH"; GroupDescription: "Environment:"; Flags: checkedonce

[Files]
; Main executables
Source: "v1.0.0\berk-lang.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "v1.0.0\berk-repl.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "v1.0.0\berk-lsp.exe"; DestDir: "{app}"; Flags: ignoreversion
; LLVM and dependencies
Source: "v1.0.0\bin\*"; DestDir: "{app}\bin"; Flags: ignoreversion recursesubdirs createallsubdirs
; Standard library
Source: "v1.0.0\stdlib\*"; DestDir: "{app}\stdlib"; Flags: ignoreversion recursesubdirs createallsubdirs
; Test files and demos
Source: "v1.0.0\test\*"; DestDir: "{app}\test"; Flags: ignoreversion recursesubdirs createallsubdirs
; Documentation
Source: "v1.0.0\README.md"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\BERK REPL"; Filename: "{app}\berk-repl.exe"; Comment: "BERK Interactive REPL"
Name: "{group}\BERK Documentation"; Filename: "{app}\README.md"
Name: "{group}\BERK Examples & Tests"; Filename: "{app}\test"; Comment: "BERK Example Programs and Tests"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\BERK REPL"; Filename: "{app}\berk-repl.exe"; Tasks: desktopicon; Comment: "BERK Interactive REPL"

[Registry]
; File associations for .berk files
Root: HKCR; Subkey: ".berk"; ValueType: string; ValueName: ""; ValueData: "BERKSourceFile"; Flags: uninsdeletevalue
Root: HKCR; Subkey: "BERKSourceFile"; ValueType: string; ValueName: ""; ValueData: "BERK Source File"; Flags: uninsdeletekey
Root: HKCR; Subkey: "BERKSourceFile\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\berk-lang.exe,0"
Root: HKCR; Subkey: "BERKSourceFile\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\berk-lang.exe"" ""%1"""
Root: HKCR; Subkey: "BERKSourceFile\shell\compile"; ValueType: string; ValueName: ""; ValueData: "Compile with BERK"
Root: HKCR; Subkey: "BERKSourceFile\shell\compile\command"; ValueType: string; ValueName: ""; ValueData: """{app}\berk-lang.exe"" compile ""%1"""

[Code]
const
  EnvironmentKey = 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment';

procedure AddToPath();
var
  OldPath: string;
  NewPath: string;
  AppPath: string;
  BinPath: string;
begin
  AppPath := ExpandConstant('{app}');
  BinPath := AppPath + '\bin';
  
  if RegQueryStringValue(HKEY_LOCAL_MACHINE, EnvironmentKey, 'Path', OldPath) then
  begin
    // Check if already in PATH
    if Pos(Uppercase(AppPath), Uppercase(OldPath)) = 0 then
    begin
      NewPath := OldPath;
      if (Length(NewPath) > 0) and (NewPath[Length(NewPath)] <> ';') then
        NewPath := NewPath + ';';
      NewPath := NewPath + AppPath + ';' + BinPath;
      RegWriteStringValue(HKEY_LOCAL_MACHINE, EnvironmentKey, 'Path', NewPath);
    end;
  end;
end;

procedure RemoveFromPath();
var
  OldPath: string;
  AppPath: string;
  BinPath: string;
  NewPath: string;
begin
  AppPath := ExpandConstant('{app}');
  BinPath := AppPath + '\bin';
  
  if RegQueryStringValue(HKEY_LOCAL_MACHINE, EnvironmentKey, 'Path', OldPath) then
  begin
    NewPath := OldPath;
    StringChangeEx(NewPath, ';' + AppPath, '', True);
    StringChangeEx(NewPath, AppPath + ';', '', True);
    StringChangeEx(NewPath, AppPath, '', True);
    StringChangeEx(NewPath, ';' + BinPath, '', True);
    StringChangeEx(NewPath, BinPath + ';', '', True);
    StringChangeEx(NewPath, BinPath, '', True);
    // Clean up double semicolons
    while Pos(';;', NewPath) > 0 do
      StringChangeEx(NewPath, ';;', ';', True);
    RegWriteStringValue(HKEY_LOCAL_MACHINE, EnvironmentKey, 'Path', NewPath);
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    if WizardIsTaskSelected('addtopath') then
      AddToPath();
  end;
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  if CurUninstallStep = usPostUninstall then
    RemoveFromPath();
end;

[Run]
Filename: "{app}\berk-repl.exe"; Description: "{cm:LaunchProgram,BERK REPL}"; Flags: nowait postinstall skipifsilent
