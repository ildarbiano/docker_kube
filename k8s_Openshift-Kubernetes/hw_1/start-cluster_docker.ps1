Write-Host "=== STARTING APPLICATION ===" -ForegroundColor Green

# 1. Запускаем Docker Desktop
Write-Host "1. Starting Docker Desktop..." -ForegroundColor Yellow
Start-Process "C:\Program Files\Docker\Docker\Docker Desktop.exe"
Write-Host "   - Waiting for Docker to start..." -ForegroundColor Cyan
Start-Sleep -Seconds 15

# 2. Проверяем что Docker запустился
Write-Host "2. Checking Docker status..." -ForegroundColor Yellow
try {
    docker version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "   - Docker is running" -ForegroundColor Green
    } else {
        Write-Host "   - Docker is not ready, waiting..." -ForegroundColor Yellow
        Start-Sleep -Seconds 10
    }
} catch {
    Write-Host "   - Docker is starting..." -ForegroundColor Yellow
    Start-Sleep -Seconds 10
}

# 3. Запускаем Minikube
Write-Host "3. Starting Minikube cluster..." -ForegroundColor Yellow
minikube start 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host "   >>>>>> Minikube started." -ForegroundColor Green
} else {
    Write-Host "   - Minikube failed to start" -ForegroundColor Red
    exit 1
}
