# ── DIM_STOCKITEM ──────────────────────────────────────────────────────
# YAML: tables[2]

view: dim_stockitem {
  sql_table_name: salesengineering-2022.PROCESSED_GOLD.DIM_STOCKITEM ;;
  label: "Products"


  dimension: stockitemid {
    primary_key: yes
    type: number
    sql: ${TABLE}.STOCKITEMID ;;
    description: "Unique identifier for each stock item."
  }

  dimension: stock_item_name {
    # YAML synonyms: goods, item, merchandise, product, product name, SKU
    type: string
    sql: ${TABLE}.STOCKITEMNAME ;;
    label: "Product Name"
    description: "Name of the stock item."
    tags: ["goods", "item", "merchandise", "product", "product name", "SKU"]
  }

  dimension: brand {
    # YAML synonyms: brand name, manufacturer
    type: string
    sql: ${TABLE}.BRAND ;;
    label: "Brand"
    description: "Brand name that the stock item is associated with."
    tags: ["brand name", "manufacturer"]
  }

  dimension: color_name {
    # YAML synonyms: color
    type: string
    sql: ${TABLE}.COLORNAME ;;
    label: "Color"
    description: "Primary color of the stock item."
  }

  dimension: package_type_name {
    # YAML synonyms: package type, packaging
    type: string
    sql: ${TABLE}.PACKAGETYPENAME ;;
    label: "Package Type"
    description: "Packaging type (e.g., box, bag, container)."
    tags: ["package type", "packaging"]
  }

  dimension: is_chiller_stock {
    # YAML synonyms: cold storage, refrigerated
    type: yesno
    sql: ${TABLE}.ISCHILLERSTOCK ;;
    label: "Requires Refrigeration?"
    description: "Whether the stock item requires chiller/refrigeration."
    tags: ["cold storage", "refrigerated"]
  }

  dimension: lead_time_days {
    # YAML synonyms: delivery days, lead time
    type: number
    sql: ${TABLE}.LEADTIMEDAYS ;;
    label: "Lead Time (Days)"
    description: "Lead time in days for delivery."
    tags: ["delivery days", "lead time"]
  }

  dimension: unit_price {
    type: number
    value_format_name: usd
    sql: ${TABLE}.UNITPRICE ;;
    label: "Unit Price"
    description: "Unit price of the stock item."
  }

  dimension: recommended_retail_price {
    # YAML synonyms: MSRP, retail price, RRP
    type: number
    value_format_name: usd
    sql: ${TABLE}.RECOMMENDEDRETAILPRICE ;;
    label: "Recommended Retail Price"
    description: "Recommended retail price for selling to customers."
    tags: ["MSRP", "retail price", "RRP"]
  }

  measure: product_count {
    # YAML: PRODUCT_COUNT = COUNT(DISTINCT STOCKITEMID)
    # synonyms: item count, number of products, SKU count
    type: count_distinct
    sql: ${TABLE}.STOCKITEMID ;;
    label: "Product Count"
    description: "Count of distinct products."
    tags: ["item count", "number of products", "SKU count"]
  }
}
