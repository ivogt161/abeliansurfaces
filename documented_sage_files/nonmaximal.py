r"""

Determines the finite set of primes for which the Galois action is nonmaximal.

Given a genus 2 curve `C: y^2 + h(x)*y = f(x)`, determines the finite set of
primes `l` for which the Galois action on `J_C[l]` is nonmaximal. The Code is
organized according to maximal subgroups of GSp_4.

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
import pandas as pd
import string
import logging
logging.basicConfig(
    format='%(asctime)s %(levelname)s: %(message)s',
    datefmt='%H:%M:%S',
    filename='all_curves_3010.log', level=logging.DEBUG
)

logger = logging.getLogger(__name__)

# Globals

R.<x> = PolynomialRing(QQ)
x = R.gen()

# In order for the following file to be found, it is assumed that the cwd is
# the top directory of abeliansurfaces. This should be the case if you're
# loading this file into sage. If there's any problem, making the
# following path absolute should resolve the issue.

PATH_TO_MY_TABLE = 'gamma0_wt2_hecke_lpolys_1000.txt'
OUTPUT_FILE = "g2c_results_verbose.csv"

#########################################################
#                            #
#                   Auxiliary functions            #
#                            #
#########################################################


def p_part(p, N):
    r"""
    Return the `p`-part of the integer `N`.

    INPUT:

    - ``p`` -- a prime integer.

    - ``N`` -- An integer

    OUTPUT: the largest power of `p` dividing `N`.

    EXAMPLES::

        TODO
    """
    if N != 0:
        return p^valuation(N, p)
    else:
        return 1


def poor_mans_conductor(C):
    r"""
    Return the conductor of a genus `2` hyperelliptic curve up to a factor of
    `2`.

    INPUT:

    - ``C`` -- HyperellipticCurve object; over `\QQ` and of genus `2`.

    OUTPUT:

    An integer of the form `2^n \cdot \text{Cond}(C)` for some integer `n`,
    where `\text{Cond}(C)` is the true conductor of `C`.

    EXAMPLES::

        TODO
    """
    f, h = C.hyperelliptic_polynomials()
    red_data = genus2reduction(h, f)
    N = red_data.conductor
    if red_data.prime_to_2_conductor_only:
        N = 2*N
    return N


def maximal_square_divisor(N):
    r"""
    Return the maximal square divisor of `N`.

    INPUT:

    - ``N`` -- integer.

    EXAMPLES::

        TODO
    """
    PP = prime_factors(N)
    n = 1
    for p in PP:
        n = n * p^(floor(valuation(N, p)/2))

    return n


def true_conductor(C):
    r"""
    Return the true conductor of a genus `2` hyperelliptic curve.

    INPUT:

    - ``C`` -- HyperellipticCurve object; over `\QQ` and of genus `2`.

    OUTPUT: The conductor `\text{Cond}(C)` of `C`.

    EXAMPLES::

        TODO

    .. WARNING::

        Not implemented.

    .. TODO::

        Implement
    """
    print(
        "Warning. This hasn't yet been implemented.",
        "The return value isn't actually the conductor."
    )
    return poor_mans_conductor(C)


def update_verbose_results(dict_to_update, new_keys, value_str):
    r"""
    TODO one-sentence description

    INPUT:

    - ``dict_to_update`` -- dictionary; TODO describe.

    - ``new_keys`` -- TODO object type; TODO describe.

    - ``value_str`` -- TODO object type; TODO describe.

    OUTPUT: An updated version of ``dict_to_update``.

    EXAMPLES::

        TODO

    """
    if new_keys:
        for k in new_keys:
            if k in dict_to_update:
                dict_to_update[k] += '.{}'.format(value_str)
            else:
                dict_to_update[k] = value_str
    return dict_to_update


def format_verbose_column(type_dict, wit_dict):
    r"""
    TODO one-sentence description

    INPUT:

    - ``type_dict`` -- dictionary; TODO describe.

    - ``wit_dict`` -- dictionary; TODO describe.

    OUTPUT: TODO describe.

    EXAMPLES::

        TODO

    """
    surj_primes_verbose = []

    for k in wit_dict:
        if -1 in wit_dict[k] or 0 in wit_dict[k]:
            surj_primes_verbose.append((k, type_dict[k], wit_dict[k]))

    return [k for k, v, wit in surj_primes_verbose],
    ['{}.{}:wit={}'.format(str(k), v, wit)
        for k, v, wit in surj_primes_verbose]


#########################################################
#                            #
#          Governed by a quadratic character        #
#                            #
#########################################################


def maximal_quadratic_conductor(N):
    r"""
    TODO one-sentence description

    INPUT:

    - ``N`` -- integer

    OUTPUT: TODO describe

    EXAMPLES::

        TODO

    """
    if N % 2 == 0:
        return 4*radical(N)
    else:
        return radical(N)


def character_list(N):
    r"""
    TODO one-sentence description

    INPUT:

    - ``N`` -- integer

    OUTPUT: An updated version of ``dict_to_update``.

    EXAMPLES::

        TODO

    """
    c = maximal_quadratic_conductor(N)
    D = DirichletGroup(c, base_ring=QQ, zeta_order=2)
    return [phi for phi in D if phi.conductor() != 1]


def set_up_quadratic_chars(N):
    r"""
    TODO one-sentence description

    INPUT:

    - ``N`` -- integer

    OUTPUT: TODO describe

    EXAMPLES::

        TODO

    """
    return [(phi, 0, 0) for phi in character_list(N)]


def rule_out_quadratic_ell_via_Frob_p(p, fp, MM):
    r"""
    TODO one-sentence description

    INPUT:

    - ``p`` -- integer; new prime.

    - ``fp`` -- integer polynomial; characteristic polynomial of frobenius
      at `p` on a hyperelliptic curve.

    - ``MM`` -- list; of the form ``[phi, M, y]``, where

      - ``phi`` is a non-trivial quadratic character,
      - ``M`` is an integer such that all primes `\ell` for which
        there is a quadratic obstruction associated with ``phi`` must divide
        ``M``.
      - ``y`` is a counter for the number of nontrivial Frobenius constraints
        going into ``M``.

    OUTPUT: A list which TODO add description.

    EXAMPLES::

        TODO

    """
    ap = -fp.coefficients(sparse=false)[3]
    if ap == 0:
        return MM
    else:
        MM0 = []
        for phi, M, y in MM:
            if (M == 1 or phi(p) != -1 or y > 1):
                MM0.append((phi, M, y))
            else:
                MM0.append((phi, gcd(M, p*ap), y+1))

#        MM0 = [(phi,M/(p_part(2,M)*p_part(3,M)), y) for phi,M,y in MM0]
        return MM0


#########################################################
#                            #
#             Reducible (easy cases)            #
#                            #
#########################################################

# This should probably be update with the GCD of the return value and 120
def compute_f_from_d(d, p):
    r"""
    TODO one-sentence description

    INPUT:

    - ``d`` -- integer;

    - ``p`` -- prime integer;

    OUTPUT: TODO add description

    EXAMPLES::

        TODO

    """
    return Integers(d)(p).multiplicative_order()


def rule_out_one_dim_ell(p, fp, d, M):
    # Zev's direct implementation of what is in Dieulefait SS 3.1 and 3.2.
    r"""
    TODO one-sentence description

    INPUT:

    - ``p`` -- integer; TODO add description.

    - ``fp`` -- integer polynomial; TODO add description.

    - ``d`` -- TODO object type; TODO add description.

    - ``M`` -- TODO object type; TODO add description.

    OUTPUT: TODO

    EXAMPLES::

        TODO

    .. WARNING::

        There are some bugs here because the conductor used here has
        incorrect factors of `2`.

    REFERENCES:

    TODO make a master bibliography file.

    For more information, see [Die2004]_, 3.1 and 3.2

    """
    if M != 1:
        f = compute_f_from_d(d, p)
        x = fp.variables()[0]
        M = gcd(M, p*fp.resultant(x^f-1))
    return M


def rule_out_related_two_dim_ell_case1(p, fp, d, M):
    r"""
    TODO one-sentence description

    INPUT:

    - ``p`` -- integer; TODO add description.

    - ``fp`` -- integer polynomial; TODO add description.

    - ``d`` -- TODO object type; TODO add description.

    - ``M`` -- TODO object type; TODO add description.

    OUTPUT: TODO

    EXAMPLES::

        TODO

    """
    if M != 1:
        f = compute_f_from_d(d, p)
        ap = -fp.coefficients(sparse=false)[3]
        bp = fp.coefficients(sparse=false)[2]
        x = fp.variables()[0]

        Q = (x*bp-1-p^2*x^2)*(p*x + 1)^2 - ap^2*p*x^2
        M = gcd(M, p*Q.resultant(x^f-1))
    return M


def rule_out_related_two_dim_ell_case2(p, fp, d, M):
    r"""
    TODO one-sentence description

    INPUT:

    - ``p`` -- integer; TODO add description.

    - ``fp`` -- integer polynomial; TODO add description.

    - ``d`` -- TODO object type; TODO add description.

    - ``M`` -- TODO object type; TODO add description.

    OUTPUT: TODO

    EXAMPLES::

        TODO

    """
    if M != 1:
        f = compute_f_from_d(d, p)
        ap = -fp.coefficients(sparse=false)[3]
        bp = fp.coefficients(sparse=false)[2]
        x = fp.variables()[0]

        Q = (x*bp-p-p*x^2)*(x + 1)^2 - ap^2*x^2
        M = gcd(M, p*Q.resultant(x^f-1))

    return M

# Isabel's code using the fact that the exponent of the determinant
# character divides 120.

# the following three functions implement the following for n=2,3,5:
# f(x) = x^4 - t*x^3 + s*x^2 - p^alpha*t*x + p^(2*alpha) is a
# degree 4 polynomial whose roots multiply in pairs to p^alpha
# returns the tuple (p, tn, sn, alphan) of the polynomial
# f^(n)(x) = x^4 - tn*x^3 + sn*x^2 - p^(alphan)*tn*x + p^(2*alphan)
# whose roots are the nth powers of the roots of f


def power_roots2(ptsa):
    r"""
    TODO one-sentence description

    INPUT:

    - ``ptsa`` -- list; of the form ``[p, t, s, alpha]`` where

      - ``p`` -- prime integer; TODO description

      - ``t`` -- TODO object type; TODO description

      - ``s`` -- TODO object type; TODO description

      - ``a`` -- TODO object type; TODO description

    OUTPUT: TODO

    EXAMPLES::

        TODO

    """
    p, t, s, alpha = ptsa
    return (p, t^2 - 2*s, s^2 - 2*p^alpha*t^2 + 2*p^(2*alpha), 2*alpha)


def power_roots3(ptsa):
    r"""
    TODO one-sentence description

    INPUT:

    - ``ptsa`` -- list; of the form ``[p, t, s, alpha]`` where

      - ``p`` -- prime integer; TODO description

      - ``t`` -- TODO object type; TODO description

      - ``s`` -- TODO object type; TODO description

      - ``a`` -- TODO object type; TODO description

    OUTPUT: TODO

    EXAMPLES::

        TODO

    """
    p, t, s, alpha = ptsa
    return (
        p,
        t^3 - 3*s*t + 3*p^alpha*t, s^3 - 3*p^alpha*s*t^2 + 3*p^(2*alpha)*t^2
        + 3*p^(2*alpha)*t^2 - 3*p^(2*alpha)*s, 3*alpha
    )


def power_roots5(ptsa):
    r"""
    TODO one-sentence description

    INPUT:

    - ``ptsa`` -- list; of the form ``[p, t, s, alpha]`` where

      - ``p`` -- prime integer; TODO description

      - ``t`` -- TODO object type; TODO description

      - ``s`` -- TODO object type; TODO description

      - ``a`` -- TODO object type; TODO description

    OUTPUT: TODO

    EXAMPLES::

        TODO

    """
    p, t, s, alpha = ptsa
    return (
        p,
        t^5 - 5*s*t^3 + 5*s^2*t + 5*p^alpha*t^3 - 5*p^alpha*s*t
        - 5*p^(2*alpha)*t,
        s^5 - 5*p^alpha*s^3*t^2 + 5*p^(2*alpha)*s*t^4 + 5*p^(2*alpha)*s^2*t^2
        - 5*p^(3*alpha)*t^4 + 5*p^(2*alpha)*s^2*t^2 - 5*p^(2*alpha)*s^3
        - 5*p^(3*alpha)*t^4 - 5*p^(3*alpha)*s*t^2 + 5*p^(4*alpha)*t^2
        + 5*p^(4*alpha)*t^2 + 5*p^(4*alpha)*s,
        5*alpha
    )


# put these together to do any power dividing 120 that we actually need
# c is the power
def power_roots(cptsa):
    r"""
    TODO one-sentence description

    INPUT:

    - ``ptsa`` -- list; of the form ``[p, t, s, alpha]`` where

      - ``p`` -- prime integer; TODO description

      - ``t`` -- TODO object type; TODO description

      - ``s`` -- TODO object type; TODO description

      - ``a`` -- TODO object type; TODO description

    OUTPUT: TODO

    EXAMPLES::

        TODO

    """
    c, p, t, s, alpha = cptsa
    if 120 % c != 0:
        raise ValueError("can't raise to this power")

    ptsa = (p, t, s, alpha)

    while c % 2 == 0:
        c, ptsa = c/2, power_roots2(ptsa)

    while c % 3 == 0:
        c, ptsa = c/3, power_roots3(ptsa)

    while c % 5 == 0:
        c, ptsa = c/5, power_roots5(ptsa)

    return ptsa


# given a quartic f whose roots multiply to p^alpha in pairs,
# returns the quartic whose roots are the products of roots
# of f that DO NOT multiply to p^alpha
def roots_pairs_not_p(ptsa):
    r"""
    TODO one-sentence description

    INPUT:

    - ``ptsa`` -- list; of the form ``[p, t, s, alpha]`` where

      - ``p`` -- prime integer; TODO description

      - ``t`` -- TODO object type; TODO description

      - ``s`` -- TODO object type; TODO description

      - ``a`` -- TODO object type; TODO description

    OUTPUT: TODO

    EXAMPLES::

        TODO

    """
    p, t, s, alpha = ptsa
    return (p, s - 2*p, p*t^2 - 2*p*s + 2*p^2, 2*alpha)

# t and s are the first and second elementary symmetric functions in the
# roots of the characteristic polynomial of Frobenius at p for a curve C
# M is an integer such that every prime ell for which J_C[ell] could be
# 1 + 3 reducible divides M
# y is a counter for the number of nontrivial Frobenius conditions going
# into M


def rule_out_1_plus_3_via_Frob_p(c, p, t, s, M=0, y=0):
    r"""
    TODO one-sentence description

    INPUT:

    - ``c`` -- TODO object type; TODO description 

    - ``p`` -- TODO object type; TODO description

    - ``t`` -- TODO object type; TODO description

    - ``s`` -- TODO object type; TODO description

    - ``M`` -- TODO object type (default: `0`); TODO description 

    - ``y`` -- TODO objec ttype (default: `0`); TODO description

    OUTPUT: TODO

    EXAMPLES::

        TODO

    """
    p, tnew, snew, alphanew = power_roots((c, p, t, s, 1))
    Pnew(x) = x^4 - tnew*x^3 + snew*x^2 - p^alphanew*tnew*x + p^(2*alphanew)
    Pval = Pnew(1)
    if Pval != 0:
        return ZZ(gcd(M, p*Pval)), y+1
    else:
        return M, y

# t and s are the first and second elementary symmetric functions in the
# roots of the characteristic polynomial of Frobenius at p for a curve C
# M is an integer such that every prime ell for which J_C[ell] could be
# 2+2 non-self-dual type reducible divides M
# y is a counter for the number of nontrivial Frobenius conditions going
# into M


def rule_out_2_plus_2_nonselfdual_via_Frob_p(c, p, t, s, M=0, y=0):
    r"""
    TODO one-sentence description

    INPUT:

    - ``c`` -- TODO object type; TODO description 

    - ``p`` -- TODO object type; TODO description

    - ``t`` -- TODO object type; TODO description

    - ``s`` -- TODO object type; TODO description

    - ``M`` -- TODO object type (default: `0`); TODO description 

    - ``y`` -- TODO objec ttype (default: `0`); TODO description

    OUTPUT: TODO

    EXAMPLES::

        TODO

    """
    p, tnew, snew, alphanew = roots_pairs_not_p((p, t, s, 1))
    p, tnew, snew, alphanew = power_roots((c, p, tnew, snew, alphanew))
    Pnew(x) = x^4 - tnew*x^3 + snew*x^2 - p^alphanew*tnew*x + p^(2*alphanew)
    Pval = Pnew(1)*Pnew(p^c)
    if Pval != 0:
        return ZZ(gcd(M, p*Pval)), y+1
    else:
        return M, y


#########################################################
#                            #
#          Reducible (modular forms case)        #
#                            #
#########################################################

def special_divisors(N):
    r"""
    TODO one-sentence description

    INPUT:

    - ``N`` -- TODO object type; TODO description

    OUTPUT: TODO

    EXAMPLES::

        TODO

    """
    D0 = [d for d in divisors(N) if d <= sqrt(N)]
    D0.reverse()
    D = []
    for d0 in D0:
        if all([d % d0 != 0 for d in D]):
            D.append(d0)

    D.reverse()
    return D


def get_cuspidal_levels(N, max_cond_exp_2=None):
    r"""
    TODO one-sentence description

    INPUT:

    - ``N`` -- TODO object type; TODO description

    - ``max_cond_exp_2`` -- TODO object type (default: `None`); TODO description

    OUTPUT: TODO

    EXAMPLES::

        TODO

    """
    if max_cond_exp_2 is not None:
        # if we're here, then N is the even poor mans conductor

        # recall we put a 2 in the poor mans conductor
        conductor_away_two = N/2
        possible_conductors = [conductor_away_two * 2^i
                               for i in range(max_cond_exp_2 + 1)]
        # unordered, hopefully not a problem.
        return list(set([d for N in possible_conductors
                         for d in special_divisors(N)]))
    else:
        return special_divisors(N)


def create_polynomial_database(path_to_datafile, levels_of_interest):
    r"""
    TODO one-sentence description

    INPUT:

    - ``path_to_datafile`` -- str; TODO description

    - ``levels_of_interest`` -- TODO object type; TODO description

    OUTPUT: TODO

    EXAMPLES::

        TODO

    """
    df = pd.read_csv(
        path_to_datafile,
        sep=":", header=None,
        names=["N", "p", "coeffs"]
    )
    actual_levels_of_interest = [i for i, j, k in levels_of_interest]
    df_relevant = df.loc[df["N"].isin(actual_levels_of_interest)].copy()

    df_relevant["coeffs"] = df_relevant["coeffs"].apply(ast.literal_eval)
    return df_relevant


def set_up_cuspidal_spaces(N, path_to_datafile=None, max_cond_exp_2=None):
    r"""
    TODO one-sentence description

    INPUT:

    - ``N`` -- integer; TODO description

    - ``path_to_datafile`` -- str; TODO description

    - ``max_cond_exp_2`` -- TODO object type (default: `None`); TODO description

    OUTPUT: TODO

    EXAMPLES::

        TODO

    """
    D = get_cuspidal_levels(N, max_cond_exp_2)
    if path_to_datafile is not None:
        levels_of_interest = [(d, 0, 0) for d in D]

        # There are no modular forms of level < 11
        bad_levels = [(i, 0, 0) for (i, 0, 0) in levels_of_interest
                      if i in range(11)]

        levels_of_interest = [z for z in levels_of_interest
                              if z not in bad_levels]

        DB = create_polynomial_database(path_to_datafile, levels_of_interest)
        return levels_of_interest, DB
    else:
        return [(CuspForms(d), 0, 0) for d in D], None


def reconstruct_hecke_poly_from_trace_polynomial(cusp_form_space, p):
    # Implement Zev and Joe Wetherell's idea
    r"""
    TODO one-sentence description

    INPUT:

    - ``cusp_form_space`` -- TODO object type; TODO description

    - ``p`` -- prime integer; TODO description

    OUTPUT: TODO

    EXAMPLES::

        TODO

    """
    char_T_x = R(cusp_form_space.hecke_polynomial(p))
    S.<a,b> = QQ[]
    char_T_a_b = S(char_T_x(x=a)).homogenize(var='b')
    substitute_poly = char_T_a_b(a=1+p*b^2)

    return R(substitute_poly(a=0, b=x))


def get_hecke_characteristic_polynomial(cusp_form_space, p, coeff_table=None):
    r"""
    TODO Make this description more self contained.
    This should return the left hand side of Equation 3.8.

    INPUT:

    - ``cusp_form_space`` -- TODO object type; either a space of weight `2`
      cuspform with trivial Nebentypus or a level (given as an integer).

    - ``p`` -- prime integer

    - ``coeff_table`` -- str; a filename with a list of characteristic
      polynomials for spaces of modular forms.

    OUTPUT: an integer polynomial of twice the dimension of the cuspform space.

    EXAMPLES::

        TODO

    REFERENCES:

    For more information, see TODO

    """
    if coeff_table is None:
        return reconstruct_hecke_poly_from_trace_polynomial(cusp_form_space, p)
    else:

        slice_of_coeff_table = coeff_table.loc[
                                (coeff_table["N"] == cusp_form_space)
                                & (coeff_table["p"] == p)]

        if slice_of_coeff_table.shape[0] == 1:
            logger.info("doing pandas stuff for level {}"
                        .format(cusp_form_space))
            hecke_charpoly_coeffs = slice_of_coeff_table.iloc[int(0)]["coeffs"]
            hecke_charpoly = sum([hecke_charpoly_coeffs[i]*(R.0)^i
                                  for i in range(len(hecke_charpoly_coeffs))])
        else:  # i.e., can't find data in database
            warning_msg = ("Warning: couldn't find level {} and prime {} "
                           "in DB.\nReconstructing on the fly...")\
                           .format(cusp_form_space, p)
            logger.info(warning_msg)
            CuspFormSpaceOnFly = CuspForms(cusp_form_space)
            hecke_charpoly =\
                reconstruct_hecke_poly_from_trace_polynomial(
                    CuspFormSpaceOnFly, p
                )

        return hecke_charpoly


def rule_out_cuspidal_space_using_Frob_p(S, p, fp, M, y, coeff_table=None):
    r"""
    TODO One sentence description

    INPUT:

    - ``S`` -- TODO object type; TODO description

    - ``p`` -- prime integer

    - ``fp`` -- TODO object type; TODO description

    - ``M`` -- TODO object type; TODO description

    - ``y`` -- TODO object type; TODO description

    - ``coeff_table`` -- TODO object type (default: `None`); TODO description

    OUTPUT: TODO

    EXAMPLES::

        TODO

    """
    if M != 1 and y < 2:
        Tp = get_hecke_characteristic_polynomial(S, p, coeff_table=coeff_table)
        res = fp.resultant(Tp)
        if res != 0:
            return gcd(M, p*res), y+1
    return M, y


def rule_out_cuspidal_spaces_using_Frob_p(p, fp, MC, coeff_table=None):
    r"""
    TODO One sentence description

    INPUT:

    - ``p`` -- prime integer

    - ``fp`` -- TODO object type; TODO description

    - ``MC`` -- TODO object type; TODO description

    - ``coeff_table`` -- TODO object type (default: `None`); TODO description

    OUTPUT: TODO

    EXAMPLES::

        TODO

    """
    MC0 = []
    for S, M, y in MC:
        Mm, yy = rule_out_cuspidal_space_using_Frob_p(
            S, p, fp, M, y, coeff_table=coeff_table
        )
        MC0.append((S, Mm, yy))
    return MC0


#########################################################
#                            #
#          Find surjective primes from list        #
#                            #
#########################################################

# This was going to be the copied/pasted code from the CoCalc notebook,
# developed by the 'testing_surjectivity' subgroup people. However, that code
# stretched to almost 600 lines of code itself (mostly lists of polynomials),
# so it's cleaner to give it its own module. We could import it like a normal
# python package, but then this file will have to be run as a sage executable,
# and since I expect most people to 'load' this current into the sage shell,
# the following is preferable. The downside with this is that it means the user
# needs to launch sage from the top level 'abeliansurfaces' directory.

load('find_surj_from_list.sage')


#########################################################
#                            #
#               Putting it all together            #
#                            #
#########################################################


def find_nonmaximal_primes(C, N=None, path_to_datafile=None):
    r"""
    The main function.

    Identifies the 

    INPUT:

    - ``C`` -- HyperellipticCurve; must be of genus ``2``.
      TODO should there be more of a description for the curve ``C``?

    - ``N`` -- int or ``None`` (default: ``None``); the conductor of ``C``
      if known.

    - ``path_to_datafile`` -- str or ``None`` (default: ``None``); The path of
      the file with the Hecke characteristic polynomials.

    OUTPUT:

    The set of primes `\ell` at which the mod-`\ell` representation of the
    Jacobian of ``C`` is nonsurjective.

    EXAMPLES::

        TODO

    """
    M1p3 = 0
    y1p3 = 0
    M2p2nsd = 0
    y2p2nsd = 0

    if N is None:
        f, h = C.hyperelliptic_polynomials()
        red_data = genus2reduction(h, f)
        # is this the true conductor if red_data.prime_to_2_conductor_only is
        # False?
        N = red_data.conductor
        max_cond_exp_2 = None
        if red_data.prime_to_2_conductor_only:
            # I think this is the case where we don't know exactly the
            # two-part of conductor
            N = 2*N
            max_cond_exp_2 = red_data.minimal_disc.valuation(2)

    # MCusp is a list of the form <S,M,y>, where S is either a space of cusp
    # forms or a level, M is an integer such that all primes with a reducible
    # sub isomorphic to therep of a cusp form in S divide M, y is a counter
    # for the number of nontrivial Frobenius conditions go into M
    MCusp, DB = set_up_cuspidal_spaces(
                N, path_to_datafile=path_to_datafile, max_cond_exp_2=None)

    # MQuad is a list of the form <phi,M,y>, where phi is a quadratic
    # character, M is the integer
    # all nonsurjective primes governed by phi must divide, and y is counter
    # for the number of nontrivial Frobenius conditions going into M
    MQuad = set_up_quadratic_chars(N)

    d = maximal_square_divisor(N)

    # we'll test as many p as we need to get at least 2 nontrivial Frobenius
    # conditions for every possible cause of non-surjectivity
    sufficient_p = False

    p = 1

    while not sufficient_p:
        p = next_prime(p)
        if N % p != 0:
            Cp = C.change_ring(FiniteField(p))
            fp = Cp.frobenius_polynomial()
            fp_rev = Cp.zeta_function().numerator()

            # M31 = rule_out_one_dim_ell(p,fp,d,M31);
            # M32A = rule_out_related_two_dim_ell_case1(p,fp,d,M32A)
            # M32B = rule_out_related_two_dim_ell_case2(p,fp,d,M32B)

            f = Integers(d)(p).multiplicative_order()
            c = gcd(f, 120)
            c = lcm(c, 8)  # adding in the max power of 2
            tp = - fp.coefficients(sparse=false)[3]
            sp = fp.coefficients(sparse=false)[2]

            M1p3, y1p3 = rule_out_1_plus_3_via_Frob_p(c, p, tp, sp, M1p3, y1p3)
            M2p2nsd, y2p2nsd = rule_out_2_plus_2_nonselfdual_via_Frob_p(
                                c, p, tp, sp, M2p2nsd, y2p2nsd)
            MCusp = rule_out_cuspidal_spaces_using_Frob_p(
                        p, fp_rev, MCusp, coeff_table=DB)
            MQuad = rule_out_quadratic_ell_via_Frob_p(p, fp, MQuad)

        if (M1p3 == 1) or (y1p3 > 1):
            if (M2p2nsd == 1) or (y2p2nsd > 1):
                if all((Mc == 1 or yc > 1) for S, Mc, yc in MCusp):
                    if all((Mq == 1 or yq > 1) for phi, Mq, yq in MQuad):
                        sufficient_p = True
    # ell_red_easy = [
    # prime_factors(M31), prime_factors(M32A), prime_factors(M32B)]

    # we will always include the non-semistable primes.
    non_maximal_primes = set([p[0] for p in list(N.factor()) if p[1] > 1])

    non_maximal_primes_verbose = dict.fromkeys(non_maximal_primes, 'nss')

    ell_red_1p3 = M1p3.prime_factors()
    non_maximal_primes = non_maximal_primes.union(set(ell_red_1p3))
    non_maximal_primes_verbose = update_verbose_results(
                                non_maximal_primes_verbose,
                                ell_red_1p3, '1p3')

    ell_red_2p2 = M2p2nsd.prime_factors()
    non_maximal_primes = non_maximal_primes.union(set(ell_red_2p2))
    non_maximal_primes_verbose = update_verbose_results(
                                    non_maximal_primes_verbose,
                                    ell_red_2p2, '2p2')

    if path_to_datafile is not None:
        ell_red_cusp = [(S, prime_factors(M)) for S, M, y in MCusp]
    else:
        ell_red_cusp = [(S.level(), prime_factors(M)) for S, M, y in MCusp]

    ell_red_cusp_primes = [p for a, j in ell_red_cusp for p in j]
    non_maximal_primes = non_maximal_primes.union(set(ell_red_cusp_primes))
    non_maximal_primes_verbose = update_verbose_results(
                                    non_maximal_primes_verbose,
                                    ell_red_cusp_primes, 'cusp')

    ell_irred = [(phi, prime_factors(M)) for phi, M, t in MQuad]
    ell_irred_primes = [p for a, j in ell_irred for p in j]
    non_maximal_primes = non_maximal_primes.union(set(ell_irred_primes))
    non_maximal_primes_verbose = update_verbose_results(
                                    non_maximal_primes_verbose,
                                    ell_irred_primes, 'irred')

    # we will always include the primes 2,3,5,7
    for k in [2, 3, 5, 7]:
        if k not in non_maximal_primes_verbose:
            non_maximal_primes_verbose[k] = '?'

    return non_maximal_primes_verbose


def nonmaximal_wrapper(row, path_to_datafile=None):
    r"""
    Pandas wrapper of ``find_nonmaximal_primes`` and ``is_surjective``.

    INPUT:

    - ``row`` -- int; TODO add description

    - ``path_to_datafile`` -- str or ``None`` (default: ``None``); The path of
      the file with the Hecke characteristic polynomials.

    OUTPUT:

    TODO

    EXAMPLES::

        TODO

    """
    logger.info("Starting curve of label {}".format(row['labels']))
    C = HyperellipticCurve(R(row['data'][0]), R(row['data'][1]))
    conductor_of_C = Integer(row['labels'].split(".")[0])
    possibly_nonmaximal_primes_verbose = find_nonmaximal_primes(
                                            C, N=conductor_of_C,
                                            path_to_datafile=path_to_datafile)
    possibly_nonmaximal_primes = set(possibly_nonmaximal_primes_verbose.keys())
    probably_nonmaximal_primes_verbose = is_surjective(
                                            C,
                                            L=list(possibly_nonmaximal_primes),
                                            verbose=True)

    probably_nonmaximal_primes, final_verbose_column = format_verbose_column(
        possibly_nonmaximal_primes_verbose, probably_nonmaximal_primes_verbose)

    return possibly_nonmaximal_primes, probably_nonmaximal_primes,
    final_verbose_column


def get_many_results(subset=None):
    r"""
    The main calling function which outputs a csv file of the results.

    Returns results only on a subset of the data.
    Set this to a small number (e.g. 5 or 10) to
    get quick results on a few curves. Defaults to
    None (meaning the whole dataset).

    INPUT:

    - ``subset`` -- TODO data type or ``None`` (default: ``None``); Set this to 

        - a small number (e.g. `5` or `10`) to get quick results on a few curves
        - ``None`` for the entire dataset.

    EXAMPLES::

        TODO

    """
    from g2c_curves_all import labels, data
    df = pd.DataFrame(zip(labels, data),
                      columns=['labels', 'data'])

    if subset is not None:
        df = df.head(int(subset)).copy()
        print("Running on the first {} LMFDB genus 2 curves which are "
              "absolutely simple...(will take about {} seconds)..."
              .format(subset, subset*3))
        logger.info("Running on the first {} LMFDB genus 2 curves which "
                    "are absolutely simple...(will take about {} seconds)..."
                    .format(subset, subset*3))
    else:
        print("Running on all LMFDB genus 2 curves which are absolutely simple"
              "...(will take AGES)..."
              .format(subset))
        logger.info("Running on all LMFDB genus 2 curves which are absolutely "
                    "simple...(will take AGES)...".format(subset))

    # The following line runs the above code on all curves in the dataframe
    df[['possibly_nonmaximal_primes', 'probably_nonmaximal_primes',
        'verbose_output']]
    = df.apply(nonmaximal_wrapper, axis=int(1),
               path_to_datafile=PATH_TO_MY_TABLE, result_type="expand")

    # It may be useful to know the primes where the Jacobian has rational
    # torsion. This has been computed in Magma elsewhere. Since not everyone
    # has access to Magma, this data has been saved in the file
    # 'torsion_primes.csv'.

    df_torsion = pd.read_csv('torsion_primes.csv')
    df = pd.merge(df, df_torsion, how='left', on='labels')

    df.rename(columns={'data': 'polynomials'}, inplace=True)

    # We now output the csv results file
    df.to_csv(OUTPUT_FILE, index=False)
    print("The results output to {}".format(OUTPUT_FILE))
    logger.info("The results output to {}".format(OUTPUT_FILE))


#########################################################
#                            #
#                         Outputs            #
#                            #
#########################################################

# If you want to run the code on either all of, a subset of, the genus 2 curves
# in the LMFDB, the following will do it. It will output the file in the cwd.

get_many_results()

#
# If however you only want to run it on a specific curve, then the following
# will do
#

# print("Running one example...")
# f = x^2 + x
# h = x^3 + 1
# C = HyperellipticCurve(R(f),R(h))
# conductor_of_C = 249
# possibly_nonmaximal_primes = find_nonmaximal_primes(C, N=conductor_of_C,
#                               path_to_datafile=PATH_TO_MY_TABLE)
# probably_nonmaximal_primes = is_surjective(
#                               C,L=list(possibly_nonmaximal_primes))
# print("Possibly nonmaximal primes: {}\nProbably nonmaximal primes: {}"
#       .format(possibly_nonmaximal_primes, probably_nonmaximal_primes))
