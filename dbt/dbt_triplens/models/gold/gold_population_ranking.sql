{{ config(
    materialized='table'
) }}

with countries as (

    select
        country_name,
        official_name,
        capital_city,
        continent,
        region,
        subregion,
        population,
        area_km2,
        currency_code,
        currency_name,
        is_independent,
        un_member
    from {{ ref('triplens_countries') }}

),

population_metrics as (

    select
        country_name,
        official_name,
        capital_city,
        continent,
        region,
        subregion,
        population,
        area_km2,
        currency_code,
        currency_name,
        is_independent,
        un_member,

        row_number() over (
            order by population desc nulls last
        ) as population_rank,

        round(
            population / nullif(area_km2, 0),
            2
        ) as population_density,

        case
            when population >= 100000000 then 'Very Large'
            when population >= 50000000 then 'Large'
            when population >= 10000000 then 'Medium'
            when population >= 1000000 then 'Small'
            else 'Very Small'
        end as population_band

    from countries

    where country_name is not null
      and population is not null
      and area_km2 is not null

)

select *
from population_metrics