view: inventory_items {
  sql_table_name: schema_looker.inventory_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension: price_buckets {
    type: string
    case: {
      when: {
        sql: ${cost} >= 0 and ${cost} < 20 ;;
        label: "Low"
      }
      when: {
        sql: ${cost} >= 20 and ${cost} < 50 ;;
        label: "Middle"
      }
      when: {
        sql: ${cost} >= 50 and ${cost} < 100 ;;
        label: "High"
      }
      else: "Hella High"
    }
  }


  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension_group: sold {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.sold_at ;;
  }

  measure: count {
    type: count
    drill_fields: [id, products.item_name, products.id]
  }
}
