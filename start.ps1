## This code is from the Windows Activator start script; I changed it to 
## work for my purposes.

## https://github.com/massgravel/Microsoft-Activation-Scripts

# Enable TLSv1.2 for compatibility with older clients

# COLORS!!!
$style=@(
    0, 'default', 'bold',
    4, 'underline',
    24, 'nounderline',
    7, 'negative',
    27, 'positive',
    '_fg',
        30, 'black', 'red', 'green', 'yellow', 'blue', 'magenta', 'cyan', 'white',
        39, 'default',
    '_bg',
        'black', 'red', 'green', 'yellow', 'blue', 'magenta', 'cyan', 'white',
        49, 'default',
    '_bf', 90, 'black', 'red', 'green', 'yellow', 'blue', 'magenta', 'cyan', 'white',
    '_bb', 100, 'black', 'red', 'green', 'yellow', 'blue', 'magenta', 'cyan', 'white'
) `
| &{
    Begin {
        $sequence="$([char]27)[{0}m"
        $style=@{
            fg=@{
                rgb=$sequence -f '38;2;{0};{1};{2}'
                x=$sequence -f '38;5;{0}'
            };
            bg=@{
                rgb=$sequence -f '48;2;{0};{1};{2}'
                x=$sequence -f '48;5;{0}'
            };
            bf=@{};
            bb=@{};
        }
        $current=$style
        $index=$null
    }
    Process {
        Switch -regex ($_) {
            '\d' { $index=$_ }
            '^_' { $current=$style[$_ -replace '^.',''] }
            Default {
                $current[$_]=$sequence -f $index++
#comment me out
"$($current[$_])$($_)`t" | Out-Host
            }
        }
    }
    End {
        $style
#more demonstrations
@(($style.bg.rgb -f 120,32,230), ($style.fg.x -f 30), 'hello', $style.default) -join '' | Out-Host
    }
}




[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor [System.Net.SecurityProtocolType]::Tls12

$DownloadURL = 'https://github.com/AlphaGameDeveloper/Minecraft-Tools/raw/main/run.bat'

$FilePath = "$env:TEMP\MinecraftTools.bat"
$ScriptArgs = "$args "

try {
    Invoke-WebRequest -Uri $DownloadURL -UseBasicParsing -OutFile $FilePath -ErrorAction Stop
} catch {
    Write-Host $style.fg.red "ERROR: An error occured whilst 
    Write-Error $_
}

if (Test-Path $FilePath) {
    Start-Process $FilePath $ScriptArgs -Wait
    $item = Get-Item -LiteralPath $FilePath
    $item.Delete()
} else {
    Write-Host $style.fg.red "ERROR: An error occured whilst running the script...  (Please open a GitHub issue.)!"
    Write-Host $style.fg.yellow "ERROR: I can\'t find the file I just downloaded (It should have been downloaded at $FilePath !)"
}
