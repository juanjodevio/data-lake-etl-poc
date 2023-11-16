IMG_VERSION=0.0.1
IMG_NAME=data-lake-etl-poc
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
dbt-docs-serve:
	poetry run dbt docs serve --profiles-dir ./data_lake_etl_poc --project-dir ./data_lake_etl_poc 
dbt-docs-generate:
	poetry run dbt docs generate --profiles-dir ./data_lake_etl_poc --project-dir ./data_lake_etl_poc 

docker-build:
	docker build . -t data-lake-etl-poc

docker-dbt-run:
	docker run data-lake-etl-poc run

upload-to-ecr:
	poetry export -f requirements.txt --without-hashes --output ./data_lake_etl_poc/requirements.txt
	docker build . -t $(IMG_NAME):$(IMG_VERSION) 
	docker tag $$(docker images --quiet $(IMG_NAME):$(IMG_VERSION)) 508632573795.dkr.ecr.us-east-1.amazonaws.com/data-lake-etl-poc
	aws ecr get-login-password --region us-east-1 --profile juanjodevio | docker login --username AWS --password-stdin 508632573795.dkr.ecr.us-east-1.amazonaws.com
	docker push 508632573795.dkr.ecr.us-east-1.amazonaws.com/$(IMG_NAME):$(IMG_VERSION)
