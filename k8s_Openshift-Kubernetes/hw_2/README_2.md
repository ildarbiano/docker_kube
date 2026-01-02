# Полезные ссылки для выполнения задания
https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
https://kubernetes.io/docs/concepts/services-networking/_print/ 
https://kubernetes.io/docs/concepts/services-networking/service/#proxy-mode-userspace 


# Практическое задание 2
1. Собрать docker image на базе Dockerfile и файла app.py 
docker build -t my-app-2 .
Пояснение параметров:
    -t my-app - задает имя образа (tag)
    . - указывает на текущую директорию, где ищется Dockerfile
docker images
REPOSITORY                    TAG       IMAGE ID       CREATED          SIZE
my-app-2                      latest    7e60b6130c93   17 seconds ago   81.8MB

2. После сборки разместить образ на своем акаунте Dockerhub
docker login                                                    # Эта команда покажет текущего пользователя
    Docker Hub требует, чтобы образы имели формат:
    username/repository-name:tag
    Ваш текущий образ my-app-2:latest - это локальное имя, которое Docker Hub не примет.
docker tag my-app-2 tonnelier/my-app-2-hub:latest     # Переименовать образ в формат Docker Hub. Команда docker tag не создает новый образ! Она просто добавляет новое имя/тег к существующему образу. Ваш IMAGE ID останется тем же (7e60b6130c93), но появится дополнительное имя.
docker push tonnelier/my-app-2-hub:latest             # Затем загрузить
docker images                                         # Увидите два образа с одинаковым IMAGE ID но разными именами. Так что это не "переименование" в смысле изменения, а добавление правильного имени для загрузки в Docker Hub!

3. Создать secret объект с credentials от dockerhub и именем pull-secret
Для публичных образов Secret не нужен. - это безопасный способ дать Kubernetes доступ к вашему приватному Docker Hub репозиторию!
          

4. Создать YAML файл deployment.yaml 
- в качестве образа использовать путь до докерхаба с вашим образом
- использовать 3 реплики приложения
- использовать cpu request = 100m / cpu limits = 500m для контейнера 
- использовать memory request = 100M / Memory limits = 500M для контейнера
- использовать secret с именем  pull-secret для скачивания имаджа с сайта dockerhub
- название микросервиса my-app, label=my-app

5. Задеплоить deployment в кластер в неймспейс homework
kubectl apply -f deployment.yaml
```

6. Создать service для доступа к этому POD, декларативно или императивно

7. Создать Ingress для доступа к этому POD, декларативно или императивно, с адресом my-color-app.info и именем ingress-my-app



-------- проверка что создалось -----------
minikube status
kubectl config get-contexts                 # имя кластера. Кластер minikube - вся ваша Kubernetes среда
kubectl get ns
kubectl get pods --all-namespaces           # Проверить ВСЕ ресурсы во ВСЕХ namespaces
kubectl get all -n homework-2               # имя namespace. Namespace minikube - просто один из многих namespace'ов (который у вас пустой)        
kubectl get namespace homework-2
остановка ресурсов, которые были. 
Создать скрипт остановки namespace "homework-2" при работающем 
------------------
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
