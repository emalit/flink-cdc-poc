from pathlib import Path
import pandas as pd

CDC_OUTPUT_DIR = 'setup_scripts/flink-output-files/default.db/e_transfer_deposits_cdc/bucket-0'

def read_parquet_files(dirpath):
    data_dir = Path(dirpath)
    full_df = pd.concat(
        pd.read_parquet(parquet_file)
        for parquet_file in data_dir.glob("*.parquet")
    )
    print(full_df.sort_values('_SEQUENCE_NUMBER'))


if __name__ == "__main__":
    read_parquet_files(CDC_OUTPUT_DIR)
