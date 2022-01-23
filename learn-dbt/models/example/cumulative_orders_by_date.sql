{{ config(materialized='table') }}

with daily as(
  select
    o_orderdate,
    sum(o_totalprice) as daily_sales
  from "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."ORDERS"
  group by 1
  order by 1
)

select
    o_orderdate,
    daily_sales,
    sum(daily_sales) over (order by o_orderdate rows between unbounded preceding and current row) as cumulative_sum
from daily
order by 1
