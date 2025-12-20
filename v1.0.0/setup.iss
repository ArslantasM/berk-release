; BERK Programming Language Installer
; Inno Setup Script

#define MyAppName "BERK Programming Language"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "BERK Language Team"
#define MyAppURL "https://github.com/ArslantasM/berk-lang"
#define MyAppExeName "berk-lang.exe"

[Setup]
AppId={{8A5E7B2C-4F3D-4E8A-9B1C-2D3E4F5A6B7C}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\BERK
DefaultGroupName=BERK
AllowNoIcons=yes
LicenseFile=LICENSE
OutputDir=.
OutputBaseFilename=BERK-v{#MyAppVersion}-windows-x64
SetupIconFile=docs\berk-logo.ico
Compression=lzma2/ultra64
SolidCompression=yes
WizardStyle=modern
ArchitecturesInstallIn64BitMode=x64compatible
PrivilegesRequired=admin
ChangesEnvironment=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "turkish"; MessagesFile: "compiler:Languages\Turkish.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "addtopath"; Description: "Add BERK to system PATH"; GroupDescription: "Environment:"; Flags: checkedonce

[Files]
; Main executables
Source: "bin\berk-lang.exe"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "bin\berk-lsp.exe"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "bin\berk-repl.exe"; DestDir: "{app}\bin"; Flags: ignoreversion

; Documentation
Source: "README.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "LICENSE"; DestDir: "{app}"; Flags: ignoreversion
Source: "docs\*"; DestDir: "{app}\docs"; Flags: ignoreversion recursesubdirs createallsubdirs

; Examples
Source: "examples\*"; DestDir: "{app}\examples"; Flags: ignoreversion recursesubdirs createallsubdirs

; Standard Library
Source: "stdlib\*"; DestDir: "{app}\stdlib"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\BERK REPL"; Filename: "{app}\bin\berk-repl.exe"; WorkingDir: "{app}"
Name: "{group}\BERK Documentation"; Filename: "{app}\docs\index.html"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\BERK REPL"; Filename: "{app}\bin\berk-repl.exe"; Tasks: desktopicon; WorkingDir: "{app}"

[Registry]
; File associations for .berk files
Root: HKCR; Subkey: ".berk"; ValueType: string; ValueName: ""; ValueData: "BerkFile"; Flags: uninsdeletevalue
Root: HKCR; Subkey: "BerkFile"; ValueType: string; ValueName: ""; ValueData: "BERK Source File"; Flags: uninsdeletekey
Root: HKCR; Subkey: "BerkFile\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\bin\berk-lang.exe,0"
Root: HKCR; Subkey: "BerkFile\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\bin\berk-lang.exe"" run ""%1"""
Root: HKCR; Subkey: "BerkFile\shell\edit"; ValueType: string; ValueName: ""; ValueData: "Edit with VS Code"
Root: HKCR; Subkey: "BerkFile\shell\edit\command"; ValueType: string; ValueName: ""; ValueData: """code"" ""%1"""

[Code]
procedure CurStepChanged(CurStep: TSetupStep);
var
  Path: string;
  BerkPath: string;
begin
  if CurStep = ssPostInstall then
  begin
    if IsTaskSelected('addtopath') then
    begin
      BerkPath := ExpandConstant('{app}\bin');
      RegQueryStringValue(HKLM, 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'Path', Path);
      if Pos(BerkPath, Path) = 0 then
      begin
        Path := Path + ';' + BerkPath;
        RegWriteStringValue(HKLM, 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'Path', Path);
      end;
    end;
  end;
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  Path: string;
  BerkPath: string;
  P: Integer;
begin
  if CurUninstallStep = usPostUninstall then
  begin
    BerkPath := ExpandConstant('{app}\bin');
    RegQueryStringValue(HKLM, 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'Path', Path);
    P := Pos(';' + BerkPath, Path);
    if P > 0 then
    begin
      Delete(Path, P, Length(';' + BerkPath));
      RegWriteStringValue(HKLM, 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'Path', Path);
    end
    else
    begin
      P := Pos(BerkPath + ';', Path);
      if P > 0 then
      begin
        Delete(Path, P, Length(BerkPath + ';'));
        RegWriteStringValue(HKLM, 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'Path', Path);
      end
      else
      begin
        P := Pos(BerkPath, Path);
        if P > 0 then
        begin
          Delete(Path, P, Length(BerkPath));
          RegWriteStringValue(HKLM, 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'Path', Path);
        end;
      end;
    end;
  end;
end;

[Run]
Filename: "{app}\bin\berk-repl.exe"; Description: "Launch BERK REPL"; Flags: nowait postinstall skipifsilent
