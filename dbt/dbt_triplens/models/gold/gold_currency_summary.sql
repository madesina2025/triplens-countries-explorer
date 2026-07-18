{{ config(
    materialized='table'
) }}

with countries as (

    select
        country_name,
        continent,
        population,
        currency_code,
        currency_name,
        currency_symbol
    from {{ ref('triplens_countries') }}

),

currency_summary as (

    select
        currency_code,
        currency_name,
        currency_symbol,

        count(distinct country_name) as total_countries,

        sum(population) as combined_population,

        count(distinct continent) as total_continents,

        listagg(distinct continent, ', ')
            within group (order by continent) as continents_used

    from countries

    where currency_code is not null

    group by
        currency_code,
        currency_name,
        currency_symbol

)

select *
from currency_summary