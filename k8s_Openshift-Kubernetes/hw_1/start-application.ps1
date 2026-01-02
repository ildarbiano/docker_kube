Write-Host "=== STARTING APPLICATION ===" -ForegroundColor Green


# 4. Разворачиваем приложение из манифестов
Write-Host "4. Deploying application..." -ForegroundColor Yellow

# Создаем namespace
Write-Host "   - Creating namespace..." -ForegroundColor Cyan
kubectl apply -f .\namespace.yaml
if ($LASTEXITCODE -ne 0) {
    Write-Host "   ERROR: Failed to create namespace" -ForegroundColor Red
    exit 1
}

# Разворачиваем приложение в правильном порядке
Write-Host "   - Creating deployment..." -ForegroundColor Cyan
kubectl apply -f .\deployment.yaml
if ($LASTEXITCODE -ne 0) {
    Write-Host "   ERROR: Failed to create deployment" -ForegroundColor Red
    # Продолжаем выполнение, чтобы увидеть другие ошибки
}

Write-Host "   - Creating service..." -ForegroundColor Cyan
kubectl apply -f .\service.yaml
if ($LASTEXITCODE -ne 0) {
    Write-Host "   ERROR: Failed to create service" -ForegroundColor Red
}

Write-Host "   - Creating ingress..." -ForegroundColor Cyan
kubectl apply -f .\ingress.yaml
if ($LASTEXITCODE -ne 0) {
    Write-Host "   ERROR: Failed to create ingress" -ForegroundColor Red
}

Write-Host "   - Creating dashboard..." -ForegroundColor Cyan
kubectl apply -f .\dashboard-admin.yaml
if ($LASTEXITCODE -ne 0) {
    Write-Host "   ERROR: Failed to create dashboard" -ForegroundColor Red
}

Write-Host "   >>>>> Application deployment completed." -ForegroundColor Green

# 5. Проверяем статус с диагностикой
Write-Host "5. Checking application status..." -ForegroundColor Cyan
Start-Sleep -Seconds 10

Write-Host "`n--- DEPLOYMENTS IN HOMEWORK-1 ---" -ForegroundColor Yellow
kubectl get deployments -n homework-1

Write-Host "`n--- PODS IN HOMEWORK-1 ---" -ForegroundColor Yellow
kubectl get pods -n homework-1

Write-Host "`n--- EVENTS IN HOMEWORK-1 ---" -ForegroundColor Yellow
kubectl get events -n homework-1 --sort-by='.lastTimestamp'

Write-Host "`n--- DETAILED POD INFO ---" -ForegroundColor Yellow
$pods = kubectl get pods -n homework-1 -o name
foreach ($pod in $pods) {
    Write-Host "Pod: $pod" -ForegroundColor Cyan
    kubectl describe $pod -n homework-1
}

Write-Host "`n     >>>>>>>>> DEPLOYMENT COMPLETED!" -ForegroundColor Green
