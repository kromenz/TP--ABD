DECLARE @colunas NVARCHAR(MAX);
DECLARE @query NVARCHAR(MAX);

-- Obter a lista de corridas dinamicamente
SELECT @colunas = COALESCE(@colunas + ', ', '') + QUOTENAME(nome)
FROM (
    SELECT DISTINCT nome
    FROM Corrida
) AS Corrida;

-- Montar a consulta dinâmica
SET @query = '
SELECT *
FROM (
  SELECT p.nome AS NomePiloto, c.nome AS NomeCorrida, e.valor AS Tempo
  FROM Estatisticas e
  INNER JOIN Corrida c ON c.id_corrida = e.id_corrida
  INNER JOIN Piloto p ON p.id_piloto = e.id_piloto
  WHERE e.tipo_stat = 1
) AS SourceTable
PIVOT (
  AVG(Tempo)
  FOR NomeCorrida IN (' + @colunas + ')
) AS PivotTable
ORDER BY NomePiloto;';

-- Executar a consulta dinâmica
EXECUTE sp_executesql @query;