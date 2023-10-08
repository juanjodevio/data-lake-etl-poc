dbt-debug:
	poetry run dbt debug --profiles-dir ./data_lake_etl_poc --project-dir ./data_lake_etl_poc 

dbt-test:
	poetry run dbt test --profiles-dir ./data_lake_etl_poc --project-dir ./data_lake_etl_poc 

dbt-run:
	poetry run dbt run --profiles-dir ./data_lake_etl_poc --project-dir ./data_lake_etl_poc 

dbt-build:
	poetry run dbt build --profiles-dir ./data_lake_etl_poc --project-dir ./data_lake_etl_poc 

dbt-clean:
	poetry run dbt clean --profiles-dir ./data_lake_etl_poc --project-dir ./data_lake_etl_poc 