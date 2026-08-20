USE AdventureWorks2025;
GO

-- 1. List schemas that contain tables
SELECT
    s.name AS schema_name,
    COUNT(t.object_id) AS table_count
FROM sys.schemas AS s
LEFT JOIN sys.tables AS t
    ON s.schema_id = t.schema_id
GROUP BY s.name
HAVING COUNT(t.object_id) > 0
ORDER BY table_count DESC;

-- 2. List all user tables
SELECT
    s.name AS schema_name,
    t.name AS table_name
FROM sys.tables AS t
JOIN sys.schemas AS s
    ON t.schema_id = s.schema_id
ORDER BY
    s.name,
    t.name;

-- 3. List tables with row counts
SELECT
    s.name AS schema_name,
    t.name AS table_name,
    SUM(p.rows) AS row_count
FROM sys.tables AS t
JOIN sys.schemas AS s
    ON t.schema_id = s.schema_id
JOIN sys.partitions AS p
    ON t.object_id = p.object_id
WHERE p.index_id IN (0, 1)
GROUP BY
    s.name,
    t.name
ORDER BY
    row_count DESC;