import ast

load('nonmaximal.sage')
load('find_surj_from_list.sage')

TEST_DATA = 'test_data.csv'


def unpack_nonmaximal_primes(x):

    actual_nonmaximal_primes = ast.literal_eval(x)

    if actual_nonmaximal_primes == {}:
        actual_nonmaximal_primes = set()

    return actual_nonmaximal_primes

def run_code_on_tests(row, path_to_datafile=None):
    """Runs our code'"""
    row['data'] = ast.literal_eval(row['data'])
    C = HyperellipticCurve(R(row['data'][0]), R(row['data'][1]))
    print(C)
    conductor_of_C = Integer(row['conductor'])
    possibly_nonmaximal_primes = find_nonmaximal_primes(C, conductor_of_C, path_to_datafile=path_to_datafile)
    probably_nonmaximal_primes = is_surj(C, L=list(possibly_nonmaximal_primes))
    return possibly_nonmaximal_primes, probably_nonmaximal_primes

df = pd.read_csv(TEST_DATA)
df['nonmaximal_primes'] = df['nonmaximal_primes'].apply(unpack_nonmaximal_primes)
df[['possibly_nonmaximal_primes','probably_nonmaximal_primes']] = df.apply(run_code_on_tests, axis=int(1), path_to_datafile=PATH_TO_MY_TABLE, result_type="expand")
df['pass'] = df['probably_nonmaximal_primes'] == df['nonmaximal_primes']

if all(df['pass']) == True:
    print("All tests passed. HURRAH!")
else:
    df_bad = df.loc[df['pass'] == False]
    FAILED_TESTS = 'failed_tests.csv'
    df_bad.to_csv(FAILED_TESTS, index=False)
    print("Some tests failed. These have been output to {}".format(FAILED_TESTS))



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