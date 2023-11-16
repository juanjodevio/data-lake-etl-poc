from dbt.cli.main import dbtRunner, dbtRunnerResult

# initialize
dbt = dbtRunner()

# create CLI args as a list of strings
cli_args = ["run", " --profiles-dir", "./data_lake_etl_poc"]
run --profiles-dir ./data_lake_etl_poc --project-dir ./data_lake_etl_poc 
# run the command
res: dbtRunnerResult = dbt.invoke(cli_args)

# inspect the results
for r in res.result:
    print(r)
    print("----")
    # print(f"{r.node.name}: {r.status}")
