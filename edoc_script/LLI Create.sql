DECLARE @cols NVARCHAR(MAX);
DECLARE @sql NVARCHAR(MAX);

-- Generate dynamic columns without STRING_AGG
SELECT @cols = STUFF((
    SELECT DISTINCT
        ',' + QUOTENAME('Facility' + CAST(FacilityNo AS VARCHAR(10)))
    FROM
    (
        SELECT
            ROW_NUMBER() OVER (ORDER BY id) AS FacilityNo
        FROM dbo.t_Sanction_Master_Details where edoc_id=567
    ) A
    FOR XML PATH(''), TYPE
).value('.', 'NVARCHAR(MAX)'), 1, 1, '');

SET @sql = '
SELECT *
FROM
(
    SELECT
        ''loan_nature'' AS FieldName,
        ''Facility'' + CAST(ROW_NUMBER() OVER (ORDER BY id) AS VARCHAR(10)) AS FacilityNo,
        CAST(loan_nature AS NVARCHAR(MAX)) AS Value
    FROM dbo.t_Sanction_Master_Details

    UNION ALL

    SELECT
        ''amount'',
        ''Facility'' + CAST(ROW_NUMBER() OVER (ORDER BY id) AS VARCHAR(10)),
        CAST(amount AS NVARCHAR(MAX))
    FROM dbo.t_Sanction_Master_Details

    UNION ALL

    SELECT
        ''validity'',
        ''Facility'' + CAST(ROW_NUMBER() OVER (ORDER BY id) AS VARCHAR(10)),
        CAST(validity AS NVARCHAR(MAX))
    FROM dbo.t_Sanction_Master_Details

    UNION ALL

    SELECT
        ''customer_name'',
        ''Facility'' + CAST(ROW_NUMBER() OVER (ORDER BY id) AS VARCHAR(10)),
        CAST(customer_name AS NVARCHAR(MAX))
    FROM dbo.t_Sanction_Master_Details
) AS SourceData
PIVOT
(
    MAX(Value)
    FOR FacilityNo IN (' + @cols + ')
) AS PivotTable;
';

EXEC sp_executesql @sql;