CREATE FUNCTION dbo.Calcular
(	@fechaInicio DATE,
    @fechaFin DATE,
    @horaInicio1 TIME,
    @horaFin1 TIME,
    @horaInicio2 TIME,
    @horaFin2 TIME
	
)
RETURNS INT
AS
BEGIN
    DECLARE @totalSegundos INT
	---------------------------------------------------------------
	DECLARE @diasHabiles INT = 0;
    DECLARE @currentDate DATE = @fechaInicio;
	DECLARE @totalSegundosDIF INT = 0;
	DECLARE @RESULTADO INT
	



    -- Calcular el máximo entre los tiempos de inicio
    DECLARE @horaInicioMax TIME
    SET @horaInicioMax = IIF(@horaInicio1 > @horaInicio2, @horaInicio1, @horaInicio2)

    -- Calcular el mínimo entre los tiempos de fin
    DECLARE @horaFinMin TIME
    SET @horaFinMin = IIF(@horaFin1 < @horaFin2, @horaFin1, @horaFin2)

    -- Calcular la intersección en segundos
    SET @totalSegundos = DATEDIFF(SECOND, @horaInicioMax, @horaFinMin)

    -- Si la intersección es negativa, usar FULL OUTER JOIN y calcular la unión total en segundos
    IF @totalSegundos < 0
    BEGIN
        SET @totalSegundos = 
            (DATEDIFF(SECOND, @horaInicio1, @horaFin1) +
            DATEDIFF(SECOND, @horaInicio2, @horaFin2))
    END
	--RETURN @totalSegundos
	---------------------------------------------------------------------------------
	WHILE @currentDate <= @fechaFin
    BEGIN
        -- 1 es domingo, 2 es lunes, ..., 7 es sábado
        IF DATEPART(WEEKDAY, @currentDate) BETWEEN 1 AND 5
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM DiasFestivos WHERE Fecha = @currentDate)
            BEGIN
                SET @diasHabiles = @diasHabiles + 1;
            END
        END

        SET @currentDate = DATEADD(DAY, 1, @currentDate);
    END

    --RETURN @diasHabiles-1;
-------------------------------------------------------------------------
IF EXISTS (SELECT 1 FROM DiasFestivos WHERE Fecha = @fechaFin)

 BEGIN
    DECLARE @horaInicio2_1 TIME = '00:00';


	 -- Calcular el máximo entre los tiempos de inicio
    DECLARE @horaInicioMax_2 TIME
    SET @horaInicioMax_2 = IIF(@horaInicio1 > @horaInicio2_1, @horaInicio1, @horaInicio2_1)

    -- Calcular el mínimo entre los tiempos de fin
    DECLARE @horaFinMin_2 TIME
    SET @horaFinMin = IIF(@horaFin1 < @horaFin2, @horaFin1, @horaFin2)

    -- Calcular la intersección en segundos
    SET @totalSegundosDIF = DATEDIFF(SECOND, @horaInicioMax_2, @horaFinMin)

    -- Si la intersección es negativa, usar FULL OUTER JOIN y calcular la unión total en segundos
    IF @totalSegundosDIF <= 0
    BEGIN
        SET @totalSegundosDIF = 0
          
    END
	

END

  DECLARE @SegundosInicio INT
  DECLARE @SegundosFin INT
  SELECT @SegundosInicio = DATEPART(SECOND, @horaInicio1)
  SELECT @SegundosFin = DATEPART(SECOND, @HoraFin1)
  DECLARE @DifSegundos INT
  SET @DifSegundos = DATEDIFF(SECOND, @horaInicio1, @HoraFin1)

  IF @diasHabiles > 2 AND (@totalSegundos>(8000))
  BEGIN 
  SET @RESULTADO = ((@diasHabiles-1)*@DifSegundos)+(@totalSegundos-@totalSegundosDIF)
		
  END
   ELSE IF @diasHabiles <= 2 AND (@totalSegundos<(8000))
   ------------------2---------------1020 < 36000
  BEGIN
    SET @RESULTADO = (@totalSegundos-@totalSegundosDIF)+(@diasHabiles-1)*@DifSegundos
  END
  ELSE
  BEGIN
  SET @RESULTADO = (@totalSegundos-@totalSegundosDIF)
  END


  IF ((@totalSegundos < 8000 OR @totalSegundos > 30000) AND(@diasHabiles>2))
  BEGIN 
   SET @RESULTADO = ((@diasHabiles-2)*@DifSegundos)+(@totalSegundos-@totalSegundosDIF)
  END
  
  --------------------------------------------------------------------------------------------

  RETURN @RESULTADO;

END
