with customers as (
    select * from {{ ref('stg_tpch_customer') }}
),
locations as (
    select * from {{ ref('int_locations_joined') }}
)
select
    c.customer_id,
    c.customer_name,
    c.address,
    c.phone_number,
    c.account_balance,
    c.market_segment,
    l.nation_name as customer_nation,
    l.region_name as customer_region
from customers c
left join locations l on c.nation_id = l.nation_id