CREATE TRIGGER VerificarIdadeMinima
ON Piloto
AFTER INSERT, UPDATE
AS
BEGIN
    -- Verificar a idade m�nima para cada linha inserida ou atualizada
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE data_n > DATEADD(YEAR, -18, GETDATE())
    )
    BEGIN
        -- Se existir pelo menos uma linha que n�o atende � idade m�nima, lan�ar erro e desfazer a transa��o
        RAISERROR('A idade m�nima para um piloto � de 18 anos.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END