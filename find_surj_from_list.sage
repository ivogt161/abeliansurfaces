"""find_surj_from_list.sage
Given a typical hyperelliptic curve H over the rationals, is_surjective(H) returns a list of primes less than 1000 at which the residual
Galois repsentation might not be surjective. The primes less than 1000 outside of the returned list are verified to be surjective.
"""

def _init_exps():
    """
    Return a dictionary with keys l = 3, 5, and 7; for each l, the associated value is the list of characteristic polynomials of the matrices in the exceptional subgroup of GSp(4,l).
    """
    #char3 is the list of characteristic polynomials of matrices in the one subgroup of GSp(4,3) (up to conjugation) that isn't ruled out by surj_tests
    R.<x> = PolynomialRing(Zmod(3))
    char3 = [x^4 + 2*x^3 + x^2 + 2*x + 1,
        x^4 + 1,
        x^4 + x^3 + 2*x^2 + x + 1,
        x^4 + 2*x^3 + 2*x + 1,
        x^4 + x^3 + 2*x^2 + 2*x + 1,
        x^4 + x^3 + x^2 + x + 1,
        x^4 + x^3 + x^2 + 2*x + 1,
        x^4 + 2*x^2 + 1,
        x^4 + x^3 + x + 1,
        x^4 + 2*x^3 + 2*x^2 + x + 1,
        x^4 + 2*x^3 + 2*x^2 + 2*x + 1,
        x^4 + x^2 + 1,
        x^4 + 2*x^3 + x^2 + x + 1]
    #char5 Is the list of characteristic polynomials of matrices in the one subgroup of GSp(4,5) (up to conjugation) that isn't ruled out by surj_tests
    R.<x> = PolynomialRing(Zmod(5))
    char5 = [x^4 + x^3 + 2*x^2 + x + 1,
        x^4 + x^3 + 4*x + 1,
        x^4 + x^3 + x^2 + x + 1,
        x^4 + x^3 + x + 1,
        x^4 + 4*x^2 + 1,
        x^4 + 4*x^3 + 4*x^2 + 4*x + 1,
        x^4 + 3*x^2 + 1,
        x^4 + 4*x^3 + 3*x^2 + 4*x + 1,
        x^4 + 2*x^2 + 1,
        x^4 + 4*x^3 + 4*x^2 + x + 1,
        x^4 + 4*x^3 + 2*x^2 + 4*x + 1,
        x^4 + x^2 + 1,
        x^4 + 2*x^3 + 4*x^2 + 3*x + 1,
        x^4 + 4*x^3 + 3*x^2 + x + 1,
        x^4 + 1,
        x^4 + 4*x^3 + x^2 + 4*x + 1,
        x^4 + 2*x^3 + 3*x^2 + 3*x + 1,
        x^4 + 4*x^3 + 2*x^2 + x + 1,
        x^4 + 4*x^3 + 4*x + 1,
        x^4 + 2*x^3 + 2*x^2 + 3*x + 1,
        x^4 + 4*x^3 + x^2 + x + 1,
        x^4 + 3*x^3 + 4*x^2 + 3*x + 1,
        x^4 + 2*x^3 + x^2 + 3*x + 1,
        x^4 + 4*x^3 + x + 1,
        x^4 + 3*x^3 + 3*x^2 + 3*x + 1,
        x^4 + 2*x^3 + 3*x + 1,
        x^4 + 3*x^3 + 2*x^2 + 3*x + 1,
        x^4 + 3*x^3 + x^2 + 3*x + 1,
        x^4 + 3*x^3 + 3*x + 1,
        x^4 + 2*x^3 + 4*x^2 + 2*x + 1,
        x^4 + 2*x^3 + 3*x^2 + 2*x + 1,
        x^4 + 2*x^3 + 2*x^2 + 2*x + 1,
        x^4 + 3*x^3 + 4*x^2 + 2*x + 1,
        x^4 + 2*x^3 + x^2 + 2*x + 1,
        x^4 + x^3 + 4*x^2 + 4*x + 1,
        x^4 + 3*x^3 + 3*x^2 + 2*x + 1,
        x^4 + 2*x^3 + 2*x + 1,
        x^4 + x^3 + 3*x^2 + 4*x + 1,
        x^4 + 3*x^3 + 2*x^2 + 2*x + 1,
        x^4 + x^3 + 4*x^2 + x + 1,
        x^4 + 3*x^3 + x^2 + 2*x + 1,
        x^4 + x^3 + 2*x^2 + 4*x + 1,
        x^4 + x^3 + 3*x^2 + x + 1,
        x^4 + x^3 + x^2 + 4*x + 1,
        x^4 + 3*x^3 + 2*x + 1]
    #char7 Is the list of characteristic polynomials of matrices in the one subgroup of GSp(4,7) (up to conjugation) that isn't ruled out by surj_tests
    R.<x> = PolynomialRing(Zmod(7))
    char7 = [x^4 + 2*x^3 + 5*x^2 + 5*x + 1,
        x^4 + 5*x^3 + 5*x^2 + 2*x + 1,
        x^4 + x^3 + 6*x^2 + 2*x + 4,
        x^4 + x^3 + 3*x^2 + 4*x + 2,
        x^4 + 5*x^3 + 3*x^2 + 5*x + 1,
        x^4 + 1,
        x^4 + 2*x^2 + 1,
        x^4 + 6*x^2 + 1,
        x^4 + 4*x^3 + x + 4,
        x^4 + 4*x^3 + 2*x^2 + x + 4,
        x^4 + 6*x^3 + x^2 + 6*x + 1,
        x^4 + 4*x^3 + 5*x^2 + 2*x + 2,
        x^4 + x^3 + x + 1,
        x^4 + 3*x^3 + 5*x^2 + 5*x + 2,
        x^4 + 3*x^3 + 6*x + 4,
        x^4 + 3*x^3 + 2*x^2 + 6*x + 4,
        x^4 + 6*x^3 + 3*x^2 + 3*x + 2,
        x^4 + 2,
        x^4 + x^3 + 4*x^2 + 6*x + 1,
        x^4 + 3*x^2 + 4,
        x^4 + 6*x^2 + 2,
        x^4 + 5*x^2 + 4,
        x^4 + 3*x^3 + 6*x^2 + 3*x + 1,
        x^4 + 6*x^3 + 6*x^2 + 5*x + 4,
        x^4 + 3*x^3 + 4*x^2 + 4*x + 1,
        x^4 + 4*x^3 + 4*x^2 + 3*x + 1,
        x^4 + 4*x^3 + 6*x^2 + 4*x + 1,
        x^4 + 2*x^3 + x + 2,
        x^4 + x^3 + 2*x^2 + 3*x + 2,
        x^4 + 2*x^3 + 4*x^2 + x + 2,
        x^4 + 6*x^3 + 4*x^2 + x + 1,
        x^4 + 3*x^3 + x^2 + x + 4,
        x^4 + 2*x^3 + x^2 + 3*x + 4,
        x^4 + x^3 + 3*x^2 + 5*x + 4,
        x^4 + 5*x^2 + 1,
        x^4 + 2*x^3 + 5*x^2 + 4*x + 4,
        x^4 + 3*x^3 + 6*x^2 + 2*x + 2,
        x^4 + 6*x^3 + 6*x + 1,
        x^4 + 2*x^3 + 2*x^2 + 6*x + 2,
        x^4 + x^3 + x^2 + x + 1,
        x^4 + 5*x^3 + 2*x^2 + x + 2,
        x^4 + 5*x^3 + 5*x^2 + 3*x + 4,
        x^4 + 4*x^3 + 6*x^2 + 5*x + 2,
        x^4 + 4*x^3 + x^2 + 6*x + 4,
        x^4 + 5*x^3 + x^2 + 4*x + 4,
        x^4 + 2*x^3 + 3*x^2 + 2*x + 1,
        x^4 + 6*x^3 + 3*x^2 + 2*x + 4,
        x^4 + x^2 + 2,
        x^4 + 4,
        x^4 + 5*x^3 + 6*x + 2,
        x^4 + 3*x^2 + 2,
        x^4 + 6*x^3 + 2*x^2 + 4*x + 2,
        x^4 + 4*x^2 + 4,
        x^4 + 5*x^3 + 4*x^2 + 6*x + 2]
    return {3 : char3, 5 : char5, 7 : char7}

# G1920 is Mitchell's exceptional group label. The numbers mean trace^2/similitude,
#  middle coeff/similitude
G1920_group_data = [
(0, -2),
(0, -1),
(0, 0),
(0, 1),
(0, 2),
(1, 1),
(2, 1),
(2, 2),
(4, 2),
(4, 3),
(8, 4),
(16, 6)
]


# G720 is Mitchell's exceptional group label. The numbers mean trace^2/similitude,
#  middle coeff/similitude
G720_group_data = [
(0, 1), (0, 0), (4, 3), (1, 1), (16, 6), (0, 2), (1, 0), (3, 2), (0, -2)
]


def _init_wit(L):
    """
    Return a list for witnesses with all entries initially all set to zero, in the following format:
        2: [_] <-> [_is_surj_at_2 ]
        3: [_,_,_] <-> [witness for _surj_test_A, witness for _surj_test_B, witness for _surj_test_small_prime]
        5: [_,_,_] <-> [witness for _surj_test_A, witness for _surj_test_B, witness for _surj_test_small_prime]
        7: [_,_,_] <-> [witness for _surj_test_A, witness for _surj_test_B, witness for _surj_test_small_prime]
        3: [_,_,_] <-> [witness for _surj_test_A, witness for _surj_test_B]
    """
    witnesses = {}
    for l in L:
        # if l == 2:
        #     witnesses[l] = [0]
        # elif l in [3,5,7]:
        #     witnesses[l] = [0,0,0]
        # else:
        #     witnesses[l] = [0,0,0,0]
        # witnesses[l] = [0,0,0,0,0]
        if l > 7:
            witnesses[l] = [0,0,0,0]
        else:
            witnesses[l] = [0]
    return witnesses


def _is_surj_at_2(f,h):
    """
    Return True if and only if the mod 2 Galois image of the Jacobian of y^2 + h(x) y = f(x) is surjective, i.e. if and
    only if the Galois group of the polynomial 4*f+h^2 is all of S_6.
    """
    F = 4*f + h^2
    return F.is_irreducible() and F.galois_group().order() == 720


def _surj_test_A(frob_mod):
    """
    Return True if frob_mod is irreducible.
    """
    return frob_mod.is_irreducible()


def _surj_test_B(frob_mod):
    """
    Return True if frob_mod has nonzero trace and has a linear factor with multiplicity one.
    """
    if -frob_mod[3] != 0:
        for fact in frob_mod.factor():
            if fact[0].degree() == 1 and fact[1] == 1:
                return True
    return False


def _surj_test_1920(l, p, frob_mod):

    trace_sq_over_sim = frob_mod[3]^2 / p
    middle_over_sim = frob_mod[2] / p

    if (trace_sq_over_sim, middle_over_sim) not in G1920_group_data:
        return True
    return False


def _surj_test_720(l, p, frob_mod):

    trace_sq_over_sim = frob_mod[3]^2 / p
    middle_over_sim = frob_mod[2] / p

    if (trace_sq_over_sim, middle_over_sim) not in G720_group_data:
        return True
    return False


def _surj_test_small_prime(l, frob_mod, exps):
    """
    Return True if frob_mod is the characteristic polynomial of a matrix that is not in the exceptional subgroup mod l
    """
    return not frob_mod in exps[l]


def _update_wit(l, p, frob, f, h, exps, wit):
    """
    Return an updated list of witnesses, based on surjectivity tests for frob at p.
    """
    frob_mod = frob.change_ring(Zmod(l))
    # for i in range(len(wit)):
    # if wit[i] == 0:
    #     if l == 2:
    #         if _is_surj_at_2(f,h):
    #             wit[i] = 1
    #         else:
    #             wit[i] = -1
    #     elif i == 0 and _surj_test_A(frob_mod):
    #         wit[i] = p
    #     elif i == 1 and _surj_test_B(frob_mod):
    #         wit[i] = p
    #     elif i == 2 and _surj_test_small_prime(l, p, frob_mod, exps):
    #         wit[i] = p
    #     elif i == 3

    for i in range(len(wit)):
        if wit[i] == 0:
            if l > 7:
                # means wit has size 4
                if i == 0 and _surj_test_A(frob_mod):
                    wit[i] = p
                elif i == 1 and _surj_test_B(frob_mod):
                    wit[i] = p
                elif i == 2 and _surj_test_720(frob_mod):
                    wit[i] = p
                elif i == 3 and _surj_test_1920(frob_mod):
                    wit[i] = p
            else:
                # wit vector is singleton
                if l == 2:
                    assert i == 0
                    if _is_surj_at_2(f,h):
                        wit[i] = 1
                    else:
                        wit[i] = -1
                else:
                    assert l in [3,5,7]
                    if _surj_test_small_prime(l, frob_mod, exps):
                        wit[i] = p

    return wit


def is_surjective(H, L=list(primes(1000)), bound=1000, verbose=False):
    r"""
    Return a list of primes in L at which the residual Galois representation of the Jacobian of `H` might not be surjective.
    Outside of the returned list, all primes in L are surjective. The primes in the returned list are likely non-surjective.

    INPUT:

    - ``H`` -- hyperelliptic curve with typical Jacobian

    - ``L`` -- list of primes (default: list of primes less than 1000)

    - ``bound`` -- integer (default: `1000`)

    - ``verbose`` -- boolean (default: `False`)

    OUTPUT: a list

    EXAMPLES:

        sage: R.<x> = PolynomialRing(QQ);
        sage: H = HyperellipticCurve(R([0, 1, 1]), R([1, 0, 0, 1]));
        sage: is_surjective(H)
        [2, 7]

        sage: R.<x> = PolynomialRing(QQ)
        sage: H = HyperellipticCurve(R([0, 21, -5, -9, 1, 1]), R([1, 1])); H
        Hyperelliptic Curve over Rational Field defined by y^2 + (x + 1)*y = x^5 + x^4 - 9*x^3 - 5*x^2 + 21*x
        sage: is_surjective(H)
        [2, 13]

    """
    f,h = H.hyperelliptic_polynomials()
    # C = 2 * genus2reduction(h, f).conductor # An integer which agrees up with the conductor of H: y^2 + h y = f, except possibly at two. Bad primes of Jac(H) divide it.
    C = 2 * prod(genus2reduction(h,f).local_data.keys())
    witnesses = _init_wit(L)
    exps = _init_exps()
    to_check = L.copy() # to_check is the list of primes for which we still need to determine surjectivity. Initially, it equals L and we remove primes as their status is determined.
    for p in primes(3,bound):
        if C % p != 0:
            Hp = H.change_ring(GF(p))
            frob = Hp.frobenius_polynomial()
            to_remove = []
            for l in to_check:
                if p != l and 0 in witnesses[l]:
                    witnesses[l] = _update_wit(l, p, frob, f, h, exps, witnesses[l])
                    if not 0 in witnesses[l]:
                        to_remove.append(l)
            for l in to_remove:
                to_check.remove(l)
            if len(to_check) == 0:
                break
    if verbose:
        return witnesses
    probably_non_surj_primes = []
    for l in L:
        if -1 in witnesses[l] or 0 in witnesses[l]:
            probably_non_surj_primes.append(l)
    return probably_non_surj_primes







#################################################
### FURTHER EXAMPLES 
#################################################

#R.<x> = PolynomialRing(Rationals())

# Talk example
#H = HyperellipticCurve(R([0, 21, -5, -9, 1, 1]), R([1, 1])); H
#is_surjective(H)

# Ex from Noam (not typical)
#H = HyperellipticCurve(5*x^6-4*x^5+20*x^4-2*x^3+24*x^2+20*x+5);
#is_surj(H)

#Example from Drew
#H = HyperellipticCurve(R([-118, 106, 9, -21, 0, 1]), R([0, 1])); H
#is_surj(H)

#H = HyperellipticCurve(R([9, 6, -33, -18, 25, 20])); H
#is_surj(H)

#H = HyperellipticCurve(3628260*x^6 - 1222632*x^5 - 3709872*x^4 + 2955424*x^3 + 2006931*x^2 - 314944*x + 143566,0); H
#is_surj(H)

#H = HyperellipticCurve(58428*x^6 + 894708*x^5 + 3976245*x^4 + 2374954*x^3 - 12089658*x^2 - 319990*x - 7081 ,0); H
#is_surj(H)

#Noam's Example
#H = HyperellipticCurve(16568*x^6 - 91931*x^5 - 1154002*x^4 + 5931677*x^3 - 476629*x^2 - 5645488*x - 1898052,0); H
#is_surj(H)

#CM curve
#H = HyperellipticCurve(R([1, 0, 0, 0, 0, 0, 1])); H
#is_surj(H)

#?
#H = HyperellipticCurve(R([1, -2, -1, 4, 3, 2, 1])); H
#is_surj(H)

#conductor 249
#H = HyperellipticCurve(R([1, 4, 4, 2, 0, 0, 1])); H
#is_surj(H)

#Drew first curve on zulip
#H = HyperellipticCurve( -x^6+6*x^5+3*x^4+5*x^3+23*x^2-3*x+5,x); H
#is_surj(H)

#Drew second curve on zulip
#H=HyperellipticCurve(3*x^5+9*x^4+14*x^3+39*x^2+16,x^3); H
#is_surj(H)

#Curve from Calegari table
#H=HyperellipticCurve(7*x^6-22*x^5-7*x^4 + 61*x^3 -3*x^2-54*x-12,x);H
#is_surj(H)

#Random curve from LMFDB
#H = HyperellipticCurve(R([0, 1, 16, 72, 33, 4]), R([0, 1])); H
#is_surj(H)
