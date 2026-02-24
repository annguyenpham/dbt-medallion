with source as (
    select * from {{ source('tpch', 'part') }}
),
renamed as (
    select
        p_partkey as part_id,
        p_name as p_name,
        p_mfgr as p_mfgr,
        p_brand as p_brand,
        p_type as p_type,
        p_size as p_size,
        p_container as p_container,
        p_retailprice as p_retailprice
    from source
)
select * from renamed