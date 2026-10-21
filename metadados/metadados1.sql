--1) Selecionar os metadados das tabelas criadas pelo usuário logado.
--Mostrar: o nome da tabela (TABELA).
--Ordenado: Pelo nome da tabela ascendente.
SELECT TABLE_NAME AS TABELA
FROM USER_TABLES
ORDER BY TABLE_NAME ASC;

--2) Selecionar os metadados das colunas das tabelas criadas pelo usuário logado.
--Mostrar: o nome da tabela (TABELA), nome da coluna (COLUNA), tipo de dado da
--coluna (TIPO_DADO) e o tamanho da coluna.
--Ordenado: Pelo nome da tabela ascendente e, dentro deste, pelo nome da coluna
--descendente.
SELECT TABLE_NAME AS TABELA,
    COLUMN_NAME AS COLUNA,
    DATA_TYPE AS TIPO_DADO,
    DATA_LENGTH AS TAMANHO
FROM USER_TAB_COLUMNS
ORDER BY TABLE_NAME ASC, COLUMN_NAME DESC;

--3) Selecionar os metadados das regras (constraints) implementadas nas tabelas criadas
--pelo usuário logado.
--Mostrar: o dono (DONO), o nome da constraint (CONSTRAINT), tipo da constraint
--(TIPO) e condição da regra (REGRA).
--Ordenado: Pelo nome da constraint descendente e, dentro deste, pelo tipo.
SELECT OWNER AS DONO,
    CONSTRAINT_NAME AS "CONSTRAINT",
    CONSTRAINT_TYPE AS TIPO,
    SEARCH_CONDITION AS REGRA
FROM USER_CONSTRAINTS
ORDER BY CONSTRAINT_NAME DESC, CONSTRAINT_TYPE ASC;

--4) Selecionar os metadados das regras (constraints) implementadas nas colunas das
--tabelas criadas pelo usuário logado.
--Mostrar: o dono (DONO), o nome da constraint (CONSTRAINT), o nome da tabela
--(TABELA), nome da coluna (COLUNA) e posição da coluna (POSICAO).
--Ordenado: Pelo nome da constraint
SELECT OWNER AS DONO,
    CONSTRAINT_NAME AS "CONSTRAINT",
    TABLE_NAME AS TABELA,
    COLUMN_NAME AS COLUNA,
    POSITION AS POSICAO
FROM USER_CONS_COLUMNS
ORDER BY CONSTRAINT_NAME ASC;



