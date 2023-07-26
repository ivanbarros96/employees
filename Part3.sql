UPDATE Caso
SET Horas_trabajadas = dbo.Calcular(Fecha_inicio,Fecha_fin,Horai_bodega,Horaf_bodega, Horai,Horaf);
------------------------------------------------------------------------------
--DECLARE @fechaInicio DATE = '2023-01-03';
--DECLARE @fechaFin DATE = '2023-01-05';
--DECLARE @horaInicio1 TIME = '06:30:00';
--DECLARE @horaFin1 TIME = '16:30:00';
--DECLARE @horaInicio2 TIME = '15:54:00';
--DECLARE @horaFin2 TIME = '08:44:00';

--SElect dbo.Calcular(@fechaInicio, @fechaFin, @horaInicio1, @horaFin1, @horaInicio2, @horaFin2) as CantiSegTotal;
-------------------------------------------------------------------
UPDATE caso
SET Horas_trabajadas = FORMAT(Horas_trabajadas / 3600, '00') + ':' + RIGHT('0' + FORMAT(Horas_trabajadas % 3600 / 60, '00'), 2)

select * from caso;
