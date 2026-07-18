{{ config(
    materialized='table'
) }}

with countries as (

    select *
    from {{ ref('triplens_countries') }}

)

select
    count(distinct country_name) as total_countries,

    sum(population) as global_population,

    round(avg(population), 2) as average_country_population,

    round(sum(area_km2), 2) as total_area_km2,

    round(avg(area_km2), 2) as average_country_area_km2,

    count(distinct continent) as total_continents,

    count(distinct region) as total_regions,

    count(distinct subregion) as total_subregions,

    count_if(is_independent = true) as independent_countries,

    count_if(un_member = true) as un_member_countries,

    count_if(eu_member = true) as eu_member_countries,

    count_if(african_union_member = true) as african_union_countries,

    count_if(asean_member = true) as asean_countries,

    count(distinct currency_code) as total_currencies,

    count(distinct primary_language) as total_primary_languages

from countries