with source as (
    select * from {{ source('tpch', 'orders') }}
),
renamed as (
    select
        o_orderkey as order_id,
        o_custkey as customer_id,
        o_orderstatus as order_status,
        o_totalprice as total_price,
        o_orderdate as order_date,
        o_orderpriority as priority,
        o_clerk as clerk_name,
        o_shippriority as ship_priority
    from source
)
select * from renamed