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
        currency_symbol,
        primary_language,
        primary_language_native,
        is_independent,
        un_member,
        eu_member,
        african_union_member,
        asean_member
    from {{ ref('triplens_countries') }}

),

rankings as (

    select
        country_name,
        population_rank,
        population_density,
        population_band
    from {{ ref('gold_population_ranking') }}

)

select
    c.country_name,
    c.official_name,
    c.capital_city,
    c.continent,
    c.region,
    c.subregion,
    c.population,
    c.area_km2,
    r.population_density,
    r.population_rank,
    r.population_band,
    c.currency_code,
    c.currency_name,
    c.currency_symbol,
    c.primary_language,
    c.primary_language_native,
    c.is_independent,
    c.un_member,
    c.eu_member,
    c.african_union_member,
    c.asean_member
from countries c

left join rankings r
    on c.country_name = r.country_name