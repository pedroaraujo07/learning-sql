CREATE OR REPLACE PROCEDURE PROC_ATUALZ_EMAIL_ALUNO (
    p_ra         IN ALUNOS.RA%TYPE,
    p_novo_email IN ALUNOS.EMAIL%TYPE
) IS
    v_pos_arroba NUMBER;
    v_qtd_arroba NUMBER;
    v_pos_ponto  NUMBER;
BEGIN
    IF p_novo_email IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'O e-mail não pode ser nulo.');
    END IF;

    v_qtd_arroba := LENGTH(p_novo_email) - LENGTH(REPLACE(p_novo_email, '@', ''));
    
    IF v_qtd_arroba <> 1 THEN
        RAISE_APPLICATION_ERROR(-20002, 'O e-mail deve conter exatamente um caractere @.');
    END IF;

    v_pos_arroba := INSTR(p_novo_email, '@');

    IF v_pos_arroba <= 1 OR v_pos_arroba >= LENGTH(p_novo_email) THEN
        RAISE_APPLICATION_ERROR(-20003, 'Deve haver pelo menos um caractere antes e depois do @.');
    END IF;

    v_pos_ponto := INSTR(p_novo_email, '.', v_pos_arroba);
    
    IF v_pos_ponto <= (v_pos_arroba + 1) OR v_pos_ponto = LENGTH(p_novo_email) THEN
        RAISE_APPLICATION_ERROR(-20004, 'O e-mail deve conter um ponto válido após o @.');
    END IF;

    UPDATE ALUNOS
    SET EMAIL = p_novo_email
    WHERE RA = p_ra;

    IF SQL%NOTFOUND THEN
        RAISE_APPLICATION_ERROR(-20005, 'Aluno com RA ' || p_ra || ' não encontrado.');
    END IF;

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END PROC_ATUALZ_EMAIL_ALUNO;
/

CREATE OR REPLACE FUNCTION FUNC_ATUALZ_EMAIL_ALUNO (
    p_ra         IN ALUNOS.RA%TYPE,
    p_novo_email IN ALUNOS.EMAIL%TYPE
) RETURN VARCHAR2 IS
BEGIN
    PROC_ATUALZ_EMAIL_ALUNO(p_ra => p_ra, p_novo_email => p_novo_email);
    
    RETURN 'Atualizado com sucesso';

EXCEPTION
    WHEN OTHERS THEN
        RETURN 'Não atualizado pelo motivo: ' || SQLERRM;
END FUNC_ATUALZ_EMAIL_ALUNO;
/


SELECT FUNC_ATUALZ_EMAIL_ALUNO(184, 'fred.silva@example.com') AS RESULTADO FROM DUAL;

SET SERVEROUTPUT ON;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Teste 1 (Sem @): ' || FUNC_ATUALZ_EMAIL_ALUNO(184, 'fred.silva.example.com'));
    DBMS_OUTPUT.PUT_LINE('Teste 2 (Dois @): ' || FUNC_ATUALZ_EMAIL_ALUNO(184, 'fred@@example.com'));
    DBMS_OUTPUT.PUT_LINE('Teste 3 (Sem ponto pós @): ' || FUNC_ATUALZ_EMAIL_ALUNO(184, 'fred@examplecom'));
    DBMS_OUTPUT.PUT_LINE('Teste 4 (RA inexistente): ' || FUNC_ATUALZ_EMAIL_ALUNO(99999, 'fred@example.com'));
END;
/