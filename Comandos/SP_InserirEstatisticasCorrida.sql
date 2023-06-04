CREATE PROCEDURE dbo.InserirEstatisticasCorrida
    @id_corrida INT,
    @id_piloto INT,
    @tempo_total DECIMAL(18, 2),
    @numero_paragens INT,
    @peso_ant DECIMAL(18, 2),
    @peso_depois DECIMAL(18, 2),
    @melhor_volta DECIMAL(18, 2)
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar a posição do piloto
    DECLARE @posicao INT;
    SET @posicao = dbo.VerificarPosicaoPiloto(@id_corrida, @tempo_total);

    -- Verifica se ja está ocupada
    IF EXISTS (
        SELECT 1
        FROM Estatisticas
        WHERE id_corrida = @id_corrida
            AND tipo_stat = 5 -- Estatísticas de posição
            AND valor = @posicao
    )
    BEGIN
        -- Atualizar posições
        UPDATE Estatisticas
        SET valor = valor + 1
        WHERE id_corrida = @id_corrida
            AND tipo_stat = 5 -- Estatísticas de posição
            AND valor >= @posicao;
    END

    -- Inserir estatísticas de tempo total com a posição
    INSERT INTO Estatisticas (id_piloto, id_corrida, tipo_stat, valor)
    VALUES (@id_piloto, @id_corrida, 1, @tempo_total);

    -- Inserir estatísticas de número de paragens
    INSERT INTO Estatisticas (id_piloto, id_corrida, tipo_stat, valor)
    VALUES (@id_piloto, @id_corrida, 2, @numero_paragens);

    -- Inserir estatísticas de peso antes da corrida
    INSERT INTO Estatisticas (id_piloto, id_corrida, tipo_stat, valor)
    VALUES (@id_piloto, @id_corrida, 3, @peso_ant);

    -- Inserir estatísticas de peso depois da corrida
    INSERT INTO Estatisticas (id_piloto, id_corrida, tipo_stat, valor)
    VALUES (@id_piloto, @id_corrida, 4, @peso_depois);

    -- Inserir estatística da posição
    INSERT INTO Estatisticas (id_piloto, id_corrida, tipo_stat, valor)
    VALUES (@id_piloto, @id_corrida, 5, @posicao);

    -- Inserir estatísticas de melhor volta
    INSERT INTO Estatisticas (id_piloto, id_corrida, tipo_stat, valor)
    VALUES (@id_piloto, @id_corrida, 6, @melhor_volta);

END