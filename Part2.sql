CREATE FUNCTION dbo.CalcularDuracion(
    @Inicio1 TIME,
    @Fin1 TIME,
    @Inicio2 TIME,
    @Fin2 TIME
)
RETURNS INT
AS
BEGIN
    DECLARE @Duracion INT;

    -- Convertir los valores de tiempo a segundos
    DECLARE @Inicio1Segundos INT = DATEDIFF(SECOND, '00:00:00', @Inicio1);
    DECLARE @Fin1Segundos INT = DATEDIFF(SECOND, '00:00:00', @Fin1);
    DECLARE @Inicio2Segundos INT = DATEDIFF(SECOND, '00:00:00', @Inicio2);
    DECLARE @Fin2Segundos INT = DATEDIFF(SECOND, '00:00:00', @Fin2);

    SELECT @Duracion = 
        CASE
            WHEN @Inicio1Segundos <= @Inicio2Segundos AND @Fin1Segundos <= @Inicio2Segundos THEN 0
            WHEN @Inicio1Segundos >= @Fin2Segundos AND @Fin1Segundos >= @Fin2Segundos THEN 0
            WHEN @Inicio1Segundos >= @Inicio2Segundos AND @Fin1Segundos <= @Fin2Segundos THEN @Fin1Segundos - @Inicio1Segundos
            WHEN @Inicio1Segundos <= @Inicio2Segundos AND @Fin1Segundos >= @Fin2Segundos THEN @Fin2Segundos - @Inicio2Segundos
            WHEN @Inicio1Segundos >= @Inicio2Segundos AND @Fin1Segundos >= @Fin2Segundos THEN @Fin2Segundos - @Inicio1Segundos
            WHEN @Inicio1Segundos <= @Inicio2Segundos AND @Fin1Segundos <= @Fin2Segundos THEN @Fin1Segundos - @Inicio2Segundos
            ELSE 0
        END;

    -- Verificar si la duración es negativa y usar FULL OUTER JOIN si es el caso
    IF @Duracion < 0
    BEGIN
         SET @Duracion = (@Fin1Segundos - @Inicio1Segundos) + @Duracion;
	END

    RETURN @Duracion;
END;
