# wp-nginx
:whale2:[bear85/wp-nginx](https://hub.docker.com/repository/docker/bear85/wp-nginx)

:whale2:[mysql:5.7.38-debian](https://hub.docker.com/layers/mysql/library/mysql/5.7.38-debian/images/sha256-e73f0d1cb2e042d4b93fcd4a301c147cbc0a28e982c0e965901162a733991df6?context=explore)

```bash
docker build --no-cache -t bear85/nginx:v1.2 .
#docker run --name wp-tst0 -p 9200:80 -d bear85/nginx:v1.2

docker network create -d bridge <name_network>
docker network list

docker volume create wp-mysql-volume
docker volume ls
docker volume inspect wp-mysql-volume

#база добавляется только первый раз (при смонтированном томе), т.е. если надо пересоздать контайнер, надо удалить поюзанный контейнер, удалить том, создать том, запустить эту команду.

docker run --name wp-mysql0 --mount source=wp-mysql-volume,target=/var/lib/mysql --network wp-nginx-network --env MYSQL_ROOT_PASSWORD=123qwe! --env  MYSQL_DATABASE=wordpress -p 3306:3306 -d mysql:5.7.38-debian

docker run --name <container name> --mount source=<volume on host>,target=<path in container> --network <created common network> -e MYSQL_ROOT_PASSWORD=<root password> -d <image:tag>

docker run --name wp-tst0 -p 9200:80 --network wp-nginx-network -d bear85/nginx:v1.2
```
