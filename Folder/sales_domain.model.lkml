connection: "rs-db"  # Your BigQuery or Snowflake connection name in Looker

label: "Sales Domain (Old)"
include: "/views/*.view.lkml"

# ── Explores (entry points for users) ─────────────────────────────────
# This is roughly equivalent to your top-level YAML name + relationships

explore: fact_orders {
  label: "Sales Orders"


  # relationship: ORDERS_TO_CUSTOMER
  join: dim_customer {
    type: left_outer
    sql_on: ${fact_orders.customerid} = ${dim_customer.customerid} ;;
    relationship: many_to_one
  }

  # relationship: ORDERS_TO_PRODUCT
  join: dim_stockitem {
    type: left_outer
    sql_on: ${fact_orders.stockitemid} = ${dim_stockitem.stockitemid} ;;
    relationship: many_to_one
  }

  # relationship: ORDERS_TO_SALESPERSON
  join: dim_employee {
    type: left_outer
    sql_on: ${fact_orders.salespersonid} = ${dim_employee.salespersonid} ;;
    relationship: many_to_one
  }
}
