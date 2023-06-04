CREATE TRIGGER VerificarIdadeMinima
ON Piloto
AFTER INSERT, UPDATE
AS
BEGIN
    -- Verificar a idade mínima para cada linha inserida ou atualizada
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE data_n > DATEADD(YEAR, -18, GETDATE())
    )
    BEGIN
        -- Se existir pelo menos uma linha que não atende à idade mínima, lançar erro e desfazer a transação
        RAISERROR('A idade mínima para um piloto é de 18 anos.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END