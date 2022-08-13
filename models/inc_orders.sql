{{config(
    materialized='incremental',
    unique_key='O_ORDERKEY')}}

with orders as (
    select * from {{ref('orders')}}
)


select * from orders
{% if is_incremental() %}
	where O_ORDERDATE > (select dateadd('day', -1, max(O_ORDERDATE)) from {{ this }})
{% endif %}

