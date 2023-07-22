
BEGIN TRANSACTION;

UPDATE Caso
SET Horas_trabajadas = dbo.CalcularDuracion(Horai_bodega,Horaf_bodega, Horai,Horaf);

UPDATE Caso
SET diastrabajados = dbo.CalcularDiferenciaDias(Fecha_inicio,Fecha_fin);

UPDATE Caso
SET Horas_trabajadas = dbo.Caso.Horas_trabajadas + (dbo.Caso.diastrabajados*( DATEDIFF(SECOND, '00:00:00', dbo.Caso.Horaf_bodega)- DATEDIFF(SECOND, '00:00:00', dbo.Caso.Horai_bodega) ))
where (dbo.Caso.diastrabajados >=1
and
dbo.Caso.Horas_trabajadas >=( DATEDIFF(SECOND, '00:00:00', dbo.Caso.Horaf_bodega)- DATEDIFF(SECOND, '00:00:00', dbo.Caso.Horai_bodega) ) );

UPDATE caso
SET Horas_trabajadas = CONCAT(FLOOR(Horas_trabajadas / 3600), ':', RIGHT('0' + CAST(FLOOR((Horas_trabajadas % 3600) / 60) AS VARCHAR(2)), 2));

COMMIT;

--ALTER TABLE caso
--DROP COLUMN diastrabajados;
SELECT [Num_caso]
      ,[Fecha_inicio]
      ,[Fecha_fin]
      ,[Horai]
      ,[Horaf]
      ,[Horai_bodega]
      ,[Horaf_bodega]
      ,[Horas_trabajadas]
      FROM [dbo].[Caso]




--5 horas y 30 min,
--5 horas
-- 1 hora
--- 18 horas
--- 9 horAS (20 es festivo)





--drop function CalcularDiferenciaDias;


