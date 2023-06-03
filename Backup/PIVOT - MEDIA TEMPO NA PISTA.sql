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
  FOR NomeCorrida IN ([GP Peru], [GP China])
) AS PivotTable;