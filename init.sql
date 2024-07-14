-- Criação da extensão PostGIS
CREATE EXTENSION IF NOT EXISTS postgis;

-- Criação de uma tabela para armazenar informações dos parques
CREATE TABLE IF NOT EXISTS parques (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    localizacao GEOGRAPHY(Point, 4326)
);

-- Inserção de dados de exemplo
INSERT INTO parques (nome, localizacao)
VALUES 
('Parque Central', ST_GeogFromText('SRID=4326;POINT(-46.633309 -23.55052)')),
('Parque da Cidade', ST_GeogFromText('SRID=4326;POINT(-46.632930 -23.547160)')),
('Parque do Lago', ST_GeogFromText('SRID=4326;POINT(-46.635229 -23.544847)'));

-- Função para selecionar todos os parques
CREATE OR REPLACE FUNCTION selecionar_todos_parques()
RETURNS TABLE(id INT, nome VARCHAR, latitude FLOAT, longitude FLOAT) AS $$
BEGIN
    RETURN QUERY
    SELECT p.id, p.nome, ST_X(p.localizacao::geometry) AS latitude, ST_Y(p.localizacao::geometry) AS longitude
    FROM parques p;
END;
$$ LANGUAGE plpgsql;


-- Função para encontrar parques dentro de um raio de 1 km de um ponto específico
CREATE OR REPLACE FUNCTION parques_proximos(ponto GEOGRAPHY, raio FLOAT)
RETURNS TABLE(nome VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT p.nome
    FROM parques p
    WHERE ST_DWithin(p.localizacao, ponto, raio);
END;
$$ LANGUAGE plpgsql;

-- Função para calcular a distância entre dois parques
CREATE OR REPLACE FUNCTION distancia_entre_parques(id1 INT, id2 INT)
RETURNS TABLE(parque1 VARCHAR, parque2 VARCHAR, distancia FLOAT) AS $$
BEGIN
    RETURN QUERY
    SELECT p1.nome AS parque1, p2.nome AS parque2, ST_Distance(p1.localizacao, p2.localizacao) AS distancia
    FROM parques p1, parques p2
    WHERE p1.id = id1 AND p2.id = id2;
END;
$$ LANGUAGE plpgsql;

-- Função para adicionar um parque
CREATE OR REPLACE FUNCTION adicionar_parque(nome VARCHAR, latitude FLOAT, longitude FLOAT)
RETURNS VOID AS $$
BEGIN
    INSERT INTO parques (nome, localizacao)
    VALUES (nome, ST_GeogFromText('SRID=4326;POINT(' || longitude || ' ' || latitude || ')'));
END;
$$ LANGUAGE plpgsql;