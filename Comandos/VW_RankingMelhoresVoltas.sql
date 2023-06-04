CREATE VIEW VRankingMelhoresVoltas AS
SELECT ROW_NUMBER() OVER(ORDER BY e.valor) AS Ranking_Melhor_Volta,
p.nome AS Piloto,c.nome AS GP, e.valor AS Melhor_Volta, c.id_corrida
FROM Estatisticas e
INNER JOIN Piloto p ON e.id_piloto = p.id_piloto
INNER JOIN Corrida c ON e.id_corrida  = c.id_corrida
WHERE e.tipo_stat=6
GROUP BY c.id_corrida, e.valor, p.nome, c.nome