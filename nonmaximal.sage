"""nonmaximal.sage

Given a genus 2 curve specifed by polynomials f, h:
C:  y^2  + h(x)*y = f(x)
Determines the finite set of primes ell for which the Galois
action on J_C[ell] is nonmaximal.

Code is organized according to maximal subgroups of GSp_4"""

# Imports

import ast
import pandas as pd

#########################################################
#                            #
#                   Auxiliary functions            #
#                            #
#########################################################

def p_part(p, N):
    if N != 0:
        return p^valuation(N,p)
    else:
        return 1


def poor_mans_conductor(C):
    f,h = C.hyperelliptic_polynomials()
    red_data = genus2reduction(h,f)
    N = red_data.conductor
    if red_data.prime_to_2_conductor_only:
        N = 2*N
    return N

def maximal_square_divisor(N):
    PP = prime_factors(N)
    n = 1
    for p in PP:
        n = n * p^(floor(valuation(N,p)/2))
    
    return n
    
def true_conductor(C):
    print("Warning. This hasn't yet been implemented. The return value isn't actually the conductor.")
    return poor_mans_conductor(C)


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
    return [(phi,0) for phi in character_list(N)]



def rule_out_quadratic_ell_via_Frob_p(p,fp,MM):
    """Provide a summary of what this method is doing.

    Args:
        p (int): new prime
        fp (integer poly): charpoly of frobenius at p on a hyperelliptic curve
        MM (list): list of the form <phi,M>, where phi is a non-trivial
        quadratic character and all prime ell for which there is a quadratic
        obstruction associated with phi must divide M

    Returns:
        (list): TODO
    """
    ap = -fp.coefficients(sparse=false)[3]
    MM0 = []
    for phi,M in MM:
        if (M == 1 or phi(p) != -1):
            MM0.append((phi,M))
        else:
            MM0.append((phi,gcd(M,p*ap)))

    MM0 = [(phi,M/(p_part(2,M)*p_part(3,M))) for phi,M in MM0]
    return MM0



#########################################################
#                            #
#             Reducible (easy cases)            #
#                            #
#########################################################

#This should probably be update with the GCD of the return value and 120
def compute_f_from_d(d,p):
	return Integers(d)(p).multiplicative_order()

def rule_out_one_dim_ell(p,fp,d,M):
    """Zev's direct implementation of what is in Dieulefait SS 3.1 and 3.2.
    Warning: some bugs because the conductor used here is wrong at 2

    Args:
        p ([type]): [description]
        fp ([type]): [description]
        d ([type]): [description]
        M ([type]): [description]

    Returns:
        [type]: [description]
    """    
    if M != 1:
        f = compute_f_from_d(d,p)
        x = fp.variables()[0]
        M = gcd(M,p*fp.resultant(x^f-1))

    return M


def rule_out_related_two_dim_ell_case1(p,fp,d,M):
    if M != 1:
        f = compute_f_from_d(d,p)
        ap = -fp.coefficients(sparse=false)[3]
        bp = fp.coefficients(sparse=false)[2]
        x = fp.variables()[0]

        Q = (x*bp - 1 - p^2*x^2)*(p*x + 1)^2 - ap^2*p*x^2
        M = gcd(M,p*Q.resultant(x^f-1))

    return M

def rule_out_related_two_dim_ell_case2(p,fp,d,M):
    if M != 1:
        f = compute_f_from_d(d,p)
        ap = -fp.coefficients(sparse=false)[3]
        bp = fp.coefficients(sparse=false)[2]
        x = fp.variables()[0]

        Q = (x*bp - p - p*x^2)*(x + 1)^2 - ap^2*x^2
        M = gcd(M,p*Q.resultant(x^f-1))
    
    return M

"""
Isabel's code using the fact that the exponent of the determinant
character divides 120.

the following three functions implement the following for n=2,3,5:
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
def rule_out_1_plus_3_via_Frob_p(c, p, t, s, M=0):
    p, tnew, snew, alphanew = power_roots((c, p, t, s, 1))
    Pnew(x) = x^4 - tnew*x^3 + snew*x^2 - p^alphanew*tnew*x + p^(2*alphanew)
    return ZZ(gcd(M, p*Pnew(1)))

#t and s are the first and second elementary symmetric functions in the
#roots of the characteristic polynomial of Frobenius at p for a curve C
#M is an integer such that every prime ell for which J_C[ell] could be
#2+2 non-self-dual type reducible divides M
def rule_out_2_plus_2_nonselfdual_via_Frob_p(c, p, t, s, M):
    p, tnew, snew, alphanew = roots_pairs_not_p((p, t, s, 1))
    p, tnew, snew, alphanew = power_roots((c, p, tnew, snew, alphanew))
    Pnew(x) = x^4 - tnew*x^3 + snew*x^2 - p^alphanew*tnew*x + p^(2*alphanew)
    return ZZ(gcd(M, p*Pnew(1)*Pnew(p^c)))



#########################################################
#                            #
#          Reducible (modular forms case)        #
#                            #
#########################################################


def special_divisors(N):
    D0 = [d for d in divisors(N) if d <= sqrt(N)]
    D0.reverse()
    D = []
    for d0 in D0:
            if all([d % d0 != 0 for d in D]):
                    D.append(d0)
            
    D.reverse()
    return D


def create_polynomial_database(path_to_datafile, levels_of_interest):
    # DB = [[R(1) for j in range(MaxP+1)] for i in range(MaxN+1)]

    # with open(path_to_datafile) as coeff_table:
    #     for line in coeff_table:
    #         flds = line.split(":")
    #         coeffs = ast.literal_eval(flds[2])
    #         coeffs.reverse()
    #         DB[ast.literal_eval(flds[0])][ast.literal_eval(flds[1])] = sum([coeffs[i]*(R.0)^i for i in range(len(coeffs))])

    # return DB

    df = pd.read_csv(path_to_datafile, sep=":", header=None, names=["N", "p", "coeffs"])
    actual_levels_of_interest = [i for i,j in levels_of_interest]
    df_relevant = df.loc[df["N"].isin(actual_levels_of_interest)].copy()

    df_relevant["coeffs"] = df_relevant["coeffs"].apply(ast.literal_eval)

    return df_relevant


def set_up_cuspidal_spaces(N, path_to_datafile=None):
    if path_to_datafile is not None:
        levels_of_interest = [(d,0) for d in divisors(N) if d <= sqrt(N)]
        
        # There are no modular forms of level < 11
        bad_levels = [(i,0) for (i,0) in levels_of_interest if i in range(11)]

        levels_of_interest = [z for z in levels_of_interest if z not in bad_levels]

        DB = create_polynomial_database(path_to_datafile, levels_of_interest)
        return levels_of_interest, DB
    else:
    	D = special_divisors(N)
    	return [(CuspForms(d),0) for d in D], None


def reconstruct_hecke_poly_from_trace_polynomial(cusp_form_space, p):
    """Implement Zev and Joe Wetherell's idea"""

    char_T_x = R(cusp_form_space.hecke_polynomial(p))
    S.<a,b> = QQ[]
    char_T_a_b = S(char_T_x(x=a)).homogenize(var='b')
    substitute_poly = char_T_a_b(a=1+p*b^2)

    return R(substitute_poly(a=0, b=x))


def get_hecke_characteristic_polynomial(cusp_form_space, p, coeff_table = None):
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
        return reconstruct_hecke_poly_from_trace_polynomial(cusp_form_space, p)
    else:

        slice_of_coeff_table = coeff_table.loc[(coeff_table["N"] == cusp_form_space) 
                                               & (coeff_table["p"] == p)]

        if slice_of_coeff_table.shape[0] == 1:
            hecke_charpoly_coeffs = slice_of_coeff_table.iloc[int(0)]["coeffs"]
            hecke_charpoly = sum([hecke_charpoly_coeffs[i]*(R.0)^i for i in range(len(hecke_charpoly_coeffs))])
        else:  # i.e., can't find data in database
            warning_msg = ("Warning: couldn't find level {} and prime {} in DB.\n"
                           "Reconstructing on the fly...").format(cusp_form_space, p)
            print(warning_msg)
            CuspFormSpaceOnFly = CuspForms(cusp_form_space)
            hecke_charpoly = reconstruct_hecke_poly_from_trace_polynomial(CuspFormSpaceOnFly, p)

        return hecke_charpoly


    # else, get the poly from the coefficient table
#    look_up_key = "{}:{}:".format(cusp_form_space[0], p)
#    found = False
    
#    while found == False:
#        line = linecache.getline(coeff_table,cusp_form_space[1])
#        cusp_form_space[1] = cusp_form_space + 1
#        if line.startswith(look_up_key):
#            coeffs_of_hecke_charpoly = ast.literal_eval(line.split(":")[-1])
#            found = True
#            break

#    for line in coeff_table:
#    	if line.startswith(look_up_key):
#        	coeffs_of_hecke_charpoly = ast.literal_eval(line.split(":")[-1])
#                found=True
#                break
    
#    if found:
#        f = sum(coeffs_of_hecke_charpoly[i]*x^i for i in range(len(coeffs_of_hecke_charpoly)))
#    else:
	#Changed by Zev.
        #print("Warning: Didn't find the polynomial in the database.\nReconstructing on the fly...")
        #print("Warning: Didn't find the polynomial in the database.\n Try running without an input file.")
        #f = reconstruct_large_hecke_poly_from_small(cusp_form_space, p)

#    return f


def rule_out_cuspidal_space_using_Frob_p(S,p,fp,M,coeff_table=None):
    if M != 1:
        Tp = get_hecke_characteristic_polynomial(S,p, coeff_table=coeff_table)
        return gcd(M,p*fp.resultant(Tp))
    else:
        return M

def rule_out_cuspidal_spaces_using_Frob_p(p,fp,MC, coeff_table = None):
    MC0 = []
    for S,M in MC:
        MC0.append((S,rule_out_cuspidal_space_using_Frob_p(S,p,fp,M, coeff_table=coeff_table)))
    return MC0



#########################################################
#                            #
#               Putting it all together            #
#                            #
#########################################################


def find_nonmaximal_primes(C, N, path_to_datafile=None):

    #N = poor_mans_conductor(C)
    #M31 = 0
    #M32A = 0
    #M32B = 0
    M1p3 = 0
    M2p2nsd = 0
    MCusp, DB = set_up_cuspidal_spaces(N, path_to_datafile=path_to_datafile)
    MQuad = set_up_quadratic_chars(N)
    
    d = maximal_square_divisor(N)

    for p in prime_range(1000):
            if N % p != 0:
                Cp = C.change_ring(FiniteField(p))
                fp = Cp.frobenius_polynomial()
                fp_rev = Cp.zeta_function().numerator()

                #M31 = rule_out_one_dim_ell(p,fp,d,M31);
                #M32A = rule_out_related_two_dim_ell_case1(p,fp,d,M32A)
                #M32B = rule_out_related_two_dim_ell_case2(p,fp,d,M32B)

                f = Integers(d)(p).multiplicative_order()
                c = gcd(f, 120)
                c = lcm(c, 8) #adding in the max power of 2
                tp = - fp.coefficients(sparse=false)[3]
                sp = fp.coefficients(sparse=false)[2]

                M1p3 = rule_out_1_plus_3_via_Frob_p(c, p, tp, sp, M1p3)
                M2p2nsd = rule_out_2_plus_2_nonselfdual_via_Frob_p(c, p, tp, sp, M2p2nsd)
                # import pdb; pdb.set_trace()
                MCusp = rule_out_cuspidal_spaces_using_Frob_p(p,fp_rev,MCusp,coeff_table=DB)
                MQuad = rule_out_quadratic_ell_via_Frob_p(p,fp,MQuad)


    #ell_red_easy = [prime_factors(M31), prime_factors(M32A), prime_factors(M32B)]
    
    # we will always include 2, 3, and the non-semistable primes. Eventually
    # we'll do this properly, importing non_semistable_primes.py, but for now
    # do a quick thing
    non_maximal_primes = {2,3,5,7}.union(set([p[0] for p in list(N.factor()) if p[1]>1]))
    
    ell_red_easy = [M1p3.prime_factors(), M2p2nsd.prime_factors()]
    non_maximal_primes = non_maximal_primes.union(set([p for j in ell_red_easy for p in j]))

    if path_to_datafile is not None:
        ell_red_cusp = [(S,prime_factors(M)) for S,M in MCusp]
    else:
        ell_red_cusp = [(S.level(),prime_factors(M)) for S,M in MCusp]

    non_maximal_primes = non_maximal_primes.union(set([p for a,j in ell_red_cusp for p in j]))

    ell_irred = [(phi,prime_factors(M)) for phi,M in MQuad]
    non_maximal_primes = non_maximal_primes.union(set([p for a,j in ell_irred for p in j]))

    return non_maximal_primes

# Test code
R.<x> = PolynomialRing(QQ)
#f = x^6 - x^3 - x + 1

#f = 2*x^5 + 3*x^4 - x^3 - 2*x^2
#h = 1


f = -x^6 + 6*x^5 + 3*x^4 + 5*x^3 + 23*x^2 - 3*x + 5
C = HyperellipticCurve(f,0)
#answer=find_nonmaximal_primes(C, 279936)
#print(answer)
PATH_TO_MY_TABLE = '/home/barinder/Documents/sage_projects/abeliansurfaces/gamma0_wt2_hecke_lpolys_1000.txt'

answer=find_nonmaximal_primes(C, 279936,path_to_datafile=PATH_TO_MY_TABLE)
print(answer)


#N = poor_mans_conductor(C)

#answer=find_nonmaximal_primes(C, N)
#print(answer)

#MM = set_up_quadratic_chars(N)
#for p in prime_range(100):
#    if N % p != 0:
#        Cp = C.change_ring(FiniteField(p))
#        fp = Cp.frobenius_polynomial()
#        ap = -fp.coefficients(sparse=false)[3]
#        MM = rule_out_quadratic_ell_via_Frob_p(p,fp,MM)
#        print p,[m[1] for m in MM]
#    if all([m[1] == 1 for m in MM]): #This means the image if surjective for all ell > 3 with irreducible image.
#           break

