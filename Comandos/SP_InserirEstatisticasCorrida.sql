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

    -- Verificar a posi��o do piloto
    DECLARE @posicao INT;
    SET @posicao = dbo.VerificarPosicaoPiloto(@id_corrida, @tempo_total);

    -- Verifica se ja est� ocupada
    IF EXISTS (
        SELECT 1
        FROM Estatisticas
        WHERE id_corrida = @id_corrida
            AND tipo_stat = 5 -- Estat�sticas de posi��o
            AND valor = @posicao
    )
    BEGIN
        -- Atualizar posi��es
        UPDATE Estatisticas
        SET valor = valor + 1
        WHERE id_corrida = @id_corrida
            AND tipo_stat = 5 -- Estat�sticas de posi��o
            AND valor >= @posicao;
    END

    -- Inserir estat�sticas de tempo total com a posi��o
    INSERT INTO Estatisticas (id_piloto, id_corrida, tipo_stat, valor)
    VALUES (@id_piloto, @id_corrida, 1, @tempo_total);

    -- Inserir estat�sticas de n�mero de paragens
    INSERT INTO Estatisticas (id_piloto, id_corrida, tipo_stat, valor)
    VALUES (@id_piloto, @id_corrida, 2, @numero_paragens);

    -- Inserir estat�sticas de peso antes da corrida
    INSERT INTO Estatisticas (id_piloto, id_corrida, tipo_stat, valor)
    VALUES (@id_piloto, @id_corrida, 3, @peso_ant);

    -- Inserir estat�sticas de peso depois da corrida
    INSERT INTO Estatisticas (id_piloto, id_corrida, tipo_stat, valor)
    VALUES (@id_piloto, @id_corrida, 4, @peso_depois);

    -- Inserir estat�stica da posi��o
    INSERT INTO Estatisticas (id_piloto, id_corrida, tipo_stat, valor)
    VALUES (@id_piloto, @id_corrida, 5, @posicao);

    -- Inserir estat�sticas de melhor volta
    INSERT INTO Estatisticas (id_piloto, id_corrida, tipo_stat, valor)
    VALUES (@id_piloto, @id_corrida, 6, @melhor_volta);

END