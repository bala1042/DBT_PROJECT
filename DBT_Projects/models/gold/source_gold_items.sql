WITH dedup_query AS (
SELECT 
    *,
    row_number() OVER (PARTITION BY id ORDER BY updateDate DESC) AS deduplicate_id 
FROM 
    {{ source('source', 'items') }}
)
SELECT 
    id,
    name,
    category,
    updateDate
FROM dedup_query
WHERE deduplicate_id = 1