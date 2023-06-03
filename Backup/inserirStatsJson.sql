DECLARE @json NVARCHAR(MAX) = '
[
    {"id_piloto": 1, "id_corrida": 1, "tipo_stat": 1, "valor": 10.5},
    {"id_piloto": 2, "id_corrida": 1, "tipo_stat": 2, "valor": 20.3},
    {"id_piloto": 1, "id_corrida": 2, "tipo_stat": 1, "valor": 15.2}
]';

EXEC dbo.InserirEstatisticasFromJSON @json;
