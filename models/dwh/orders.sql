{{config(materialized="table")}}

with orders as (
    select * from DBT_RAW.TPCH.ORDERS limit 10
)


select *,  from orders