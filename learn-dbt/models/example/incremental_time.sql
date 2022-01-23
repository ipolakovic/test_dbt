{{ config(materialized='incremental', unique_key = 't_time_id') }}

select
    *,
    to_time(concat(T_HOUR::varchar, ':', T_MINUTE, ':', T_SECOND)) as std_time
from "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF10TCL"."TIME_DIM"
where  std_time <= current_time


{% if is_incremental() %}
  and std_time > (select max(std_time) from {{this}} )
{% endif %}
