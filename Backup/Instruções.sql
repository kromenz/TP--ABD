SELECT TOP(1000) b.nome as Nome_do_Piloto, c.data, c.nome as Nome_da_Corrida, d.descricao, a.valor, 
       RANK() OVER (PARTITION BY a.id_corrida,a.tipo_stat ORDER BY a.valor ) AS rank
FROM Estatisticas a 
INNER JOIN Piloto b on b.id_piloto=a.id_piloto
INNER JOIN Corrida c on c.id_corrida=a.id_corrida
INNER JOIN Tipo_Stat d on d.tipo_stat=a.tipo_stat

