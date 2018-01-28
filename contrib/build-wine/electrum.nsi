;--------------------------------
;Include Modern UI
  !include "TextFunc.nsh" ;Needed for the $GetSize fuction. I know, doesn't sound logical, it isn't.
  !include "MUI2.nsh"
  
;--------------------------------
;Variables

  !define PRODUCT_NAME "Electrum-uno"
  !define PRODUCT_WEB_SITE "https://github.com/flurbos/electrum-uno"
  !define PRODUCT_PUBLISHER "Electrum Technologies GmbH"
  !define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"

;--------------------------------
;General

  ;Name and file
<<<<<<< HEAD
  Name "Unobtanium Electrum"
  OutFile "dist/electrum-uno-setup.exe"

  ;Default installation folder
  InstallDir "$PROGRAMFILES\Electrum-uno"

  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\Electrum-uno" ""
=======
  Name "${PRODUCT_NAME}"
  OutFile "dist/electrum-setup.exe"

  ;Default installation folder
  InstallDir "$PROGRAMFILES\${PRODUCT_NAME}"

  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\${PRODUCT_NAME}" ""
>>>>>>> 743ef9ec8f1e69c56f587359f00de19f4f05ff0a

  ;Request application privileges for Windows Vista
  RequestExecutionLevel admin

  ;Specifies whether or not the installer will perform a CRC on itself before allowing an install
  CRCCheck on
  
  ;Sets whether or not the details of the install are shown. Can be 'hide' (the default) to hide the details by default, allowing the user to view them, or 'show' to show them by default, or 'nevershow', to prevent the user from ever seeing them.
  ShowInstDetails show
  
  ;Sets whether or not the details of the uninstall  are shown. Can be 'hide' (the default) to hide the details by default, allowing the user to view them, or 'show' to show them by default, or 'nevershow', to prevent the user from ever seeing them.
  ShowUninstDetails show
  
  ;Sets the colors to use for the install info screen (the default is 00FF00 000000. Use the form RRGGBB (in hexadecimal, as in HTML, only minus the leading '#', since # can be used for comments). Note that if "/windows" is specified as the only parameter, the default windows colors will be used.
  InstallColors /windows
  
  ;This command sets the compression algorithm used to compress files/data in the installer. (http://nsis.sourceforge.net/Reference/SetCompressor)
  SetCompressor /SOLID lzma
  
  ;Sets the dictionary size in megabytes (MB) used by the LZMA compressor (default is 8 MB).
  SetCompressorDictSize 64
  
  ;Sets the text that is shown (by default it is 'Nullsoft Install System vX.XX') in the bottom of the install window. Setting this to an empty string ("") uses the default; to set the string to blank, use " " (a space).
  BrandingText "${PRODUCT_NAME} Installer v${PRODUCT_VERSION}" 
  
  ;Sets what the titlebars of the installer will display. By default, it is 'Name Setup', where Name is specified with the Name command. You can, however, override it with 'MyApp Installer' or whatever. If you specify an empty string (""), the default will be used (you can however specify " " to achieve a blank string)
  Caption "${PRODUCT_NAME}"

  ;Adds the Product Version on top of the Version Tab in the Properties of the file.
  VIProductVersion 1.0.0.0
  
  ;VIAddVersionKey - Adds a field in the Version Tab of the File Properties. This can either be a field provided by the system or a user defined field.
  VIAddVersionKey ProductName "${PRODUCT_NAME} Installer"
  VIAddVersionKey Comments "The installer for ${PRODUCT_NAME}"
  VIAddVersionKey CompanyName "${PRODUCT_NAME}"
  VIAddVersionKey LegalCopyright "2013-2016 ${PRODUCT_PUBLISHER}"
  VIAddVersionKey FileDescription "${PRODUCT_NAME} Installer"
  VIAddVersionKey FileVersion ${PRODUCT_VERSION}
  VIAddVersionKey ProductVersion ${PRODUCT_VERSION}
  VIAddVersionKey InternalName "${PRODUCT_NAME} Installer"
  VIAddVersionKey LegalTrademarks "${PRODUCT_NAME} is a trademark of ${PRODUCT_PUBLISHER}" 
  VIAddVersionKey OriginalFilename "${PRODUCT_NAME}.exe"

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING
  !define MUI_ABORTWARNING_TEXT "Are you sure you wish to abort the installation of ${PRODUCT_NAME}?"
  
  !define MUI_ICON "tmp\electrum\icons\electrum.ico"
  
;--------------------------------
;Pages

  !insertmacro MUI_PAGE_DIRECTORY
<<<<<<< HEAD

  ;Start Menu Folder Page Configuration
  !define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU"
  !define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\Electrum-uno"
  !define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"

  ;!insertmacro MUI_PAGE_STARTMENU Application $StartMenuFolder

=======
>>>>>>> 743ef9ec8f1e69c56f587359f00de19f4f05ff0a
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES

;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

;Check if we have Administrator rights
Function .onInit
	UserInfo::GetAccountType
	pop $0
	${If} $0 != "admin" ;Require admin rights on NT4+
		MessageBox mb_iconstop "Administrator rights required!"
		SetErrorLevel 740 ;ERROR_ELEVATION_REQUIRED
		Quit
	${EndIf}
FunctionEnd

Section
  SetOutPath $INSTDIR

<<<<<<< HEAD
  ;ADD YOUR OWN FILES HERE...
  file /r dist\electrum-uno\*.*

  ;Store installation folder
  WriteRegStr HKCU "Software\Electrum-uno" "" $INSTDIR
=======
  ;Uninstall previous version files
  RMDir /r "$INSTDIR\*.*"
  Delete "$DESKTOP\${PRODUCT_NAME}.lnk"
  Delete "$SMPROGRAMS\${PRODUCT_NAME}\*.*"
  
  ;Files to pack into the installer
  File /r "dist\electrum\*.*"
  File "..\..\icons\electrum.ico"

  ;Store installation folder
  WriteRegStr HKCU "Software\${PRODUCT_NAME}" "" $INSTDIR
>>>>>>> 743ef9ec8f1e69c56f587359f00de19f4f05ff0a

  ;Create uninstaller
  DetailPrint "Creating uninstaller..."
  WriteUninstaller "$INSTDIR\Uninstall.exe"

<<<<<<< HEAD

  CreateShortCut "$DESKTOP\Electrum-uno.lnk" "$INSTDIR\electrum-uno.exe" ""

  ;create start-menu items
  CreateDirectory "$SMPROGRAMS\Electrum-uno"
  CreateShortCut "$SMPROGRAMS\Electrum-uno\Uninstall.lnk" "$INSTDIR\Uninstall.exe" "" "$INSTDIR\Uninstall.exe" 0
  CreateShortCut "$SMPROGRAMS\Electrum-uno\Electrum.lnk" "$INSTDIR\electrum-uno.exe" "" "$INSTDIR\electrum-uno.exe" 0

=======
  ;Create desktop shortcut
  DetailPrint "Creating desktop shortcut..."
  CreateShortCut "$DESKTOP\${PRODUCT_NAME}.lnk" "$INSTDIR\electrum-${PRODUCT_VERSION}.exe" ""

  ;Create start-menu items
  DetailPrint "Creating start-menu items..."
  CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\Uninstall.lnk" "$INSTDIR\Uninstall.exe" "" "$INSTDIR\Uninstall.exe" 0
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk" "$INSTDIR\electrum-${PRODUCT_VERSION}.exe" "" "$INSTDIR\electrum-${PRODUCT_VERSION}.exe" 0
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME} Testnet.lnk" "$INSTDIR\electrum-${PRODUCT_VERSION}.exe" "--testnet" "$INSTDIR\electrum-${PRODUCT_VERSION}.exe" 0


  ;Links bitcoin: URI's to Electrum
  WriteRegStr HKCU "Software\Classes\bitcoin" "" "URL:bitcoin Protocol"
  WriteRegStr HKCU "Software\Classes\bitcoin" "URL Protocol" ""
  WriteRegStr HKCU "Software\Classes\bitcoin" "DefaultIcon" "$\"$INSTDIR\electrum.ico, 0$\""
  WriteRegStr HKCU "Software\Classes\bitcoin\shell\open\command" "" "$\"$INSTDIR\electrum-${PRODUCT_VERSION}.exe$\" $\"%1$\""

  ;Adds an uninstaller possibilty to Windows Uninstall or change a program section
  WriteRegStr HKCU "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr HKCU "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\Uninstall.exe"
  WriteRegStr HKCU "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr HKCU "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr HKCU "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
  WriteRegStr HKCU "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\electrum.ico"

  ;Fixes Windows broken size estimates
  ${GetSize} "$INSTDIR" "/S=0K" $0 $1 $2
  IntFmt $0 "0x%08X" $0
  WriteRegDWORD HKCU "${PRODUCT_UNINST_KEY}" "EstimatedSize" "$0"
>>>>>>> 743ef9ec8f1e69c56f587359f00de19f4f05ff0a
SectionEnd

;--------------------------------
;Descriptions

;--------------------------------
;Uninstaller Section

Section "Uninstall"
  RMDir /r "$INSTDIR\*.*"

  RMDir "$INSTDIR"

<<<<<<< HEAD
  Delete "$DESKTOP\Electrum-uno.lnk"
  Delete "$SMPROGRAMS\Electrum-uno\*.*"
  RmDir  "$SMPROGRAMS\Electrum-uno"

  DeleteRegKey /ifempty HKCU "Software\Electrum-uno"

=======
  Delete "$DESKTOP\${PRODUCT_NAME}.lnk"
  Delete "$SMPROGRAMS\${PRODUCT_NAME}\*.*"
  RMDir  "$SMPROGRAMS\${PRODUCT_NAME}"
  
  DeleteRegKey HKCU "Software\Classes\bitcoin"
  DeleteRegKey HKCU "Software\${PRODUCT_NAME}"
  DeleteRegKey HKCU "${PRODUCT_UNINST_KEY}"
>>>>>>> 743ef9ec8f1e69c56f587359f00de19f4f05ff0a
SectionEnd
