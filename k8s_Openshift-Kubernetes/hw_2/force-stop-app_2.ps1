Write-Host "=== 1. STOPPING HOMEWORK APPLICATION - KUBERNETES ===" -ForegroundColor Red


# 1.1. Удаление ресурсов
Write-Host "1.1. Deleting all manifests..." -ForegroundColor Yellow
kubectl delete -f .\ingress.yaml --ignore-not-found=true --grace-period=30 2>$null				# Ingress - внешний доступ; Ingress зависит от Service
Write-Host "   - Ingress deleted" -ForegroundColor Green
kubectl delete -f .\service.yaml --ignore-not-found=true --grace-period=30 2>$null				# Service - внутренняя балансировка; Service зависит от Pods (из Deployment)
Write-Host "   - Service deleted" -ForegroundColor Green
kubectl delete -f .\deployment.yaml --ignore-not-found=true --grace-period=30 2>$null			# Deployment - приложения; Deployment управляет Pods
# 1.1.1. Ждем завершения Pods
Write-Host " 1.1.1.  - Waiting for pods termination..." -ForegroundColor Cyan
Start-Sleep -Seconds 10
kubectl delete -f .\dashboard-admin.yaml --ignore-not-found=true --grace-period=30 2>$null
Write-Host "   - Additional resources deleted" -ForegroundColor Green
kubectl delete -f .\namespace.yaml --ignore-not-found=true --grace-period=30 2>$null
Write-Host "   - Namespace deletion initiated" -ForegroundColor Green

# 1.2. Принудительная очистка если что-то осталось
Write-Host "1.2. Force cleanup..." -ForegroundColor Yellow
kubectl delete all --all -n homework --ignore-not-found=true --grace-period=0 2>$null
Write-Host "   - Force cleanup completed" -ForegroundColor Green
Write-Host " ==== All resources stopped." -ForegroundColor Green

# 1.3. Проверка
Write-Host "`n  1.3. Final verification..." -ForegroundColor Cyan
Start-Sleep -Seconds 5

# Проверяем существует ли namespace вообще
kubectl get namespace homework 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host " >>>>>> 'homework' namespace completely removed." -ForegroundColor Green
} else {
    Write-Host "   'homework' namespace still exists......." -ForegroundColor Red
    # Показываем что осталось
    kubectl get all -n homework 2>$null
}


Write-Host "=== COMPLETED CLOSE APPLICATION." -ForegroundColor Cyan
