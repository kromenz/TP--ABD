-- Crie uma tabela temporária com coluna de identidade
CREATE TABLE #DadosEstatisticas (
    RowID INT IDENTITY(1, 1),
    id_corrida INT,
    id_piloto INT,
    tempo_total DECIMAL(18, 2),
    numero_paragens INT,
    peso_ant DECIMAL(18, 2),
    peso_depois DECIMAL(18, 2),
    melhor_volta DECIMAL(18, 2)
);

-- Insira os dados desejados na tabela temporária
INSERT INTO #DadosEstatisticas (id_corrida, id_piloto, tempo_total, numero_paragens, peso_ant, peso_depois, melhor_volta)
VALUES
    (1, 139, 98.85, 1, 83, 80, 22),
    (1, 78, 77.25, 2, 82, 79, 20);

-- Variáveis de controle do loop
DECLARE @RowCount INT = (SELECT COUNT(*) FROM #DadosEstatisticas);
DECLARE @CurrentRow INT = 1;

-- Loop para chamar o SP para cada conjunto de dados
WHILE @CurrentRow <= @RowCount
BEGIN
    DECLARE @id_corrida INT, @id_piloto INT, @tempo_total DECIMAL(18, 2), @numero_paragens INT,
        @peso_ant DECIMAL(18, 2), @peso_depois DECIMAL(18, 2), @melhor_volta DECIMAL(18, 2);

    -- Obtenha os valores do conjunto de dados atual com base no RowID
    SELECT @id_corrida = id_corrida, @id_piloto = id_piloto, @tempo_total = tempo_total,
        @numero_paragens = numero_paragens, @peso_ant = peso_ant, @peso_depois = peso_depois,
        @melhor_volta = melhor_volta
    FROM #DadosEstatisticas
    WHERE RowID = @CurrentRow;

    -- Chame o SP para inserir os dados do conjunto atual
    EXEC dbo.InserirEstatisticasCorrida
        @id_corrida = @id_corrida,
        @id_piloto = @id_piloto,
        @tempo_total = @tempo_total,
        @numero_paragens = @numero_paragens,
        @peso_ant = @peso_ant,
        @peso_depois = @peso_depois,
        @melhor_volta = @melhor_volta;

    -- Atualize o contador de linha atual
    SET @CurrentRow = @CurrentRow + 1;
END;

-- Remova a tabela temporária
DROP TABLE #DadosEstatisticas;
