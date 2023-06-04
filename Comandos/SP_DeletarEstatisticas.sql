CREATE PROCEDURE DeleteEstatisticas
@id_piloto int,
@id_corrida int
AS
BEGIN

DELETE FROM Estatisticas
WHERE
  id_piloto = @id_piloto
  AND id_corrida = @id_corrida

END
GO