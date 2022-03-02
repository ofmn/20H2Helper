# Think about adding
# Think about if we want to copy out the inf files if any found - to the export of data
# Add stuff to check if there even is any logs
$Credential = Get-Credential
$UserName = $Credential.UserName
$Password = $Credential.GetNetworkCredential().Password

$script:Local = (Get-WmiObject -Class win32_computersystem).Name
function clearformwindow {
    $TextBox1.Text = ""
    $Form1.Height = 323
    $TABS.Visible = $false
    $setuperrlogtextbox.Text = ""
    $scanresulttextbox.Text = ""
    $LogsButton.visible = $false 
    $ProgressBar1.Value = 0
    $ProgressBar1.Visible = $false
}

# Clicking on button fetch
$Button1_Click = {
    
    # Get hostname from input - if no input use local machine
    If ($ComputerName.Text -eq "") {
        $ComputerName.Text = HOSTNAME.EXE
        $global:hostname = $ComputerName.Text
    }
    If ($ComputerName.Text -ne "") {
        $global:hostname = $ComputerName.Text
    }
    # When searching make sure that all fields are cleared.
    clearformwindow
    #
    If ($hostname -ne $Local) {
        $script:wmipara = @{
            ComputerName = $hostname
            Credential   = $Credential
        }
    }
    
    If ($hostname -eq $Local) {
        $script:wmipara = @{
            ComputerName = $hostname
        }
    }

    # As the searching begins show the Progressbar + perform a step in the bar
    $ProgressBar1.Visible = $true
    $ProgressBar1.PerformStep()
    
    # Get date
    $date = Get-date

    try {
        $global:win32_operatingsystem = Get-WmiObject -Class win32_operatingsystem @wmipara -ErrorAction Stop
        $ProgressBar1.PerformStep()
        #Start-sleep -s 1
        
        # Get lastboot
        $lastboot = ($win32_operatingsystem | Select-Object @{N = 'LastBootTime'; E = { $_.ConvertToDateTime($_.LastBootUpTime) } }).LastBootTime

        # Get OS version - and add "20H2" if the version matches .
        $osversion = $win32_operatingsystem.version
        If ($osversion -eq "10.0.19042") {
            $osversion = "$osversion = 20H2"
            $correctOSversion = $true
        }
        # It should test for both the OS version but also if the WindowsBT exist.
        # 20H2 = stop and just tell ITSS. No WindowsBT, also stop, because the rest of this code is dependendt on it being there
        If ($correctOSversion -ne $true) {
            If (Test-path \\$hostname\c$\`$WINDOWS.~BT) {
                # Get logs if exist
                $script:sourcefolder = "\\$hostname\c$\`$WINDOWS.~BT\Sources\Panther"
                $script:destinationfolder = "\\cher\m-drev\Trans\OLMN\20H2\$hostname"
                If (!(Test-Path "$destinationfolder")) { New-Item -Path "\\cher\m-drev\Trans\OLMN\20H2" -Name "$hostname" -ItemType "directory" }
                $log1_source = "$sourcefolder\setuperr.log"
                $log1_dest = "$destinationfolder\setuperr.log"
                $log2_source = "$sourcefolder\scanresult.xml"
                $log2_dest = "$destinationfolder\scanresult.xml"
                $log3_source = "$sourcefolder\setupact.log"
                $log3_dest = "$destinationfolder\setupact.log"
                If (Test-Path "$destinationfolder") {
                    try {
                        If (Test-Path $log1_source) { Copy-Item $log1_source -Destination $log1_dest }
                        If (Test-Path $log2_source) { Copy-Item $log2_source -Destination $log2_dest }
                        If (Test-Path $log3_source) { Copy-Item $log3_source -Destination $log3_dest }
                    }
                    catch [System.UnauthorizedAccessException] {
                        Write-Host -ForegroundColor Red "Access Denied to $hostname";
                        $ComputerName.Text = "Access Denied"
                    }
                    catch [System.Management.ManagementException] {
                        Write-Host -ForegroundColor Red "Access Denied to $hostname";
                        $ComputerName.Text = "Access Denied"
                    }
                    catch [System.Runtime.InteropServices.COMException] {
                        Write-Host -ForegroundColor Red "The RPC Server is Unavailable on $hostname";
                        clearformwindow
                        $ComputerName.Text = "Computer offline"
                    }
                
                }
    
                # Add log names of copied logs to array, and show the fullpath in Form window
                $logfiles = @()
                foreach ($entry in (Get-ChildItem $destinationfolder)) {
                    $fullnamelog = $entry.Fullname  
                    $logfiles += "`r`n$fullnamelog"
                }

                # Get disk space remaining
                $win32_logicaldisk = Get-WmiObject Win32_LogicalDisk @wmipara -Filter "DeviceID='C:'"
                $freeandtotal = ($win32_logicaldisk | Select-Object Size, FreeSpace)
                $totaldisk = [Math]::Round($freeandtotal.Size / 1GB)
                $diskspaceleft = [Math]::Round($freeandtotal.Freespace / 1GB)
                If ($diskspaceleft -le 25) { $disktext = "Not enough diskspace! - Only $diskspaceleft GB left!" }
                else { $disktext = "$diskspaceleft GB free / of $totaldisk GB" }

                # If log file "scanresult.xml" exist search for "BlockMigration="True". As this means there are out of date drivers that needs updating.
                # Count how many entries, and this will tell how many drivers need updating. Output number as filename to new file in folder.
                If (Test-Path "$destinationfolder\Scanresult.xml") {
                    #-and (!(Test-path $folder\*date*))) 
                    $driverissue = select-string -Path "$destinationfolder\Scanresult.xml" -Pattern 'oem.{1,6}\.inf(?=" BlockMigration="True")' -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value }
                    $drivercount = $driverissue.count
                    $script:driverarray = @()
                    foreach ($driver in $driverissue) {
                (Get-childitem \\$hostname\c$\Windows\INF -Filter $driver).Fullname | ForEach-Object { Copy-Item -Path $_ -Destination "\\cher\m-drev\trans\olmn\20h2\$hostname" }
                        $driverarray += $driver -replace ".*.inf", "`r`n\\$hostname\c$\Windows\INF\$driver"
                    }
                }
    

                If (Test-Path $destinationfolder\setuperr.log) {
                    $0x8007065e = select-string -Path "$destinationfolder\setuperr.log" -Pattern "Error reading if disable WU access is set, swallowing: \[0x8007065e]" -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value }
                    If ($0x8007065e.count -ge 1) { $0x8007065e = $0x8007065e[0] }
                }
                $TextBox1.Text =
                "Date:                      $date
LastBoot:               $lastboot

Hostname:               $hostname
OS Vers:                $osversion
Space Left:             $disktext
LogFiles export:        $destinationfolder
$logfiles

Please attach all logs to ticket"

        

                If (Test-Path $log1_dest) {
                    $Logsbutton.visible = $true
                    $Form1.Height = 554
                    $TABS.Visible = $true
                    $setuperrlogtextbox.Text = $0x8007065e
                }
    
                If (Test-Path $log2_dest) {
                    If ($drivercount -ge 1) {
                        $scanresulttextbox.Text = "Driver issues found : $drivercount
Please update with ThinInstaller.
            
If this does not help resolve it, please open these files with notepad to check what driver it might be.
$driverarray"

                    }
                    If ($drivercount -eq 0) { $scanresulttextbox.Text = "No outdated drivers." }

                }
                $TextBox1.Text | Out-File $destinationfolder\Textboxoutput.txt
            }
        }
        If ($correctOSversion -eq $true) { $TextBox1.Text = "Computer successfully updated." }   
        If (($correctOSversion -ne $true) -and (!(Test-Path \\$hostname\c$\`$WINDOWS.~BT))) {
            $TextBox1.Text = "
Computer have not tried running the update yet.
This is usually due to load on the WSUS servers.
Please keep the ticket and try again later or tomorrow
OS Version : $osversion"
        }
    }
    catch [System.UnauthorizedAccessException] {
        Write-Host -ForegroundColor Red "Access Denied to $hostname";
        $ComputerName.Text = "Access Denied"
    }
    catch [System.Management.ManagementException] {
        Write-Host -ForegroundColor Red "Access Denied to $hostname";
        $ComputerName.Text = "Access Denied"
    }
    catch [System.Runtime.InteropServices.COMException] {
        Write-Host -ForegroundColor Red "The RPC Server is Unavailable on $hostname";
        clearformwindow
        $ComputerName.Text = "Computer offline"
    }
    # Perform a new step in the progress bar to show progress Add 22
    $ProgressBar1.PerformStep()
}


$LogsButton_Click = {
    Invoke-Item -Path "$destinationfolder"
}

$FetchButton_Click = {
    clearformwindow
    $ComputerName.Text = ""
}

# Just testing git commits
Add-Type -AssemblyName System.Windows.Forms
. (Join-Path $PSScriptRoot '20h2.designer.ps1')
$Form1.ShowDialog()