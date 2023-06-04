CREATE TRIGGER trg_AjustarPosicaoAposDelete
ON Estatisticas
AFTER DELETE
AS
BEGIN
    DECLARE @id_corrida INT;
    DECLARE @tipo_stat INT;
    DECLARE @valor DECIMAL;

    SELECT @id_corrida = id_corrida, @tipo_stat = tipo_stat, @valor = valor
    FROM deleted;

    IF @tipo_stat = 5 
    BEGIN
        UPDATE Estatisticas
        SET valor = valor - 1
        WHERE id_corrida = @id_corrida
            AND tipo_stat = 5 
            AND valor >= @valor;
    END;
END;