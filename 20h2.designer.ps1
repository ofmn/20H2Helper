$Form1 = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.Button]$FetchButton = $null
[System.Windows.Forms.TextBox]$ComputerName = $null
[System.Windows.Forms.TextBox]$TextBox1 = $null
[System.Windows.Forms.Label]$Label1 = $null
[System.Windows.Forms.Button]$LogsButton = $null
[System.Windows.Forms.TabControl]$TABS = $null
[System.Windows.Forms.TabPage]$TabPage1 = $null
[System.Windows.Forms.RichTextBox]$setuperrlogtextbox = $null
[System.Windows.Forms.TabPage]$TabPage2 = $null
[System.Windows.Forms.RichTextBox]$scanresulttextbox = $null
[System.Windows.Forms.Button]$ClearButton = $null
[System.Windows.Forms.ProgressBar]$ProgressBar1 = $null
function InitializeComponent
{
$resources = . (Join-Path $PSScriptRoot '20h2.resources.ps1')
$FetchButton = (New-Object -TypeName System.Windows.Forms.Button)
$ComputerName = (New-Object -TypeName System.Windows.Forms.TextBox)
$TextBox1 = (New-Object -TypeName System.Windows.Forms.TextBox)
$Label1 = (New-Object -TypeName System.Windows.Forms.Label)
$LogsButton = (New-Object -TypeName System.Windows.Forms.Button)
$TABS = (New-Object -TypeName System.Windows.Forms.TabControl)
$TabPage1 = (New-Object -TypeName System.Windows.Forms.TabPage)
$setuperrlogtextbox = (New-Object -TypeName System.Windows.Forms.RichTextBox)
$TabPage2 = (New-Object -TypeName System.Windows.Forms.TabPage)
$scanresulttextbox = (New-Object -TypeName System.Windows.Forms.RichTextBox)
$ClearButton = (New-Object -TypeName System.Windows.Forms.Button)
$ProgressBar1 = (New-Object -TypeName System.Windows.Forms.ProgressBar)
$TABS.SuspendLayout()
$TabPage1.SuspendLayout()
$TabPage2.SuspendLayout()
$Form1.SuspendLayout()
#
#FetchButton
#
$FetchButton.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]112,[System.Int32]39))
$FetchButton.Name = [System.String]'FetchButton'
$FetchButton.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]75,[System.Int32]23))
$FetchButton.TabIndex = [System.Int32]4
$FetchButton.Text = [System.String]'Fetch'
$FetchButton.UseVisualStyleBackColor = $true
$FetchButton.add_Click($Button1_Click)
#
#ComputerName
#
$ComputerName.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]40))
$ComputerName.Name = [System.String]'ComputerName'
$ComputerName.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]21))
$ComputerName.TabIndex = [System.Int32]3
#
#TextBox1
#
$TextBox1.BackColor = [System.Drawing.SystemColors]::ControlLight
$TextBox1.BorderStyle = [System.Windows.Forms.BorderStyle]::None
$TextBox1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]80))
$TextBox1.Multiline = $true
$TextBox1.Name = [System.String]'TextBox1'
$TextBox1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]378,[System.Int32]200))
$TextBox1.TabIndex = [System.Int32]5
#
#Label1
#
$Label1.AutoSize = $true
$Label1.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Tahoma',[System.Single]9,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$Label1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]14,[System.Int32]5))
$Label1.Name = [System.String]'Label1'
$Label1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]89,[System.Int32]28))
$Label1.TabIndex = [System.Int32]5
$Label1.Text = [System.String]'Enter PC name
Blank for local'
$Label1.TextAlign = [System.Drawing.ContentAlignment]::MiddleLeft
#
#LogsButton
#
$LogsButton.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]289,[System.Int32]40))
$LogsButton.Name = [System.String]'LogsButton'
$LogsButton.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]101,[System.Int32]23))
$LogsButton.TabIndex = [System.Int32]6
$LogsButton.Text = [System.String]'Goto Logs folder'
$LogsButton.UseVisualStyleBackColor = $true
$LogsButton.Visible = $false
$LogsButton.add_Click($LogsButton_Click)
#
#TABS
#
$TABS.Controls.Add($TabPage1)
$TABS.Controls.Add($TabPage2)
$TABS.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]289))
$TABS.Name = [System.String]'TABS'
$TABS.SelectedIndex = [System.Int32]0
$TABS.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]378,[System.Int32]220))
$TABS.TabIndex = [System.Int32]7
$TABS.Visible = $false
#
#TabPage1
#
$TabPage1.AccessibleRole = [System.Windows.Forms.AccessibleRole]::TitleBar
$TabPage1.Controls.Add($setuperrlogtextbox)
$TabPage1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]4,[System.Int32]22))
$TabPage1.Name = [System.String]'TabPage1'
$TabPage1.Padding = (New-Object -TypeName System.Windows.Forms.Padding -ArgumentList @([System.Int32]3))
$TabPage1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]370,[System.Int32]194))
$TabPage1.TabIndex = [System.Int32]0
$TabPage1.Tag = [System.String]''
$TabPage1.Text = [System.String]'setuperr.log'
$TabPage1.UseVisualStyleBackColor = $true
#
#setuperrlogtextbox
#
$setuperrlogtextbox.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]3))
$setuperrlogtextbox.Name = [System.String]'setuperrlogtextbox'
$setuperrlogtextbox.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]364,[System.Int32]188))
$setuperrlogtextbox.TabIndex = [System.Int32]0
$setuperrlogtextbox.Text = [System.String]''
#
#TabPage2
#
$TabPage2.Controls.Add($scanresulttextbox)
$TabPage2.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]4,[System.Int32]22))
$TabPage2.Name = [System.String]'TabPage2'
$TabPage2.Padding = (New-Object -TypeName System.Windows.Forms.Padding -ArgumentList @([System.Int32]3))
$TabPage2.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]370,[System.Int32]194))
$TabPage2.TabIndex = [System.Int32]1
$TabPage2.Tag = [System.String]''
$TabPage2.Text = [System.String]'scanresult.xml'
$TabPage2.UseVisualStyleBackColor = $true
#
#scanresulttextbox
#
$scanresulttextbox.BackColor = [System.Drawing.SystemColors]::Window
$scanresulttextbox.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Tahoma',[System.Single]8.25))
$scanresulttextbox.ForeColor = [System.Drawing.SystemColors]::WindowText
$scanresulttextbox.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
$scanresulttextbox.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]0))
$scanresulttextbox.Name = [System.String]'scanresulttextbox'
$scanresulttextbox.RightToLeft = [System.Windows.Forms.RightToLeft]::No
$scanresulttextbox.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]361,[System.Int32]188))
$scanresulttextbox.TabIndex = [System.Int32]0
$scanresulttextbox.Text = [System.String]''
#
#ClearButton
#
$ClearButton.BackColor = [System.Drawing.SystemColors]::Control
$ClearButton.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Tahoma',[System.Single]8.25))
$ClearButton.ForeColor = [System.Drawing.Color]::FromArgb(([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)),([System.Int32]([System.Byte][System.Byte]0)))

$ClearButton.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]315,[System.Int32]5))
$ClearButton.Name = [System.String]'ClearButton'
$ClearButton.RightToLeft = [System.Windows.Forms.RightToLeft]::No
$ClearButton.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]75,[System.Int32]23))
$ClearButton.TabIndex = [System.Int32]4
$ClearButton.Text = [System.String]'Clear'
$ClearButton.UseVisualStyleBackColor = $true
$ClearButton.add_Click($FetchButton_Click)
#
#ProgressBar1
#
$ProgressBar1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]64))
$ProgressBar1.Maximum = [System.Int32]2
$ProgressBar1.Name = [System.String]'ProgressBar1'
$ProgressBar1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]12))
$ProgressBar1.Step = [System.Int32]1
$ProgressBar1.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous
$ProgressBar1.TabIndex = [System.Int32]8
$ProgressBar1.Visible = $false
#
#Form1
#
$Form1.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]400,[System.Int32]284))
$Form1.Controls.Add($ProgressBar1)
$Form1.Controls.Add($TABS)
$Form1.Controls.Add($LogsButton)
$Form1.Controls.Add($Label1)
$Form1.Controls.Add($TextBox1)
$Form1.Controls.Add($ComputerName)
$Form1.Controls.Add($FetchButton)
$Form1.Controls.Add($ClearButton)
$Form1.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$Form1.Icon = ([System.Drawing.Icon]$resources.'$this.Icon')
$Form1.MaximizeBox = $false
$Form1.SizeGripStyle = [System.Windows.Forms.SizeGripStyle]::Hide
$Form1.Text = [System.String]'20H2 Helper'
$TABS.ResumeLayout($false)
$TabPage1.ResumeLayout($false)
$TabPage2.ResumeLayout($false)
$Form1.ResumeLayout($false)
$Form1.PerformLayout()
Add-Member -InputObject $Form1 -Name base -Value $base -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name FetchButton -Value $FetchButton -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name ComputerName -Value $ComputerName -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name TextBox1 -Value $TextBox1 -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name Label1 -Value $Label1 -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name LogsButton -Value $LogsButton -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name TABS -Value $TABS -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name TabPage1 -Value $TabPage1 -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name setuperrlogtextbox -Value $setuperrlogtextbox -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name TabPage2 -Value $TabPage2 -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name scanresulttextbox -Value $scanresulttextbox -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name ClearButton -Value $ClearButton -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name ProgressBar1 -Value $ProgressBar1 -MemberType NoteProperty
}
. InitializeComponent
