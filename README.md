# Análise de Localização de Parques em uma Cidade

## Grupo: Sono do Djabo
- Antonio Jailson da Silva Segundo
- Bernardo Jose da Silveira Vieira
- Keven Firmo Barboza
- Lucas Denner Soares da Rocha
- Samuel Vitor de Oliveira Galdino

## Descrição
Este projeto demonstra como utilizar PostGIS para armazenar e analisar dados geoespaciais. A base de dados contém a localização de parques em uma cidade, e são realizadas consultas espaciais básicas para análise.

## Configuração

### Pré-requisitos
- Docker

### Construção e Execução do Container
1. Construa a imagem Docker:
    ```sh
    docker build -t postgis_parques .
    ```
2. Execute o container:
    ```sh
    docker run --name postgis_parques -e POSTGRES_PASSWORD=mysecretpassword -d postgis_parques
    ```
3. Iniciar o container:
    ```sh
    docker start postgis_parques
    ```

### Conexão com banco de dados
```
docker exec -it postgis_parques psql -U postgres
```

### Funções SQL

1. **Selecionar todos os parques:**
    ```sql
    SELECT * FROM selecionar_todos_parques();
    ```

2. **Encontrar parques dentro de um raio de 1 km de um ponto específico:**
    ```sql
    SELECT * FROM parques_proximos(ST_GeogFromText('SRID=4326;POINT(-46.633309 -23.55052)'), 1000);
    ```

3. **Calcular a distância entre dois parques:**
    ```sql
    SELECT * FROM distancia_entre_parques(1, 2);
    ```

4. **Adicionar um parque:**
    ```sql
    SELECT adicionar_parque('Novo Parque', -23.55577, -46.63956);
    ```


    
