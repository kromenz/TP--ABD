SELECT b.nome, c.data, c.nome, d.descricao, a.valor,
       RANK() OVER (PARTITION BY a.tipo_stat ORDER BY a.valor, a.id_corrida) AS rank
FROM Estatisticas a 
INNER JOIN Piloto b on b.id_piloto=a.id_piloto
INNER JOIN Corrida c on c.id_corrida=a.id_corrida
INNER JOIN Tipo_Stat d on d.tipo_stat=a.tipo_stat
