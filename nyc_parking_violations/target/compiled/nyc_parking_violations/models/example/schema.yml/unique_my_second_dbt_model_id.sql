
    
    

with __dbt__cte__my_second_dbt_model as (
-- Use the `ref` function to select from other models

select *
from "nyc_parking_violations"."main"."my_first_dbt_model"
where id = 1
) select
    id as unique_field,
    count(*) as n_records

from __dbt__cte__my_second_dbt_model
where id is not null
group by id
having count(*) > 1


