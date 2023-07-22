CREATE FUNCTION CalcularDiferenciaDias
(
    @FechaInicio DATE,
    @FechaFin DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @DiferenciaDias INT;

    SET @DiferenciaDias = DATEDIFF(DAY, @FechaInicio, @FechaFin);

    -- Excluir los días de fin de semana (sábados y domingos)
    SET @DiferenciaDias = @DiferenciaDias - 
        (2 * (DATEDIFF(WEEK, @FechaInicio, @FechaFin) + 
              CASE WHEN DATEPART(WEEKDAY, @FechaInicio) = 7 THEN 1 ELSE 0 END) -
              CASE WHEN DATEPART(WEEKDAY, @FechaFin) = 7 THEN 1 ELSE 0 END) - 
        (DATEDIFF(WEEK, @FechaInicio, @FechaFin) * 2) +
        CASE WHEN DATEPART(WEEKDAY, @FechaInicio) = 6 THEN 1 ELSE 0 END;

    -- Excluir los días festivos en Colombia
    DECLARE @Contador INT = 0;
    DECLARE @FechaActual DATE = @FechaInicio;

    WHILE @FechaActual <= @FechaFin
    BEGIN
        IF EXISTS (SELECT 1 FROM DiasFestivos WHERE Fecha = @FechaActual)
        BEGIN
            SET @Contador = @Contador + 1;
        END

        SET @FechaActual = DATEADD(DAY, 1, @FechaActual);
    END

    SET @DiferenciaDias = @DiferenciaDias - @Contador;

    IF @DiferenciaDias <= 0
    BEGIN
         SET @DiferenciaDias = (@DiferenciaDias * -1);
    END

    RETURN @DiferenciaDias;
END;
