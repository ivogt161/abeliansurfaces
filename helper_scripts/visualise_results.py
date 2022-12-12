"""visualise_results.py

This script takes the results file, does some stuff on it, and outputs
five graphs in the 'results' folder:

1. 'hist_nonmaximal_prime_count': A histogram showing how many curves had
    0,1,2 or 3 nonmaximal primes;

2. 'bar_nonmaximal_prime_dist': A bar chart showing how many curves were
    nonmaximal at each prime that arose;

3. 'bar_stacked_nonmaximal_prime_dist_torsion': As in (2), but stacked according
    to whether the curve is nonmaximal at p because it is a torsion prime;

4. 'bar_stacked_nonmaximal_prime_dist_types': As in (2), but stacked according
    to the type of the prime in the nonmaximal classification. Since some primes
    were assigned multiple types, fractional counts were assigned (so, e.g.
    '2.nss.cusp.irred' would contribute 1/3 each to 'nss', 'cusp', 'irred').

5. 'bar_stacked_witnesses': Stacked bar chart showing which of the three witness
    tests were used to conclude that that prime is indeed nonmaximal. Since for
    some primes there were multiple witnesses (e.g. '7.irred:wit=[0,5,0]'),
    fractional counts were again assigned (in this case, 1/2 each to 'surj_test_A'
    and 'surj_test_exp').

Each of the five graphs will be shown on screen (one at a time), and won't be
saved until you close it.

To run this script, run the command 'python visualise_results.py' from the
abeliansurfaces directory.

Notes:

1. This assumes you have python 3. If you have both, try
   'python3 visualise_results.csv'

2. This script checks to see if the results directory exists, and if not, creates
   it. As such, you need write permission to your copy of the abeliansurfaces
   directory (or - not recommended - run this script as sudo).

"""

# Imports

import pandas as pd
import ast
import matplotlib
matplotlib.use('TkAgg')
import matplotlib.pyplot as plt
from collections import Counter
from itertools import chain
import pathlib


# Globals

RESULTS_PATH = "./output/results_big_corrected_torsion.csv"
PRIME_TYPES = ["1p3", "2p2", "cusp", "irred", "?", "nss"]
WITNESS_TYPES = ["A", "B", "exp"]
RESULTS_DIR = pathlib.Path(__file__).parent.absolute() / "results"
# The following requires write permission to the abeliansurfaces folder
pathlib.Path(RESULTS_DIR).mkdir(parents=True, exist_ok=True)


def get_type_scores(verbose_output_str):
    """Computes the type score counter for each curve"""
    verbose_output_list = ast.literal_eval(verbose_output_str)

    type_score_dict = {
        k: {prime_type: 0 for prime_type in PRIME_TYPES}
        for k in nonmaximal_prime_dist["prime"]
    }

    for a_verbose_str in verbose_output_list:
        prime_and_types, _ = a_verbose_str.split(":")
        prime, types_info = prime_and_types.split(".", 1)
        prime = int(prime)
        types_info_split = types_info.split(".")
        num_different_types = len(types_info_split)
        for the_type in types_info_split:
            type_score_dict[prime][the_type] += 1 / num_different_types

    type_score_counter = {k: Counter(v) for k, v in type_score_dict.items()}

    return type_score_counter


def get_witness_scores(verbose_output_str):
    """Computes the witness score counter for each curve"""
    verbose_output_list = ast.literal_eval(verbose_output_str)

    witness_score_dict = {
        k: {wit_type: 0 for wit_type in WITNESS_TYPES}
        for k in nonmaximal_prime_dist["prime"]
        if k != 2
    }

    for a_verbose_str in verbose_output_list:
        prime = int(a_verbose_str.split(".", 1)[0])
        wit_array = ast.literal_eval(a_verbose_str.split("=")[1])
        if prime != 2:
            how_many_zeros = wit_array.count(0)
            wit_score_array = [(1 / how_many_zeros) * int(k == 0) for k in wit_array]
            if len(wit_array) == 3:
                witness_score_dict[prime]["A"] += wit_score_array[0]
                witness_score_dict[prime]["B"] += wit_score_array[1]
                witness_score_dict[prime]["exp"] += wit_score_array[2]
            elif len(wit_array) == 2:
                witness_score_dict[prime]["A"] += wit_score_array[0]
                witness_score_dict[prime]["B"] += wit_score_array[1]

    witness_score_counter = {k: Counter(v) for k, v in witness_score_dict.items()}

    return witness_score_counter


def autolabel(ax, rects):
    """Attach a text label above each bar displaying its height"""
    for rect in rects:
        height = rect.get_height()
        ax.text(
            rect.get_x() + rect.get_width() / 2.0,
            height * 1.01,
            "%d" % int(height),
            ha="center",
            va="bottom",
        )


def autolabel_stacked(ax, rects):
    """Attach a text label above each stack of bars showing its height"""
    # first get possible x values
    possible_x_values = set([r.get_x() for r in rects])
    a_width = rects[0].get_width()

    # now for each x_val, find rectangles with that x_val, get combined height,
    # and label with it
    for x_val in possible_x_values:
        heights_of_rects_with_this_x_val = [
            rect.get_height() for rect in rects if rect.get_x() == x_val
        ]
        combined_height = sum(heights_of_rects_with_this_x_val)
        ax.text(
            x_val + a_width / 2.0,
            combined_height * 1.01,
            "%d" % int(round(combined_height)),
            ha="center",
            va="bottom",
        )


def plot_hist_prime_count(df):
    """Plot how many curves had how many nonmaximal primes"""
    min_number_nonmax_primes = df["number_of_nonmaximal_primes"].min()
    max_number_nonmax_primes = df["number_of_nonmaximal_primes"].max()
    bins = [
        i - 0.5 for i in range(min_number_nonmax_primes, max_number_nonmax_primes + 2)
    ]
    fig, ax = plt.subplots(figsize=(12, 8))
    ax.set_xlabel("Number of nonmaximal primes")
    ax.set_ylabel("Number of curves")
    ax.set_title("How many curves had how many nonmaximal primes?")
    ax.set_xticks(range(min_number_nonmax_primes, max_number_nonmax_primes + 1))
    _, _, patches = ax.hist(
        df["number_of_nonmaximal_primes"],
        bins=bins,
        color="#17becf",
        edgecolor="red",
        lw=3.0,
    )
    autolabel(ax, patches)
    plt.savefig(RESULTS_DIR / 'hist_nonmaximal_prime_count.png', dpi=400)
    plt.show()


def plot_bar_nonmaximal_prime_dist(nonmaximal_prime_dist, primes_to_exclude=None):
    """Plot how many curves were nonmaximal at each prime"""
    fig, ax = plt.subplots(figsize=(12, 8))
    ax.set_xlabel("Prime")
    ax.set_ylabel("Number of curves")
    ax.set_title("How many curves were nonmaximal at each prime?")

    if primes_to_exclude:
        nonmaximal_prime_dist = (
            nonmaximal_prime_dist.loc[
                ~nonmaximal_prime_dist.prime.isin(primes_to_exclude)
            ]
            .reset_index(drop=True)
            .copy()
        )

    ax.set_xticks(nonmaximal_prime_dist["prime"])
    rects = ax.bar(
        x=nonmaximal_prime_dist["prime"],
        height=nonmaximal_prime_dist["f"],
        color="#17becf",
        edgecolor="red",
        lw=3.0,
    )
    autolabel(ax, rects)
    plt.savefig(RESULTS_DIR / 'bar_nonmaximal_prime_dist.png', dpi=400)
    plt.show()


def plot_bar_stacked_nonmaximal_prime_dist_torsion(
    nonmaximal_prime_dist, torsion_prime_dist, primes_to_exclude=None
):
    """
    Plot how many curves were nonmaximal at each prime, showing which of them
    are nonmaximal only because its a torsion prime
    """
    fig, ax = plt.subplots(figsize=(12, 8))
    ax.set_xlabel("Prime")
    ax.set_ylabel("Number of curves")
    ax.set_title("How many curves were nonmaximal at each prime due to torsion?")

    if primes_to_exclude:
        nonmaximal_prime_dist = (
            nonmaximal_prime_dist.loc[
                ~nonmaximal_prime_dist.prime.isin(primes_to_exclude)
            ]
            .reset_index(drop=True)
            .copy()
        )
        torsion_prime_dist = (
            torsion_prime_dist.loc[~torsion_prime_dist.prime.isin(primes_to_exclude)]
            .reset_index(drop=True)
            .copy()
        )

    ax.set_xticks(nonmaximal_prime_dist["prime"])
    rects = ax.bar(
        x=nonmaximal_prime_dist["prime"],
        height=nonmaximal_prime_dist["f"],
        color="#17becf",
        edgecolor="red",
        lw=3.0,
    )
    rects_torsion = ax.bar(
        x=torsion_prime_dist["prime"],
        height=torsion_prime_dist["f"],
        color="green",
        edgecolor="red",
        lw=3.0,
    )
    autolabel(ax, rects)
    ax.legend((rects[0], rects_torsion[0]), ('non torsion', 'torsion'))
    plt.savefig(RESULTS_DIR / 'bar_stacked_nonmaximal_prime_dist_torsion.png', dpi=400)
    plt.show()


def plot_bar_stacked_nonmaximal_prime_dist_types(stacked_df):
    """
    Plot how many curves were nonmaximal at each prime, showing which of them
    are nonmaximal due to it being of a certain type
    """
    fig, ax = plt.subplots(figsize=(12, 8))
    ax.set_xlabel("Prime")
    ax.set_ylabel("Number of curves")
    ax.set_title("Which nonmaximal prime types did we see?")
    ax.set_xticks(nonmaximal_prime_dist["prime"])
    rects = stacked_df.plot.bar(stacked=True, ax=ax)
    autolabel_stacked(ax, rects.patches)
    plt.savefig(RESULTS_DIR / 'bar_stacked_nonmaximal_prime_dist_types.png', dpi=400)
    plt.show()


def plot_bar_stacked_witnesses(witness_stacked_df):
    """Plot showing which witness results were used"""

    # Dark mode graphs!!! Awesome!!!
    plt.style.use("dark_background")

    fig, ax = plt.subplots(figsize=(12, 8))
    ax.set_xlabel("Prime")
    ax.set_ylabel("Number of curves")
    ax.set_title("Which witness results were used?")
    ax.set_xticks(nonmaximal_prime_dist["prime"])
    rects = witness_stacked_df.plot.bar(stacked=True, ax=ax)
    autolabel_stacked(ax, rects.patches)
    plt.savefig(RESULTS_DIR / 'bar_stacked_witnesses.png', dpi=400)
    plt.show()


if __name__ == "__main__":

    print("Reading Data ...")

    df = pd.read_csv(RESULTS_PATH)

    print(
        "Done. Processing verbose results. Shouldn't be more than a minute or two ..."
    )

    df["probably_nonmaximal_primes"] = df.probably_nonmaximal_primes.apply(
        ast.literal_eval
    )
    df["number_of_nonmaximal_primes"] = df.probably_nonmaximal_primes.apply(len)
    nonmaximal_prime_dist = (
        pd.Series(Counter(chain(*df.probably_nonmaximal_primes)))
        .sort_index()
        .rename_axis("prime")
        .reset_index(name="f")
    )

    df["torsion_primes"] = df["torsion_primes"].str.replace("{}", "set()")
    df["torsion_primes"] = df["torsion_primes"].apply(eval)
    df["probably_nonmaximal_primes"] = df.probably_nonmaximal_primes.apply(set)

    df["nontorsion_nonmaximal_primes"] = df["probably_nonmaximal_primes"] - df[
        "torsion_primes"
    ].apply(set)

    torsion_prime_dist = (
        pd.Series(Counter(chain(*df.torsion_primes)))
        .sort_index()
        .rename_axis("prime")
        .reset_index(name="f")
    )
    nontorsion_nonmaximal_prime_dist = (
        pd.Series(Counter(chain(*df.nontorsion_nonmaximal_primes)))
        .sort_index()
        .rename_axis("prime")
        .reset_index(name="f")
    )

    print(f"nonmaximal_prime_dist = {nonmaximal_prime_dist}\ntorsion_prime_dist = {torsion_prime_dist}\nnontorsion_nonmaximal_prime_dist = {nontorsion_nonmaximal_prime_dist}")

    df["type_scores"] = df.verbose_output.apply(get_type_scores)
    df["witness_scores"] = df.verbose_output.apply(get_witness_scores)

    add_them = {
        k: sum([that_counter[k] for that_counter in df["type_scores"]], Counter())
        for k in nonmaximal_prime_dist["prime"]
    }
    add_witnesses = {
        k: sum([that_counter[k] for that_counter in df["witness_scores"]], Counter())
        for k in nonmaximal_prime_dist["prime"]
        if k != 2
    }

    stacked_df = pd.DataFrame.from_dict(add_them, orient="index").fillna(0.0)
    witness_stacked_df = pd.DataFrame.from_dict(add_witnesses, orient="index").fillna(
        0.0
    )

    print("Done. Plotting...")

    plot_hist_prime_count(df)
    plot_bar_nonmaximal_prime_dist(nonmaximal_prime_dist, primes_to_exclude=[2])
    plot_bar_stacked_nonmaximal_prime_dist_torsion(
        nonmaximal_prime_dist, torsion_prime_dist)
    plot_bar_stacked_nonmaximal_prime_dist_types(stacked_df)
    plot_bar_stacked_witnesses(witness_stacked_df)

    print("Done :)")
