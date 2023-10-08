{{
  config(
    materialized='incremental',
    format='parquet',
    incremental_strategy='merge',
    unique_key='battery_result_id',
    write_compression='snappy',
    on_schema_change='append_new_columns',
    table_type='iceberg',
    partitioned_by=["org_id", "battery_end_year", "battery_end_month"]
  )
}}
with cta as (
SELECT battery_result.id battery_result_id,
    organization.org_id org_id,
    from_iso8601_timestamp(battery_result.battery_result_date) battery_result_date,
    battery_result.battery.name battery_name,
    battery_result.metrics battery_metrics,
    battery_result.assessment_results assessment_results
FROM {{ source('datalake-landing', 'rds') }}
)
select battery_result_id,
	battery_name,
	battery_metrics,
	assessment_results,
	org_id,
    cast(battery_result_date as timestamp(6) with time zone) battery_result_date,
	date_format(battery_result_date, '%Y') battery_end_year,
	date_format(battery_result_date, '%m') battery_end_month
from cta

