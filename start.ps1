## This code is from the Windows Activator start script; I changed it to 
## work for my purposes.

## https://github.com/massgravel/Microsoft-Activation-Scripts

# Enable TLSv1.2 for compatibility with older clients
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor [System.Net.SecurityProtocolType]::Tls12

$DownloadURL = 'https://github.com/AlphaGameDeveloper/Minecraft-Tools/raw/main/run.bat'

$FilePath = "$env:TEMP\MinecraftTools.bat"
$ScriptArgs = "$args "

try {
    Invoke-WebRequest -Uri $DownloadURL -UseBasicParsing -OutFile $FilePath -ErrorAction Stop
} catch {
    Write-Error $_
}

if (Test-Path $FilePath) {
    Start-Process $FilePath $ScriptArgs -Wait
    $item = Get-Item -LiteralPath $FilePath
    $item.Delete()
}
