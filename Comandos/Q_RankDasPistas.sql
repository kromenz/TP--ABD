SELECT p.nome AS Nome_do_Piloto, c.data, c.nome AS Nome_da_Corrida, t.descricao, e.valor,
       RANK() OVER (PARTITION BY t.descricao,c.nome ORDER BY e.valor) AS rank
FROM Estatisticas e
INNER JOIN Piloto p ON p.id_piloto = e.id_piloto
INNER JOIN Corrida c ON c.id_corrida = e.id_corrida
INNER JOIN Tipo_Stat t ON t.tipo_stat = e.tipo_stat
WHERE e.tipo_stat IN (1, 2, 6)
ORDER BY c.nome
