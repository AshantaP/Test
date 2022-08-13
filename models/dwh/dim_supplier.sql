{{config(materialized="table")}}

with nation as (
    select * from {{ref('stg_nation')}}
),

dim_supplier as (
    
    select S_SUPPKEY, S_NAME, S_PHONE, S_ADDRESS,N_NAME,R_NAME  from DBT_RAW.TPCH.SUPPLIER
    INNER JOIN nation ON SUPPLIER.S_NATIONKEY = nation.N_NATIONKEY
)


select * from dim_supplier 