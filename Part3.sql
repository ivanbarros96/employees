UPDATE Caso
SET Horas_trabajadas = dbo.Calcular(Fecha_inicio,Fecha_fin,Horai_bodega,Horaf_bodega, Horai,Horaf);

------------------------------------------------------------------------------
UPDATE caso SET Horas_trabajadas = CONCAT(FORMAT(Horas_trabajadas / 3600, '00'), ':', 
                              RIGHT('0' + FORMAT(Horas_trabajadas % 3600 / 60, '00'), 2), ':',
                              RIGHT('0' + FORMAT(Horas_trabajadas % 60, '00'), 2));

select * from Caso

--DECLARE @fechaInicio DATE = '2023-01-03';
--DECLARE @fechaFin DATE = '2023-01-04';
--DECLARE @horaInicio1 TIME = '06:30:00';
--DECLARE @horaFin1 TIME = '16:30:00';
--DECLARE @horaInicio2 TIME = '16:29:00';
--DECLARE @horaFin2 TIME = '06:31:00';

--SElect dbo.Calcular(@fechaInicio, @fechaFin, @horaInicio1, @horaFin1, @horaInicio2, @horaFin2) as CantiSegTotal;

