# ── FACT_ORDERS ────────────────────────────────────────────────────────
# YAML: tables[3] — the fact table with orders, quantities, prices

view: fact_orders {
  sql_table_name: salesengineering-2022.PROCESSED_GOLD.FACT_ORDERS ;;
  label: "Orders"


  # ── Dimensions (from YAML dimensions) ─────────────────────────────

  dimension: orderid {
    primary_key: yes
    type: number
    sql: ${TABLE}.ORDERID ;;
    description: "Serves as a unique identifier for each order placed, enabling differentiation and individual recognition of every transaction conducted."
  }

  dimension: orderlineid {
    type: number
    sql: ${TABLE}.ORDERLINEID ;;
    description: "Serves as a unique identifier for each individual item in an order."
  }

  dimension: customerid {
    type: number
    sql: ${TABLE}.CUSTOMERID ;;
    hidden: yes  # Users join through dim_customer instead
    description: "FK to DIM_CUSTOMER"
  }

  dimension: salespersonid {
    type: number
    sql: ${TABLE}.SALESPERSONID ;;
    hidden: yes  # Users join through dim_employee instead
    description: "FK to DIM_EMPLOYEE"
  }

  dimension: stockitemid {
    type: number
    sql: ${TABLE}.STOCKITEMID ;;
    hidden: yes  # Users join through dim_stockitem instead
    description: "FK to DIM_STOCKITEM"
  }

  dimension_group: order {
    # LookML dimension_groups auto-generate _date, _month, _quarter, _year
    # YAML just had: ORDERDATE, DATE
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    sql: ${TABLE}.ORDERDATE ;;
    description: "Date when the order was placed by the customers with the sales person."
  }

  dimension: order_description {
    type: string
    sql: ${TABLE}.ORDERDESCRIPTION ;;
    description: "Stock item description of the order line number."
  }

  # ── Facts / raw numeric columns (YAML facts → LookML dimensions) ──

  dimension: quantity {
    type: number
    sql: ${TABLE}.QUANTITY ;;
    description: "Number of items included in each order."
  }

  dimension: unit_price {
    type: number
    value_format_name: usd
    sql: ${TABLE}.UNITPRICE ;;
    description: "Monetary amount charged for a single item within an order. USD is the default currency."
  }

  dimension: tax_rate {
    type: number
    value_format: "0.000\%"
    sql: ${TABLE}.TAXRATE ;;
    description: "Percentage of sales tax applied to each order."
  }

  dimension: line_total {
    # YAML fact: LINE_TOTAL = QUANTITY * UNITPRICE
    type: number
    value_format_name: usd
    sql: ${TABLE}.QUANTITY * ${TABLE}.UNITPRICE ;;
    description: "Total value for the order line calculated as quantity times unit price."
  }

  # ── Metrics (YAML metrics → LookML measures) ──────────────────────

  measure: total_revenue {
    # YAML: TOTAL_REVENUE = SUM(QUANTITY * UNITPRICE)
    # synonyms: gross sales, revenue, sales amount, total sales
    type: number
    sql: SUM(${TABLE}.QUANTITY * ${TABLE}.UNITPRICE) ;;
    value_format_name: usd
    label: "Total Revenue"
    description: "Sum of all order line totals (quantity × unit price) representing total sales value."
    tags: ["gross sales", "revenue", "sales amount", "total sales"]
  }

  measure: order_count {
    # YAML: ORDER_COUNT = COUNT(DISTINCT ORDERID)
    # synonyms: number of orders, order volume, transactions
    type: count_distinct
    sql: ${TABLE}.ORDERID ;;
    label: "Order Count"
    description: "Count of distinct orders placed."
    tags: ["number of orders", "order volume", "transactions"]
  }

  measure: total_quantity {
    # YAML: TOTAL_QUANTITY = SUM(QUANTITY)
    # synonyms: quantity sold, units sold, volume
    type: sum
    sql: ${TABLE}.QUANTITY ;;
    label: "Total Quantity"
    description: "Total number of units sold across all orders."
    tags: ["quantity sold", "units sold", "volume"]
  }

  measure: avg_order_value {
    # YAML: AVG_ORDER_VALUE = SUM(QUANTITY * UNITPRICE) / NULLIF(COUNT(DISTINCT ORDERID), 0)
    # synonyms: AOV, average order, average transaction
    type: number
    sql: ${total_revenue} / NULLIF(${order_count}, 0) ;;
    value_format_name: usd
    label: "Average Order Value"
    description: "Average revenue per order."
    tags: ["AOV", "average order", "average transaction"]
  }
}
