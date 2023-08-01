-- Función para calcular total de segundos entre fechas y horas
CREATE FUNCTION dbo.Calcular
(	@fechaInicio DATE,
    @fechaFin DATE,
    @horaInicio1 TIME,----bodega ini
    @horaFin1 TIME,-----bodega fin
    @horaInicio2 TIME,
    @horaFin2 TIME
	
)
RETURNS INT
AS
BEGIN
	-- Declarar variables
    DECLARE @totalSegundos INT
	---------------------------------------------------------------
	DECLARE @diasHabiles INT = 0;
    DECLARE @currentDate DATE = @fechaInicio;
	DECLARE @totalSegundosDIF INT = 0;
	DECLARE @RESULTADO INT
	DECLARE @totalSegundos1 INT
    DECLARE @totalSegundos2 INT
	DECLARE @DifSegundos INT
	-- Calcular diferencia en segundos entre hora inicio y fin
	SET @DifSegundos = DATEDIFF(SECOND, @horaInicio1, @HoraFin1)
		
    -- Calcular segundos para fecha de inicio
    IF NOT EXISTS (SELECT 1 FROM DiasFestivos WHERE Fecha = @fechaInicio)
    BEGIN
         -- Revisar si rango de hora 2 está dentro de hora 1
        IF @horaInicio2 > @horaInicio1 AND @horaInicio2 < @horaFin1

        BEGIN
            SET @totalSegundos1 = DATEDIFF(SECOND, @horaInicio1, @horaFin1) - DATEDIFF(SECOND, @horaInicio1, @horaInicio2) 
        END
        ELSE IF @horaInicio2 >= @horaFin1
        BEGIN
            SET @totalSegundos1 = 0
        END
        ELSE
        BEGIN
            SET @totalSegundos1 = DATEDIFF(SECOND, @horaInicio1, @horaFin1) 
        END
    END
    ELSE
    BEGIN
        SET @totalSegundos1 = 0
    END
    
   -- Calcular segundos para fecha fin
    IF NOT EXISTS (SELECT 1 FROM DiasFestivos WHERE Fecha = @fechaFin)
    BEGIN
         -- Revisar si rango de hora 2 está dentro de hora 1
        IF @horaFin2 > @horaInicio1 AND @horaFin2 < @horaFin1 
        BEGIN
            SET @totalSegundos2 = DATEDIFF(SECOND, @horaInicio1, @horaFin1) + DATEDIFF(SECOND, @horaFin1, @horaFin2) 
        END
        ELSE IF @horaInicio1 >= @horaFin2
        BEGIN
            SET @totalSegundos2 = 0
        END
        ELSE
        BEGIN
            SET @totalSegundos2 = DATEDIFF(SECOND, @horaInicio1, @horaFin1)
        END
    END
    ELSE
    BEGIN
        SET @totalSegundos2 = 0
    END
	set @totalSegundos =@totalSegundos2 + @totalSegundos1;
    --RETURN @totalSegundos
	---------------------------------------------------------------------------------
	------Calculo dias habiles
	WHILE @currentDate <= @fechaFin
    BEGIN
        -- Revisar si es día hábil
		-- 1 es lunes, 2 es martes, ..., 6 es sábado
        IF DATEPART(WEEKDAY, @currentDate) BETWEEN 1 AND 5
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM DiasFestivos WHERE Fecha = @currentDate)
            BEGIN 
			-- Incrementar fecha  
                SET @diasHabiles = @diasHabiles + 1;
            END
        END

        SET @currentDate = DATEADD(DAY, 1, @currentDate);
    END
	-- Revisar último día
	IF EXISTS (SELECT 1 FROM DiasFestivos WHERE Fecha = @fechaFin)
	BEGIN
	SET @diasHabiles = @diasHabiles + 1;
	END
	-- Descontar rangos
	SET @diasHabiles=@diasHabiles-2;
    --RETURN @diasHabiles;
-------------------------------------------------------------------------
	SET @RESULTADO = (@diasHabiles*@DifSegundos)+@totalSegundos;
 --------------------------------------------------------------------------------------------

  RETURN @resultado;

END
