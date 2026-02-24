{{
    config(
        materialized='incremental',
        unique_key='order_item_id'
    )
}}

with orders as (
    select * from {{ ref('stg_tpch_orders') }}
),
line_items as (
    select * from {{ ref('stg_tpch_lineitems') }}
)

select
    li.order_item_id,
    li.order_id,
    li.part_id,
    li.supplier_id,
    o.customer_id,
    o.order_date,
    li.quantity,
    li.extended_price,
    li.discount,
    (li.extended_price * (1 - li.discount)) as discounted_price,
    o.order_status,
    li.return_flag,
    li.status_code

from line_items li
join orders o on li.order_id = o.order_id

{% if is_incremental() %}
  where o.order_date > (select max(order_date) from {{ this }})
{% endif %}