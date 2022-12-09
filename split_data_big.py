"""split_data_big.py

The splitting into smaller chunks script, but for Drew's larger dataset.

"""

import pathlib
import pandas as pd

OUTPUT_DIR = pathlib.Path(__file__).parent.absolute() / "data"
path_to_datafile = "st2e20.txt"

df = pd.read_csv(
    path_to_datafile,
    sep=":",
    header=None,
    names=["disc", "cond", "hash", "data", "rank", "lpolys", "stgroup"],
    usecols=["disc", "cond", "data", "stgroup"],
)
df_generic = df.loc[df["stgroup"] == "USp(4)"].copy()
df_generic.sort_values(by=["cond"], inplace=True)

B = 200  # how many rows to add to each child datafile


num_files_tracker = 0


while (num_files_tracker * B < df.shape[0]):
    left_index = int(num_files_tracker * B)
    right_index = int((num_files_tracker + 1) * B)
    this_file_name = f"g2c_curves_{left_index}_{right_index}.csv"
    this_file_name = OUTPUT_DIR / this_file_name
    df_generic.iloc[left_index:right_index].to_csv(
        this_file_name, index=False, columns=["cond", "disc", "data"]
    )
    num_files_tracker += 1
