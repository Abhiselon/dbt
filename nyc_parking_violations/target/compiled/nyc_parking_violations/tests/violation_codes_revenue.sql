

with __dbt__cte__silver_parking_violation_codes as (
WITH manhattan_violation_codes AS (
    SELECT
        violation_code,
        definition,
        TRUE AS is_manhattan_96th_st_below,
        manhattan_96th_st_below AS fee_usd,
    FROM
        "nyc_parking_violations"."main"."bronze_parking_violation_codes"
),

all_other_violation_codes AS (
    SELECT
        violation_code,
        definition,
        FALSE AS is_manhattan_96th_st_below,
        all_other_areas AS fee_usd,
    FROM
        "nyc_parking_violations"."main"."bronze_parking_violation_codes"
)

SELECT * FROM manhattan_violation_codes
UNION ALL
SELECT * FROM all_other_violation_codes
ORDER BY violation_code ASC
) SELECT
    violation_code,
    SUM(fee_usd) AS total_revenue_usd
FROM
    __dbt__cte__silver_parking_violation_codes
GROUP BY
    violation_code
HAVING
    NOT(total_revenue_usd >= 1)