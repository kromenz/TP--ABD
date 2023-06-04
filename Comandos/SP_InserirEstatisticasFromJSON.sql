CREATE PROCEDURE InserirEstatisticasFromJSON
    @json NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Estatisticas (id_piloto, id_corrida, tipo_stat, valor)
    SELECT
        id_piloto,
        id_corrida,
        tipo_stat,
        valor
    FROM OPENJSON(@json)
    WITH (
        id_piloto INT '$.id_piloto',
        id_corrida INT '$.id_corrida',
        tipo_stat INT '$.tipo_stat',
        valor DECIMAL(18, 2) '$.valor'
    );
END
GO