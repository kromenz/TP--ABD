DECLARE @id_corrida INT
SET @id_corrida = 1

DECLARE cursorPosicoes CURSOR READ_ONLY FOR
    SELECT e.id_piloto, e.valor, e2.valor
    FROM Estatisticas e
    LEFT JOIN Estatisticas e2 ON e2.id_corrida = e.id_corrida
        AND e2.id_piloto = e.id_piloto
        AND e2.tipo_stat = 1 -- Tipo de estat�stica "tempo"
    WHERE e.id_corrida = @id_corrida
        AND e.tipo_stat = 5 -- Tipo de estat�stica "posicao"
    ORDER BY e.valor ASC

OPEN cursorPosicoes

PRINT 'Corrida | Posi��o| Piloto | Tempo'
PRINT '----------------------------------------------'

-- Vari�veis para controle do loop do cursor
DECLARE @id_piloto INT, @valor_posicao INT, @tempo DECIMAL(18, 2)

-- In�cio do loop do cursor
FETCH NEXT FROM cursorPosicoes INTO @id_piloto, @valor_posicao, @tempo
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Obt�m o nome da corrida
    DECLARE @nome_corrida VARCHAR(50)
    SELECT @nome_corrida = nome FROM Corrida WHERE id_corrida = @id_corrida
    
    -- Obt�m o nome do piloto
    DECLARE @nome_piloto VARCHAR(50)
    SELECT @nome_piloto = nome FROM Piloto WHERE id_piloto = @id_piloto
    
    -- Imprime a linha da tabela
    PRINT @nome_corrida + ' | ' + CAST(@valor_posicao AS VARCHAR(10)) + ' | ' + @nome_piloto + ' | ' + COALESCE(CAST(@tempo AS VARCHAR(10)), '')

    -- Obt�m o pr�ximo registro do cursor
    FETCH NEXT FROM cursorPosicoes INTO @id_piloto, @valor_posicao, @tempo
END

-- Fecha o cursor
CLOSE cursorPosicoes
DEALLOCATE cursorPosicoes