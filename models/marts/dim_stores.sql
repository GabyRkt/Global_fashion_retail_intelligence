with stg_stores as (
    select * from {{ ref('stg_stores') }}
)

select
    store_id,
    store_name,
    city,
    case
        when country = '中国' then 'China'
        when country = 'Deutschland' then 'Germany'
        when country = 'España' then 'Spain'
        else country
    end as country,
    number_of_employees,
    zip_code,
    latitude,
    longitude,
    case
        when country in ('France', 'Deutschland', 'España', 'Portugal') then 'Continental Europe'
        when country = 'United Kingdom' then 'Europe UK'
        when country = 'United States' then 'North America'
        when country = '中国' then 'Asia'
        else 'Other'
    end as region

from stg_stores