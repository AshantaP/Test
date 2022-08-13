{{config(materialized="table")}}

with nation as (
    select * from {{ref('stg_nation')}}
),

dim_customer as (
    
    select C_CUSTKEY, C_NAME, C_PHONE, C_ADDRESS,N_NAME,R_NAME  from DBT_RAW.TPCH.CUSTOMER
    INNER JOIN nation ON CUSTOMER.C_NATIONKEY = nation.N_NATIONKEY
)


select * from dim_customer