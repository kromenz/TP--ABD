CREATE FUNCTION fn_campeao (@dt Date)
RETURNS TABLE 
AS
RETURN
(
    SELECT p.nome,p.nacionalidade
    FROM Piloto p
    WHERE p.id_piloto = (
    SELECT TOP 1 e.id_piloto
    FROM Estatisticas e
    INNER JOIN Corrida c ON e.id_corrida = c.id_corrida
    WHERE YEAR(c.data)  = YEAR(@dt) AND e.tipo_stat = 5 AND e.valor = 1
    GROUP BY e.id_piloto
    ORDER BY COUNT(*) DESC
)
)

\\ Ver a função
SELECT nome, nacionalidade
FROM dbo.fn_campeao('2023-01-01'); 