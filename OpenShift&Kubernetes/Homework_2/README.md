# Полезные ссылки для выполнения задания
https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
https://kubernetes.io/docs/concepts/services-networking/_print/ 
https://kubernetes.io/docs/concepts/services-networking/service/#proxy-mode-userspace 


# Практическое задание 2
1. Собрать docker image на базе Dockerfile и файла app.py 
2. После сборки разместить образ на своем акаунте Dockerhub
3. Создать secret объект с credentials от dockerhub и именем pull-secret
4. Создать YAML файл deployment.yaml 
- в качестве образа использовать путь до докерхаба с вашим образом
- использовать 3 реплики приложения
- использовать cpu request = 100m / cpu limits = 500m для контейнера 
- использовать memory request = 100M / Memory limits = 500M для контейнера
- использовать secret с именем  pull-secret для скачивания имаджа с сайта dockerhub
- название микросервиса my-app, label=my-app-2

5. Задеплоить deployment в кластер в неймспейс homework_2
kubectl apply -f deployment.yaml
```

6. Создать service для доступа к этому POD, декларативно или императивно

7. Создать Ingress для доступа к этому POD, декларативно или императивно, с адресом my-color-app.info и именем ingress-my-app

8. Посмотреть внешний адрес кластера
minikube ip
```

9. Добавить в /etc/hosts(WSL or Linux) или в C:\Windows\System32\drivers\etc\hosts (Windows) новую запись
IP-адрес-кластера my-color-app.info
```

Пример:
192.168.49.2 my-color-app.info
```
10. При помощи браузера зайти по адресу приложения 

######################### Практическое задание с повышеной сложностью #############################
Разобраться почему каждый раз при обновлении страницы с адресом приложения меняется цвет.
