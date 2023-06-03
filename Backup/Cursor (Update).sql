DECLARE @penalizacao DECIMAL(10, 2) = 5.0; -- Penalização
DECLARE @id_corrida INT = 1 -- Corrida a Penalizar

DECLARE PilotoCursor CURSOR FOR
    SELECT id_piloto
    FROM Estatisticas
    WHERE tipo_stat = 1 and id_corrida = @id_corrida
    ORDER BY valor DESC
    OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

OPEN PilotoCursor;

DECLARE @id_piloto INT;

FETCH NEXT FROM PilotoCursor INTO @id_piloto;

WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE Estatisticas
    SET valor = valor + @penalizacao
    WHERE id_piloto = @id_piloto and id_corrida = @id_corrida and tipo_stat = 1;

    FETCH NEXT FROM PilotoCursor INTO @id_piloto;
END;

CLOSE PilotoCursor;
DEALLOCATE PilotoCursor;