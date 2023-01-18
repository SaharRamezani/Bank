CREATE PROCEDURE STOD  
    @DesDepVar INT,  
    @SourceDepVar INT
AS  
    WITH DirectReports(SourceDep, DesDep, TrnTime, tLevel) AS
(
SELECT SourceDep, DesDep, TrnTime, 0 AS tLevel
FROM dbo.Trn_Src_Des
WHERE Trn_Src_Des.DesDep=@DesDepVar
UNION
SELECT SourceDep, DesDep, TrnTime, 0 AS tLevel
FROM dbo.Trn_Src_Des
WHERE Trn_Src_Des.SourceDep IS NULL  AND Trn_Src_Des.DesDep=@SourceDepVar
UNION ALL
SELECT e.SourceDep, e.DesDep, e.TrnTime, tLevel + 1
FROM dbo.Trn_Src_Des AS e
INNER JOIN DirectReports AS d
ON e.SourceDep = d.DesDep
)
SELECT SourceDep, DesDep, TrnTime--, tLevel,
--ROW_NUMBER() OVER (PARTITION BY SourceDep, DesDep, TrnTime ORDER BY SourceDep, DesDep, TrnTime ASC) AS Row#
FROM DirectReports
--ORDER BY DesDep
Group by SourceDep, DesDep, TrnTime
OPTION (MAXRECURSION 0)
--WHERE
--SELECT * FROM  dbo.Trn_Src_Des
GO  
WITH DirectReports(SourceDep, DesDep, TrnTime, tLevel) AS
(
    SELECT SourceDep, DesDep, TrnTime, 0 AS tLevel
    FROM dbo.Trn_Src_Des
    WHERE Trn_Src_Des.DesDep=null
UNION
    SELECT SourceDep, DesDep, TrnTime, 0 AS tLevel
    FROM dbo.Trn_Src_Des
    WHERE Trn_Src_Des.SourceDep IS NULL  AND Trn_Src_Des.DesDep=1
    UNION ALL
    SELECT e.SourceDep, e.DesDep, e.TrnTime, tLevel + 1
    FROM dbo.Trn_Src_Des AS e
        INNER JOIN DirectReports AS d
        ON e.SourceDep = d.DesDep
)
SELECT SourceDep, DesDep, TrnTime--, EmployeeLevel,
--ROW_NUMBER() OVER (PARTITION BY SourceDep, DesDep, TrnTime ORDER BY SourceDep, DesDep, TrnTime ASC) AS Row#
FROM DirectReports
--ORDER BY DesDep
Group by SourceDep, DesDep, TrnTime
OPTION (MAXRECURSION 0)
--WHERE
--SELECT * FROM  dbo.Trn_Src_Des
