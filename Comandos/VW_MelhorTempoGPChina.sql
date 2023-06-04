CREATE VIEW VW_MelhorTempoGPChina AS
SELECT c."data", MIN(e.valor) AS MelhorTempo
FROM Corrida c
INNER JOIN Estatisticas e ON c.id_corrida = e.id_corrida
WHERE c.nome = 'GP China' AND e.tipo_stat = 1
GROUP BY c."data";