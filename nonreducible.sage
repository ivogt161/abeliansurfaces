def p_part(p, N):
    if N != 0:
        return p^valuation(N,p)
    else:
        return 1


def maximal_quadratic_conductor(N):
    if N % 2 == 0:
        return 4*radical(N)
    else:
        return radical(N)


def poor_mans_conductor(C):
    f,h = C.hyperelliptic_polynomials()
    red_data = genus2reduction(h,f)
    N = red_data.conductor
    if red_data.prime_to_2_conductor_only:
        N = 2*N
    return N


def character_list(C):
    N = poor_mans_conductor(C)
    c = maximal_quadratic_conductor(N)
    D = DirichletGroup(c,base_ring=QQ,zeta_order=2)
    return [phi for phi in D if phi.conductor() != 1]


# C is the hyperelliptic curve, p is the new prime,
# MM is a list of the form <phi,M>, where phi is a non-trivial
# quadratic character and all prime ell for which there is a quadratic
# obstruction associated with phi must divide M
# If phi(p) = -1, then we can hopefully replace M with a factor of M
def rule_out_quadratic_ell_via_Frob_p(p,ap,MM):
    MM0 = []
    for phi,M in MM:
        if phi(p) != -1:
            MM0.append((phi,M))
        else:
            MM0.append((phi,gcd(M,p*ap)))
    MM0 = [(phi,M/(p_part(2,M)*p_part(3,M))) for phi,M in MM0]
    return MM0

def set_up_quadratic_chars(C):
    return [(phi,0) for phi in character_list(C)]


# Test code
R.<x> = PolynomialRing(QQ)
#f = x^6 - x^3 - x + 1
f = 2*x^5 + 3*x^4 - x^3 - 2*x^2
h = 1
C = HyperellipticCurve(f,h=h)
N = poor_mans_conductor(C)
MM = set_up_quadratic_chars(C)
for p in prime_range(100):
    if N % p != 0:
        Cp = C.change_ring(FiniteField(p))
        fp = Cp.frobenius_polynomial()
        ap = -fp.coefficients(sparse=false)[3]
        MM = rule_out_quadratic_ell_via_Frob_p(p,ap,MM)
        print p,[m[1] for m in MM]
    if all([m[1] == 1 for m in MM]): #This means the image if surjective for all ell > 3 with irreducible image.
        break

