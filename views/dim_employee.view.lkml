# ── DIM_EMPLOYEE ───────────────────────────────────────────────────────
# YAML: tables[1]

view: dim_employee {
  sql_table_name: salesengineering-2022.PROCESSED_GOLD.DIM_EMPLOYEE ;;
  label: "Sales Reps"

  dimension: salespersonid {
    primary_key: yes
    type: number
    sql: ${TABLE}.SALESPERSONID ;;
    description: "Unique identifier for each salesperson."
  }

  dimension: full_name {
    # YAML synonyms: agent, employee, rep, sales rep, sales representative, salesperson, seller
    type: string
    sql: ${TABLE}.FULLNAME ;;
    label: "Sales Rep"
    description: "Employee full name used for identifying sales personnel."
    tags: ["agent", "employee", "rep", "sales rep", "sales representative", "salesperson", "seller"]
  }

  measure: salesperson_count {
    # YAML: SALESPERSON_COUNT = COUNT(DISTINCT SALESPERSONID)
    # synonyms: number of reps, rep count, team size
    type: count_distinct
    sql: ${TABLE}.SALESPERSONID ;;
    label: "Sales Rep Count"
    description: "Count of distinct salespeople."
    tags: ["number of reps", "rep count", "team size"]
  }
}
