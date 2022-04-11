$pathExeCreater = "D:\OneDrive - MuM - OM\TWIProgrammierung\Autodesk\CreateExe\ps2exe.ps1"
$pathMainScript = "C:\Work\ADSKLincensingModify\MainscriptADSKLM2020.ps1"
$pathOutput = "C:\Work\ADSKLincensingModify\ADSKLicensingModify.exe"
$pathIcon = "C:\Work\ADSKLincensingModify\res\MuMDefaultIcon.ico"
. $pathExeCreater -inputFile $pathMainScript -outputFile $pathOutput -iconFile $pathIcon -noConsole -noOutput -title "ADSK Licensing Modify" -copyright "Tobias Wiesendanger" -verbose -version 2.1