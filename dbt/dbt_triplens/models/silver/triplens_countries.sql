{{ config(materialized='view') }}

with raw_countries as (

    select
        country.value as country_record

    from {{ ref('stg_triplens_countries') }},
    lateral flatten(input => payload) country

),

countries as (

    select
        country_record:names:common::string as country_name,
        country_record:names:official::string as official_name,

        country_record:capitals[0]:name::string as capital_city,

        country_record:continents[0]::string as continent,

        country_record:region::string as region,
        country_record:subregion::string as subregion,

        country_record:population::number as population,

        country_record:area:kilometers::float as area_km2,
        country_record:area:miles::float as area_miles2,

        country_record:independent::boolean as is_independent,

        country_record:currencies[0]:code::string as currency_code,
        country_record:currencies[0]:name::string as currency_name,
        country_record:currencies[0]:symbol::string as currency_symbol,

        country_record:languages[0]:name::string as primary_language,
        country_record:languages[0]:native_name::string as primary_language_native,

        country_record:memberships:un::boolean as un_member,
        country_record:memberships:eu::boolean as eu_member,
        country_record:memberships:african_union::boolean as african_union_member,
        country_record:memberships:asean::boolean as asean_member,
        country_record:memberships:brics::boolean as brics_member,
        country_record:memberships:commonwealth::boolean as commonwealth_member,
        country_record:memberships:g20::boolean as g20_member,
        country_record:memberships:g7::boolean as g7_member,
        country_record:memberships:nato::boolean as nato_member,
        country_record:memberships:oecd::boolean as oecd_member

    from raw_countries

)

select *
from countries