r"""

Find primes with reducible representation with odd-dimensional subquotient.

Given a genus 2 curve, return a finite list of primes ell containing all
primes for which the mod ell representation is reducible with an
odd-dimensional subquotient

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

# computes the formulas for the polynomials whose roots are the
# 2nd, 3rd, and 5th power of the roots of a degree 4 polynomial

# TODO: we should make these variables private.
R = QQ['a, b, c, d']

SF = SymmetricFunctions(QQ)
e = SF.e()


def _coeff_t(n):
    r"""
    EXAMPLES::

        TODO
    """
    return e.from_polynomial(a^n + b^n + c^n + d^n).restrict_parts(4)


def _coeff_s(n):
    r"""
    EXAMPLES::

        TODO
    """
    return e.from_polynomial(
        a^n*b^n + a^n*c^n + a^n*d^n
        + b^n*c^n + b^n*d^n + c^n*d^n).restrict_parts(4)

# returns:
# sage: _coeff_t(2)
# e[1, 1] - 2*e[2]
# sage: _coeff_s(2)
# e[2, 2] - 2*e[3, 1] + 2*e[4]
# sage: _coeff_t(3)
# e[1, 1, 1] - 3*e[2, 1] + 3*e[3]
# sage: _coeff_s(3)
# e[2, 2, 2] - 3*e[3, 2, 1] + 3*e[3, 3] + 3*e[4, 1, 1] - 3*e[4, 2]
# sage: _coeff_t(5)
# e[1, 1, 1, 1, 1] - 5*e[2, 1, 1, 1] + 5*e[2, 2, 1] + 5*e[3, 1, 1] - 5*e[3, 2] - 5*e[4, 1]
# sage: _coeff_s(5)
# e[2, 2, 2, 2, 2] - 5*e[3, 2, 2, 2, 1] + 5*e[3, 3, 2, 1, 1] + 5*e[3, 3, 2, 2] - 5*e[3, 3, 3, 1] + 5*e[4, 2, 2, 1, 1] - 5*e[4, 2, 2, 2] - 5*e[4, 3, 1, 1, 1] - 5*e[4, 3, 2, 1] + 5*e[4, 3, 3] + 5*e[4, 4, 1, 1] + 5*e[4, 4, 2]

# the following three functions implement the following for n=2,3,5:
# f(x) = x^4 - t*x^3 + s*x^2 - p^alpha*t*x + p^(2*alpha) is a
# degree 4 polynomial whose roots multiply in pairs to p^alpha
# returns the tuple (p, tn, sn, alphan) of the polynomial
# f^(n)(x) = x^4 - tn*x^3 + sn*x^2 - p^(alphan)*tn*x + p^(2*alphan)
# whose roots are the nth powers of the roots of f

# TODO these might be better as (weakly) private functions
# Does this actually not give errors? The (()) seems to be
# invalid syntax in Sage/Python.


def power_roots2((p, t, s, alpha)):
    r"""Encode inputs into a quartic and return quartic with squared roots.

    Let f(x) be the quartic polynomial
    .. MATH::

    f(x) = x^4 - tx^3 + sx^2 - p^\alpha tx + p^(2\alpha).

    `f(x)` is expected to have roots that multiply in pairs to `p^\alpha`.

    INPUT:

    - ``p`` -- prime integer

    - ``t`` -- integer

    - ``s`` -- integer

    - ``alpha`` -- integer

    OUTPUT:

    The tuple `(p, t_2, s_2, \alpha_2)` such that the roots of
    .. MATH::

    f^2(x) = x^4 - 2tx^3 + 2sx^2 - 2p^(\alpha_2)tx + p^(2\alpha_2)

    are the squares of the roots of `f(x)`.

    EXAMPLES::

        TODO
    """
    return (p, t^2 - 2*s, s^2 - 2*p^alpha*t^2 + 2*p^(2*alpha), 2*alpha)


def power_roots3((p, t, s, alpha)):
    r"""Encode inputs into a quartic and return quartic with cubed roots.

    Let f(x) be the quartic polynomial
    .. MATH::

    f(x) = x^4 - tx^3 + sx^2 - p^\alpha tx + p^(2\alpha).

    `f(x)` is expected to have roots that multiply in pairs to `p^\alpha`.

    INPUT:

    - ``p`` -- prime integer

    - ``t`` -- integer

    - ``s`` -- integer

    - ``alpha`` -- integer

    OUTPUT:

    The tuple `(p, t_3, s_3, \alpha_3)` such that the roots of
    .. MATH::

    f^2(x) = x^4 - 3tx^3 + 3sx^2 - 3p^(\alpha_3)tx + p^(3\alpha_3)

    are the squares of the roots of `f(x)`.

    EXAMPLES::

        TODO
    """
    return (p, t^3 - 3*s*t + 3*p^alpha*t,
            s^3 - 3*p^alpha*s*t^2 + 3*p^(2*alpha)*t^2
            + 3*p^(2*alpha)*t^2 - 3*p^(2*alpha)*s, 3*alpha)


def power_roots5((p, t, s, alpha)):
    r"""Encode inputs into a quartic and return quartic with fifth-power roots.

    Let f(x) be the quartic polynomial
    .. MATH::

    f(x) = x^4 - tx^3 + sx^2 - p^\alpha tx + p^(2\alpha).

    `f(x)` is expected to have roots that multiply in pairs to `p^\alpha`.

    INPUT:

    - ``p`` -- prime integer

    - ``t`` -- integer

    - ``s`` -- integer

    - ``alpha`` -- integer

    OUTPUT:

    The tuple `(p, t_5, s_5, \alpha_5)` such that the roots of
    .. MATH::

    f^2(x) = x^4 - 5tx^3 + 5sx^2 - 5p^(\alpha_5)tx + p^(5\alpha_5)

    are the squares of the roots of `f(x)`.

    EXAMPLES::

        TODO
    """
    return (p, t^5 - 5*s*t^3 + 5*s^2*t + 5*p^alpha*t^3 - 5*p^alpha*s*t
            - 5*p^(2*alpha)*t,
            s^5 - 5*p^alpha*s^3*t^2 + 5*p^(2*alpha)*s*t^4 + 5*p^(2*alpha)*s^2*t^2
            - 5*p^(3*alpha)*t^4 + 5*p^(2*alpha)*s^2*t^2 - 5*p^(2*alpha)*s^3
            - 5*p^(3*alpha)*t^4 - 5*p^(3*alpha)*s*t^2 + 5*p^(4*alpha)*t^2
            + 5*p^(4*alpha)*t^2 + 5*p^(4*alpha)*s, 5*alpha)


# puts these together to do n=120
def power_roots12((p, t, s, alpha)):
    r"""TODO one-sentence description

    Let f(x) be the quartic polynomial
    .. MATH::

    f(x) = x^4 - tx^3 + sx^2 - p^\alpha tx + p^(2\alpha).

    `f(x)` is expected to have roots that multiply in pairs to `p^\alpha`.

    INPUT:

    - ``p`` -- prime integer

    - ``t`` -- integer

    - ``s`` -- integer

    - ``alpha`` -- integer

    OUTPUT:

    TODO

    EXAMPLES::

        TODO
    """
    return power_roots2(power_roots2(power_roots2(
        power_roots3(power_roots5((p, t, s, alpha))))))


# put these together to do the power actually needed
def power_roots((c, p, t, s, alpha)):
    r"""TODO one-sentence description

    Let f(x) be the quartic polynomial
    .. MATH::

    f(x) = x^4 - tx^3 + sx^2 - p^\alpha tx + p^(2\alpha).

    `f(x)` is expected to have roots that multiply in pairs to `p^\alpha`.

    INPUT:

    - ``c`` -- integer

    - ``p`` -- prime integer

    - ``t`` -- integer

    - ``s`` -- integer

    - ``alpha`` -- integer

    OUTPUT:

    TODO

    EXAMPLES::

        TODO
    """
    ptsa = (p, t, s, alpha)
    while c % 2 == 0:
        c, ptsa = c/2, power_roots2(ptsa)
    while c % 3 == 0:
        c, ptsa = c/3, power_roots3(ptsa)
    while c % 5 == 0:
        c, ptsa = c/5, power_roots5(ptsa)
    return ptsa


# TODO delete comment below
# given a quartic f whose roots multiply to p^alpha in pairs,
# returns the quartic whose roots are the products of roots
# of f that DO NOT multiply to p^alpha
def roots_pairs_not_p((p, t, s, alpha)):
    r"""TODO one-sentence description.

    Let f(x) be the quartic polynomial
    .. MATH::

    f(x) = x^4 - tx^3 + sx^2 - p^\alpha tx + p^(2\alpha).

    `f(x)` is expected to have roots that multiply in pairs to `p^\alpha`.

    INPUT:

    - ``p`` -- prime integer

    - ``t`` -- integer

    - ``s`` -- integer

    - ``alpha`` -- integer

    OUTPUT: TODO is this correct?

    The tuple `(p, t', s', \alpha')` such that the roots of
    .. MATH::

    g(x) = x^4 - t'x^3 + s'x^2 - p^(\alpha')t'x + p^(\alpha')

    are the products of roots of `f` that DO NOT multiply to `p^\alpha`.

    EXAMPLES::

        TODO
    """
    return (p, s - 2*p, p*t^2 - 2*p*s + 2*p^2, 2*alpha)


# t and s are the first and second elementary symmetric functions in the
# roots of the characteristic polynomial of Frobenius at p
def rule_out_1_plus_3_via_Frob_p(c, p, t, s, M):
    r"""TODO one-sentence description.

    Let f(x) be the quartic polynomial
    .. MATH::

    f(x) = x^4 - tx^3 + sx^2 - p^\alpha tx + p^(2\alpha).

    `f(x)` is expected to have roots that multiply in pairs to `p^\alpha`.

    INPUT:

    - ``p`` -- prime integer

    - ``t`` -- TODO type; TODO add description.

    - ``s`` -- TODO type; TODO add description.

    - ``M`` -- TODO type; TODO add description.

    OUTPUT:

    TODO

    EXAMPLES::

        TODO
    """
    p, t12, s12, alpha12 = power_roots((c, p, t, s, 1))
    P12(x) = x^4 - t12*x^3 + s12*x^2 - p^alpha12*t12*x + p^(2*alpha12)
    # print P12(1), P12(p^120)
    return gcd(M, p*P12(1))


def rule_out_2_plus_2_nonselfdual_via_Frob_p(c, p, t, s, M):
    r"""TODO one-sentence description.

    Let f(x) be the quartic polynomial
    .. MATH::

    f(x) = x^4 - tx^3 + sx^2 - p^\alpha tx + p^(2\alpha).

    `f(x)` is expected to have roots that multiply in pairs to `p^\alpha`.

    INPUT:

    - ``p`` -- prime integer

    - ``t`` -- TODO type; TODO add description.

    - ``s`` -- TODO type; TODO add description.

    - ``M`` -- TODO type; TODO add description.

    OUTPUT:

    TODO

    EXAMPLES::

        TODO
    """
    p, tnew, snew, alphanew = roots_pairs_not_p((p, t, s, 1))
    p, tnew, snew, alphanew = power_roots((c, p, tnew, snew, alphanew))
    Pnew(x) = x^4 - tnew*x^3 + snew*x^2 - p^alphanew*tnew*x + p^(2*alphanew)
    return gcd(M, p*Pnew(1)*Pnew(p^c))


# copied from Zev's code
# TODO: delete this and import from somewhere else.
def maximal_square_divisor(N):
    PP = prime_factors(N)
    n = 1
    for p in PP:
        n = n * p^(floor(valuation(N, p)/2))

    return n


# very minimal working example
x = QQ['x'].gen()
# f = x^6 - x^3 - x + 1
f = 3*x^5 + 9*x^4 + 14*x^3 + 39*x^2 + 16
h = x^3
C = HyperellipticCurve(f, h)
Naway2 = genus2reduction(h, f).conductor
d = maximal_square_divisor(2^6*Naway2)
print d
M13 = 0
M22 = 0
for p in prime_range(3, 100):
    if Naway2 % p != 0:
        f = Integers(d)(p).multiplicative_order()
        c = gcd(f, 120)
        Cp = C.change_ring(GF(p))
        fp = Cp.frobenius_polynomial()
        tp = - fp.coefficients(sparse=false)[3]
        sp = fp.coefficients(sparse=false)[2]
        M13 = rule_out_1_plus_3_via_Frob_p(c, p, tp, sp, M13)
        M22 = rule_out_2_plus_2_nonselfdual_via_Frob_p(c, p, tp, sp, M22)
print M13, M22
