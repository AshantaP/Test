

{{config(materialized='view')}}

with region_asia as (

select R_REGIONKEY,R_NAME
    from {{ source( 'staging', 'REGION') }} where R_NAME = 'ASIA'
),


nation_india as (

    select N_NATIONKEY,N_NAME,R_NAME from {{ source( 'staging', 'NATION') }}
    INNER JOIN region_asia ON region_asia.R_REGIONKEY = NATION.N_REGIONKEY
        where N_NAME = 'INDIA'
        
)

select * from nation_india
