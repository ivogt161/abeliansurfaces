r"""

TODO one-line description.

Given a polynomial f, return the primes l where the mod-l galois representation
falls into Case 3.3 of Dieulefait's paper, i.e., splits as a sum of two 2-d
pieces, each self-dual.

This is the bit which uses CuspForms.

This is actually *NOT* what we want to do - we don't want to work with
the newforms directly; but it might be useful to someone for some purpose
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

# Global info
R.<x> = ZZ[]


# TODO delete this and import Zev's function
# Zev's function, copied here for now
def special_divisors(N)
    D0 = [d for d in divisors(N) if d <= sqrt(N)]
    D0.reverse()
    D = []
    for d0 in D0:
            if all([d % d0 != 0 for d in D]):
                    D.append(d0)
            
    D.reverse()
    return D


# TODO delete this and import Zev's function
# Zev's function, copied here for now
def set_up_cuspidal_spaces(N)
    D = special_divisors(N)
    return [CuspForms(d) for d in D]


def basis_of_eigenforms_of_level(t):
    r"""Return a basis of eigenforms of this level.
    TODO what is ``this``?

    TODO longer description

    INPUT:

    - ``t`` -- TODO type; TODO add description

    OUTPUT:

    TODO

    EXAMPLES::

        TODO

    ALGORITHM::

        There is a result in Diamond/Shurman telling us that a basis of
        newforms at each M | N gives us this basis. Since we are probably
        not using this idea anyway, we just quickly deal with the case
        of prime t. If you want to use this properly, then this becomes TODO.

    REFERENCES:

    For more information, see TODO Diamond/Shurman. TODO add in master
    bibliography.
    """
    return CuspForms(t).newforms(names='a')


def left_hand_of_3_8(t, p, f):
    r"""TODO one-sentence description.

    TODO longer description

    INPUT:

    - ``t`` -- TODO type; TODO add description

    - ``p`` -- prime integer

    - ``f`` -- TODO type; TODO add description

    OUTPUT:

    TODO

    EXAMPLES::

        TODO

    ALGORITHM::

        Left hand side of Formula 3.8 in Dieulefait's paper.

    REFERENCES:

    For more information, see TODO Dieulefait. TODO add in master
    bibliography.
    """
    C_p = HyperellipticCurve(f).base_extend(GF(p))
    Pol_p = R(C_p.frobenius_polynomial())
    polys_in_prod = [(x^2 - f[p]*x + p) for f in basis_of_eigenforms_of_level(t)]
    the_prod_poly = prod(polys_in_prod)
    return the_prod_poly.resultant(Pol_p)


def get_two_dim_self_dual_primes(f):
    r"""Main calling function.

    TODO longer description

    INPUT:

    - ``f`` -- TODO type; TODO add description

    OUTPUT:

    TODO

    EXAMPLES::

        TODO

    """
    N_away_2 = genus2reduction(0,f).conductor  # Dieulefait calls this c (kinda)

    S = special_divisors(N_away_2)

    final_primes = set()

    for t in S:
        left_hand_of_3_8_list = []
        for p in primes(3,100):
            if N_away_2 % p != 0:
                left_hand_of_3_8_list.append(left_hand_of_3_8(t,p,f))
        gcd_of_this_list = gcd(left_hand_of_3_8_list)
        final_primes = final_primes.union(set(prime_divisors(gcd_of_this_list)))

    return final_primes
