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
		id participant_id,
		first_name,
		last_name,
		handedness,
		email,
		organization.org_id org_id,
		from_iso8601_timestamp(battery_result.battery_result_date) battery_result_date
	FROM {{ source('datalake-landing', 'rds') }}
)
select battery_result_id,
	participant_id,
	'' as first_name,
	last_name,
	handedness,
	email,
	org_id,
	date_format(battery_result_date, '%Y') battery_end_year,
	date_format(battery_result_date, '%m') battery_end_month
from cta