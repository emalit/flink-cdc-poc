# flink-cdc-poc
A PoC for Flink CDC

This PoC uses Postgres as a database and Paimon as a datalake platform. It streams the
contents of a test table into the filesystem.

## Setup
Download the following jars and copy them into the main repo:
- [flink-shaded-hadoop-2-uber-2.8.3-10.0.jar](https://mvnrepository.com/artifact/org.apache.flink/flink-shaded-hadoop-2-uber)
- [flink-sql-connector-postgres-cdc-3.0.1.jar](https://nightlies.apache.org/flink/flink-cdc-docs-master/docs/connectors/flink-sources/sqlserver-cdc/)
- [paimon-flink-1.18.0.9.0.jar](https://paimon.apache.org/docs/0.9/flink/quick-start/)

Make sure you have Docker on your machine, then run:
```commandline
make up
```

This should spin up a Postgres instance in your docker, and a flink container.

## Jobs

To get the Flink Dashboard up, you can run:
```commandline
docker exec -it flink-cdc-flink /opt/flink/bin/start-cluster.sh
```

Run the job:
```commandline
docker exec -it flink-cdc-flink /opt/flink/bin/sql-client.sh embedded -f /opt/jobs/e_transfer_deposits_cdc.sql
```

You should be able to observe a flink job running now.

Feel free to insert/change/delete data in the `e_transfer_deposits` table. The CDC job will stream
the changes to the local directory `flink-output-files/default.db/`.

To view the parquet files in the output directory, you can use the accompanying `parquet_reader.py`. You will likely
need to install `pandas` to get the script to work.

```commandline
python3 -m venv venv
source venv/bin/activate
pip3 install -r requirements.txt
python3 parquet_reader.py
```
