BEGIN TRANSACTION
UPDATE Caso
SET Horas_trabajadas = dbo.Calcular(Fecha_inicio,Fecha_fin,Horai_bodega,Horaf_bodega, Horai,Horaf)
WHERE (Fecha_fin != '' or Fecha_fin != '' );
------------------------------------------------------------------------------
UPDATE Caso
SET Horas = CONVERT(DECIMAL(10,2), dbo.Calcular(Fecha_inicio, Fecha_fin, Horai_bodega, Horaf_bodega, Horai, Horaf) / 3600.0)
WHERE (Fecha_fin != '' or Fecha_fin != '' );


UPDATE caso SET Horas_trabajadas = CONCAT(FORMAT(Horas_trabajadas / 3600, '00'), ':', 
                              RIGHT('0' + FORMAT(Horas_trabajadas % 3600 / 60, '00'), 2), ':',
                              RIGHT('0' + FORMAT(Horas_trabajadas % 60, '00'), 2))
							  WHERE (Fecha_fin != '' or Fecha_fin != '' );

COMMIT TRANSACTION
select * from Caso


--DECLARE @fechaInicio DATE = '2023-05-11';
--DECLARE @fechaFin DATE = '2023-05-19';
--DECLARE @horaInicio1 TIME = '06:30:00';
--DECLARE @horaFin1 TIME = '16:30:00';
--DECLARE @horaInicio2 TIME = '11:11:00';
--DECLARE @horaFin2 TIME = '08:55:16';

--SElect CONVERT(DECIMAL(10,2),dbo.Calcular(@fechaInicio, @fechaFin, @horaInicio1, @horaFin1, @horaInicio2, @horaFin2)/ 3600.0) as Result;


