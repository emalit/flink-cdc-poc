-- docker exec -it flink-cdc-flink /opt/flink/bin/sql-client.sh embedded -f /opt/jobs/e_transfer_deposits_cdc.sql
SET 'execution.checkpointing.interval' = '3 s';

-- OUTPUT TABLE --

CREATE CATALOG paimon_catalog WITH (
    'type' = 'paimon',
    'warehouse' = 'file:///opt/flink-output-files'
);

USE CATALOG paimon_catalog;

CREATE TABLE IF NOT EXISTS e_transfer_deposits_cdc (
    canonical_id VARCHAR NOT NULL PRIMARY KEY NOT ENFORCED,
    identity_canonical_id VARCHAR,
    account_canonical_id VARCHAR,
    funding_method_canonical_id VARCHAR,
    transfer_type VARCHAR,
    amount DECIMAL(16,4),
    currency VARCHAR,
    amount_in_cad DECIMAL(16,4),
    status VARCHAR,
    transfer_created_at TIMESTAMP
);

-- INPUT TABLE --
CREATE TEMPORARY TABLE e_transfer_deposits (
    canonical_id STRING,
    identity_canonical_id STRING,
    account_canonical_id STRING,
    funding_method_canonical_id STRING,
    transfer_type STRING,
    amount DECIMAL(16, 4),
    currency STRING,
    amount_in_cad DECIMAL(16, 4),
    status STRING,
    transfer_created_at TIMESTAMP,
    PRIMARY KEY (canonical_id) NOT ENFORCED
) WITH (
    'connector' = 'postgres-cdc',
    'hostname' = 'flink-cdc-postgres',
    'port' = '5432',
    'username' = 'postgres',
    'password' = 'postgres',
    'database-name' = 'main',
    'schema-name' = 'public',
    'table-name' = 'e_transfer_deposits',
    'slot.name' = 'flink',
    'decoding.plugin.name' = 'pgoutput'
);

-- PROCESS --
INSERT INTO e_transfer_deposits_cdc SELECT * FROM e_transfer_deposits;