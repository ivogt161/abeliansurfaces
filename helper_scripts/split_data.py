"""split_data.py

This python script takes an input data file of labels and data for genus 2
curves, and outputs that same data into several smaller files into a specified
directory. This is a helper script to allow for parallel running of our code.

"""

import pathlib
import pandas as pd

OUTPUT_DIR = pathlib.Path(__file__).parent.parent.absolute() / "data/curve_data_may_23"
pathlib.Path(OUTPUT_DIR).mkdir(parents=True, exist_ok=True)
from data.curve_data.g2c_curves_all import labels, data

df = pd.DataFrame(zip(labels, data), columns=["labels", "data"])

B = 200  # how many rows to add to each child datafile

num_files_tracker = 0

while (num_files_tracker * B < df.shape[0]):
    left_index = int(num_files_tracker * B)
    right_index = int((num_files_tracker + 1) * B)
    this_file_name = f"g2c_curves_{left_index}_{right_index}.csv"
    this_file_name = OUTPUT_DIR / this_file_name
    df.iloc[left_index:right_index].to_csv(this_file_name, index=False)
    num_files_tracker += 1
