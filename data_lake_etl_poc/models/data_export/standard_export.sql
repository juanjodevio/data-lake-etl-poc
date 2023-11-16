{{
  config(
    materialized='view',
  )
}}

SELECT battery_result_date,
	first_name,
	last_name,
	handedness,
	battery_name,
	battery_metrics
FROM {{ref("battery_results")}}
left join {{ref("participants")}} using (battery_result_id);