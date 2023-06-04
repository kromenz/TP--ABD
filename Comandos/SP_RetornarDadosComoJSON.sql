CREATE PROCEDURE RetornarDadosComoJSON
AS
BEGIN
    SET NOCOUNT ON;

    SELECT id_piloto, nome, peso, altura
    FROM Piloto
    FOR JSON AUTO;
END
GO