r"""
Lists primes whose residual Galois representations might be non-surjective

Given a typical hyperelliptic curve `H` over `\\QQ` of genus `2`, returns
a list of primes less than `1000` at which the residual Galois representation
might not be surjective. The primes less than `1000` outside of the returned
list are verified to be surjective.

EXAMPLES::
.. TODO

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


def _init_exps():
    r"""
    Return characteristic polynomials of elements in the exceptional subgroup.

    OUTPUT: A dictionary

    - whose keys are `l = 3,5,7` and

    - whose associated values are the lists of characteristic polynomials of
    the matrices in the exceptional subgroup of `\\text{GSp}(4,l)`.

    EXAMPLES:

    TODO
    """
    # char3 is the list of characteristic polynomials of matrices in the one
    # subgroup of GSp(4,3) (up to conjugation) that isn't ruled out by
    # surj_tests
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
        x^4 + 2*x^3 + x^2 + x + 1
    ]
    # char5 Is the list of characteristic polynomials of matrices in the one
    # subgroup of GSp(4,5) (up to conjugation) that isn't ruled out by
    # surj_tests
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
        x^4 + 3*x^3 + 2*x + 1
    ]
    # char7 is the list of characteristic polynomials of matrices in the one
    # subgroup of GSp(4,7) (up to conjugation) that isn't ruled out
    # by surj_tests
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
        x^4 + 5*x^3 + 4*x^2 + 6*x + 2
    ]
    return {3: char3, 5: char5, 7: char7}


def _init_wit(L):
    r"""
    Return a formatted dictionary to be passed to the is_surjective function.

    INPUT:

    - ``L`` -- a list of primes

    OUTPUT: A dictionary

    - whose keys are the prime numbers in ``L`` and

    - whose associated values are the lists for witnesses with all entries
      initially all set to zero, in the following format:
        2: [_] <-> [_is_surj_at_2 ]
        3: [_,_,_] <-> [
                        witness for _surj_test_A,
                        witness for _surj_test_B,
                        witness for _surj_test_exp
                       ]
        5: [_,_,_] <-> [
                        witness for _surj_test_A,
                        witness for _surj_test_B,
                        witness for _surj_test_exp
                       ]
        7: [_,_,_] <-> [
                        witness for _surj_test_A,
                        witness for _surj_test_B,
                        witness for _surj_test_exp
                       ]
        other: [_,_] <-> [witness for _surj_test_A, witness for _surj_test_B]

    EXAMPLES:

    TODO
    """
    witnesses = {}
    for l in L:
        if l == 2:
            witnesses[l] = [0]
        elif l in [3, 5, 7]:
            witnesses[l] = [0, 0, 0]
        else:
            witnesses[l] = [0, 0]
    return witnesses


def _is_surj_at_2(f, h):
    r"""
    Return True if the mod 2 Galois representation is surjective.

    The mod `2` Galois representation is that of the Jacobian of the
    genus `2` curve given by `y^2 + h(x) y = f(x)`.

    INPUT:

    - ``f`` -- singlevariate polynomial; ``f`` must be of degree at most `6`.

    - ``h`` -- singlevariate polynomial; ``g`` must be of degree at most `3`,
      and must be an element of the same polynomial ring as ``f``.
      Moreover, the curve must be of genus `2`, so `\\deg h = 3` or
      `\\deg f = 5` or `6`.

    ALGORITHM:

    The mod `2` Galois representation is surjective if and only if the Galois
    group of the polynomial `4f + h^2` is all of `S_6`.

    """
    F = 4*f + h^2
    return F.is_irreducible() and F.galois_group().order() == 720


def _surj_test_A(frob_mod):
    r"""
    Return True if frob_mod is irreducible over is base field.

    INPUT:

    - ``frob_mod`` -- singlevariate polynomial; ``frob_mod`` has
      coefficients over a finite field `\\GF{q}` for some
      prime `l`.

    EXAMPLES:
    TODO
    """
    return frob_mod.is_irreducible()


def _surj_test_B(frob_mod):
    r"""
    Return True if frob_mod has nonzero trace and has a linear factor with
    multiplicity one.

    INPUT:

    - ``frob_mod`` -- singlevariate polynomial; ``frob_mod`` has
      coefficients over a finite field `\\GF{l}` for some
      prime `l`.

    EXAMPLES:
    TODO
    """
    if -frob_mod[3] != 0:
        for fact in frob_mod.factor():
            if fact[0].degree() == 1 and fact[1] == 1:
                return True
    return False


def _surj_test_exp(l, frob_mod, exps):
    r"""
    Return True if frob_mod is the characteristic polynomial of a matrix that
    is not in the exceptional subgroup mod `l`.

    INPUT:

    - ``frob_mod`` -- singlevariate polynomial; ``frob_mod`` has
      coefficients over a finite field `\\GF{l}` for some
      prime `l`.

    EXAMPLES:
    TODO
    """
    return frob_mod not in exps[l]


def _update_wit(l, p, frob, f, h, exps, wit):
    """
    Return an updated list of witnesses, based on surjectivity tests for frob
    at p.

    INPUT:

    - ``l`` -- prime integer.

    - ``p`` -- prime integer; must not equal ``l``.

    - ``frob`` -- singlevariate integer polynomial; 

    - ``f`` -- singlevariate polynomial;

    - ``g`` -- singlevariate polynomial;

    - ``exps`` -- TODO

    - ``wit`` -- TODO
    """
    frob_mod = frob.change_ring(Zmod(l))
    for i in range(0, len(wit)):
        if wit[i] == 0:
            if l == 2:
                if _is_surj_at_2(f, h):
                    wit[i] = 1
                else:
                    wit[i] = -1
            elif i == 0 and _surj_test_A(frob_mod):
                wit[i] = p
            elif i == 1 and _surj_test_B(frob_mod):
                wit[i] = p
            elif i == 2 and _surj_test_exp(l, frob_mod, exps):
                wit[i] = p
    return wit


def is_surjective(H, L=list(primes(1000)), bound=1000, verbose=False):
    r"""
    Return a list of primes in L at which the residual Galois representation
    of the Jacobian of `H` might not be surjective.

    Outside of the returned list, all primes in L are surjective. The primes
    in the returned list are likely non-surjective.

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
    f, h = H.hyperelliptic_polynomials()
    # An integer which agrees up with the conductor of H: y^2 + h y = f,
    # except possibly at two. Bad primes of Jac(H) divide it.
    C = 2 * prod(genus2reduction(h, f).local_data.keys())
    witnesses = _init_wit(L)
    exps = _init_exps()
    # to_check is the list of primes for which we still need to determine
    # surjectivity. Initially, it equals L and we remove primes as their
    # status is determined.
    to_check = L.copy()
    for p in primes(3, bound):
        if C % p != 0:
            Hp = H.change_ring(GF(p))
            frob = Hp.frobenius_polynomial()
            to_remove = []
            for l in to_check:
                if p != l and 0 in witnesses[l]:
                    witnesses[l] = _update_wit(
                        l, p, frob, f, h, exps, witnesses[l]
                    )
                    if 0 not in witnesses[l]:
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
