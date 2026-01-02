# Полезные ссылки для выполнения задания
- https://kubernetes.io/docs/tasks/administer-cluster/namespaces-walkthrough/


# Практическое задание 1
1. Установить minikube по инструкции
2. Создать новый неймспейс в кластере minikube с названием `homework`
3. Переключить контекст на созданный неймспейс
4. Создать императивным способом deployment
kubectl create deployment web --image=gcr.io/google-samples/hello-app:1.0
```

5. Создать императивным способом service 
kubectl expose deployment web --type=NodePort --port=8080
```

6. При помощи minikube посмотреть адрес сервиса для доступа к приложению.
minikube service -n homework web --url
```

В случае корректного выполнения мы увидим страницу в текстом:
Hello, world!
Version: 1.0.0
Hostname: web-6bf786c76b-f66r7
```

7. Создать ingress для доступа к приложению извне.
Необходимо локально создать файл.
ingress.yaml
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
  namespace: homework
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$1
spec:
  rules:
    - host: hello-world.info
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: my-app
                port:
                  number: 8080
```
8. Применить данный файл при помощи утилиты kubectl 
```
kubectl apply -f ingress.yaml
```

9. Посмотреть внешний адрес кластера
```
minikube ip
```

10. Добавить в /etc/hosts(WSL or Linux) или в C:\Windows\System32\drivers\etc\hosts (Windows) новую запись
```
IP-адрес-кластера hello-world.info
```
Пример:
```
192.168.49.2 hello-world.info
```

11. Зайти браузером по адресу http://hello-world.info  и увидеть то же сообщение, что мы видели, когда заходили через адрес service.

################ Практическое задание с повышеной сложностью ###################

12. После того, как создали все объекты кластера и убедились, что всё работает, удаляем, что создали.
```
kubectl delete deployment web
kubectl delete svc web
kubectl delete ingress example-ingress
```

13. Создать 3 новых файла в формате YAML для deployment, service и ingress и декларативным способом создать эти объекты в кластере
```
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml
```

14. Зайти браузером по адресу http://hello-world.info  и увидеть то же сообщение, что мы видели, когда заходили через адрес service.


