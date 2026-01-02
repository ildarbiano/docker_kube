Write-Host "=== 1. STOPPING HOMEWORK KUBERNETES CLUSTER & DOCKER ===" -ForegroundColor Red


# 1.1. Stop Minikube cluster
Write-Host "1.4. Stopping Minikube..." -ForegroundColor Yellow
minikube stop 2>$null
Write-Host "  >>>>> Minikube stopped." -ForegroundColor Green



Write-Host "`n  `n  === 2. STOPPING DOCKER DESKTOP ===" -ForegroundColor Red


# 2.1. Stop Docker service first (graceful shutdown)
Write-Host "2.1. Stopping Docker service..." -ForegroundColor Yellow
Stop-Service -Name "com.docker.service" -Force -ErrorAction SilentlyContinue
Write-Host "   - Docker service stopped" -ForegroundColor Green

# 2.2. Stop Docker Desktop GUI
Write-Host "2.2. Stopping Docker Desktop processes..." -ForegroundColor Yellow
taskkill /IM "Docker Desktop.exe" /F 2>$null
Get-Process -Name "Docker Desktop" -ErrorAction SilentlyContinue | Stop-Process -Force
Write-Host "   - Docker Desktop GUI stopped" -ForegroundColor Green

# 2.3. Clean up all remaining docker processes
Write-Host "2.3. Cleaning up all docker processes..." -ForegroundColor Yellow
Get-Process | Where-Object {$_.ProcessName -like "*docker*"} | Stop-Process -Force
Write-Host "   - All docker processes cleaned up" -ForegroundColor Green

# 2.4. Check result
Write-Host "2.4. Checking result..." -ForegroundColor Cyan
Start-Sleep -Seconds 2
$dockerProcesses = Get-Process -Name "Docker Desktop" -ErrorAction SilentlyContinue

if (-not $dockerProcesses) {
    Write-Host "SUCCESS: Docker Desktop completely stopped!" -ForegroundColor Green
} else {
    Write-Host "ERROR: Docker Desktop still running" -ForegroundColor Red
    Write-Host "Remaining processes:" -ForegroundColor Red
    $dockerProcesses | Format-Table Name, Id
}

Write-Host "=== COMPLETED ALL." -ForegroundColor Cyan
