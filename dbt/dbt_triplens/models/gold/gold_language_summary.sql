{{ config(
    materialized='table'
) }}

with countries as (

    select
        country_name,
        continent,
        population,
        primary_language,
        primary_language_native
    from {{ ref('triplens_countries') }}

),

language_summary as (

    select
        primary_language as language_name,
        primary_language_native as native_language_name,

        count(distinct country_name) as total_countries,

        sum(population) as combined_population,

        count(distinct continent) as total_continents,

        listagg(distinct continent, ', ')
            within group (order by continent) as continents_spoken

    from countries

    where primary_language is not null

    group by
        primary_language,
        primary_language_native

)

select *
from language_summary