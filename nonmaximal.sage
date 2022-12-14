"""nonmaximal.sage

Given a genus 2 curve specifed by polynomials f, h:
C:  y^2  + h(x)*y = f(x)
Determines the finite set of primes ell for which the Galois
action on J_C[ell] is nonmaximal.

Code is organized according to maximal subgroups of GSp_4"""

# Imports
import ast
import pandas as pd
import string
import logging
# Globals

R.<x> = PolynomialRing(QQ)
x = R.gen()

# In order for the following file to be found, it is assumed that the cwd is
# the top directory of abeliansurfaces. This should be the case if you're loading
# this file into sage. If there's any problem, making the following path absolute
# should resolve the issue.

PATH_TO_MY_TABLE = 'data/gamma0_wt2_hecke_lpolys.txt'
HECKE_LPOLY_LIM = 1025  # the limit up to which we have complete lpoly data

#########################################################
#                            #
#                   Auxiliary functions            #
#                            #
#########################################################


def maximal_square_divisor(N):
    PP = prime_factors(N)
    n = 1
    for p in PP:
        n = n * p^(floor(valuation(N,p)/2))

    return n



def update_verbose_results(dict_to_update, new_keys, value_str):
    if new_keys:
        for k in new_keys:
            if k in dict_to_update:
                dict_to_update[k] += '.{}'.format(value_str)
            else:
                dict_to_update[k] = value_str
    return dict_to_update


#########################################################
#                            #
#          Governed by a quadratic character        #
#                            #
#########################################################


def maximal_quadratic_conductor(N):
    if N % 2 == 0:
        return 4*radical(N)
    else:
        return radical(N)

def character_list(N):
    #N = poor_mans_conductor(C)
    c = maximal_quadratic_conductor(N)
    D = DirichletGroup(c,base_ring=QQ,zeta_order=2)
    return [phi for phi in D if phi.conductor() != 1]


def set_up_quadratic_chars(N):
    return [(phi,0,0) for phi in character_list(N)]



def rule_out_quadratic_ell_via_Frob_p(p,fp,MM):
    """Provide a summary of what this method is doing.

    Args:
        p (int): new prime
        fp (integer poly): charpoly of frobenius at p on a hyperelliptic curve
        MM (list): list of the form <phi,M,y>, where phi is a non-trivial
        quadratic character, all primes ell for which there is a quadratic
        obstruction associated with phi must divide M, y is a counter for the
	the number of nontrivial Frobenius constraints going into M

    Returns:
        (list): TODO
    """
    ap = -fp.coefficients(sparse=False)[3]
    if ap == 0:
        return MM
    else:
        MM0 = []
        for phi,M,y in MM:
            if (M == 1 or phi(p) != -1 or y>1):
                MM0.append((phi,M,y))
            else:
                MM0.append((phi,gcd(M,p*ap), y+1))

        return MM0



#########################################################
#                            #
#             Reducible (easy cases)            #
#                            #
#########################################################


"""
The following three functions implement the following for n=2,3,5:
f(x) = x^4 - t*x^3 + s*x^2 - p^alpha*t*x + p^(2*alpha) is a
degree 4 polynomial whose roots multiply in pairs to p^alpha
returns the tuple (p, tn, sn, alphan) of the polynomial
f^(n)(x) = x^4 - tn*x^3 + sn*x^2 - p^(alphan)*tn*x + p^(2*alphan)
whose roots are the nth powers of the roots of f
"""

def power_roots2(ptsa):
    p, t, s, alpha = ptsa
    return (p, t^2 - 2*s, s^2 - 2*p^alpha*t^2 + 2*p^(2*alpha), 2*alpha)


def power_roots3(ptsa):
    p, t, s, alpha = ptsa
    return (p, t^3 - 3*s*t + 3*p^alpha*t, s^3 - 3*p^alpha*s*t^2 + 3*p^(2*alpha)
            *t^2 + 3*p^(2*alpha)*t^2 - 3*p^(2*alpha)*s, 3*alpha)


def power_roots5(ptsa):
    p, t, s, alpha = ptsa
    return (p, t^5 - 5*s*t^3 + 5*s^2*t + 5*p^alpha*t^3 - 5*p^alpha*s*t -
    5*p^(2*alpha)*t, s^5 - 5*p^alpha*s^3*t^2 + 5*p^(2*alpha)*s*t^4 +
    5*p^(2*alpha)*s^2*t^2 - 5*p^(3*alpha)*t^4 + 5*p^(2*alpha)*s^2*t^2 -
    5*p^(2*alpha)*s^3 - 5*p^(3*alpha)*t^4 - 5*p^(3*alpha)*s*t^2 +
    5*p^(4*alpha)*t^2 + 5*p^(4*alpha)*t^2 + 5*p^(4*alpha)*s, 5*alpha)


#put these together to do any power dividing 120 that we actually need
#c is the power
def power_roots(cptsa):
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


#given a quartic f whose roots multiply to p^alpha in pairs,
#returns the quartic whose roots are the products of roots
#of f that DO NOT multiply to p^alpha
def roots_pairs_not_p(ptsa):
    p, t, s, alpha = ptsa
    return (p, s - 2*p, p*t^2 - 2*p*s + 2*p^2, 2*alpha)

#t and s are the first and second elementary symmetric functions in the
#roots of the characteristic polynomial of Frobenius at p for a curve C
#M is an integer such that every prime ell for which J_C[ell] could be
#1 + 3 reducible divides M
#y is a counter for the number of nontrivial Frobenius conditions going
#into M
def rule_out_1_plus_3_via_Frob_p(c, p, t, s, M=0, y=0):
    p, tnew, snew, alphanew = power_roots((c, p, t, s, 1))
    Pnew = (
        x ** 4
        - tnew * x ** 3
        + snew * x ** 2
        - p ** alphanew * tnew * x
        + p ** (2 * alphanew)
    )
    Pval = Pnew(x=1)
    if Pval != 0:
        return ZZ(gcd(M, p * Pval)), y + 1
    else:
        return M, y


#t and s are the first and second elementary symmetric functions in the
#roots of the characteristic polynomial of Frobenius at p for a curve C
#M is an integer such that every prime ell for which J_C[ell] could be
#2+2 non-self-dual type reducible divides M
#y is a counter for the number of nontrivial Frobenius conditions going
#into M
def rule_out_2_plus_2_nonselfdual_via_Frob_p(c, p, t, s, M=0, y=0):
    p, tnew, snew, alphanew = roots_pairs_not_p((p, t, s, 1))
    p, tnew, snew, alphanew = power_roots((c, p, tnew, snew, alphanew))
    Pnew = (
        x ** 4
        - tnew * x ** 3
        + snew * x ** 2
        - p ** alphanew * tnew * x
        + p ** (2 * alphanew)
    )
    Pval = Pnew(x=1) * Pnew(x=p ** c)
    if Pval != 0:
        return ZZ(gcd(M, p * Pval)), y + 1
    else:
        return M, y


#########################################################
#                            #
#          Reducible (modular forms case)        #
#                            #
#########################################################


def special_divisors(N):
    D0 = [d for d in divisors(N) if d <= sqrt(N)]
    return D0


def get_cuspidal_levels(N, max_cond_exp_2=None):

    if max_cond_exp_2 is not None:
        # if we're here, then N is the even poor mans conductor
        conductor_away_two = N/2  # recall we put a 2 in the poor mans conductor
        possible_conductors = [conductor_away_two * 2^i for i in range(max_cond_exp_2 + 1)]
        return list(set([d for N in possible_conductors for d in special_divisors(N)]))  # not ordered, hopefully not a problem.
    else:
        return special_divisors(N)


def create_polynomial_database(path_to_datafile, levels_of_interest):

    df = pd.read_csv(path_to_datafile, sep=":", header=None, names=["N", "p", "coeffs"])
    actual_levels_of_interest = [i for i,j,k in levels_of_interest]
    df_relevant = df.loc[df["N"].isin(actual_levels_of_interest)].copy()

    df_relevant["coeffs"] = df_relevant["coeffs"].apply(ast.literal_eval)

    return df_relevant


def set_up_cuspidal_spaces(N, path_to_datafile=None, max_cond_exp_2=None):
    D = get_cuspidal_levels(N, max_cond_exp_2)
    if path_to_datafile is not None:
        levels_of_interest = [(d,0,0) for d in D]
        DB = create_polynomial_database(path_to_datafile, levels_of_interest)
        return levels_of_interest, DB
    else:
    	return [(CuspForms(d),0,0) for d in D], None


def reconstruct_hecke_poly_from_trace_polynomial(cusp_form_space, p):
    """Implement Zev and Joe Wetherell's idea"""

    char_T_x = R(cusp_form_space.new_subspace().hecke_polynomial(p))
    S.<a,b> = QQ[]
    char_T_a_b = S(char_T_x(x=a)).homogenize(var='b')
    substitute_poly = char_T_a_b(a=1+p*b^2)

    return R(substitute_poly(a=0, b=x))


def get_hecke_characteristic_polynomial(cusp_form_space, p, coeff_table=None):
    """This should return the left hand side of Equation 3.8.

    Args:
        cusp_form_space ([type]): either a space of weight 2 cuspforms with trivial
        Nebentypus or a level (given as an integer)
        p (int): prime number
        coeff_table: a filename with a list of characteristic polyomials for spaces of modular forms

    Returns:
        [pol]: an integer polynomial of twice the dimension of the cuspform
               space
    """

    if coeff_table is None:
        raise RuntimeError("We're not computing forms on the fly ...")

    slice_of_coeff_table = coeff_table.loc[
        (coeff_table["N"] == cusp_form_space) & (coeff_table["p"] == p)
    ]

    if slice_of_coeff_table.shape[0] == 1:
        hecke_charpoly_coeffs = slice_of_coeff_table.iloc[int(0)]["coeffs"]
        if hecke_charpoly_coeffs:
            hecke_charpoly = sum(
                [
                    hecke_charpoly_coeffs[i] * (R(x) ** i)
                    for i in range(len(hecke_charpoly_coeffs))
                ]
            )
        else:
            # missing data in dat file
            CuspFormSpaceOnfly = CuspForms(cusp_form_space)
            hecke_charpoly = reconstruct_hecke_poly_from_trace_polynomial(CuspFormSpaceOnfly, p)
    else:  # i.e., can't find data in database
        if cusp_form_space <= HECKE_LPOLY_LIM:
            # if we are here, then the reason we couldn't find any forms in the DB is
            # that there aren't actually any, so we return an empty product of Lpolys
            hecke_charpoly = 1
        else:
            # if we are here, then our lpoly datafile doesn't have enough data
            warning_msg = ("Warning: couldn't find level {} and prime {} in DB").format(
                cusp_form_space, p
            )
            raise RuntimeError(warning_msg)
    return hecke_charpoly


def rule_out_cuspidal_space_using_Frob_p(S,p,fp,M,y,coeff_table=None):
    if M != 1 and y<2:
        Tp = get_hecke_characteristic_polynomial(S,p, coeff_table=coeff_table)
        res = fp.resultant(Tp)
        if res != 0:
            return gcd(M,p*res), y+1
    return M, y


def rule_out_cuspidal_spaces_using_Frob_p(p,fp,MC, coeff_table = None):
    if p < 100:
        MC0 = []
        for S,M,y in MC:
            Mm, yy = rule_out_cuspidal_space_using_Frob_p(S,p,fp,M,y,coeff_table=coeff_table)
            MC0.append((S,Mm,yy))
        return MC0
    else:
        return MC


#########################################################
#                            #
#          Find surjective primes from list        #
#                            #
#########################################################

"""
This was going to be the copied/pasted code from the CoCalc notebook,
developed by the 'testing_surjectivity' subgroup people. However, that code
stretched to almost 600 lines of code itself (mostly lists of polynomials), so
it's cleaner to give it its own module. We could import it like a normal
python package, but then this file will have to be run as a sage executable, and
since I expect most people to 'load' this current into the sage shell, the
following is preferable. The downside with this is that it means the user needs
to launch sage from the top level 'abeliansurfaces' directory.
"""

load('find_surj_from_list.sage')


#########################################################
#                            #
#               Putting it all together            #
#                            #
#########################################################


def find_nonmaximal_primes(C, poor_cond, N=None, path_to_datafile=None):
    """The main function

    Args:
        C : Hyperelliptic Curve
        N (optional) : The conductor of C if known
        path_to_datafile (optional): Where to find the dataset containing the
        Hecke characteristic polynomials. Defaults to None

    Returns:
        [set]: Set of primes containing nonmaximal primes
    """
    M1p3 = 0
    y1p3 = 0
    M2p2nsd = 0
    y2p2nsd = 0

    if N is None:
        f,h = C.hyperelliptic_polynomials()
        red_data = genus2reduction(h,f)
        N = red_data.conductor  # is this the true conductor if red_data.prime_to_2_conductor_only is False?
        max_cond_exp_2 = None
        if red_data.prime_to_2_conductor_only:
            # I think this is the case where we don't know exactly the two-part of conductor
            N = 2*N
            max_cond_exp_2 = red_data.minimal_disc.valuation(2)

    #MCusp is a list of the form <S,M,y>, where S is either a space of cusp forms or
    #a level, M is an integer such that all primes with a reducible sub isomorphic to the
    #rep of a cusp form in S divide M, y is a counter for the number of nontrivial Frobenius
    #conditions go into M
    MCusp, DB = set_up_cuspidal_spaces(N, path_to_datafile=path_to_datafile, max_cond_exp_2=None)

    #MQuad is a list of the form <phi,M,y>, where phi is a quadratic character, M is the integer
    #all nonsurjective primes governed by phi must divide, and y is counter for the number of nontrivial
    #Frobenius conditions going into M
    MQuad = set_up_quadratic_chars(N)

    d = maximal_square_divisor(N)

    #we'll test as many p as we need to get at least 2 nontrivial Frobenius conditions for every
    #possible cause of non-surjectivity
    sufficient_p = False

    p = 1

    while (not sufficient_p):
        p = next_prime(p)
        if poor_cond % p != 0:
            Cp = C.change_ring(FiniteField(p))
            fp = Cp.frobenius_polynomial()
            fp_rev = Cp.zeta_function().numerator()

            f = Integers(d)(p).multiplicative_order()
            c = gcd(f, 120)
            c = lcm(c, 8)  # adding in the max power of 2
            tp = - fp.coefficients(sparse=False)[3]
            sp = fp.coefficients(sparse=False)[2]

            M1p3, y1p3 = rule_out_1_plus_3_via_Frob_p(c, p, tp, sp, M1p3, y1p3)
            M2p2nsd, y2p2nsd = rule_out_2_plus_2_nonselfdual_via_Frob_p(c, p, tp, sp, M2p2nsd, y2p2nsd)
            MCusp = rule_out_cuspidal_spaces_using_Frob_p(p,fp_rev,MCusp,coeff_table=DB)
            MQuad = rule_out_quadratic_ell_via_Frob_p(p,fp,MQuad)

        #See if we have sufficient information for every test
        if (M1p3 == 1) or (y1p3 > 1):
            if (M2p2nsd == 1) or (y2p2nsd > 1):
                if all((Mq == 1 or yq > 1) for phi, Mq, yq in MQuad):
                    if all((Mc == 1 or yc>1) for S, Mc, yc in MCusp):
                        sufficient_p = True

        #Stop the code if we haven't found helpful information from all Frobenius elements up to 1000
        if p > 1000:
            if (M1p3 != 1) and (y1p3 <= 1):
                failure_msg = f"Odd-dimensional subrep test is not succeeding and M1p3={M1p3}"
                logging.warning(failure_msg)
            if (M2p2nsd != 1) and (y2p2nsd <= 1):
                failure_msg = f"Two-plus-two non self-dual subrep test is not succeeding and M2p2nsd={M2p2nsd}"
                logging.warning(failure_msg)
            for S, Mc, yc in MCusp:
                if Mc != 1 and yc <= 1:
                    failure_msg = f"Modular forms reducible test is not succeeding for level N={S}: Mc={Mc}"
                    logging.warning(failure_msg)
            for phi, Mq, yq in MQuad:
                if Mq != 1 and yq <=1:
                    failure_msg = f"Quadratic character test is failing for the character phi={phi}: Mq={Mq}"
                    logging.warning(failure_msg)

            raise RuntimeError("Couldn't pass all tests with aux primes < 1000")


    # we will always include the bad primes.
    non_maximal_primes = set([p[0] for p in list(N.factor())])

    non_maximal_primes_verbose = dict.fromkeys(non_maximal_primes, 'nss')


    ell_red_1p3 = M1p3.prime_factors()
    non_maximal_primes = non_maximal_primes.union(set(ell_red_1p3))
    non_maximal_primes_verbose = update_verbose_results(non_maximal_primes_verbose,
                                                        ell_red_1p3,
                                                        '1p3')

    ell_red_2p2 = M2p2nsd.prime_factors()
    non_maximal_primes = non_maximal_primes.union(set(ell_red_2p2))
    non_maximal_primes_verbose = update_verbose_results(non_maximal_primes_verbose,
                                                        ell_red_2p2,
                                                        '2p2')

    if path_to_datafile is not None:
        ell_red_cusp = [(S,prime_factors(M)) for S,M,y in MCusp]
    else:
        ell_red_cusp = [(S.level(),prime_factors(M)) for S,M,y in MCusp]

    ell_red_cusp_primes = set([p for a,j in ell_red_cusp for p in j])
    non_maximal_primes = non_maximal_primes.union(set(ell_red_cusp_primes))
    non_maximal_primes_verbose = update_verbose_results(non_maximal_primes_verbose,
                                                        ell_red_cusp_primes,
                                                        'cusp')

    ell_irred = [(phi,prime_factors(M)) for phi,M,t in MQuad]
    ell_irred_primes = set([p for a,j in ell_irred for p in j])
    non_maximal_primes = non_maximal_primes.union(set(ell_irred_primes))
    non_maximal_primes_verbose = update_verbose_results(non_maximal_primes_verbose,
                                                        ell_irred_primes,
                                                        'irred')

    # we will always include the primes 2,3,5,7
    for k in [2,3,5,7]:
        if k not in non_maximal_primes_verbose:
            non_maximal_primes_verbose[k] = '?'
    return non_maximal_primes_verbose


#########################################################
#                            #
#                         Outputs            #
#                            #
#########################################################


def run_one_example(f,h,cond=None):
    print("Running one example...")
    C = HyperellipticCurve(R(f),R(h))
    poor_cond = 2 * prod(genus2reduction(h,f).local_data.keys())
    possibly_nonmaximal_primes = find_nonmaximal_primes(C, poor_cond, N=cond, path_to_datafile=PATH_TO_MY_TABLE)
    probably_nonmaximal_primes = is_surjective(C,poor_cond, L=list(possibly_nonmaximal_primes))
    print("Possibly nonmaximal primes: {}\nProbably nonmaximal primes: {}".format(possibly_nonmaximal_primes,
                                                        probably_nonmaximal_primes))
