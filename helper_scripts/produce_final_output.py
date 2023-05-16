"""produce_final_output.py

To run this script in parallel, get the broken down data files into the
data directory, and then from the top directory, run

find ./torsion_data_out -type f | parallel -j64 "python3 helper_scripts/produce_final_output.py {}"

This is a hacky script to combine data from different tables; it arose because
torsion prime data was missing, so had to be computed separately and added
to the output. 

"""

import pandas as pd
import argparse
import pathlib
def do_work(filename):

    df_torsion = pd.read_csv(filename)
    thing = pathlib.Path(filename.name).name
    thing = thing.split("_",2)[2]
    thing = thing.split(".")[0]
    output_filename = "/home/barinder/abeliansurfaces/output/" + thing + "_output.csv"
    df_output = pd.read_csv(output_filename)

    # this adds in the torsion data
    df_output['torsion_primes'] = df_torsion['torsion_primes']
    
    final_output_filename = "/home/barinder/abeliansurfaces/final_output/" + thing + "_output.csv"
    df_output.to_csv(final_output_filename, index=False)



def cli_handler(args):
    do_work(args.filename)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "filename",
        metavar="filename",
        type=argparse.FileType("r"),
        help="filename on which to execute the code",
    )
    args = parser.parse_args()
    cli_handler(args)