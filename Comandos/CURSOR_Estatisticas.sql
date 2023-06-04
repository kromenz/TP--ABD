-- Declaração das variáveis
DECLARE @nome_piloto varchar(50),
        @id_corrida INT,
        @nome_corrida varchar(50),
        @tipo_stat INT,
        @valor DECIMAL(18, 2),
        @rank INT;

-- Declaração do cursor
DECLARE estatisticas_cursor CURSOR FOR
SELECT b.nome, a.id_corrida, c.nome, a.tipo_stat, a.valor,
       RANK() OVER (PARTITION BY a.tipo_stat ORDER BY a.valor, a.id_corrida) AS rank
FROM Estatisticas a 
INNER JOIN Piloto b on b.id_piloto=a.id_piloto
INNER JOIN Corrida c on c.id_corrida=a.id_corrida

ORDER BY tipo_stat;

-- Abertura do cursor
OPEN estatisticas_cursor;

-- Obtenção do primeiro registro
FETCH NEXT FROM estatisticas_cursor INTO @nome_piloto, @id_corrida,@nome_corrida, @tipo_stat, @valor, @rank;

PRINT '    Nome do Piloto     | ID_Corrida |  Nome da Corrida  | Tipo_Stat |   Valor  |  Rank';
PRINT '----------------------------------------------------------';

-- Loop através dos registros
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Exiba ou faça o que for necessário com os valores do registro atual, incluindo o rank
    PRINT FORMATMESSAGE(' %20s',CAST(@nome_piloto AS VARCHAR(50))) + '  | ' + FORMATMESSAGE('%9s',CAST(@id_corrida AS VARCHAR(10))) + '  | ' + FORMATMESSAGE('%15s',CAST(@nome_corrida AS VARCHAR(50))) + '  | ' + FORMATMESSAGE('%8s',CAST(@tipo_stat AS VARCHAR(10))) + '  | ' + FORMATMESSAGE('%7s',CAST(@valor AS VARCHAR(10))) + '  |   ' + CAST(@rank AS VARCHAR(10));

    -- Obtenção do próximo registro
    FETCH NEXT FROM estatisticas_cursor INTO @nome_piloto, @id_corrida,@nome_corrida, @tipo_stat, @valor, @rank;
END

-- Fechamento do cursor
CLOSE estatisticas_cursor;
DEALLOCATE estatisticas_cursor;