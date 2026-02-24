with parts as (
    select * from {{ ref('stg_tpch_part') }}
)
select
    part_id,
    p_name as part_name,
    p_mfgr as manufacturer,
    p_brand as brand,
    p_type as type,
    p_size as size,
    p_container as container,
    p_retailprice as retail_price
from parts