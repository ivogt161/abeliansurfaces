# -*- coding: utf-8 -*-
r"""
Some functions regarding Galois representations of Jacobians of
hyperelliptic curves.
Mostly used in the `gal_reps.py` in this module.
EXAMPLES::

Here is an example of a generic Jacobian; the LMFDB label of the curve is
249.a.249.1::

    sage: R.<x> = QQ[]
    sage: f = x^6 + 2*x^3 + 4*x^2 + 4*x + 1
    sage: C = HyperellipticCurve(f)
    sage: A = C.jacobian()
    sage: A.geometric_endomorphism_ring_is_ZZ()
    True

Here is an example of a Jacobian whose endomorphism algebra is a field but not
the rational number field; the LMFDB label of the curve is 529.a.529.1::

    sage: f = x^6 - 4*x^5 + 2*x^4 + 2*x^3 + x^2 + 2*x + 1
    sage: C = HyperellipticCurve(f)
    sage: A = C.jacobian()
    sage: A.geometric_endomorphism_algebra_is_field()
    True
    sage: A.geometric_endomorphism_ring_is_ZZ()
    False

Here is an example of a Jacobian whose endomorphism algebra is not a field;
the LMFDB label of the curve is 169.a.169.1::

    sage: f = x^6 + 4*x^5 + 6*x^4 + 2*x^3 + x^2 + 2*x + 1
    sage: C = HyperellipticCurve(f)
    sage: A = C.jacobian()
    sage: A.geometric_endomorphism_algebra_is_field()
    False

.. WARNING::
    blah blah

AUTHORS::
- Us
"""

# ****************************************************************************
#                   Copyright (C) 2022 The Authors
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#                  https://www.gnu.org/licenses/
# ****************************************************************************

from __future__ import print_function, absolute_import

from sage.arith.all import valuation, gcd
from sage.modular.all import CuspForms
from sage.rings.all import ZZ, QQ, Zmod, PolynomialRing
from sage.modular.dirichlet import DirichletGroup
from math import sqrt, floor

"""
GN_group_data is a list of all possible values of (trace^2/similitude factor, middle coefficient/similitude factor) that occur in an exceptional maximal subgroup of GSp_4(F_ell) of projective order N.  The values N = 1920 and N = 720 occur for ell arbitrarily large, while N = 5040 only occurs for ell = 7.
"""

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
    (16, 6),
]

G720_group_data = [
    (0, 1),
    (0, 0),
    (4, 3),
    (1, 1),
    (16, 6),
    (0, 2),
    (1, 0),
    (3, 2),
    (0, -2),
]

G5040_group_data_mod7 = [
    (0, 0),
    (0, 1),
    (0, 2),
    (0, 5),
    (0, 6),
    (1, 0),
    (1, 1),
    (2, 6),
    (3, 2),
    (4, 3),
    (5, 3),
    (6, 3),
]


def _init_wit(L):
    """
    Return a list for witnesses with all entries initially all set to zero or 1, in the following format:
        2: [_] <-> [_is_surj_at_2 ]
        ell > 2: [_,_,_,_,_] <-> [witness for _surj_test_A, witness for _surj_test_B, witness for _surj_test_720, witness for _surj_test_1920, witness for _surj_test_5040 ]
    An entry for one of the exceptional tests (_surj_test_720, _surj_test_1920, _surj_test_5040) is set to 1 if that exceptional subgroup cannot occur for the given value of ell.
    """
    witnesses = {}
    for l in L:
        if l == 2:
            witnesses[l] = [0]
        else:
            witnesses[l] = [0, 0, 0, 0, 0]
            if not l % 12 in {5, 7}:
                witnesses[l][2] = 1
            if l == 7:
                witnesses[l][2] = 1
            if not l % 8 in {3, 5}:
                witnesses[l][3] = 1
            if l != 7:
                witnesses[l][4] = 1
    return witnesses


def _is_surj_at_2(f, h):
    """
    Return True if and only if the mod 2 Galois image of the Jacobian of y^2 + h(x) y = f(x) is surjective, i.e. if and
    only if the Galois group of the polynomial 4*f+h^2 is all of S_6.
    """
    F = 4*f + h**2
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

    assert l % 8 in {3, 5}

    trace_sq_over_sim = frob_mod[3] ** 2 / p
    middle_over_sim = frob_mod[2] / p

    G1920_group_data_mod_ell = [(Zmod(l)(a), Zmod(l)(b)) for (a, b) in G1920_group_data]

    if (trace_sq_over_sim, middle_over_sim) not in G1920_group_data_mod_ell:
        return True
    return False


def _surj_test_720(l, p, frob_mod):

    assert l % 12 in {5, 7} and l != 7

    trace_sq_over_sim = frob_mod[3] ** 2 / p
    middle_over_sim = frob_mod[2] / p

    G720_group_data_mod_ell = [(Zmod(l)(a), Zmod(l)(b)) for (a, b) in G720_group_data]

    if (trace_sq_over_sim, middle_over_sim) not in G720_group_data_mod_ell:
        return True
    return False


def _surj_test_5040(l, p, frob_mod):

    assert l == 7

    trace_sq_over_sim = frob_mod[3] ** 2 / p
    middle_over_sim = frob_mod[2] / p

    if (trace_sq_over_sim, middle_over_sim) not in G5040_group_data_mod7:
        return True
    return False


def _update_wit(l, p, frob, f, h, wit):
    """
    Return an updated list of witnesses, based on surjectivity tests for frob at p.
    """
    frob_mod = frob.change_ring(Zmod(l))

    for i in range(len(wit)):
        if wit[i] == 0:
            if l > 2:
                # means wit has size 5
                if i == 0 and _surj_test_A(frob_mod):
                    wit[i] = p
                elif i == 1 and _surj_test_B(frob_mod):
                    wit[i] = p
                elif i == 2 and _surj_test_720(l, p, frob_mod):
                    wit[i] = p
                elif i == 3 and _surj_test_1920(l, p, frob_mod):
                    wit[i] = p
                elif i == 4 and _surj_test_5040(l, p, frob_mod):
                    wit[i] = p
            else:
                # wit vector is singleton
                assert i == 0
                if _is_surj_at_2(f, h):
                    wit[i] = 1
                else:
                    wit[i] = -1

    return wit


#########################################################
#                            #
#                   Auxiliary functions            #
#                            #
#########################################################


def maximal_square_divisor(N):
    """
    TESTS::
    """
    # TODO: Consider making this function private.
    # TODO: Add tests/examples (required)
    PP = ZZ(N).prime_divisors()
    n = 1
    for p in PP:
        n = n * p ** (floor(valuation(N, p) / 2))
    return n


#########################################################
#                            #
#          Governed by a quadratic character        #
#                            #
#########################################################


def maximal_quadratic_conductor(N):
    """
    TESTS::
    """
    # TODO: Consider making this function private.
    # TODO: Add tests/examples (required)
    if N % 2 == 0:
        return 4 * ZZ(N).radical()
    else:
        return ZZ(N).radical()


def character_list(N):
    """
    TESTS::
    """
    # TODO: Consider making this function private.
    # TODO: Add tests/examples (required)
    c = maximal_quadratic_conductor(N)
    D = DirichletGroup(c, base_ring=QQ, zeta_order=2)
    return [phi for phi in D if phi.conductor() != 1]


def set_up_quadratic_chars(N):
    """
    TESTS::
    """
    # TODO: Consider making this function private.
    # TODO: Add tests/examples (required)
    return [(phi, 0, 0) for phi in character_list(N)]


def rule_out_quadratic_ell_via_Frob_p(p, fp, MM):
    """Provide a summary of what this method is doing.
    INPUT:
    - ``p`` -- prime integer; new prime.
    - ``fp`` -- polynomial over the integers; the characteristic polynomial
        Frobenius at ``p`` on a hyperelliptic curve.
    - ``MM`` -- list; the items are tuples of the form ``(\\phi, M, y)``,
        where ``\\phi`` is a non-trivial quadratic character, all primes
        ``\\ell`` for which there is a quadratic obstruction associated with
        ``\\phi`` must divide ``M``, ``y`` is a counter for the number of
        nontrivial Frobenius constraints going into ``M``.
    OUTPUT: a list
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
    # TODO: Consider making this function private
    # TODO: Add tests/examples (required)
    # TODO: Complete the description and output description.
    # TODO: Delete the stuff under Args:
    ap = -fp.coefficients(sparse=False)[3]
    if ap == 0:
        return MM
    else:
        MM0 = []
        for phi, M, y in MM:
            if M == 1 or phi(p) != -1 or y > 1:
                MM0.append((phi, M, y))
            else:
                MM0.append((phi, gcd(M, p * ap), y + 1))
        return MM0


#########################################################
#                            #
#             Reducible (easy cases)            #
#                            #
#########################################################

# Isabel's code using the fact that the exponent of the determinant
# character divides 120.

# the following three functions implement the following for n=2,3,5:
# f(x) = x**4 - t*x**3 + s*x**2 - p**alpha*t*x + p**(2*alpha) is a
# degree 4 polynomial whose roots multiply in pairs to p**alpha
# returns the tuple (p, tn, sn, alphan) of the polynomial
# f**(n)(x) = x**4 - tn*x**3 + sn*x**2 - p**(alphan)*tn*x + p**(2*alphan)
# whose roots are the nth powers of the roots of f


def power_roots2(ptsa):
    """
    TESTS::
    """
    # TODO: Consider making this function private
    # TODO: Add tests/examples (required)
    p, t, s, alpha = ptsa
    return (
        p,
        t**2 - 2 * s,
        s**2 - 2 * p**alpha * t**2 + 2 * p ** (2 * alpha),
        2 * alpha,
    )


def power_roots3(ptsa):
    """
    TESTS::
    """
    # TODO: Consider making this function private
    # TODO: Add tests/examples (required)
    p, t, s, alpha = ptsa
    return (
        p,
        t**3 - 3 * s * t + 3 * p**alpha * t,
        s**3
        - 3 * p**alpha * s * t**2
        + 3 * p ** (2 * alpha) * t**2
        + 3 * p ** (2 * alpha) * t**2
        - 3 * p ** (2 * alpha) * s,
        3 * alpha,
    )


def power_roots5(ptsa):
    """
    TESTS::
    """
    # TODO: Consider making this function private
    # TODO: Add tests/examples (required)
    p, t, s, alpha = ptsa
    return (
        p,
        t**5
        - 5 * s * t**3
        + 5 * s**2 * t
        + 5 * p**alpha * t**3
        - 5 * p**alpha * s * t
        - 5 * p ** (2 * alpha) * t,
        s**5
        - 5 * p**alpha * s**3 * t**2
        + 5 * p ** (2 * alpha) * s * t**4
        + 5 * p ** (2 * alpha) * s**2 * t**2
        - 5 * p ** (3 * alpha) * t**4
        + 5 * p ** (2 * alpha) * s**2 * t**2
        - 5 * p ** (2 * alpha) * s**3
        - 5 * p ** (3 * alpha) * t**4
        - 5 * p ** (3 * alpha) * s * t**2
        + 5 * p ** (4 * alpha) * t**2
        + 5 * p ** (4 * alpha) * t**2
        + 5 * p ** (4 * alpha) * s,
        5 * alpha,
    )


# put these together to do any power dividing 120 that we actually need
# c is the power
def power_roots(cptsa):
    """
    TESTS::
    """
    # TODO: Consider making this function private
    # TODO: Add tests/examples (required)
    c, p, t, s, alpha = cptsa
    if 120 % c != 0:
        raise ValueError("can't raise to this power")

    ptsa = (p, t, s, alpha)

    while c % 2 == 0:
        c, ptsa = c / 2, power_roots2(ptsa)

    while c % 3 == 0:
        c, ptsa = c / 3, power_roots3(ptsa)

    while c % 5 == 0:
        c, ptsa = c / 5, power_roots5(ptsa)

    return ptsa


# given a quartic f whose roots multiply to p**alpha in pairs,
# returns the quartic whose roots are the products of roots
# of f that DO NOT multiply to p**alpha
def roots_pairs_not_p(ptsa):
    """
    TESTS::
    """
    # TODO: Consider making this function private
    # TODO: Add tests/examples (required)
    p, t, s, alpha = ptsa
    return (p, s - 2 * p, p * t**2 - 2 * p * s + 2 * p**2, 2 * alpha)


# t and s are the first and second elementary symmetric functions in the
# roots of the characteristic polynomial of Frobenius at p for a curve C
# M is an integer such that every prime ell for which J_C[ell] could be
# 1 + 3 reducible divides M
# y is a counter for the number of nontrivial Frobenius conditions going
# into M
def rule_out_1_plus_3_via_Frob_p(c, p, t, s, M=0, y=0):
    """
    TESTS::
    """
    # TODO: Consider making this function private
    # TODO: Add tests/examples (required)
    p, tnew, snew, alphanew = power_roots((c, p, t, s, 1))
    x = PolynomialRing(QQ, "x").gen()
    Pnew = (
        x**4
        - tnew * x**3
        + snew * x**2
        - p**alphanew * tnew * x
        + p ** (2 * alphanew)
    )
    Pval = Pnew(x=1)
    if Pval != 0:
        return ZZ(gcd(M, p * Pval)), y + 1
    else:
        return M, y


# t and s are the first and second elementary symmetric functions in the
# roots of the characteristic polynomial of Frobenius at p for a curve C
# M is an integer such that every prime ell for which J_C[ell] could be
# 2+2 non-self-dual type reducible divides M
# y is a counter for the number of nontrivial Frobenius conditions going
# into M
def rule_out_2_plus_2_nonselfdual_via_Frob_p(c, p, t, s, M=0, y=0):
    """
    TESTS::
    """
    # TODO: Consider making this function private
    # TODO: Add tests/examples (required)
    p, tnew, snew, alphanew = roots_pairs_not_p((p, t, s, 1))
    p, tnew, snew, alphanew = power_roots((c, p, tnew, snew, alphanew))
    x = PolynomialRing(QQ, "x").gen()
    Pnew = (
        x**4
        - tnew * x**3
        + snew * x**2
        - p**alphanew * tnew * x
        + p ** (2 * alphanew)
    )
    Pval = Pnew(x=1) * Pnew(x=p**c)
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
    """
    TESTS::
    """
    # TODO: Consider making this function private
    # TODO: Add tests/examples (required)
    D0 = [d for d in divisors(N) if d <= sqrt(N)]
    return D0


def get_cuspidal_levels(N, max_cond_exp_2=None):
    """
    TESTS::
    """
    # TODO: Consider making this function private
    # TODO: Add tests/examples (required)
    if max_cond_exp_2 is not None:
        # if we're here, then N is the even poor mans conductor
        conductor_away_two = N / 2  # recall we put a 2 in the poor mans conductor
        possible_conductors = [
            conductor_away_two * 2 ** i for i in range(max_cond_exp_2 + 1)
        ]
        return list(
            set([d for N in possible_conductors for d in special_divisors(N)])
        )  # not ordered, hopefully not a problem.
    else:
        return special_divisors(N)


def set_up_cuspidal_spaces(N, max_cond_exp_2=None):
    """
    TESTS::
    """
    # TODO: Consider making this function private
    # TODO: Add tests/examples (required)
    D = get_cuspidal_levels(N, max_cond_exp_2)
    return [(CuspForms(d), 0, 0) for d in D]


def reconstruct_hecke_poly_from_trace_polynomial(cusp_form_space, p):
    """
    Implement Zev and Joe Wetherell's idea
    TESTS::
    """
    # TODO: Consider making this function private
    # TODO: Add tests/examples (required)
    R = PolynomialRing(QQ, "x")
    x = R.gen()
    char_T_x = R(cusp_form_space.hecke_polynomial(p))
    S = PolynomialRing(QQ, 2, "ab")
    a, b = S.gens()
    char_T_a_b = S(char_T_x(x=a)).homogenize(var="b")
    substitute_poly = char_T_a_b(a=1 + p * b**2)
    return R(substitute_poly(a=0, b=x))


def rule_out_cuspidal_space_using_Frob_p(S, p, fp, M, y):
    """
    TESTS::
    """
    # TODO: Consider making this function private
    # TODO: Add tests/examples (required)
    if M != 1 and y < 2:
        Tp = reconstruct_hecke_poly_from_trace_polynomial(S, p)
        res = fp.resultant(Tp)
        if res != 0:
            return gcd(M, p * res), y + 1
    return M, y


def rule_out_cuspidal_spaces_using_Frob_p(p, fp, MC):
    """
    TESTS::
    """
    # TODO: Consider making this function private
    # TODO: Add tests/examples (required)
    MC0 = []
    for S, M, y in MC:
        Mm, yy = rule_out_cuspidal_space_using_Frob_p(S, p, fp, M, y)
        MC0.append((S, Mm, yy))
    return MC0