# ==============================
# Windows Service Monitor Script
# ==============================

# Services to monitor (use SERVICE NAMES, not display names)
$Services = @(
    "Spooler",     # Print Spooler
    "wuauserv"     # Windows Update
)

# Log file location
$LogDir  = "$env:USERPROFILE\Documents\ServiceLogs"
$LogFile = "$LogDir\service-monitor.log"

# Create log directory if missing
if (!(Test-Path $LogDir)) {
    New-Item -ItemType Directory -Path $LogDir | Out-Null
}

# Timestamp function
function Write-Log {
    param ([string]$Message)
    $Time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$Time - $Message" | Tee-Object -FilePath $LogFile -Append
}

Write-Log "===== Service check started ====="

foreach ($ServiceName in $Services) {

    $Service = Get-Service -Name $ServiceName -ErrorAction SilentlyContinue

    if ($null -eq $Service) {
        Write-Log "Service '$ServiceName' not found."
        continue
    }

    if ($Service.Status -ne "Running") {
        Write-Log "Service '$ServiceName' is $($Service.Status). Attempting restart."

        try {
            Restart-Service -Name $ServiceName -Force -ErrorAction Stop
            Write-Log "Service '$ServiceName' restarted successfully."
        }
        catch {
            Write-Log "ERROR restarting '$ServiceName' : $_"
        }
    }
    else {
        Write-Log "Service '$ServiceName' is running."
    }
}

Write-Log "===== Service check completed ====="