# Полезные ссылки для выполнения задания
https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/ 
https://man7.org/linux/man-pages/man7/capabilities.7.html 


# Практическое задание 3
Для выполнения данного задания необходимо выполнить всё из задания номер 2.


1. Подключить HPA к созданному deployment
- min replicas = 1
- max replicas = 6
- cpu utilization = 40%
- name = hpa-my-app

2. При помощи утилиты curl и циклов сделать нагрузку на сайт, чтобы появились новые реплики приложения и отработал HPA
Пример(WSL или Linux):
for x in {1..10000}; do time curl http://1.2.3.4:8080/ ; done ;
```
	> Алтернатива можно просто много раз обновлять страницу вручную при помощи клавиши F5.
	> Сами реплики мы можем увидеть, несколько раз подряд введя команду 
kubectl get pods
```

3. Имитируем проблему и затем решаем
- удаляем все существующие файлы YAML на локальном ПК
- у нас есть только объекты в кластере
- нам их надо как-то сохранить локально, например для сохраности в git репозитории
- при помощи команды импортируем содержимое объектов из кластера себе локально
kubectl get secret pull-secret -o yaml -> secret.yaml
kubectl get deployment my-app -o yaml -> deployment.yaml
kubectl get hpa hpa-my-app -o yaml -> hpa-my-app.yaml
kubectl get ingress ingress-my-app -o yaml -> ingress.yaml
```
4. При помощи текстового редактора открыть каждый из файлов и удалить лишние строчки.

5. Удалить все объекты из неймспейса в кластере (чтобы проверить, что мы всё сделали корректно)
kubectl delete all --all
```

6. При помощи четырёх файлов восстановить deployment, service, ingress, hpa объекты в кластере
kubectl apply -f secret.yaml
kubectl apply -f deployment.yaml
kubectl apply -f hpa-my-app.yaml
kubectl apply -f ingress.yaml
```
7. В локальном файле deployment.yaml добавить security context 
- запретить CAP_NET_BIND_SERVICE

8. Применить в кластере новый deployment, посмотреть в логи приложения, убедится, что security context сработал и Nginx не запускается.

9. В локальном файле deployment.yaml добавить security context 
- разрешить CAP_NET_BIND_SERVICE, всё остальное запретить

10. Применить в кластере новый deployment, посмотреть в логи приложения, убедится, что security context сработал и Nginx снова запускается.

