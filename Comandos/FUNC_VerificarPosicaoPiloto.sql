CREATE FUNCTION VerificarPosicaoPiloto
(
    @id_corrida INT,
    @tempo DECIMAL(18, 2)
)
RETURNS INT
AS
BEGIN
    DECLARE @posicao INT;

    SELECT @posicao = COUNT(*) + 1
    FROM Estatisticas
    WHERE id_corrida = @id_corrida
        AND tipo_stat = 1
        AND valor < @tempo;

    RETURN @posicao;
END;