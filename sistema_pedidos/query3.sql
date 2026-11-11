-- a. Inserir uma prateleira de código 390, descrição 'Prateleira de
-- teste' e número de seções 2.
-- RESOLUÇÃO:
SELECT * FROM PRATELEIRA
ORDER BY CODIGO ASC;

INSERT INTO PRATELEIRA 
VALUES (390, 'Prateleira de teste', 2);

-- b. Listar as prateleiras e os respectivos produtos que podem
-- armazenar. Mostrando a frase 'sem produto' quando não se relaciona
-- com nenhum. Mostrar: Prateleira (CODIGO, DESCRICAO), descrição
-- (PRODUTO) e quantidade distinta de produtos, ordenados pela quantidade
-- de produtos decrescente.
-- RESOLUÇÃO:
SELECT * FROM PRATELEIRA;

SELECT P.CODIGO,
       P.DESCRICAO AS PRATELEIRA,
       NVL(PR.DESCRICAO, 'sem produto') AS PRODUTO,
       COUNT(DISTINCT PR.CODIGO) AS QTD_PRODUTOS
FROM PRATELEIRA P
LEFT JOIN CAPACIDADE_ESTOQUE CE ON P.CODIGO = CE.CODIGO_PRA
LEFT JOIN PRODUTO PR ON CE.CODIGO_PRO = PR.CODIGO
GROUP BY P.CODIGO, P.DESCRICAO, PR.DESCRICAO
ORDER BY QTD_PRODUTOS DESC;

-- c. Selecionar todos os clientes da view VIEW_CLIENTE que são PF.
-- Mostrar: CODIGO, NOME e CNPF, ordenado decrescente pelo nome do
-- cliente.
-- RESOLUÇÃO:
SELECT * FROM VIEW_CLIENTE;

SELECT CODIGO, NOME, CNPF
FROM VIEW_CLIENTE
WHERE TIPO_CLIENTE = 'PF'
ORDER BY NOME DESC;

-- d. Listar os pedidos e seus respectivos produtos. Mostrar: numero do
-- pedido (PEDIDO), DATA do pedido, descrição do produto (PRODUTO) e
-- QUANTIDADE de produtos no pedido. Ordenado pela DATA do pedido
-- crescente e, dentro das datas, pelo produto decrescente.
-- RESOLUÇÃO:
SELECT * FROM PEDIDO;

SELECT PE.NUMERO AS PEDIDO,
       PE.DATA,
       PR.DESCRICAO AS PRODUTO,
       IP.QUANTIDADE
FROM PEDIDO PE
JOIN ITEM_PRODUTO IP ON PE.NUMERO = IP.NUMERO_PED
JOIN PRODUTO PR ON IP.CODIGO_PRO = PR.CODIGO
ORDER BY PE.DATA ASC, PR.DESCRICAO DESC;