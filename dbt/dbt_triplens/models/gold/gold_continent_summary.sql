{{ config(materialized='table') }}

with countries as (

    select *
    from {{ ref('triplens_countries') }}

),

continent_summary as (

    select
        continent,
        count(*) as total_countries,
        sum(population) as total_population,
        avg(population) as average_population,
        sum(area_km2) as total_area_km2,
        avg(area_km2) as average_area_km2,
        count_if(is_independent = true) as independent_countries,
        count_if(un_member = true) as un_member_countries

    from countries

    group by continent

)

select *
from continent_summary