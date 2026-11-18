-- a. Fazer uma trigger para manter o log de alterações em uma tabela no
-- banco de dados de PEDIDO, com o nome TRG_LOG_ALTR_BD_nome_tabela.
-- Ao realizar uma alteração na tabela escolhida do projeto pedido.
-- A trigger irá fazer uma inclusão na tabela LOG_ALTERACOES, onde a
-- ação será em conformidade com o tipo de alteração (INSERÇÃO, ALTERAÇÃO
-- e/ou DELEÇÃO), incluindo o nome da tabela e a data alteração.
-- RESOLUÇÃO:

CREATE OR REPLACE TRIGGER TRG_LOG_ALTR_BD_VENDEDOR
AFTER INSERT OR UPDATE OR DELETE ON VENDEDOR
FOR EACH ROW
DECLARE
    v_acao LOG_ALTERACOES.ACAO%TYPE;
BEGIN
    IF INSERTING THEN
        v_acao := 'INSERÇÃO';
    ELSIF UPDATING THEN
        v_acao := 'ALTERAÇÃO';
    ELSIF DELETING THEN
        v_acao := 'DELEÇÃO';
    END IF;
    INSERT INTO LOG_ALTERACOES (ACAO, TABELA, DATA_EVENTO)
    VALUES (v_acao, 'VENDEDOR', SYSDATE);
END;
/




-- b. Fazer queries, pelo menos uma para cada ação (INSERÇÃO, ALTERAÇÃO
-- e/ou DELEÇÃO) na tabela escolhida.
-- RESOLUÇÃO:
SELECT * FROM VENDEDOR;

INSERT INTO VENDEDOR (MATRICULA, NOME, CNPF) 
VALUES (999, 'Carlos Alberto Teste', '000000000');

UPDATE VENDEDOR 
SET NOME = 'Carlos Alberto Alterado' 
WHERE MATRICULA = 999;

DELETE FROM VENDEDOR 
WHERE MATRICULA = 999;

-- C. Fazer uma query para verificar os logs registrados nas ações do item
-- b.
-- RESOLUÇÃO:
SELECT ID_LOG, 
       ACAO, 
       TABELA, 
       TO_CHAR(DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS') AS DATA_HORA
FROM LOG_ALTERACOES
WHERE TABELA = 'VENDEDOR'
ORDER BY ID_LOG ASC;