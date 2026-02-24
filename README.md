# TPC-H Dimensional Modeling with dbt & Snowflake

This project transforms the standard **Snowflake TPC-H Sample Dataset** (`SNOWFLAKE_SAMPLE_DATA.TPCH_SF1`) into a consumer-ready Star Schema. It leverages **dbt** to execute transformations using the **Medallion Architecture** (Bronze, Silver, Gold).

## 🏛️ High-Level Architecture

The pipeline extracts raw, highly normalized transactional data and processes it through three distinct layers to produce clean, optimized dimensional models for business intelligence and analytics.



### Data Flow & Lineage

```mermaid
graph TD
    subgraph Snowflake Source
        S[(SNOWFLAKE_SAMPLE_DATA)]
    end

    subgraph Bronze Layer: Staging
        stg_orders(stg_tpch_orders<br/>View)
        stg_lineitems(stg_tpch_lineitems<br/>View)
        stg_customer(stg_tpch_customer<br/>View)
        stg_part(stg_tpch_part<br/>View)
        stg_nation(stg_tpch_nation<br/>View)
        stg_region(stg_tpch_region<br/>View)
    end

    subgraph Silver Layer: Intermediate
        int_locations(int_locations_joined<br/>Ephemeral)
    end

    subgraph Gold Layer: Marts
        dim_customers[(dim_customers<br/>Table)]
        dim_parts[(dim_parts<br/>Table)]
        fct_order_items[[(fct_order_items<br/>Incremental)]]
    end

    %% Relationships
    S --> stg_orders & stg_lineitems & stg_customer & stg_part & stg_nation & stg_region
    
    stg_nation --> int_locations
    stg_region --> int_locations

    stg_customer --> dim_customers
    int_locations --> dim_customers

    stg_part --> dim_parts

    stg_orders --> fct_order_items
    stg_lineitems --> fct_order_items
    dim_customers -. FK .-> fct_order_items
    dim_parts -. FK .-> fct_order_items
