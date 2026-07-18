{{ config(
    materialized='table'
) }}

with countries as (

    select *
    from {{ ref('triplens_countries') }}

),

region_summary as (

    select
        continent,
        region,
        subregion,

        count(*) as total_countries,

        sum(population) as total_population,

        round(avg(population), 2) as average_population,

        round(sum(area_km2), 2) as total_area_km2,

        round(avg(area_km2), 2) as average_area_km2,

        count_if(is_independent = true) as independent_countries,

        count_if(un_member = true) as un_member_countries

    from countries

    where region is not null
      and subregion is not null

    group by
        continent,
        region,
        subregion

)

select *
from region_summary