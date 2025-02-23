# Comandos para o docker

## Para desenvolver o backend
```bash
./startApplication-back-end.bat
```
## Para consumir a API feita no frontend 
```bash
./startApplication-front-end.bat
```

## Comandos básicos docker

### Rodar container
 
```shell
docker run <id ou nome container>
```

### Rodar container, modo iterativo
 
```shell
docker run -it <id ou nome container> bash
```
`bash` acessa o terminal do container

### Iniciar docker compose
 
```shell
docker-compose -f <nome arquivo docker compose>.yaml up --build -d
```

### Parar docker compose
 
```shell
docker compose down -v
```

### Listar imagens
 
```shell
docker image ls
```

### Excluir imagem específica
 
```shell
docker rmi <nome da imagem ou id>
```