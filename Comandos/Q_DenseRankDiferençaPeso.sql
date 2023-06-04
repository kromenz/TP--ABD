SELECT Piloto, DiferencaPeso, DENSE_RANK() OVER (ORDER BY DiferencaPeso) AS Ranking
FROM (
    SELECT p.nome AS Piloto, 
           MAX(CASE WHEN e.tipo_stat = 3 THEN e.valor END) - MAX(CASE WHEN e.tipo_stat = 4 THEN e.valor END) AS DiferencaPeso
    FROM Estatisticas e
    INNER JOIN Piloto p ON e.id_piloto = p.id_piloto
    WHERE e.tipo_stat IN (3, 4)
    GROUP BY p.nome
) AS Resultado
ORDER BY Ranking;