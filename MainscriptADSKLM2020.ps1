Clear-Host
#Initialize
[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')  | out-null
[System.Reflection.Assembly]::LoadWithPartialName('System.ComponentModel') | out-null
[System.Reflection.Assembly]::LoadWithPartialName('System.Data')           | out-null
[System.Reflection.Assembly]::LoadWithPartialName('System.Drawing')        | out-null
[System.Reflection.Assembly]::LoadWithPartialName('presentationframework') | out-null

[System.Reflection.Assembly]::LoadWithPartialName('PresentationCore')      | out-null
[System.Reflection.Assembly]::LoadFrom('res\assembly\MahApps.Metro.dll')       | out-null
[System.Reflection.Assembly]::LoadFrom('res\assembly\System.Windows.Interactivity.dll') | out-null
[System.Reflection.Assembly]::LoadFrom('res\assembly\MahApps.Metro.IconPacks.dll') | out-null

# When compiled with PS2EXE the variable MyCommand contains no path anymore

if ($MyInvocation.MyCommand.CommandType -eq "ExternalScript")
{ # Powershell script
	$Path = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
}
else
{ # PS2EXE compiled script
	$Path = Split-Path -Parent -Path ([Environment]::GetCommandLineArgs()[0])
}

Write-Host $Path

$tempPath= $env:TEMP 
$JsonFileName = "\templistADSK.json"
$MainformIcon = $Path + "\res\mum.png"

#===========================================================================
#Product Key Hash Table 2020
#===========================================================================

#region Hash Table 2020
$Hashtable2020 = @" 
    Autodesk3dsMax2020 = 128L1
    Autodesk3dsMax2020withSoftimage = 978L1
    AutodeskAdvanceSteel2020 = 959L1
    AutodeskAliasAutoStudio2020 = 966L1
    AutodeskAliasConcept2020 = A63L1
    AutodeskAliasDesign2020 = 712L1
    AutodeskAliasSpeedForm2020 = A62L1
    AutodeskAliasSurface2020 = 736L1
    AutodeskAutoCAD2020 = 001L1
    AutodeskAutoCADArchitecture2020 = 185L1
    AutodeskAutoCADDesignSuitePremium2020 = 768L1
    AutodeskAutoCADDesignSuiteStandard2020 = 767L1
    AutodeskAutoCADElectrical2020 = 225L1
    AutodeskAutoCADInventorLTSuite2020 = 596L1
    AutodeskAutoCADLT2020 = 057L1
    AutodeskAutoCADLTwithCALSTools2020 = 545L1
    AutodeskAutoCADMap3D2020 = 129L1
    AutodeskAutoCADMechanical2020 = 206L1
    AutodeskAutoCADMEP2020 = 235L1
    AutodeskAutoCADPlant3D2020 = 426L1
    AutodeskAutoCADRasterDesign2020 = 340L1
    AutodeskAutoCADRevitLTSuite2020 = 834L1
    AutodeskBuildingDesignSuitePremium2020 = 765L1
    AutodeskBuildingDesignSuiteStandard2020 = 784L1
    AutodeskBuildingDesignSuiteUltimate2020 = 766L1
    AutodeskBurn2020 = C0YL1
    AutodeskCivil3D2020 = 237L1
    AutodeskFabricationCADmep2020 = 839L1
    AutodeskFabricationCAMduct2020 = 842L1
    AutodeskFabricationESTmep2020 = 841L1
    AutodeskFactoryDesignSuitePremium2020 = 757L1
    AutodeskFactoryDesignSuiteStandard2020 = 789L1
    AutodeskFactoryDesignSuiteUltimate2020 = 760L1
    AutodeskFactoryDesignUtilities2020 = P03L1
    AutodeskFeatureCAMPremium2020 = A9FL1
    AutodeskFeatureCAMStandard2020 = A9GL1
    AutodeskFeatureCAMUltimate2020 = A9EL1
    AutodeskFlame2020 = C0TL1
    AutodeskFlame2020Education = C14L1
    AutodeskFlameAssist2020 = C0VL1
    AutodeskFlamePremium2020 = C0XL1
    AutodeskFlare2020 = C0WL1
    AutodeskHSMPremium2020 = C12L1
    AutodeskHSMUltimate2020 = C13L1
    AutodeskInfrastructureDesignSuitePremium2020 = 786L1
    AutodeskInfrastructureDesignSuiteStandard2020 = 787L1
    AutodeskInfrastructureDesignSuiteUltimate2020 = 785L1
    AutodeskInventor2020 = 208L1
    AutodeskInventorEngineertoOrder2020Developer = A66L1
    AutodeskInventorEngineertoOrder2020Distribution = 996L1
    AutodeskInventorEngineertoOrder2020Server = 997L1
    AutodeskInventorEngineertoOrderSeries2020 = 805L1
    AutodeskInventorEngineertoOrderServer2020 = 752L1
    AutodeskInventorHSMPremium2020 = 969L1
    AutodeskInventorHSMUltimate2020 = 970L1
    AutodeskInventorLT2020 = 529L1
    AutodeskInventorOEM2020 = 798L1
    AutodeskInventorProfessional2020 = 797L1
    AutodeskLustre2020 = C0UL1
    AutodeskLustreBurn2020 = C10L1
    AutodeskLustreShotReactor2020 = C11L1
    AutodeskManufacturingAutomationUtility2020 = A9YL1
    AutodeskManufacturingDataExchangeUtilityPremium2020 = A9VL1
    AutodeskManufacturingDataExchangeUtilityStandard2020 = A9XL1
    AutodeskManufacturingPostProcessorUtility2020 = A9TL1
    AutodeskMayaLT2020 = 923L1
    AutodeskMEPFabricationSuite2020 = 00QL1
    AutodeskNastran2020 = 986L1
    AutodeskNastranInCAD2020 = 987L1
    AutodeskNavisworksManage2020 = 507L1
    AutodeskNavisworksSimulate2020 = 506L1
    AutodeskPartMaker2020 = A9SL1
    AutodeskPlantDesignSuitePremium2020 = 763L1
    AutodeskPlantDesignSuiteStandard2020 = 788L1
    AutodeskPlantDesignSuiteUltimate2020 = 764L1
    AutodeskPointLayout2020 = 925L1
    AutodeskPowerInspectPremium2020 = A9JL1
    AutodeskPowerInspectStandard2017 = A9KL1
    AutodeskPowerInspectStandard2018 = A9KL1
    AutodeskPowerInspectStandard2020 = A9KL1
    AutodeskPowerInspectUltimate2020 = A9HL1
    AutodeskPowerMillModeling2020 = A9UL1
    AutodeskPowerMillPremium2020 = A9AL1
    AutodeskPowerMillStandard2020 = A9QL1
    AutodeskPowerMillUltimate2020 = A9PL1
    AutodeskPowerShapePremium2020 = A9ML1
    AutodeskPowerShapeStandard2020 = A9NL1
    AutodeskPowerShapeUltimate2020 = A9LL1
    AutodeskProductDesignSuitePremium2020 = 782L1
    AutodeskProductDesignSuiteUltimate2020 = 781L1
    AutodeskReCapPro = 919L1
    AutodeskRevit2020 = 829L1
    AutodeskRevitLT2020 = 828L1
    AutodeskRobotStructuralAnalysisProfessional2020 = 547L1
    AutodeskSketchBookforEnterprise = 871L1
    AutodeskTruComp2020 = 00EL1
    AutodeskTruFiber2020 = 01WL1
    AutodeskTruLaser2020 = 00DL1
    AutodeskTruNest2020NestingEngine = 00FL1
    AutodeskTruNestComposites2020 = 00BL1
    AutodeskTruNestContour2020 = 00AL1
    AutodeskTruNestMultiTool2020 = 00CL1
    AutodeskTruPlan2020 = 01VL1
    AutodeskVaultOffice2020 = 555L1
    AutodeskVaultProfessional2020 = 569L1
    AutodeskVaultWorkgroup2020 = 559L1
    AutodeskVehicleTracking2020 = 955L1
    AutodeskVRED2020 = 884L1
    AutodeskVREDDesign2020 = 885L1
    AutodeskVREDPresenter2020 = 888L1
    AutodeskVREDProfessional2020 = 886L1
    AutodeskVREDRenderNodeconsumptionbasedlicense2020 = A93L1
    AutodeskVREDRenderNode2020 = 890L1
    AutodeskVREDServer2020 = 887L1
    AutodeskWiretapGateway2020 = C0ZL1
    FeatureCAMPremium2020 = P16L1
    FeatureCAMStandard2020 = P15L1
    FeatureCAMUltimate2020 = P17L1
    HSMWorksPremium2020 = 873L1
    HSMWorksUltimate2020 = 872L1
    PowerInspectPremium2020 = P13L1
    PowerInspectStandard2020 = P12L1
    PowerInspectUltimate2020 = P14L1
    PowerMillPremium2020 = P07L1
    PowerMillStandard2020 = A9ZL1
    PowerMillUltimate2020 = P08L1
    PowerShapePremium2020 = P10L1
    PowerShapeStandard2020 = P09L1
    PowerShapeUltimate2020 = P11L1
    T1EnterpriseMultiflex2020 = 535L1
    InventorNesting = C1QL1
"@  | ConvertFrom-StringData
#endregion


Function ADSKEXE{
if (Test-Path -Path "C:\Program Files (x86)\Common Files\Autodesk Shared\AdskLicensing\Current\helper\AdskLicensingInstHelper.exe") {
	$global:ExePath = "C:\Program Files (x86)\Common Files\Autodesk Shared\AdskLicensing\Current\helper\AdskLicensingInstHelper.exe"
	Write-Host 'Exe Found'
    $WPFStatusBox.Text = "Exe Found / Ready"
    $WPFimage.Source = $Path + "\res\icons8_ok_48px.png"
    $WPFlistBox.IsEnabled = $True
    $WPFLicense.IsEnabled = $True
    $WPFSearchbox.IsEnabled = $True
    $WPFPrintList.IsEnabled = $True
    $WPFRunButton.IsEnabled = $True
    $WPFGenerate.IsEnabled = $True


}else{
	Write-Output 'Exe NotFound'
    $WPFStatusBox.Text = "Exe Not Found / Not Ready"
    $WPFimage.Source = $Path + "\res\icons8_cancel_48px.png"
  }
}

Function Generate{
    Write-Host "Generate Clicked"
        
    if($WPFLicense.SelectedItem.Content -eq "Network licensing"){
        if($Servertype -eq "RESET"){
            $global:CMDString = '"' + $ExePath + '"' + " change " + "--prod_key " + $Product  + " --prod_ver 2020.0.0.F " + "--lic_method " + '""' + " --lic_server_type " + '""' + " --lic_servers " + '""'
        Set-Clipboard -Value $CMDString
        $WPFResultBox.Text = $CMDString
        Write-Host $CMDString
        }
        else{
        $global:CMDString = '"' + $ExePath + '"' + " change " + "--prod_key " + $Product  + " --prod_ver 2020.0.0.F " + "--lic_method " + $License + " --lic_server_type " + $Servertype + " --lic_servers " + $WPFServerName.Text
        Set-Clipboard -Value $CMDString
        $WPFResultBox.Text = $CMDString
        Write-Host $CMDString
        }
    }
    else{
        $global:CMDString = '"' + $ExePath + '"' + " change " + "--prod_key " + $Product  + " --prod_ver 2020.0.0.F " + "--lic_method " + $License
        Set-Clipboard -Value $CMDString
        $WPFResultBox.Text = $CMDString
        Write-Host $CMDString
        }
    }
#===========================================================================
#Config Files / Write / Read etc.
#===========================================================================
#region Config

#Write new Default Config if deleted
function New-Config {
    #Checks for target directory and creates if non-existent 
  if (!(Test-Path -Path "$Path\res\settings\options.config")) {
    #Setup default preferences	
    #Creates hash table and .clixml config file
    $Config = @{
      'ThemeProperty' = "LightTheme"
    }
    $Config | Export-Clixml -Path "$Path\res\settings\options.config"
    Import-Config
  }
} #end function New-Config

function Import-Config {
	#If a config file exists for the current user in the expected location, it is imported
	#and values from the config file are placed into global variables
	if (Test-Path -Path "$Path\res\settings\options.config") {
		try {
			#Imports the config file and saves it to variable $Config
			$Config = Import-Clixml -Path "$Path\res\settings\options.config"
			
			#Creates global variables for each config property and sets their values
            $global:ThemeProperty = $Config.ThemeProperty

            #Set Properties depending on Optionfile
            if($global:ThemeProperty -eq "DarkTheme")
            {
              $WPFThemeSwitch.IsChecked = $true
              SetTheme("DarkTheme")
            }
            else 
            {
              $WPFThemeSwitch.IsChecked = $false
              SetTheme("LightTheme")
            }
            
		}
		catch {
			[System.Windows.Forms.MessageBox]::Show("An error occurred importing your Config file. A new Config file will be generated for you. $_", 'Import Config Error', 'OK', 'Error')
			New-Config
		}
	} #end if config file exists
	else {
		New-Config
	}
} #end function Import-Config

function Update-Config {
  #Creates a new Config hash table with the current preferences set by the user
$Config = @{
      'ThemeProperty' = $global:ThemeProperty
}
  #Export the updated config
  $Config | Export-Clixml -Path "$Path\res\settings\options.config"
} #end function Update-Config

#endregion
function SetTheme($Themestr){
  $Theme = [MahApps.Metro.ThemeManager]::DetectAppStyle($Form)
  if($Themestr -eq "DarkTheme")
  {
    $global:ThemeProperty = "DarkTheme"
    [MahApps.Metro.ThemeManager]::ChangeAppStyle($Form, $Theme.Item2, [MahApps.Metro.ThemeManager]::GetAppTheme("BaseDark"));
    $Theme = [MahApps.Metro.ThemeManager]::DetectAppStyle($Form)
    [MahApps.Metro.ThemeManager]::ChangeAppStyle($Form, [MahApps.Metro.ThemeManager]::GetAccent("Steel"), $Theme.Item1);
  }
  else 
  {
    $global:ThemeProperty = "LightTheme"
    [MahApps.Metro.ThemeManager]::ChangeAppStyle($Form, $Theme.Item2, [MahApps.Metro.ThemeManager]::GetAppTheme("BaseLight")); 
    $Theme = [MahApps.Metro.ThemeManager]::DetectAppStyle($Form)
    [MahApps.Metro.ThemeManager]::ChangeAppStyle($Form, [MahApps.Metro.ThemeManager]::GetAccent("Cobalt"), $Theme.Item1);
  }
}
#region XAML Reader
# where is the XAML file?
$xamlFile = $path + "\res\MainWindow.xaml"

$inputXML = Get-Content $xamlFile -Raw
$inputXML = $inputXML -replace 'mc:Ignorable="d"','' -replace "x:N",'N' -replace '^<Win.*', '<Window'
[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
[xml]$XAML = $inputXML
#Read XAML
 
$reader=(New-Object System.Xml.XmlNodeReader $xaml)
try{
    $Form=[Windows.Markup.XamlReader]::Load( $reader )
}
catch{
    Write-Warning "Unable to parse XML, with error: $($Error[0])`n Ensure that there are NO SelectionChanged or TextChanged properties in your textboxes (PowerShell cannot process them)"
    throw
}

#$ThemeSwitch = $Form.Findname("ThemeSwitch")
$WPFFlyOutContent = $Form.Findname("FlyOutContent")
 
#===========================================================================
# Load XAML Objects In PowerShell
#===========================================================================
  
$xaml.SelectNodes("//*[@Name]") | ForEach-Object{"trying item $($_.Name)";
    try {Set-Variable -Name "WPF$($_.Name)" -Value $Form.FindName($_.Name) -ErrorAction Stop}
    catch{throw}
    }
 
Function Get-FormVariables{
if ($global:ReadmeDisplay -ne $true){Write-host "If you need to reference this display again, run Get-FormVariables" -ForegroundColor Yellow;$global:ReadmeDisplay=$true}
write-host "Found the following interactable elements from our form" -ForegroundColor Cyan
get-variable WPF*
} 
Get-FormVariables
#endregion XAML Reader

#===========================================================================
# Use this space to add code to the various form elements in your GUI
#===========================================================================
                                                                    
#Initialize Form
#Deactivate everything until Exe check is used

$WPFlistBox.IsEnabled = $False
$WPFLicense.IsEnabled = $False
$WPFServerType.IsEnabled = $False
$WPFServerName.IsEnabled = $False
$WPFSearchbox.IsEnabled = $False
$WPFPrintList.IsEnabled = $False
$WPFRunButton.IsEnabled = $False
$WPFGenerate.IsEnabled = $False

#Add Product by Hashtable
$WPFlistBox.ItemsSource =  $Hashtable2020.Keys

#Correct Font Size
foreach( $item in $WPFlistBox){ 
    $item.FontSize = "14"
}

#Load Config
Import-Config

#===========================================================================
#Events Bindings
#===========================================================================

#region Events

#Selection Event Change Product
$WPFlistBox.Add_SelectionChanged(
  { 
    $SelectedItem = $WPFlistBox.SelectedItem
    Write-Host $SelectedItem
            
        Try{
          Write-Host $Hashtable2020.Get_Item($SelectedItem)
          $global:Product = $Hashtable2020.Get_Item($SelectedItem)
        }
        catch{}

        #Clear Resultbox if something changes
        $WPFResultBox.Text = ""

    }
)

#Selection Event Change License
$WPFLicense.Add_SelectionChanged(
     { 
          
          if ($WPFLicense.SelectedItem.Content -eq "Network licensing")
          {
            $WPFServerType.IsEnabled = $true
            $WPFServerName.IsEnabled = $true
            $global:License = "NETWORK"
          }
          elseif($WPFLicense.SelectedItem.Content -eq "Standalone Licensing") {
            $WPFServerType.IsEnabled = $False
            $WPFServerName.Text = ""
            $WPFServerName.IsEnabled = $False
            $global:License = "STANDALONE"
          }
          elseif($WPFLicense.SelectedItem.Content -eq "User Licensing") {
            $WPFServerType.IsEnabled = $False
            $WPFServerName.Text = ""
            $WPFServerName.IsEnabled = $False
            $global:License = "USER"
          }
          elseif($WPFLicense.SelectedItem.Content -eq "Reset") {
            $WPFServerType.IsEnabled = $False
            $WPFServerName.Text = ""
            $WPFServerName.IsEnabled = $False
            $global:License = '""' 
          }
        #Clear Resultbox if something changes
        $WPFResultBox.Text = ""

     }
)

#Selection Event Change Server Typ
$WPFServerType.Add_SelectionChanged(
     { 
          if ($WPFServerType.SelectedItem.Content  -eq "Single Server")
          {
            $global:Servertype = "SINGLE"
          }
          elseif($WPFServerType.SelectedItem.Content  -eq "Redundant servers")
          {
            $global:Servertype = "REDUNDANT"  
          }
          elseif($WPFServerType.SelectedItem.Content  -eq "Distributed servers")
          {
            $global:Servertype = "DISTRIBUTED"  
          }
          elseif($WPFServerType.SelectedItem.Content  -eq "Reset server")
          {
            $global:Servertype = "RESET"  
          }
       #Clear Resultbox if something changes
       $WPFResultBox.Text = ""   
     }
)

#Adding code to Check Path Button
 $WPFCheckPath.Add_Click({
    Write-Host "Check Path Clicked"
    ADSKEXE
}) 

#Adding code to Print List Button
$WPFPrintList.Add_Click({
    Write-Host "Print List Clicked"
    $jsonString = &"C:\Program Files (x86)\Common Files\Autodesk Shared\AdskLicensing\Current\helper\AdskLicensingInstHelper.exe" list |ConvertFrom-Json| ConvertTo-Json |Out-File ($tempPath + $JsonFileName)
    Invoke-Item  ($tempPath + $JsonFileName)
}) 

#Adding code to Generate / Copy
$WPFGenerate.Add_Click({
    Write-Host "Generate Clicked"
    Generate
}) 

$WPFSearchbox.Add_KeyDown({
      #Reset selection / otherwise you could have something selectet that is no longer present
      $WPFlistBox.SelectedIndex = -1
      $global:Product = ""
      $SearchValue = $WPFSearchbox.Text
      Write-Host $SearchValue
      $WPFlistBox.ItemsSource = @(( $Hashtable2020.Keys| Where-Object { $_ -like "*$SearchValue*" }))
})

$WPFRunButton.Add_Click({

if($WPFlistBox.SelectedItem.Count -lt 1)
{
  $ok = [MahApps.Metro.Controls.Dialogs.MessageDialogStyle]::Affirmative
  [MahApps.Metro.Controls.Dialogs.DialogManager]::ShowModalMessageExternal($Form,"Run","No Product is selected! Select a Product from list!",$ok)
}
else {
    if($WPFResultBox.Text -ne ""){
      # OK CANCEL Style
      $okAndCancel = [MahApps.Metro.Controls.Dialogs.MessageDialogStyle]::AffirmativeAndNegative
       # show ok/cancel message
      $result = [MahApps.Metro.Controls.Dialogs.DialogManager]::ShowModalMessageExternal($Form,"Run CMD","Do you realy want to run this command?",$okAndCancel)
   
        If ($result -eq "Affirmative"){ 
          $CMDPath = $tempPath + "\ADSKMCommandtemp.cmd"
          Set-Content -Path $CMDPath -Value $WPFResultBox.Text -Encoding ASCII
          Invoke-Item $CMDPath
      
          $Loginpath = $env:LOCALAPPDATA + "\Autodesk\Web Services\LoginState.xml"
          Remove-Item  $Loginpath -ErrorAction Ignore
        }
      else{
          #do nothing
      }
    }
  
  else { 
          #This gets only triggered if the string is empty. If there is already a string it does not overwrite it. Use Generate / Copy for that.
          Generate 
          # OK CANCEL Style
          $okAndCancel = [MahApps.Metro.Controls.Dialogs.MessageDialogStyle]::AffirmativeAndNegative
          # show ok/cancel message
          $result = [MahApps.Metro.Controls.Dialogs.DialogManager]::ShowModalMessageExternal($Form,"Run CMD","Do you realy want to run this command?",$okAndCancel)
  
        If ($result -eq "Affirmative"){ 
          $CMDPath = $tempPath + "\ADSKMCommandtemp.cmd"
          Set-Content -Path $CMDPath -Value $WPFResultBox.Text -Encoding ASCII
          Invoke-Item $CMDPath
      
          $Loginpath = $env:LOCALAPPDATA + "\Autodesk\Web Services\LoginState.xml"
          Remove-Item  $Loginpath -ErrorAction Ignore
        }
        else{
            #do nothing
        }
      }
  }


})

$WPFThemeSwitch.Add_Click({
  if($WPFThemeSwitch.IsChecked -eq $true) #BaseDark
  {
    SetTheme("DarkTheme")
    Update-Config
  }
  else{
    SetTheme("LightTheme")
    Update-Config
  }
})

$WPFSettingsButton.Add_Click({
  $WPFFlyOutContent.IsOpen = $true 
})

$WPFOpenLoginStatePath.Add_Click({
  try {
    $OpenPath=$env:LOCALAPPDATA + "\Autodesk\Web Services\"
    Write-Host $OpenPath
    Invoke-Item $OpenPath
  }
  catch {
    $ok = [MahApps.Metro.Controls.Dialogs.MessageDialogStyle]::Affirmative
    [MahApps.Metro.Controls.Dialogs.DialogManager]::ShowModalMessageExternal($Form,"Open Path","Could not find Path!",$ok)
  }
})

$WPFHelpButton.Add_Click({
  $Helpfile = $Path + "\res\settings\ADSKLicensingModifierHelpFile.chm"
  Invoke-Item $Helpfile
})
#endregion Events

#===========================================================================
# Shows the form
#===========================================================================
#Initialize Form
$Form.Icon = $MainformIcon
$WPFimage.Source = $Path +"\res\icons8_cancel_48px.png"
$WPFMUMLogo.Source = $Path + "\res\MUMLogo.png"
$WPFStatusBox.Text = "Not Ready / Check Path"

$Form.ShowDialog() | out-null





 