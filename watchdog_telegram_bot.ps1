param([switch]$NoLoop)

$logFile = Join-Path $PSScriptRoot "watchdog_telegram_bot.log"
$scriptDir = $PSScriptRoot

function Write-Log {
    param([string]$Msg)
    $ts = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$ts $Msg" | Out-File -FilePath $logFile -Append -Encoding UTF8
    Write-Host "$ts $Msg"
}

Write-Log "========================================"
Write-Log "Telegram Bot Watchdog started"

do {
    $proc = Get-CimInstance -ClassName Win32_Process -Filter "Name='node.exe'" -ErrorAction SilentlyContinue | Where-Object {
        $_.CommandLine -match "start-patched"
    }
    if (-not $proc) {
        Write-Log "Bot not running. Starting..."
        & "$scriptDir\start_bot_hidden.ps1"
        Write-Log "Started bot via start_bot_hidden.ps1"
    } else {
        Write-Log "Bot running (PID: $($proc.Id))"
    }

    if ($NoLoop) { break }
    Start-Sleep -Seconds 30
} while ($true)
