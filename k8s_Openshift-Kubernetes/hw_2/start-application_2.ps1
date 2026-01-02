Write-Host "=== STARTING APPLICATION ===" -ForegroundColor Green

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

# 3. Проверяем Minikube, БЕЗ НАЗНАЧЕНИЯ ИМЕНИ (default 'minikubes')
Write-Host "3. Starting Minikube cluster..." -ForegroundColor Yellow
minikube status 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host "   >>>>>> Minikube started." -ForegroundColor Green
} else {
    Write-Host "   - Minikube failed to start" -ForegroundColor Red
    exit 1
}

# 4. Разворачиваем приложение из манифестов
Write-Host "4. Deploying application..." -ForegroundColor Yellow

# Создаем namespace
kubectl apply -f .\namespace.yaml 2>$null
Write-Host "   - Namespace created" -ForegroundColor Green					# Namespace → изоляция

# Разворачиваем приложение в правильном порядке
kubectl apply -f .\deployment.yaml -n homework-2 2>$null
Write-Host "   - Deployment created" -ForegroundColor Green					# Deployment → приложение

kubectl apply -f .\service.yaml 2>$null
Write-Host "   - Service created" -ForegroundColor Green					# Service → доступ к приложению

kubectl apply -f .\ingress.yaml 2>$null
Write-Host "   - Ingress created" -ForegroundColor Green					# Ingress → внешний доступ

kubectl apply -f .\dashboard-admin.yaml 2>$null
Write-Host "   - Dashboard admin created" -ForegroundColor Green			# Dashboard
Write-Host "   >>>>> Application deployed." -ForegroundColor Green


# 5. Проверяем статус
Write-Host "5. Checking application status..." -ForegroundColor Cyan
Start-Sleep -Seconds 10

Write-Host "   - Pods status of namespace from cluster manifest:" -ForegroundColor White
kubectl get pods -n homework-2 2>$null

Write-Host "   - Services status of namespace from cluster manifest:" -ForegroundColor White
kubectl get services -n homework-2 2>$null

Write-Host "   - Ingress status of namespace from cluster manifest: " -ForegroundColor White
kubectl get ingress -n homework-2 2>$null

Write-Host "`n--- DEPLOYMENTS IN Cluster namespace ---" -ForegroundColor Yellow
kubectl get deployments -n homework-2

Write-Host "`n     >>>>>>>>> APPLICATION STARTED SUCCESSFULLY!" -ForegroundColor Green