@ECHO OFF

Rem These variables will be set in the VBScript while generating Batch file
set ERGO_ROOT=E:\pe513
set ERGOPLAN_ROOT=E:\pe513\ergoplan-pe513_fgk\ergoplan
set RELEASE=13

set ADL_FR_CATIA=CXR%RELEASE%
set CAADocCheck=FALSE
TITLE=%ADL_FR_CATIA% CAADocumentation

IF "%ERGOPLAN_ROOT%" == "" GOTO :errErgoroot

echo Version Is \\snowmass\TOOLS\mkmkcxr%RELEASE%
IF NOT EXIST \\snowmass\TOOLS\mkmkcxr%RELEASE% (
    GOTO :errVersion
)

echo %ERGOPLAN_ROOT%
@cd %ERGOPLAN_ROOT%
@cd ..\..\

GOTO :RemoveDirAndFile
:Begin
Rem @pause

echo TCK_INIT
@call \\snowmass\TOOLS\TCK\tck_init.bat
@echo TCK_PROFILE
@call \\snowmass\TOOLS\TCK\intel_a\TCK\command\tck_profile %ADL_FR_CATIA% 

@call mkdir IDL_Documetation
IF NOT EXIST IDL_Documetation\PublicInterfaces (
    echo Creating PublicInterfaces
    @call mkdir IDL_Documetation\PublicInterfaces
)

IF NOT EXIST IDL_Documetation\CAAIdlFileList.txt (
    echo Creating CAAIdlFileList.txt
    echo cominc\basedataobj.idl> IDL_Documetation\CAAIdlFileList.txt
)

@call mkdir IDL_Documetation\IdentityCard
@call echo //empty file > IDL_Documetation\IdentityCard\IdentityCard.h
@call mkGetPreq -p \\snowmass\%ADL_FR_CATIA%\BSF
@set OUTPUT_DIRPATH=%ERGO_ROOT%\IDL_Documetation\PublicInterfaces
@call %ERGOPLAN_ROOT%\util\vbscripts\CAADocument.vbs [ ^ ] ^ /*[ ^ ]*/
@call mkdcidl -o IDL_Documetation\CAADocumentation
set CAADocCheck=TRUE
GOTO :RemoveDirAndFile

:Success
echo SUCCESSFUL :: HTML Files Are Generated At CAADocumentation Directory.
GOTO :Exit

:errVersion
echo ERROR : Version Number Is Not Correct.
GOTO :Exit

:errErgoroot
echo ERROR : Please Specify ERGOPLAN_ROOT Environment Variable.
GOTO :Exit

:RemoveDirAndFile
IF "%CAADocCheck%" == "FALSE" (
    IF EXIST IDL_Documetation\CAADocumentation (
        echo Removing CAADocumentation Directory.
        @call rmdir /S /Q IDL_Documetation\CAADocumentation
       ) ELSE (
           echo Directory CAADocumentation Not Exist.
              )
)

IF EXIST intel_a (
    echo Removing intel_a Directory.
    @call rmdir /S /Q intel_a
) ELSE (
    echo Directory intel_a Not Exist.
)

IF EXIST CATIAV5Level.lvl (
    echo Removing CATIAV5Level.lvl File.
    @call del /Q CATIAV5Level.lvl
) ELSE (
    echo File CATIAV5Level.lvl Not Exist.
)

IF EXIST IDL_Documetation\IdentityCard (
    echo Removing IdentityCard File.
    @call rmdir /S /Q IDL_Documetation\IdentityCard
) ELSE (
    echo File IdentityCard Not Exist.
)

IF EXIST Install_config_intel_a (
    echo Removing Install_config_intel_a File.
    @call del /Q Install_config_intel_a
) ELSE (
    echo File Install_config_intel_a Not Exist.
)

IF "%CAADocCheck%" == "FALSE" (
     GOTO :Begin
    ) ELSE (
     GOTO :Success
)

:Exit
