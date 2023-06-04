CREATE VIEW VW_CorridaEstatisticas AS
SELECT TOP 10 c.nome AS NomeCorrida, COUNT(*) / 20 / 6 AS TotalRegistrosDivididos
FROM Corrida c
LEFT JOIN Estatisticas e ON c.id_corrida = e.id_corrida
GROUP BY c.nome
ORDER BY COUNT(*) DESC;