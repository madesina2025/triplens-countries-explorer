select countries as (
    SELECT 
-- Top level keys
    country.value:name.common::STRING as country_name,
    country.value:name.official::STRING as official_name,
    country.value:area::number as area,
    country.value:population::NUMBER as population,
    country.value:region::STRING as region,
    country.value:subregion::STRING as subregion,
    country.value:unMember::BOOLEAN as un_Member,
    country.value:independent::BOOLEAN as independent,
    country.value:startofweek::STRING as startofweek,


-- array keys (getting the first element)
    country.value:capital[0]::STRING as capital_city,
    country.value:continents[0]::STRING as continents,

-- Dynamic Currency keyss
    currency.keys::STRING as currency_code,
    currency.value:name::STRING as currency_name,
    currency.value:symbol::STRING as currency_symbol,

-- Nested IDD keys
    country.value:idd.root::STRING as idd_root,
    country.value:idd.surffixes[0]::STRING as idd_suffix
FROM
    {{ref('stg_triplens_countries')}}
    LATERAL FLATTEN(input => PAYLOAD) country,
    LATERAL FLATTEN(input => country.value:currencies) currency;

)

select * from countries
