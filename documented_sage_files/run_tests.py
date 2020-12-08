r"""

TODO one-line description.

TODO longer description.

EXAMPLES::

TODO

AUTHORS:

- TODO (2020-10-30): initial version

- person (date in ISO year-month-day format): short desc

"""

# ****************************************************************************
#       Copyright (C) 2020 YOUR NAME <your email>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#                  https://www.gnu.org/licenses/
# ****************************************************************************
import ast
import logging
logging.basicConfig(format='%(asctime)s %(levelname)s: %(message)s',
                    datefmt='%H:%M:%S',
                    filename='drew_5_and_7_2910.log', level=logging.DEBUG)

logger = logging.getLogger(__name__)

load('nonmaximal.sage')
load('find_surj_from_list.sage')

TEST_DATA = 'test_data.csv'
DREW_5_OUTPUT = 'drew_5_results.csv'
DREW_7_OUTPUT = 'drew_7_results.csv'


def unpack_nonmaximal_primes(x):
    r"""TODO add one-sentence description.

    TODO add longer description.

    INPUT:

    - ``x`` -- TODO type; TODO add description

    OUTPUT:

    TODO

    EXAMPLES::

        TODO
    """
    actual_nonmaximal_primes = ast.literal_eval(x)

    if actual_nonmaximal_primes == {}:
        actual_nonmaximal_primes = set()

    return actual_nonmaximal_primes


def run_code_on_tests(row, path_to_datafile=None):
    r"""Run our code.

    TODO add longer description.

    INPUT:

    - ``x`` -- TODO type; TODO add description

    OUTPUT:

    TODO

    EXAMPLES::

        TODO
    """
    row['data'] = ast.literal_eval(row['data'])
    C = HyperellipticCurve(R(row['data'][0]), R(row['data'][1]))
    print(C)
    conductor_of_C = Integer(row['conductor'])
    possibly_nonmaximal_primes = find_nonmaximal_primes(
                                C, conductor_of_C, 
                                path_to_datafile=path_to_datafile)
    probably_nonmaximal_primes \
        = is_surjective(C, L=list(possibly_nonmaximal_primes))
    return possibly_nonmaximal_primes, probably_nonmaximal_primes

# df = pd.read_csv(TEST_DATA)
# df['nonmaximal_primes'] = df['nonmaximal_primes'].apply(unpack_nonmaximal_primes)
# df[['possibly_nonmaximal_primes','probably_nonmaximal_primes']] = df.apply(run_code_on_tests, axis=int(1), path_to_datafile=PATH_TO_MY_TABLE, result_type="expand")
# df['pass'] = df['probably_nonmaximal_primes'] == df['nonmaximal_primes']

# if all(df['pass']) == True:
#     print("All tests passed. HURRAH!")
# else:
#     df_bad = df.loc[df['pass'] == False]
#     FAILED_TESTS = 'failed_tests.csv'
#     df_bad.to_csv(FAILED_TESTS, index=False)
#     print("Some tests failed. These have been output to {}".format(FAILED_TESTS))


def nonmaximal_wrapper_for_drew_tests(row, prime_to_check):
    r"""Pandas wrapper of ``find_nonmaximal_primes`` and ``is_surjective``.

    TODO add longer description.

    INPUT:

    - ``row`` -- integer; TODO add description

    - ``prime_to_check`` -- prime integer; TODO add description

    OUTPUT:

    TODO

    EXAMPLES::

        TODO
    """
    try:
        C = HyperellipticCurve(R(row['data'][0]), R(row['data'][1]))
        conductor_of_C = Integer(row['conductor'])
        logger.info("Doing curve of conductor {}".format(conductor_of_C))
        # possibly_nonmaximal_primes = 
        # find_nonmaximal_primes(C, N=conductor_of_C, 
        # path_to_datafile=path_to_datafile)
        probably_nonmaximal_primes = is_surjective(C, L=[prime_to_check])
        return probably_nonmaximal_primes
    except Exception as err:
        logger.critical(err)
        logger.critical("Failed at conductor {}; entries are {} and {}"
                        .format(Integer(row['conductor']),
                                row['data'][0].list(), row['data'][1].list()))
        raise


# TODO: we should make this (weakly) private.
def eval_string(w):
    r"""TODO add one-sentence description.

    TODO add longer description.

    INPUT:

    - ``w`` -- TODO type; TODO add description

    OUTPUT:

    TODO

    EXAMPLES::

        TODO
    """
    return eval(w)


def run_drew_5():
    r"""TODO add one-sentence description.

    TODO add longer description.

    OUTPUT:

    TODO

    EXAMPLES::

        TODO
    """

    df = pd.read_csv("g2_generic_mod5_nonsurjective.txt", sep=':', names=['conductor','data'])
    # df = df.iloc[int(3862):].copy()
    # df = df.iloc[:int(3)].copy()

    df["data"] = df["data"].str.replace('^','**')
    df["data"] = df["data"].apply(eval_string)

    df['probably_nonmaximal_primes'] = df.apply(nonmaximal_wrapper_for_drew_tests, axis=int(1), prime_to_check=5)
    df['nonmaximal_5'] = df['probably_nonmaximal_primes'].apply(lambda x : True if 5 in x else False)

    no_curves_nonmaximal_5 = df['nonmaximal_5'].sum()
    total_curves = df.shape[0]

    percent_curves_nonmaximal_5 = round(100*RR(no_curves_nonmaximal_5/total_curves))
    print("{}% of the curves are nonmaximal at 5".format(percent_curves_nonmaximal_5))

    # We now output the csv results file
    df.to_csv(DREW_5_OUTPUT, index=False)
    print("The results output to {}".format(DREW_5_OUTPUT))


def run_drew_7():
    r"""TODO add one-sentence description.

    TODO add longer description.

    OUTPUT:

    TODO

    EXAMPLES::

        TODO
    """
    df = pd.read_csv("g2_generic_mod7_nonsurjective.txt", sep=':', names=['conductor','data'])
    # df = df.iloc[:int(3)].copy()

    df["data"] = df["data"].str.replace('^','**')
    df["data"] = df["data"].apply(eval_string)

    df['probably_nonmaximal_primes'] = df.apply(nonmaximal_wrapper_for_drew_tests, axis=int(1), prime_to_check=7)
    df['nonmaximal_7'] = df['probably_nonmaximal_primes'].apply(lambda x : True if 7 in x else False)

    no_curves_nonmaximal_7 = df['nonmaximal_7'].sum()
    total_curves = df.shape[0]

    percent_curves_nonmaximal_7 = round(100*RR(no_curves_nonmaximal_7/total_curves))
    print("{}% of the curves are nonmaximal at 7".format(percent_curves_nonmaximal_7))

    # We now output the csv results file
    df.to_csv(DREW_7_OUTPUT, index=False)
    print("The results output to {}".format(DREW_7_OUTPUT))

# To run the Drew tests, uncomment the following; takes a long time

logger.info("Starting Drew 5 tests...")
run_drew_5()
logger.info("Starting Drew 7 tests...")
run_drew_7()


# #must have files nonmaximal.sage, test_ell.sage, and g2c_curves_list.sage
# #loaded in the sage terminal to run this

# #curves = make_data()

# R.<x> = PolynomialRing(QQ)
# C = HyperellipticCurve(R([2, 1, -9, -5, 6, 5]), R([1, 1, 1]))
# N = 6075

# #for C, N, label in curves:
# pot_non_surj = find_nonmaximal_primes(C, N,coeff_table = 'gamma0_wt2_hecke_lpolys_1000.txt')
# print pot_non_surj
# non_surj = is_surj(C, pot_non_surj)
# print non_surj

# #    g = open("surj_data.txt", "a")
# #    g.write(label + ":" + str(list(pot_non_surj)) + ":" + str(non_surj) + "\n")
# #    g.close()
