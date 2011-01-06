Name "LiveUSB Creator 3.9.3"
OutFile "liveusb-creator-3.9.3-setup.exe"

SetCompressor lzma

InstallDir "$PROGRAMFILES\LiveUSB Creator"
InstallDirRegKey HKEY_LOCAL_MACHINE "SOFTWARE\LiveUSB Creator" ""

DirText "Select the directory to install LiveUSB Creator in:"

Icon liveusb-creator.ico

Section ""

	; Install files.
	SetOverwrite on

	SetOutPath $INSTDIR
	File liveusb-creator.exe
	File LICENSE.txt
	File README.txt
	File MSVCP90.DLL
	File MSVCR90.dll
	File w9xpopen.exe
	
	SetOutPath $INSTDIR\tools
	File tools\7z.dll
	File tools\7z.exe
	File tools\7zCon.sfx
	File tools\7-Zip-License.txt
	File tools\dd.exe
	File tools\syslinux.exe
	
	; Create shortcut.
	SetOutPath -
	CreateDirectory "$SMPROGRAMS\LiveUSB Creator"
	CreateShortCut "$SMPROGRAMS\LiveUSB Creator\LiveUSB Creator.lnk" "$INSTDIR\liveusb-creator.exe"
	CreateShortCut "$SMPROGRAMS\LiveUSB Creator\Uninstall LiveUSB Creator.lnk" "$INSTDIR\uninst.exe" "" "$INSTDIR\uninst.exe" 0

	; Optionally start program.
	MessageBox MB_YESNO|MB_ICONQUESTION "Run LiveUSB Creator now?" IDNO SkipRunProgram
	Exec "$INSTDIR\liveusb-creator.exe"
SkipRunProgram:

	; Create uninstaller.
	WriteRegStr HKEY_LOCAL_MACHINE "SOFTWARE\LiveUSB Creator" "" "$INSTDIR"
	WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\LiveUSB Creator" "DisplayName" "LiveUSB Creator (remove only)"
	WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\LiveUSB Creator" "UninstallString" '"$INSTDIR\uninst.exe"'
	WriteUninstaller "$INSTDIR\uninst.exe"

SectionEnd

UninstallText "This will uninstall LiveUSB Creator from your system."

Section Uninstall

	; Delete shortcuts.
	Delete "$SMPROGRAMS\LiveUSB Creator\LiveUSB Creator.lnk"
	Delete "$SMPROGRAMS\LiveUSB Creator\Uninstall LiveUSB Creator.lnk"
	RMDir "$SMPROGRAMS\LiveUSB Creator"
	Delete "$DESKTOP\LiveUSB Creator.lnk"

	; Delete registry keys.
	Delete "$INSTDIR\uninst.exe"
	DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\LiveUSB Creator"
	DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\LiveUSB Creator"

	; Delete files.
	Delete "$INSTDIR\liveusb-creator.exe"
	Delete "$INSTDIR\LICENSE.txt"
	Delete "$INSTDIR\README.txt"
	Delete "$INSTDIR\MSVCP90.DLL"
	Delete "$INSTDIR\MSVCR90.dll"
	Delete "$INSTDIR\w9xpopen.exe"
	
	Delete "$INSTDIR\tools\7z.dll"
	Delete "$INSTDIR\tools\7z.exe"
	Delete "$INSTDIR\tools\7zCon.sfx"
	Delete "$INSTDIR\tools\7-Zip-License.txt"
	Delete "$INSTDIR\tools\dd.exe"
	Delete "$INSTDIR\tools\syslinux.exe"

	Delete "$INSTDIR\liveusb-creator.exe.log"

	; Remove the installation directories.
	RMDir "$INSTDIR\tools"
	RMDir "$INSTDIR"

SectionEnd