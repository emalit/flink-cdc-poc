DROP TABLE IF EXISTS e_transfer_deposits;
CREATE TABLE e_transfer_deposits(
    canonical_id VARCHAR NOT NULL PRIMARY KEY,
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
ALTER TABLE public.e_transfer_deposits REPLICA IDENTITY FULL;