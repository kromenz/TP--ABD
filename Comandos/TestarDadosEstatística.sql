SELECT id_corrida, nome
FROM Corrida
WHERE id_corrida NOT IN (
    SELECT DISTINCT id_corrida
    FROM Estatisticas
)

-- SEPARADOR -- 

DECLARE @id_piloto INT;
DECLARE @total_tipo1 INT;
DECLARE @total_tipo2 INT;
DECLARE @total_tipo3 INT;
DECLARE @total_tipo4 INT;
DECLARE @total_tipo5 INT;
DECLARE @total_tipo6 INT;

DECLARE PilotoCursor CURSOR FOR
SELECT id_piloto
FROM Estatisticas
GROUP BY id_piloto
ORDER BY id_piloto;

OPEN PilotoCursor;

FETCH NEXT FROM PilotoCursor INTO @id_piloto;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @total_tipo1 = (SELECT COUNT(*) FROM Estatisticas WHERE id_piloto = @id_piloto AND tipo_stat = 1);
    SET @total_tipo2 = (SELECT COUNT(*) FROM Estatisticas WHERE id_piloto = @id_piloto AND tipo_stat = 2);
    SET @total_tipo3 = (SELECT COUNT(*) FROM Estatisticas WHERE id_piloto = @id_piloto AND tipo_stat = 3);
    SET @total_tipo4 = (SELECT COUNT(*) FROM Estatisticas WHERE id_piloto = @id_piloto AND tipo_stat = 4);
    SET @total_tipo5 = (SELECT COUNT(*) FROM Estatisticas WHERE id_piloto = @id_piloto AND tipo_stat = 5);
    SET @total_tipo6 = (SELECT COUNT(*) FROM Estatisticas WHERE id_piloto = @id_piloto AND tipo_stat = 6);

    IF @total_tipo1 <> @total_tipo2 OR @total_tipo1 <> @total_tipo3 OR @total_tipo1 <> @total_tipo4 OR @total_tipo1 <> @total_tipo5 OR @total_tipo1 <> @total_tipo6
    BEGIN
        PRINT 'Piloto: ' + CAST(@id_piloto AS VARCHAR(10));
        PRINT 'TotalTipo1: ' + CAST(@total_tipo1 AS VARCHAR(10));
        PRINT 'TotalTipo2: ' + CAST(@total_tipo2 AS VARCHAR(10));
        PRINT 'TotalTipo3: ' + CAST(@total_tipo3 AS VARCHAR(10));
        PRINT 'TotalTipo4: ' + CAST(@total_tipo4 AS VARCHAR(10));
        PRINT 'TotalTipo5: ' + CAST(@total_tipo5 AS VARCHAR(10));
        PRINT 'TotalTipo6: ' + CAST(@total_tipo6 AS VARCHAR(10));
    END

    FETCH NEXT FROM PilotoCursor INTO @id_piloto;
END;

CLOSE PilotoCursor;
DEALLOCATE PilotoCursor;

-- SEPARADOR -- 

SELECT id_corrida, COUNT(*) AS TotalRegistros
FROM Estatisticas
GROUP BY id_corrida
HAVING COUNT(*) > 120;

-- SEPARADOR -- 

SELECT id_corrida, COUNT(*) AS TotalRegistros
FROM Estatisticas
GROUP BY id_corrida
HAVING COUNT(*) < 120;

-- SEPARADOR --

SELECT COUNT(DISTINCT id_corrida) AS TotalCorridas
FROM Estatisticas;

-- SEPARADOR --

SELECT p.nome AS NomePiloto, COUNT(*) AS TotalCorridas
FROM Piloto p
INNER JOIN Estatisticas e ON e.id_piloto = p.id_piloto
WHERE e.tipo_stat = 1
GROUP BY p.nome
ORDER BY TotalCorridas ASC;