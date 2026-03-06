# Windows Service Monitor (PowerShell)

A PowerShell automation script that monitors critical Windows services, restarts them if they stop, and logs all actions to a timestamped log file.

## Features
- Checks Windows service status using `Get-Service`
- Automatically restarts stopped services with `Restart-Service`
- Logs service status and recovery actions
- Designed for scheduled execution via Task Scheduler

## Files
- `check-restart-service.ps1` – main service monitoring script
- `ServiceLogs/` – runtime logs (excluded from Git via .gitignore)

## Usage
Run from an elevated PowerShell session:

```powershell
.\check-restart-service.ps1