"""nonmaximal.sage

Given a genus 2 curve specifed by polynomials f, h:
C:  y^2  + h(x)*y = f(x)
Determines the finite set of primes ell for which the Galois
action on J_C[ell] is nonmaximal.

Code is organized according to maximal subgroups of GSp_4"""


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
    print("Warning. This isn't actually the conductor.")
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
        f = Integers(d)(p).multiplicative_order()
        x = fp.variables()[0]
        M = gcd(M,p*fp.resultant(x^f-1))

    return M


def rule_out_related_two_dim_ell_case1(p,fp,d,M):
    if M != 1:
        f = Integers(d)(p).multiplicative_order()
        ap = -fp.coefficients(sparse=false)[3]
        bp = fp.coefficients(sparse=false)[2]
        x = fp.variables()[0]

        Q = (x*bp - 1 - p^2*x^2)*(p*x + 1)^2 - ap^2*p*x^2
        M = gcd(M,p*Q.resultant(x^f-1))

    return M

def rule_out_related_two_dim_ell_case2(p,fp,d,M):
    if M != 1:
        f = Integers(d)(p).multiplicative_order()
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


def set_up_cuspidal_spaces(N):
    D = special_divisors(N)
    return [(CuspForms(d),0) for d in D]


# f will be an eigenform of level N_1, but we don't need to know that
def rule_out_cuspidal_space_using_Frob_p(S,p,fp,M):
    if M != 1:
        Tp = S.hecke_polynomial(p)
        return gcd(M,p*fp.resultant(Tp))
    else:
        return M


def rule_out_cuspidal_spaces_using_Frob_p(p,fp,MC):
    MC0 = []
    for S,M in MC:
        MC0.append((S,rule_out_cuspidal_space_using_Frob_p(S,p,fp,M)))
    return MC0



#########################################################
#                            #
#               Putting it all together            #
#                            #
#########################################################


def find_nonmaximal_primes(C, N):

    #N = poor_mans_conductor(C)
    #M31 = 0
    #M32A = 0
    #M32B = 0
    M1p3 = 0
    M2p2nsd = 0
    #MCusp = set_up_cuspidal_spaces(N)
    MQuad = set_up_quadratic_chars(N)
    
    d = maximal_square_divisor(N)

    for p in prime_range(100):
            if N % p != 0:
                Cp = C.change_ring(FiniteField(p))
                fp = Cp.frobenius_polynomial()

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

                #MCusp = rule_out_cuspidals_spaces_using_Frob_p(p,fp,MCusp)
                MQuad = rule_out_quadratic_ell_via_Frob_p(p,fp,MQuad)

    #ell_red_easy = [prime_factors(M31), prime_factors(M32A), prime_factors(M32B)]

    ell_red_easy = [M1p3.prime_factors(), M2p2nsd.prime_factors()]

    #ell_red_cusp = [(S.level,prime_factors(M)) for S,M in MCusp]
    #does't include 2 and 3
    ell_irred = [(phi,prime_factors(M)) for phi,M in MQuad]

    return ell_red_easy, ell_irred

# Test code
R.<x> = PolynomialRing(QQ)
#f = x^6 - x^3 - x + 1
f = 2*x^5 + 3*x^4 - x^3 - 2*x^2
h = 1
C = HyperellipticCurve(f,h=h)
N = poor_mans_conductor(C)

find_nonmaximal_primes(C, N)

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

