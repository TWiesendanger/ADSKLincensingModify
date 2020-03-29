Clear-Host
#Initialize
[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') | out-null
[System.Reflection.Assembly]::LoadWithPartialName('System.ComponentModel') | out-null
[System.Reflection.Assembly]::LoadWithPartialName('System.Data') | out-null
[System.Reflection.Assembly]::LoadWithPartialName('System.Drawing') | out-null
[System.Reflection.Assembly]::LoadWithPartialName('presentationframework') | out-null

[System.Reflection.Assembly]::LoadWithPartialName('PresentationCore') | out-null
[System.Reflection.Assembly]::LoadFrom('res\assembly\MahApps.Metro.dll') | out-null
[System.Reflection.Assembly]::LoadFrom('res\assembly\System.Windows.Interactivity.dll') | out-null
[System.Reflection.Assembly]::LoadFrom('res\assembly\MahApps.Metro.IconPacks.dll') | out-null

# When compiled with PS2EXE the variable MyCommand contains no path anymore

if ($MyInvocation.MyCommand.CommandType -eq "ExternalScript") {
  # Powershell script
  $Path = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
}
else {
  # PS2EXE compiled script
  $Path = Split-Path -Parent -Path ([Environment]::GetCommandLineArgs()[0])
}

Write-Host $Path

#Initialize some variables
$tempPath = $env:TEMP 
$JsonFileName = "\templistADSK.json"
$MainformIcon = $Path + "\res\mum.png"
$global:ReleaseSelection = "2020"

#===========================================================================
#Product Key Hash Table
#===========================================================================
$AutodesProductsHashtable = Get-Content -Path ($Path + "\res\settings\AutodeskProducts.txt") | ConvertFrom-StringData

##############################################################
#                Functions                                   #
##############################################################
Function ADSKEXE {
  if (Test-Path -Path "C:\Program Files (x86)\Common Files\Autodesk Shared\AdskLicensing\Current\helper\AdskLicensingInstHelper.exe") {
    $global:ExePath = "C:\Program Files (x86)\Common Files\Autodesk Shared\AdskLicensing\Current\helper\AdskLicensingInstHelper.exe"
    Write-Host 'Exe Found'
    $WPFStatusBox.Text = "Exe Found / Ready"
    $WPFimage.Source = $Path + "\res\ok_48px.png"
    $WPFlistBox.IsEnabled = $True
    $WPFLicense.IsEnabled = $True
    $WPFSearchbox.IsEnabled = $True
    $WPFPrintList.IsEnabled = $True
    $WPFRunButton.IsEnabled = $True
    $WPFGenerate.IsEnabled = $True
    $WPFReleaseSelection.IsEnabled = $True
  }
  else {
    Write-Output 'Exe NotFound'
    $WPFStatusBox.Text = "Exe Not Found / Not Ready"
    $WPFimage.Source = $Path + "\res\cancel_48px.png"
  }
}

function CheckDesktopService {
  param($ServiceName)
  $arrService = Get-Service -Name $ServiceName
  if ($arrService.Status -ne "Running") {
    $global:ServiceState = $False
  }
  if ($arrService.Status -eq "running") { 
    Write-Host "$ServiceName service is already started"
    $global:ServiceState = $true
  }
}

Function Generate {
  Write-Host "Generate Clicked"
        
  if ($WPFLicense.SelectedItem.Content -eq "Network licensing") {
    if ($Servertype -eq "RESET") {
      $global:CMDString = '"' + $ExePath + '"' + " change " + "--prod_key " + $Product + " --prod_ver 2020.0.0.F " + "--lic_method " + '""' + " --lic_server_type " + '""' + " --lic_servers " + '""'
      Set-Clipboard -Value $CMDString
      $WPFResultBox.Text = $CMDString
      Write-Host $CMDString
    }
    else {
      $global:CMDString = '"' + $ExePath + '"' + " change " + "--prod_key " + $Product + " --prod_ver 2020.0.0.F " + "--lic_method " + $License + " --lic_server_type " + $Servertype + " --lic_servers " + $WPFServerName.Text
      Set-Clipboard -Value $CMDString
      $WPFResultBox.Text = $CMDString
      Write-Host $CMDString
    }
  }
  else {
    $global:CMDString = '"' + $ExePath + '"' + " change " + "--prod_key " + $Product + " --prod_ver 2020.0.0.F " + "--lic_method " + $License
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
      if ($global:ThemeProperty -eq "DarkTheme") {
        $WPFThemeSwitch.IsChecked = $true
        SetTheme("DarkTheme")
      }
      else {
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
function SetTheme($Themestr) {
  $Theme = [MahApps.Metro.ThemeManager]::DetectAppStyle($Form)
  if ($Themestr -eq "DarkTheme") {
    $global:ThemeProperty = "DarkTheme"
    [MahApps.Metro.ThemeManager]::ChangeAppStyle($Form, $Theme.Item2, [MahApps.Metro.ThemeManager]::GetAppTheme("BaseDark"));
    $Theme = [MahApps.Metro.ThemeManager]::DetectAppStyle($Form)
    [MahApps.Metro.ThemeManager]::ChangeAppStyle($Form, [MahApps.Metro.ThemeManager]::GetAccent("Steel"), $Theme.Item1);
  }
  else {
    $global:ThemeProperty = "LightTheme"
    [MahApps.Metro.ThemeManager]::ChangeAppStyle($Form, $Theme.Item2, [MahApps.Metro.ThemeManager]::GetAppTheme("BaseLight")); 
    $Theme = [MahApps.Metro.ThemeManager]::DetectAppStyle($Form)
    [MahApps.Metro.ThemeManager]::ChangeAppStyle($Form, [MahApps.Metro.ThemeManager]::GetAccent("Cobalt"), $Theme.Item1);
  }
}

function Search {

  #Reset selection / otherwise you could have something selectet that is no longer present
  $WPFlistBox.SelectedIndex = -1
  $global:Product = ""
  $SearchValue = $WPFSearchbox.Text
  Write-Host $SearchValue
 
  $WPFlistBox.ItemsSource = @(( $AutodesProductsHashtable.Keys | Where-Object { $_ -like "*$SearchValue*" -and $_ -like "*$global:ReleaseSelection" }))
  
}
#region XAML Reader
# where is the XAML file?
$xamlFile = $path + "\res\MainWindow.xaml"
#$xamlFile = "H:\Dropbox (Data)\TWIVisualStudioProcets\Powershell\ADSKLicensing\ADSKLicensingM\ADSKLicensingM\MainWindow.xaml"
$inputXML = Get-Content $xamlFile -Raw
$inputXML = $inputXML -replace 'mc:Ignorable="d"', '' -replace "x:N", 'N' -replace '^<Win.*', '<Window'
[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
[xml]$XAML = $inputXML
#Read XAML
 
$reader = (New-Object System.Xml.XmlNodeReader $xaml)
try {
  $Form = [Windows.Markup.XamlReader]::Load( $reader )
}
catch {
  Write-Warning "Unable to parse XML, with error: $($Error[0])`n Ensure that there are NO SelectionChanged or TextChanged properties in your textboxes (PowerShell cannot process them)"
  throw
}

#$ThemeSwitch = $Form.Findname("ThemeSwitch")
$WPFFlyOutContent = $Form.Findname("FlyOutContent")
 
#===========================================================================
# Load XAML Objects In PowerShell
#===========================================================================
  
$xaml.SelectNodes("//*[@Name]") | ForEach-Object { "trying item $($_.Name)";
  try { Set-Variable -Name "WPF$($_.Name)" -Value $Form.FindName($_.Name) -ErrorAction Stop }
  catch { throw }
}
 
Function Get-FormVariables {
  if ($global:ReadmeDisplay -ne $true) { Write-host "If you need to reference this display again, run Get-FormVariables" -ForegroundColor Yellow; $global:ReadmeDisplay = $true }
  write-host "Found the following interactable elements from our form" -ForegroundColor Cyan
  get-variable WPF*
} 
Get-FormVariables
#endregion XAML Reader

#===========================================================================
#                                  GUI
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
$WPFReleaseSelection.IsEnabled = $False

#Add Product by Hashtable
$WPFlistBox.ItemsSource = $AutodesProductsHashtable.Keys

#Correct Font Size
foreach ( $item in $WPFlistBox) { 
  $item.FontSize = "14"
}

#Load Config
Import-Config

#Check Desktop Licensing Service Status
CheckDesktopService "AdskLicensingService"
#Set State of ToggleSwitch in Flyout menü
If ($global:ServiceState) {
  $WPFDesktopService.IsChecked = $true
}
else {
  $WPFDesktopService.IsChecked = $false
  #$WPFServiceDialog.IsOpen = $true
}

#===========================================================================
#Events Bindings
#===========================================================================

#region Events


#Selection Event Change Release Selection
$WPFReleaseSelection.Add_SelectionChanged(
  { 
    $global:ReleaseSelection = $WPFReleaseSelection.SelectedItem.Content
    Write-Host $global:ReleaseSelection

    #Call Search Function
    Search
  }
)

#Selection Event Change Product
$WPFlistBox.Add_SelectionChanged(
  { 
    $SelectedItem = $WPFlistBox.SelectedItem
    Write-Host $SelectedItem
            
    Try {
      Write-Host $AutodesProductsHashtable.$SelectedItem
      $global:Product = $AutodesProductsHashtable.$SelectedItem
    }
    catch { }

    #Clear Resultbox if something changes
    $WPFResultBox.Text = ""

  }
)

#Selection Event Change License
$WPFLicense.Add_SelectionChanged(
  { 
          
    if ($WPFLicense.SelectedItem.Content -eq "Network licensing") {
      $WPFServerType.IsEnabled = $true
      $WPFServerName.IsEnabled = $true
      $global:License = "NETWORK"
    }
    elseif ($WPFLicense.SelectedItem.Content -eq "Standalone Licensing") {
      $WPFServerType.IsEnabled = $False
      $WPFServerName.Text = ""
      $WPFServerName.IsEnabled = $False
      $global:License = "STANDALONE"
    }
    elseif ($WPFLicense.SelectedItem.Content -eq "User Licensing") {
      $WPFServerType.IsEnabled = $False
      $WPFServerName.Text = ""
      $WPFServerName.IsEnabled = $False
      $global:License = "USER"
    }
    elseif ($WPFLicense.SelectedItem.Content -eq "Reset") {
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
    if ($WPFServerType.SelectedItem.Content -eq "Single Server") {
      $global:Servertype = "SINGLE"
    }
    elseif ($WPFServerType.SelectedItem.Content -eq "Redundant servers") {
      $global:Servertype = "REDUNDANT"  
    }
    elseif ($WPFServerType.SelectedItem.Content -eq "Distributed servers") {
      $global:Servertype = "DISTRIBUTED"  
    }
    elseif ($WPFServerType.SelectedItem.Content -eq "Reset server") {
      $global:Servertype = "RESET"  
    }
    #Clear Resultbox if something changes
    $WPFResultBox.Text = ""   
  }
)

#Adding code to Check Path Button
$WPFCheckPath.Add_Click( {
    Write-Host "Check Path Clicked"
    ADSKEXE

    #Check Desktop Licensing Service Status
    CheckDesktopService "AdskLicensingService"

    #Check Desktop Licensing Service Status
    If ($global:ServiceState) {
      $WPFDesktopService.IsChecked = $true
    }
    else {
      $WPFDesktopService.IsChecked = $false
      $WPFServiceDialog.IsOpen = $true
    }
  }) 

#Adding code to Print List Button
$WPFPrintList.Add_Click( {
    Write-Host "Print List Clicked"
    $jsonString = &"C:\Program Files (x86)\Common Files\Autodesk Shared\AdskLicensing\Current\helper\AdskLicensingInstHelper.exe" list | ConvertFrom-Json | ConvertTo-Json | Out-File ($tempPath + $JsonFileName)
    Invoke-Item  ($tempPath + $JsonFileName)
  }) 

#Adding code to Generate / Copy
$WPFGenerate.Add_Click( {
    Write-Host "Generate Clicked"
    Generate
    $WPFInfoDialog.IsOpen = $true
  }) 



$WPFSearchbox.Add_KeyDown( {
    #Call Search
    if ($_.Key -eq 'Return') {
      #Reset selection / otherwise you could have something selectet that is no longer present
      $WPFlistBox.SelectedIndex = -1
      $global:Product = ""
      $SearchValue = $WPFSearchbox.Text
      $WPFlistBox.ItemsSource = @(( $AutodesProductsHashtable.Keys | Where-Object { $_ -like "*$SearchValue*" -and $_ -like "*$global:ReleaseSelection" }))
    }
  })

$WPFRunButton.Add_Click( {

    if ($WPFlistBox.SelectedItem.Count -lt 1) {
      $ok = [MahApps.Metro.Controls.Dialogs.MessageDialogStyle]::Affirmative
      [MahApps.Metro.Controls.Dialogs.DialogManager]::ShowModalMessageExternal($Form, "Run", "No Product is selected! Select a Product from list!", $ok)
    }
    else {
      if ($WPFResultBox.Text -ne "") {
        # OK CANCEL Style
        $okAndCancel = [MahApps.Metro.Controls.Dialogs.MessageDialogStyle]::AffirmativeAndNegative
        # show ok/cancel message
        $result = [MahApps.Metro.Controls.Dialogs.DialogManager]::ShowModalMessageExternal($Form, "Run CMD", "Do you realy want to run this command?", $okAndCancel)
   
        If ($result -eq "Affirmative") { 
          $CMDPath = $tempPath + "\ADSKMCommandtemp.cmd"
          Set-Content -Path $CMDPath -Value $WPFResultBox.Text -Encoding ASCII
          Invoke-Item $CMDPath
      
          $Loginpath = $env:LOCALAPPDATA + "\Autodesk\Web Services\LoginState.xml"
          Remove-Item  $Loginpath -ErrorAction Ignore
        }
        else {
          #do nothing
        }
      }
  
      else { 
        #This gets only triggered if the string is empty. If there is already a string it does not overwrite it. Use Generate / Copy for that.
        Generate 
        # OK CANCEL Style
        $okAndCancel = [MahApps.Metro.Controls.Dialogs.MessageDialogStyle]::AffirmativeAndNegative
        # show ok/cancel message
        $result = [MahApps.Metro.Controls.Dialogs.DialogManager]::ShowModalMessageExternal($Form, "Run CMD", "Do you realy want to run this command?", $okAndCancel)
  
        If ($result -eq "Affirmative") { 
          $CMDPath = $tempPath + "\ADSKMCommandtemp.cmd"
          Set-Content -Path $CMDPath -Value $WPFResultBox.Text -Encoding ASCII
          Invoke-Item $CMDPath
      
          $Loginpath = $env:LOCALAPPDATA + "\Autodesk\Web Services\LoginState.xml"
          Remove-Item  $Loginpath -ErrorAction Ignore
        }
        else {
          #do nothing
        }
      }
    }
  })

$WPFThemeSwitch.Add_Click( {
    if ($WPFThemeSwitch.IsChecked -eq $true) {
      #BaseDark
      SetTheme("DarkTheme")
      Update-Config
    }
    else {
      SetTheme("LightTheme")
      Update-Config
    }
  })

$WPFDesktopService.Add_Click( {
    if ($WPFDesktopService.IsChecked -eq $true) {
      Start-Service -Name "AdskLicensingService"
    }
    else {
      Stop-Service -Name "AdskLicensingService"
    }
  })

$WPFRefreshService.Add_Click(
  {
    #Check Desktop Licensing Service Status
    CheckDesktopService "AdskLicensingService"
    #Set State of ToggleSwitch in Flyout menü
    If ($global:ServiceState) {
      $WPFDesktopService.IsChecked = $true
    }
    else {
      $WPFDesktopService.IsChecked = $false
      #$WPFServiceDialog.IsOpen = $true
    }
  }
)

$WPFSettingsButton.Add_Click( {
    $WPFFlyOutContent.IsOpen = $true 
  })

$WPFOpenLoginStatePath.Add_Click( {
    try {
      $OpenPath = $env:LOCALAPPDATA + "\Autodesk\Web Services\"
      Write-Host $OpenPath
      Invoke-Item $OpenPath
    }
    catch {
      $ok = [MahApps.Metro.Controls.Dialogs.MessageDialogStyle]::Affirmative
      [MahApps.Metro.Controls.Dialogs.DialogManager]::ShowModalMessageExternal($Form, "Open Path", "Could not find Path!", $ok)
    }
  })

$WPFOpenAdskLicensingServicePath.Add_Click( {
    try {
      $OpenPath = "C:\ProgramData\Autodesk\AdskLicensingService"
      Write-Host $OpenPath
      Invoke-Item $OpenPath
    }
    catch {
      $ok = [MahApps.Metro.Controls.Dialogs.MessageDialogStyle]::Affirmative
      [MahApps.Metro.Controls.Dialogs.DialogManager]::ShowModalMessageExternal($Form, "Open Path", "Could not find Path!", $ok)
    }
  })





$WPFHelpButton.Add_Click( {
    #$Helpfile = $Path + "\res\settings\ADSKLicensingModifierHelpFile.chm"
    start "https://github.com/TWiesendanger/ADSKLincensingModify"
    #Invoke-Item $Helpfile
  })
#endregion Events

#===========================================================================
# Shows the form
#===========================================================================
#Initialize Form
$Form.Icon = $MainformIcon
$WPFimage.Source = $Path + "\res\cancel_48px.png"
$WPFMUMLogo.Source = $Path + "\res\MUMLogo.png"
$WPFStatusBox.Text = "Not Ready / Check Path"

$Form.ShowDialog() | out-null