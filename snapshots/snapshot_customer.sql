{% snapshot snap_region %}

{{
    config(
      target_database='DBT_DWH',
      target_schema='TPCH',
      unique_key='C_CUSTKEY',
      strategy='timestamp',
      updated_at='last_update',
      invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('dim_customer') }}

{% endsnapshot %}