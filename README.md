graph TD
    subgraph Snowflake_Source ["Snowflake Source"]
        S[("SNOWFLAKE_SAMPLE_DATA")]
    end

    subgraph Bronze_Layer ["Bronze Layer: Staging"]
        stg_orders("stg_tpch_orders<br/>View")
        stg_lineitems("stg_tpch_lineitems<br/>View")
        stg_customer("stg_tpch_customer<br/>View")
        stg_part("stg_tpch_part<br/>View")
        stg_nation("stg_tpch_nation<br/>View")
        stg_region("stg_tpch_region<br/>View")
    end

    subgraph Silver_Layer ["Silver Layer: Intermediate"]
        int_locations("int_locations_joined<br/>Ephemeral")
    end

    subgraph Gold_Layer ["Gold Layer: Marts"]
        dim_customers[("dim_customers<br/>Table")]
        dim_parts[("dim_parts<br/>Table")]
        fct_order_items[["fct_order_items<br/>Incremental"]]
    end

    %% Relationships - safely separated to prevent layout engine crashes
    S --> stg_orders
    S --> stg_lineitems 
    S --> stg_customer 
    S --> stg_part 
    S --> stg_nation 
    S --> stg_region
    
    stg_nation --> int_locations
    stg_region --> int_locations

    stg_customer --> dim_customers
    int_locations --> dim_customers

    stg_part --> dim_parts

    stg_orders --> fct_order_items
    stg_lineitems --> fct_order_items
    
    %% Standardized dotted link syntax for GitHub
    dim_customers -.->|FK| fct_order_items
    dim_parts -.->|FK| fct_order_items
