-- docker exec -it flink-cdc-flink /opt/flink/bin/sql-client.sh embedded -f /opt/jobs/sample.sql
SET 'execution.checkpointing.interval' = '3 s';

CREATE CATALOG paimon_catalog WITH (
    'type' = 'paimon',
    'warehouse' = 'file:///opt/flink-output-files'
);

USE CATALOG paimon_catalog;

CREATE DATABASE test_db;

USE test_db;

CREATE TABLE paimon_foobar (
    number INT PRIMARY KEY NOT ENFORCED,
    text VARCHAR
);

CREATE TEMPORARY TABLE foobar (
  number INT,
  text STRING,
  PRIMARY KEY (number) NOT ENFORCED
) WITH (
  'connector' = 'postgres-cdc',
  'hostname' = 'flink-cdc-postgres',
  'port' = '5432',
  'username' = 'postgres',
  'password' = 'postgres',
  'database-name' = 'main',
  'schema-name' = 'public',
  'table-name' = 'foobar',
  'slot.name' = 'flink',
  'decoding.plugin.name' = 'pgoutput'
);

INSERT INTO paimon_foobar (number, text) SELECT * FROM foobar;
