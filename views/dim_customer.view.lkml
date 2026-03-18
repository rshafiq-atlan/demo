# ── DIM_CUSTOMER ───────────────────────────────────────────────────────
# YAML: tables[0]

view: dim_customer {
  sql_table_name:salesengineering-2022.PROCESSED_GOLD.DIM_CUSTOMER ;;
  label: "Customers"


  # ── Dimensions ─────────────────────────────────────────────────────

  dimension: customerid {
    primary_key: yes
    type: number
    sql: ${TABLE}.CUSTOMERID ;;
    description: "Unique identifier for each customer record."
  }

  dimension: customer_name {
    # YAML synonyms: account, account name, buyer, client, client name, customer
    type: string
    sql: ${TABLE}.CUSTOMERNAME ;;
    label: "Customer Name"
    description: "The full name of the customer."
    tags: ["account", "account name", "buyer", "client", "client name", "customer"]
  }

  dimension: customer_category_name {
    # YAML synonyms: category, channel, customer segment, customer type, segment
    # YAML sample_values: Novelty Shop, Supermarket, Gift Store, Computer Store, Corporate
    type: string
    sql: ${TABLE}.CUSTOMERCATEGORYNAME ;;
    label: "Customer Category"
    description: "Type of business (e.g., Novelty Shop, Supermarket, Corporate)."
    tags: ["category", "channel", "customer segment", "customer type", "segment"]
  }

  dimension: buying_group_name {
    type: string
    sql: ${TABLE}.BUYINGGROUPNAME ;;
    label: "Buying Group"
    description: "Name of the buying group the customer belongs to."
  }

  dimension_group: account_opened {
    # YAML: ACCOUNTOPENEDDATE — synonyms: account start date, customer since
    type: time
    timeframes: [raw, date, month, quarter, year]
    sql: ${TABLE}.ACCOUNTOPENEDDATE ;;
    label: "Account Opened"
    description: "The date when a customer's account was first established."
    tags: ["account start date", "customer since"]
  }

  dimension: credit_limit {
    # YAML synonyms: credit amount, credit line
    type: number
    value_format_name: usd
    sql: ${TABLE}.CREDITLIMIT ;;
    label: "Credit Limit"
    description: "Maximum amount of credit the customer is allowed."
    tags: ["credit amount", "credit line"]
  }

  dimension: is_on_credit_hold {
    # YAML synonyms: at risk, blocked, credit hold, on hold, restricted
    type: yesno
    sql: ${TABLE}.ISONCREDITHOLD ;;
    label: "On Credit Hold?"
    description: "Whether the customer's account is currently under credit hold."
    tags: ["at risk", "blocked", "credit hold", "on hold", "restricted"]
  }

  dimension: payment_days {
    # YAML synonyms: net days, payment terms
    type: number
    sql: ${TABLE}.PAYMENTDAYS ;;
    label: "Payment Days"
    description: "Number of days allocated for payment from invoice date."
    tags: ["net days", "payment terms"]
  }

  dimension: standard_discount_percentage {
    # YAML synonyms: discount rate, standard discount
    type: number
    value_format: "0.0\%"
    sql: ${TABLE}.STANDARDDISCOUNTPERCENTAGE ;;
    label: "Standard Discount %"
    description: "Regular discount percentage offered to the customer."
    tags: ["discount rate", "standard discount"]
  }

  dimension: delivery_address_line1 {
    type: string
    sql: ${TABLE}.DELIVERYADDRESSLINE1 ;;
    label: "Delivery Address"
  }

  dimension: delivery_postal_code {
    type: string
    sql: ${TABLE}.DELIVERYPOSTALCODE ;;
    label: "Delivery Postal Code"
  }

  # ── Metrics ────────────────────────────────────────────────────────

  measure: customer_count {
    # YAML: CUSTOMER_COUNT = COUNT(DISTINCT CUSTOMERID)
    # synonyms: accounts, client count, number of customers
    type: count_distinct
    sql: ${TABLE}.CUSTOMERID ;;
    label: "Customer Count"
    description: "Count of distinct customers."
    tags: ["accounts", "client count", "number of customers"]
  }
}
