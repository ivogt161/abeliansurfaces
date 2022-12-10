"""nonmaximal.py

This is the top level function used to run the algorithm on lots of curves.

To run this script in parallel, get the broken down data files into the
data directory, and then from the top directory, run

find ./data -type f | parallel "sage nonmaximal.py {} --scheme lmfdb --logfile lmfdb_2022_12_01.log"


"""

# Imports
from sage.all import (
    sum,
    PolynomialRing,
    Rationals,
    QQ,
    ZZ,
    load,
    Integer,
    Integers,
    primes,
    HyperellipticCurve,
    divisors,
    sqrt,
    radical,
    DirichletGroup,
    prime_factors,
    next_prime,
    floor,
    valuation,
    gcd,
    lcm,
    FiniteField,
    prod,
    genus2reduction,
    Zmod,
    GF,
)
import argparse
import ast
import pandas as pd
import pathlib
import logging

# The following lines import the main algorithm from the sage files
load("find_surj_from_list.sage")
load("nonmaximal.sage")

OUTPUT_DIR = pathlib.Path(__file__).parent.absolute() / "output"


def format_verbose_column(type_dict, wit_dict):

    surj_primes_verbose = []

    for k in wit_dict:
        if -1 in wit_dict[k] or 0 in wit_dict[k]:
            surj_primes_verbose.append((k, type_dict[k], wit_dict[k]))

    return [k for k, v, wit in surj_primes_verbose], [
        "{}.{}:wit={}".format(str(k), v, wit) for k, v, wit in surj_primes_verbose
    ]


def nonmaximal_wrapper_lmfdb(row, path_to_datafile=None):
    """Pandas wrapper of 'find_nonmaximal_primes' and 'is_surjective'"""
    logging.info("Starting curve of label {}".format(row["labels"]))
    C = HyperellipticCurve(R(row["data"][0]), R(row["data"][1]))
    conductor_of_C = Integer(row["labels"].split(".")[0])
            
    f, h = C.hyperelliptic_polynomials()
    red_data = genus2reduction(h, f)
    poor_cond = 2 * prod(genus2reduction(h,f).local_data.keys())

    try:
        possibly_nonmaximal_primes_verbose = find_nonmaximal_primes(
            C, poor_cond, N=conductor_of_C, path_to_datafile=path_to_datafile
        )
        possibly_nonmaximal_primes = set(possibly_nonmaximal_primes_verbose.keys())
        probably_nonmaximal_primes_verbose = is_surjective(
            C, poor_cond, L=list(possibly_nonmaximal_primes), verbose=True
        )
        probably_nonmaximal_primes, final_verbose_column = format_verbose_column(
            possibly_nonmaximal_primes_verbose, probably_nonmaximal_primes_verbose
        )
    except RuntimeError as e:
        logging.warning(f"Curve {row['labels']} failed because: {str(e)}")
        possibly_nonmaximal_primes = {0}
        probably_nonmaximal_primes = []
        final_verbose_column = []

    return possibly_nonmaximal_primes, probably_nonmaximal_primes, final_verbose_column


def nonmaximal_wrapper_new(row, path_to_datafile=None):
    """Pandas wrapper of 'find_nonmaximal_primes' and 'is_surjective'"""
    logging.info("Starting curve of cond.disc {}.{}".format(row["cond"], row["disc"]))
    C = HyperellipticCurve(R(row["data"][0]), R(row["data"][1]))
    conductor_of_C = Integer(row["cond"])
    f, h = C.hyperelliptic_polynomials()
    red_data = genus2reduction(h, f)
    poor_cond = 2 * prod(genus2reduction(h,f).local_data.keys())

    try:
        possibly_nonmaximal_primes_verbose = find_nonmaximal_primes(
            C, poor_cond, N=conductor_of_C, path_to_datafile=path_to_datafile
        )
        possibly_nonmaximal_primes = set(possibly_nonmaximal_primes_verbose.keys())
        probably_nonmaximal_primes_verbose = is_surjective(
            C, poor_cond, L=list(possibly_nonmaximal_primes), verbose=True
        )
        probably_nonmaximal_primes, final_verbose_column = format_verbose_column(
            possibly_nonmaximal_primes_verbose, probably_nonmaximal_primes_verbose
        )
    except RuntimeError as e:
        logging.warning(f"Curve {row['labels']} failed because: {str(e)}")
        possibly_nonmaximal_primes = {0}
        probably_nonmaximal_primes = []
        final_verbose_column = []

    return possibly_nonmaximal_primes, probably_nonmaximal_primes, final_verbose_column


def get_many_results(filename, scheme, subset=None):
    """Main calling function. Outputs a csv file of the results.

    Args:
        subset ([int], optional): Returns results only on a subset of the data.
                                Set this to a small number (e.g. 5 or 10) to
                                get quick results on a few curves. Defaults to
                                None (meaning the whole dataset).
    """

    df = pd.read_csv(filename)

    df["data"] = df["data"].apply(ast.literal_eval)

    if subset is not None:
        df = df.head(int(subset)).copy()
        print(
            "Running on the first {} LMFDB genus 2 curves which are absolutely simple...(will take about {} seconds)...".format(
                subset, subset * 3
            )
        )
        logging.info(
            "Running on the first {} LMFDB genus 2 curves which are absolutely simple...(will take about {} seconds)...".format(
                subset, subset * 3
            )
        )
    else:
        print(
            "Running on curves in your file. Check the logfile for progress..."
        )
        logging.info(
            "Running on curves in your file."
        )

    # The following block runs the above code on all curves in the dataframe
    if scheme == "lmfdb":
        df[
            [
                "possibly_nonmaximal_primes",
                "probably_nonmaximal_primes",
                "verbose_output",
            ]
        ] = df.apply(
            nonmaximal_wrapper_lmfdb,
            axis=int(1),
            path_to_datafile=PATH_TO_MY_TABLE,
            result_type="expand",
        )

        # It may be useful to know the primes where the Jacobian has rational torsion.
        # This has been computed in Magma elsewhere. Since not everyone has access to
        # Magma, this data has been saved in the file 'torsion_primes.csv'.

        df_torsion = pd.read_csv("data/torsion_primes.csv")
        df = pd.merge(df, df_torsion, how="left", on="labels")

    else:
        df[
            [
                "possibly_nonmaximal_primes",
                "probably_nonmaximal_primes",
                "verbose_output",
            ]
        ] = df.apply(
            nonmaximal_wrapper_new,
            axis=int(1),
            path_to_datafile=PATH_TO_MY_TABLE,
            result_type="expand",
        )

    df.rename(columns={"data": "polynomials"}, inplace=True)

    # We now output the csv results file

    output_file = pathlib.Path(filename.name).name.split(".")[0] + "_output.csv"
    output_file = OUTPUT_DIR / output_file
    df.to_csv(output_file, index=False)
    print("The results output to {}".format(output_file))
    logging.info("The results output to {}".format(output_file))


def cli_handler(args):
    loglevel = logging.DEBUG if args.verbose else logging.INFO
    logging.basicConfig(
        format="%(asctime)s %(levelname)s: %(message)s",
        datefmt="%H:%M:%S",
        filename="./log_files/" + args.logfile,
        level=loglevel,
    )
    get_many_results(args.filename, args.scheme)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "filename",
        metavar="filename",
        type=argparse.FileType("r"),
        help="filename on which to execute the code",
    )
    parser.add_argument(
        "--scheme",
        type=str,
        choices=["lmfdb", "new"],
        default="lmfdb",
        help="whether running on LMFDB dataset or Drew's bigger and newer data",
    )
    parser.add_argument(
        "--logfile",
        type=str,
        default="logs.log",
        help="the file to which logs get output",
    )
    parser.add_argument("--verbose", action="store_true", help="get more info printed")
    args = parser.parse_args()
    cli_handler(args)
