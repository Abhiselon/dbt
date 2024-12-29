
    
    



with __dbt__cte__my_second_dbt_model as (
-- Use the `ref` function to select from other models

select *
from "nyc_parking_violations"."main"."my_first_dbt_model"
where id = 1
) select *
from __dbt__cte__my_second_dbt_model
where id is null


