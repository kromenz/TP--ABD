SELECT p.nome AS NomePiloto, e.valor AS TempoVoltaMaisRapido
FROM Piloto p
INNER JOIN Estatisticas e ON p.id_piloto = e.id_piloto
WHERE e.tipo_stat = 6
  AND e.id_corrida = 1 
ORDER BY e.valor ASC;