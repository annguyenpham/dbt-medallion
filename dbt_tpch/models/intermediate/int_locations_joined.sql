with nation as (
    select * from {{ ref('stg_tpch_nation') }}
),
region as (
    select * from {{ ref('stg_tpch_region') }}
)
select
    n.nation_id,
    n.nation_name,
    r.region_id,
    r.region_name
from nation n
join region r on n.region_id = r.region_id