r"""

TODO add description

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

# TODO: what is this line below?
︠e08a72fb-aae8-4759-a840-c3c1cf09504es︠
def sub_list(l):
    r"""
    Characteristic polynomials of maximal subgroups.

    Precomputed characteristic polynomials of certain maximal subgroups of
    `\text{GSp}(4, \ell)` for small primes `\ell`. The prime `\ell` is expected
    to be `2`, `3`, `5`, or `7`.

    INPUT:

    - ``l`` -- a prime integer.

    OUTPUT:

    A list of sets. Each set consists of the characteristic polynomials of the
    elements some maximal subgroup of `\text{GSp}(4,\ell)`. More specifically,

        - if `\ell = 2`, then the list contains the sets for all maximal
          subgroups of `\text{GSp}(4,2)`, except for the maximal subgroup that
          is isomorphic to `A_6`. Since all degree `4` polynomials over
          `\GF{2}` arise as characteristic polynomials for that subgroup, the
          subgroup must be dealt with differently.

        - if `\ell = 3` or `5`, then the list contains the sets for all
          maximal subgroups of `\text{GSp}(4,\ell)`.

        - if `\ell = 7`, then the list contains the sets for the only
          exceptional maximal subgroup of `\text{GSp}(4,7)`.

    EXAMPLES::

        TODO
    """
    if l not in [2, 3, 5, 7]:
        raise Exception("l must be 2,3,5 or 7")
    S.<x> = PolynomialRing(Zmod(l))
    if l == 2:
        CHAR2 = [
            {
                x^4 + x^2 + 1,
                x^4 + 1
            },
            {
                x^4 + 1,
                x^4 + x^3 + x + 1
            },
            {
                x^4 + x^2 + 1,
                x^4 + 1,
                x^4 + x^3 + x + 1
            },
            {
                x^4 + 1,
                x^4 + x^3 + x^2 + x + 1,
                x^4 + x^3 + x + 1
            },
            {
                x^4 + x^2 + 1,
                x^4 + 1,
                x^4 + x^3 + x^2 + x + 1
            }
        ]
        return CHAR2
    if l == 3:
        CHAR3 = [
            {
                x^4 + x^2 + 1,
                x^4 + 1,
                x^4 + x^3 + x + 1,
                x^4 + x^3 + 2*x^2 + 2*x + 1,
                x^4 + 2*x^3 + 2*x + 1,
                x^4 + 2*x^2 + 1,
                x^4 + 2*x^3 + 2*x^2 + x + 1
            },
            {
                x^4 + x^2 + 1,
                x^4 + 2*x^3 + x^2 + x + 1,
                x^4 + x^3 + 2*x^2 + x + 1,
                x^4 + 2*x^3 + 2*x^2 + 2*x + 1,
                x^4 + x^3 + x + 1,
                x^4 + 2*x^3 + 2*x + 1,
                x^4 + x^3 + x^2 + 2*x + 1
            },
            {
                x^4 + 2*x^3 + x^2 + 2*x + 1,
                x^4 + 1,
                x^4 + 2*x^3 + x + 1,
                x^4 + 2*x^3 + 2*x + 1,
                x^4 + x^3 + 2*x^2 + 2*x + 1,
                x^4 + x^3 + x^2 + x + 1,
                x^4 + 2*x^2 + 1,
                x^4 + 2*x^3 + 2*x^2 + x + 1,
                x^4 + x^3 + x + 1,
                x^4 + x^3 + 2*x + 1,
                x^4 + x^2 + 1
            },
            {
                x^4 + 1,
                x^4 + x^3 + 2*x^2 + x + 1,
                x^4 + 2*x^3 + 2*x + 1,
                x^4 + x^3 + 2*x^2 + 2*x + 1,
                x^4 + x^3 + x^2 + 2*x + 1,
                x^4 + 2*x^2 + 1,
                x^4 + x^3 + x + 1,
                x^4 + 2*x^3 + 2*x^2 + x + 1,
                x^4 + 2*x^3 + 2*x^2 + 2*x + 1,
                x^4 + x^2 + 1,
                x^4 + 2*x^3 + x^2 + x + 1
            },
            {
                x^4 + 2*x^3 + x^2 + 2*x + 1,
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
            },
            {
                x^4 + x^2 + 1,
                x^4 + x^3 + 2*x^2 + x + 1,
                x^4 + 1,
                x^4 + x^3 + x^2 + x + 1,
                x^4 + 2*x^3 + 2*x^2 + 2*x + 1,
                x^4 + x^3 + x + 1,
                x^4 + 2*x^3 + x^2 + 2*x + 1,
                x^4 + 2*x^3 + 2*x + 1,
                x^4 + 2*x^2 + 1
            }
        ]
        return CHAR3
    if l == 5:
        CHAR5 = [
            {
                x^4 + 1,
                x^4 + 2*x^3 + 4*x^2 + 3*x + 1,
                x^4 + 2*x^3 + 3*x + 1,
                x^4 + x^3 + x + 1,
                x^4 + 4*x^3 + 4*x^2 + 3*x + 4,
                x^4 + 3*x^2 + 4,
                x^4 + x^2 + 4,
                x^4 + 3*x^3 + 4*x^2 + 2*x + 1,
                x^4 + 4*x^3 + 4*x + 1,
                x^4 + 3*x^3 + 2*x + 1,
                x^4 + 3*x^3 + x^2 + 4*x + 4,
                x^4 + 3*x^2 + 1,
                x^4 + 2*x^3 + x^2 + x + 4,
                x^4 + x^3 + x^2 + x + 1,
                x^4 + 4*x^3 + 2*x^2 + x + 1,
                x^4 + 2*x^3 + 3*x^2 + 2*x + 1,
                x^4 + 4*x^2 + 4,
                x^4 + x^3 + 4*x^2 + 2*x + 4,
                x^4 + 3*x^3 + 3*x^2 + 3*x + 1,
                x^4 + 2*x^2 + 4,
                x^4 + 4,
                x^4 + x^3 + 2*x^2 + 4*x + 1,
                x^4 + 4*x^3 + x^2 + 4*x + 1,
                x^4 + 2*x^2 + 1
            },
            {
                x^4 + 1,
                x^4 + 2*x^3 + 2*x^2 + x + 4,
                x^4 + 2*x^3 + 4*x^2 + 3*x + 1,
                x^4 + 2*x^3 + 2*x^2 + 3*x + 1,
                x^4 + 4*x^3 + 3*x^2 + x + 1,
                x^4 + x^3 + 3*x^2 + 3*x + 4,
                x^4 + 2*x^3 + 2*x^2 + 2*x + 1,
                x^4 + 3*x^3 + 2*x^2 + x + 4,
                x^4 + 3*x^2 + 4,
                x^4 + x^3 + 3*x^2 + 2*x + 4,
                x^4 + 3*x^3 + x + 4,
                x^4 + 3*x^3 + 2*x^2 + 3*x + 1,
                x^4 + x^2 + 4,
                x^4 + x^3 + 3*x^2 + 4*x + 1,
                x^4 + 3*x^3 + 4*x^2 + 2*x + 1,
                x^4 + 4*x^3 + 2*x + 4,
                x^4 + 3*x^3 + 2*x^2 + 2*x + 1,
                x^4 + 3*x^2 + 1,
                x^4 + x^2 + 1,
                x^4 + x^3 + 3*x^2 + x + 1,
                x^4 + x^3 + x^2 + x + 1,
                x^4 + 4*x^3 + 2*x^2 + x + 1,
                x^4 + 2*x^3 + 3*x^2 + 2*x + 1,
                x^4 + x^3 + 3*x + 4,
                x^4 + 4*x^3 + 3*x^2 + 3*x + 4,
                x^4 + 4*x^2 + 4,
                x^4 + 3*x^3 + 3*x^2 + 3*x + 1,
                x^4 + 2*x^2 + 4,
                x^4 + 2*x^3 + 2*x^2 + 4*x + 4,
                x^4 + 4,
                x^4 + 2*x^3 + 4*x + 4,
                x^4 + x^3 + 2*x^2 + 4*x + 1,
                x^4 + 4*x^3 + 3*x^2 + 2*x + 4,
                x^4 + 4*x^3 + 3*x^2 + 4*x + 1,
                x^4 + 4*x^3 + x^2 + 4*x + 1,
                x^4 + 3*x^3 + 2*x^2 + 4*x + 4,
                x^4 + 4*x^2 + 1,
                x^4 + 2*x^2 + 1
            },
            {
                x^4 + x^3 + 3*x^2 + 2*x + 4,
                x^4 + 4*x^3 + 3*x^2 + 3*x + 4,
                x^4 + x^3 + x^2 + x + 1,
                x^4 + x^3 + x + 1,
                x^4 + 4*x^2 + 1,
                x^4 + 3*x^2 + 1,
                x^4 + 4*x^3 + 3*x^2 + 4*x + 1,
                x^4 + 2*x^2 + 1,
                x^4 + x^2 + 1,
                x^4 + 2*x^3 + 4*x^2 + 3*x + 1,
                x^4 + 1,
                x^4 + 4*x^3 + x^2 + 4*x + 1,
                x^4 + 4*x^3 + 2*x^2 + x + 1,
                x^4 + 4*x^3 + 3*x^2 + 2*x + 4,
                x^4 + 4*x^3 + 4*x + 1,
                x^4 + 2*x^3 + 2*x^2 + 3*x + 1,
                x^4 + 4*x^3 + x^2 + x + 1,
                x^4 + 3*x^3 + 4*x^2 + 3*x + 1,
                x^4 + 2*x^3 + 2*x^2 + 4*x + 4,
                x^4 + 3*x^3 + 3*x^2 + 3*x + 1,
                x^4 + 4*x^3 + 2*x + 4,
                x^4 + 2*x^3 + 3*x + 1,
                x^4 + 2*x^3 + 2*x^2 + x + 4,
                x^4 + 2*x^3 + 4*x + 4,
                x^4 + 4*x^2 + 4,
                x^4 + 2*x^3 + x^2 + x + 4,
                x^4 + 3*x^3 + 2*x^2 + 4*x + 4,
                x^4 + 3*x^2 + 4,
                x^4 + 3*x^3 + x^2 + 4*x + 4,
                x^4 + x^3 + 3*x^2 + 3*x + 4,
                x^4 + 2*x^2 + 4,
                x^4 + 3*x^3 + 2*x^2 + x + 4,
                x^4 + 2*x^3 + 4*x^2 + 2*x + 1,
                x^4 + x^2 + 4,
                x^4 + 2*x^3 + 3*x^2 + 2*x + 1,
                x^4 + 4,
                x^4 + 3*x^3 + x + 4,
                x^4 + x^3 + 3*x + 4,
                x^4 + 3*x^3 + 4*x^2 + 2*x + 1,
                x^4 + 3*x^3 + 2*x^2 + 2*x + 1,
                x^4 + x^3 + 2*x^2 + 4*x + 1,
                x^4 + 4*x^3 + 4*x^2 + 3*x + 4,
                x^4 + x^3 + 4*x^2 + 2*x + 4,
                x^4 + x^3 + 3*x^2 + x + 1,
                x^4 + x^3 + x^2 + 4*x + 1,
                x^4 + 3*x^3 + 2*x + 1
            },
            {
                x^4 + 1,
                x^4 + 2*x^3 + 2*x^2 + x + 4,
                x^4 + 2*x^3 + 4*x^2 + 3*x + 1,
                x^4 + 4*x^3 + 3*x^2 + x + 1,
                x^4 + x^3 + 3*x^2 + 3*x + 4,
                x^4 + 2*x^3 + 2*x^2 + 2*x + 1,
                x^4 + x^3 + x^2 + 3*x + 4,
                x^4 + 3*x^3 + 4*x^2 + x + 4,
                x^4 + 3*x^3 + 2*x^2 + x + 4,
                x^4 + 3*x^2 + 4,
                x^4 + x^3 + 3*x^2 + 2*x + 4,
                x^4 + 3*x^3 + 2*x^2 + 3*x + 1,
                x^4 + x^2 + 4,
                x^4 + x^3 + 3*x^2 + 4*x + 1,
                x^4 + 3*x^3 + 4*x^2 + 2*x + 1,
                x^4 + 3*x^2 + 1,
                x^4 + x^2 + 1,
                x^4 + x^3 + x^2 + x + 1,
                x^4 + 4*x^3 + 2*x^2 + x + 1,
                x^4 + 2*x^3 + 3*x^2 + 2*x + 1,
                x^4 + 4*x^3 + 3*x^2 + 3*x + 4,
                x^4 + 4*x^2 + 4,
                x^4 + 2*x^3 + 4*x^2 + 4*x + 4,
                x^4 + 2*x^3 + 2*x^2 + 4*x + 4,
                x^4 + 2*x^2 + 4,
                x^4 + 3*x^3 + 3*x^2 + 3*x + 1,
                x^4 + 4,
                x^4 + x^3 + 2*x^2 + 4*x + 1,
                x^4 + 4*x^3 + 3*x^2 + 2*x + 4,
                x^4 + 4*x^3 + x^2 + 2*x + 4,
                x^4 + 4*x^3 + x^2 + 4*x + 1,
                x^4 + 3*x^3 + 2*x^2 + 4*x + 4,
                x^4 + 4*x^2 + 1,
                x^4 + 2*x^2 + 1
            },
            {
                x^4 + x^3 + 2*x + 4,
                x^4 + 4*x^3 + x^2 + 4*x + 1,
                x^4 + 4*x^3 + 3*x^2 + 4*x + 1,
                x^4 + 2*x^3 + x + 4,
                x^4 + x^3 + 3*x + 4,
                x^4 + x^3 + 2*x^2 + 3*x + 4,
                x^4 + 2*x^3 + 2*x^2 + x + 4,
                x^4 + 2*x^3 + 4*x^2 + x + 4,
                x^4 + 3*x^3 + x + 4,
                x^4 + 3*x^3 + 2*x^2 + x + 4,
                x^4 + 1,
                x^4 + 2*x^2 + 1,
                x^4 + 2*x^3 + 4*x + 4,
                x^4 + 4*x^2 + 1,
                x^4 + 2*x^3 + 2*x^2 + 4*x + 4,
                x^4 + 4*x^3 + 2*x + 4,
                x^4 + 3*x^3 + 4*x + 4,
                x^4 + 4*x^3 + 2*x^2 + 2*x + 4,
                x^4 + 3*x^3 + 2*x^2 + 4*x + 4,
                x^4 + 3*x^3 + 4*x^2 + 4*x + 4,
                x^4 + 4*x^3 + 3*x + 4,
                x^4 + x^3 + 4*x^2 + x + 1,
                x^4 + x^3 + 4*x + 1,
                x^4 + 2*x^3 + 2*x + 1,
                x^4 + x^3 + 2*x^2 + 4*x + 1,
                x^4 + x^3 + 4*x^2 + 4*x + 1,
                x^4 + 2*x^3 + 2*x^2 + 3*x + 1,
                x^4 + 2*x^3 + 4*x^2 + 3*x + 1,
                x^4 + x^2 + 4,
                x^4 + 3*x^3 + 2*x^2 + 2*x + 1,
                x^4 + 3*x^2 + 4,
                x^4 + 3*x^3 + 4*x^2 + 2*x + 1,
                x^4 + 4*x^3 + x + 1,
                x^4 + 3*x^3 + 3*x + 1,
                x^4 + 4*x^3 + 2*x^2 + x + 1,
                x^4 + 4*x^3 + 4*x^2 + x + 1,
                x^4 + x^3 + x^2 + 2*x + 4,
                x^4 + 4*x^3 + 4*x^2 + 4*x + 1,
                x^4 + x^3 + 3*x^2 + 2*x + 4,
                x^4 + x^3 + 3*x^2 + 3*x + 4,
                x^4 + 3*x^3 + 3*x^2 + x + 4,
                x^4 + x^2 + 1,
                x^4 + 3*x^2 + 1,
                x^4 + 2*x^3 + 3*x^2 + 4*x + 4,
                x^4 + 4*x^3 + 3*x^2 + 2*x + 4,
                x^4 + x^3 + x^2 + x + 1,
                x^4 + 4*x^3 + x^2 + 3*x + 4,
                x^4 + x^3 + 3*x^2 + x + 1,
                x^4 + 4*x^3 + 3*x^2 + 3*x + 4,
                x^4 + 2*x^3 + x^2 + 2*x + 1,
                x^4 + 2*x^3 + 3*x^2 + 2*x + 1,
                x^4 + 2*x^3 + x^2 + 3*x + 1,
                x^4 + 4,
                x^4 + 3*x^3 + x^2 + 2*x + 1,
                x^4 + 2*x^2 + 4,
                x^4 + 4*x^2 + 4,
                x^4 + 3*x^3 + x^2 + 3*x + 1,
                x^4 + 3*x^3 + 3*x^2 + 3*x + 1
            },
            {
                x^4 + 2*x^3 + 2*x^2 + x + 4,
                x^4 + 2*x^3 + 4*x^2 + 3*x + 1,
                x^4 + x^3 + 2*x^2 + x + 1,
                x^4 + 2*x^3 + 3*x + 1,
                x^4 + x^3 + x + 1,
                x^4 + 4*x^3 + 3*x^2 + x + 1,
                x^4 + 2*x^3 + 4*x^2 + 2*x + 1,
                x^4 + 4*x^3 + x^2 + x + 1,
                x^4 + 2*x^3 + 2*x^2 + 2*x + 1,
                x^4 + x^3 + x^2 + 3*x + 4,
                x^4 + 3*x^3 + 4*x^2 + x + 4,
                x^4 + 4*x^3 + 2*x^2 + 3*x + 4,
                x^4 + x^3 + 3*x^2 + 2*x + 4,
                x^4 + 3*x^3 + 4*x^2 + 3*x + 1,
                x^4 + 3*x^3 + 2*x^2 + 3*x + 1,
                x^4 + 2*x^3 + x^2 + 4*x + 4,
                x^4 + x^3 + 3*x^2 + 4*x + 1,
                x^4 + 4*x^3 + 4*x^2 + 2*x + 4,
                x^4 + x^3 + x^2 + 4*x + 1,
                x^4 + 3*x^3 + 4*x^2 + 2*x + 1,
                x^4 + 4*x^3 + 2*x^2 + 4*x + 1,
                x^4 + 3*x^3 + 2*x + 1,
                x^4 + 4*x^3 + 4*x + 1,
                x^4 + 3*x^3 + 3*x^2 + 4*x + 4,
                x^4 + 3*x^2 + 1,
                x^4 + 2*x^3 + 3*x^2 + x + 4,
                x^4 + 2*x^3 + 3*x^2 + 3*x + 1,
                x^4 + x^3 + x^2 + x + 1,
                x^4 + x^3 + 4*x^2 + 3*x + 4,
                x^4 + 4*x^3 + 3*x^2 + 3*x + 4,
                x^4 + 2*x^3 + 4*x^2 + 4*x + 4,
                x^4 + 3*x^3 + x^2 + x + 4,
                x^4 + x^3 + 2*x^2 + 2*x + 4,
                x^4 + 4,
                x^4 + 4*x^3 + x^2 + 2*x + 4,
                x^4 + 3*x^3 + 3*x^2 + 2*x + 1,
                x^4 + 4*x^3 + x^2 + 4*x + 1,
                x^4 + 3*x^3 + 2*x^2 + 4*x + 4,
                x^4 + 2*x^2 + 1
            },
            {
                x^4 + 1,
                x^4 + 2*x^3 + 2*x^2 + x + 4,
                x^4 + 2*x^3 + 4*x^2 + 3*x + 1,
                x^4 + 2*x^3 + 2*x^2 + 3*x + 1,
                x^4 + 4*x^3 + 3*x^2 + x + 1,
                x^4 + x^3 + 3*x^2 + 3*x + 4,
                x^4 + 2*x^3 + 2*x^2 + 2*x + 1,
                x^4 + 3*x^3 + 2*x^2 + x + 4,
                x^4 + 3*x^2 + 4,
                x^4 + x^3 + 3*x^2 + 2*x + 4,
                x^4 + 3*x^3 + x + 4,
                x^4 + 3*x^3 + 2*x^2 + 3*x + 1,
                x^4 + x^2 + 4,
                x^4 + x^3 + 3*x^2 + 4*x + 1,
                x^4 + 3*x^3 + 4*x^2 + 2*x + 1,
                x^4 + 4*x^3 + 2*x + 4,
                x^4 + 3*x^3 + 2*x^2 + 2*x + 1,
                x^4 + 3*x^2 + 1,
                x^4 + x^2 + 1,
                x^4 + x^3 + 3*x^2 + x + 1,
                x^4 + x^3 + x^2 + x + 1,
                x^4 + 4*x^3 + 2*x^2 + x + 1,
                x^4 + 2*x^3 + 3*x^2 + 2*x + 1,
                x^4 + x^3 + 3*x + 4,
                x^4 + 4*x^3 + 3*x^2 + 3*x + 4,
                x^4 + 4*x^2 + 4,
                x^4 + 3*x^3 + 3*x^2 + 3*x + 1,
                x^4 + 2*x^2 + 4,
                x^4 + 2*x^3 + 2*x^2 + 4*x + 4,
                x^4 + 4,
                x^4 + 2*x^3 + 4*x + 4,
                x^4 + x^3 + 2*x^2 + 4*x + 1,
                x^4 + 4*x^3 + 3*x^2 + 2*x + 4,
                x^4 + 4*x^3 + 3*x^2 + 4*x + 1,
                x^4 + 4*x^3 + x^2 + 4*x + 1,
                x^4 + 3*x^3 + 2*x^2 + 4*x + 4,
                x^4 + 4*x^2 + 1,
                x^4 + 2*x^2 + 1
            },
            {
                x^4 + 4*x^3 + x^2 + 4*x + 1,
                x^4 + x^3 + 2*x^2 + 2*x + 4,
                x^4 + x^3 + 4*x^2 + 2*x + 4,
                x^4 + x^3 + 3*x + 4,
                x^4 + 2*x^3 + 2*x^2 + x + 4,
                x^4 + x^3 + 4*x^2 + 3*x + 4,
                x^4 + 3*x^3 + x + 4,
                x^4 + 3*x^3 + 4*x^2 + x + 4,
                x^4 + 1,
                x^4 + 2*x^2 + 1,
                x^4 + 2*x^3 + 4*x + 4,
                x^4 + 4*x^2 + 1,
                x^4 + 2*x^3 + 4*x^2 + 4*x + 4,
                x^4 + 4*x^3 + 2*x + 4,
                x^4 + 3*x^3 + 2*x^2 + 4*x + 4,
                x^4 + 4*x^3 + 4*x^2 + 2*x + 4,
                x^4 + x^3 + x + 1,
                x^4 + x^3 + 2*x^2 + x + 1,
                x^4 + 4*x^3 + 2*x^2 + 3*x + 4,
                x^4 + 4*x^3 + 4*x^2 + 3*x + 4,
                x^4 + 2*x^3 + 2*x^2 + 2*x + 1,
                x^4 + x^3 + 2*x^2 + 4*x + 1,
                x^4 + 2*x^3 + 4*x^2 + 2*x + 1,
                x^4 + 2*x^3 + 3*x + 1,
                x^4 + 2*x^3 + 4*x^2 + 3*x + 1,
                x^4 + 3*x^3 + 2*x + 1,
                x^4 + x^2 + 4,
                x^4 + 3*x^2 + 4,
                x^4 + 3*x^3 + 4*x^2 + 2*x + 1,
                x^4 + 4*x^3 + 2*x^2 + x + 1,
                x^4 + 3*x^3 + 2*x^2 + 3*x + 1,
                x^4 + 3*x^3 + 4*x^2 + 3*x + 1,
                x^4 + 4*x^3 + 4*x + 1,
                x^4 + 4*x^3 + 2*x^2 + 4*x + 1,
                x^4 + x^3 + 3*x^2 + 2*x + 4,
                x^4 + 2*x^3 + x^2 + x + 4,
                x^4 + x^3 + x^2 + 3*x + 4,
                x^4 + 2*x^3 + 3*x^2 + x + 4,
                x^4 + 3*x^3 + x^2 + x + 4,
                x^4 + x^2 + 1,
                x^4 + 3*x^2 + 1,
                x^4 + 2*x^3 + x^2 + 4*x + 4,
                x^4 + 4*x^3 + x^2 + 2*x + 4,
                x^4 + 3*x^3 + x^2 + 4*x + 4,
                x^4 + 3*x^3 + 3*x^2 + 4*x + 4,
                x^4 + x^3 + x^2 + x + 1,
                x^4 + 4*x^3 + 3*x^2 + 3*x + 4,
                x^4 + x^3 + x^2 + 4*x + 1,
                x^4 + 2*x^3 + 3*x^2 + 2*x + 1,
                x^4 + x^3 + 3*x^2 + 4*x + 1,
                x^4 + 2*x^3 + 3*x^2 + 3*x + 1,
                x^4 + 4,
                x^4 + 2*x^2 + 4,
                x^4 + 3*x^3 + 3*x^2 + 2*x + 1,
                x^4 + 4*x^2 + 4,
                x^4 + 4*x^3 + x^2 + x + 1,
                x^4 + 4*x^3 + 3*x^2 + x + 1,
                x^4 + 3*x^3 + 3*x^2 + 3*x + 1
            },
            {
                x^4 + x^3 + 2*x^2 + x + 1,
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
            }
        ]
        return CHAR5
    if l==7:
        #CHAR7 contains the characteristic polynomials for the only exeptional maximal subgroup of GSp(4,7)
        CHAR7 = [
        {
            x^4 + 2*x^3 + 5*x^2 + 5*x + 1,
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
        }
        ]
        return CHAR7

# TODO: what is this line below?
︡3249f201-e03c-474f-86cf-474d2e4113be︡{"done":true}
︠da9d5bde-e4af-4ecf-8330-f8c945fcd99aw︠

# TODO: Consider making this (weakly) private.
def initialize_witnesses(L,ruled_out):
    r"""
    EXAMPLES::

        TODO
    """
    witnesses = {}
    for l in L:
        if l < 7: witnesses[l] = [0]*len(sub_list(l))
        else:
            if l == 7: witnesses[l] = [0]*4
            else: witnesses[l] = [0]*3
            if l in ruled_out:
                if ruled_out[l][0]: witnesses[l][0] = -2
                if ruled_out[l][1]: witnesses[l][1] = -2
                if ruled_out[l][2]: witnesses[l][2] = -2
    return witnesses

#initialize_witnesses([2,5,7,11,17],{7:[False,True,True], 11:[True,False,True], 17:[True,False,False]})

# TODO: Consider making this (weakly) private.
def initialize_char(L):
    r"""
    EXAMPLES::

        TODO
    """
    CHAR = {}
    for l in L:
        if l in [2,3,5,7]:
            CHAR[l] = sub_list(l)
    return CHAR

def inA6at2(H):
    r"""
    EXAMPLES::

        TODO
    """
    Q,P = H.hyperelliptic_polynomials()
    curve = genus2reduction(P,Q)
    disc = curve.minimal_disc
    if disc.is_square(): return True
    return False

# TODO: ``poor_mans_conductor`` is already implemented in ``nonmaximal.py``.
def poor_mans_conductor(C):
    f,h = C.hyperelliptic_polynomials()
    red_data = genus2reduction(h,f)
    N = red_data.conductor
    if red_data.prime_to_2_conductor_only:
        N = 2*N
    return N

# TODO: consider making this (weakly) private.
def chk_brk(witnesses):
    r"""TODO a one-sentence description.

    INPUT:

    - ``witnesses`` -- TODO type; TODO description

    OUTPUT: TODO

    EXAMPLES::

        TODO
    """
    for wit in witnesses:
        if 0 in witnesses[wit]: return False
    return True

# TODO: consider making this (weakly) private.
def clean_list(L):
    r"""Return a new sorted list of distinct items.

    INPUT:

    - ``L`` -- list

    OUTPUT: A sorted list whose items are the distinct items of ``L``

    EXAMPLES::

        TODO
    """
    L = list(set(L))
    L.sort()
    return L

# TODO consider making this (weakly) private.
# TODO Consider changing the name of this function because it is too vague.
def return_data(witnesses,verbose):
    r"""TODO add description

    INPUT:

    - ``witnesses`` -- TODO type; TODO add description

    - ``verbose`` -- TODO type; TODO add description

    OUTPUT: TODO

    EXAMPLES::

        TODO
    """
    if verbose == True: return witnesses
    non_surj_primes = []
    for l in L:
        if 0 in witnesses[l]: non_surj_primes.append(l)
    return non_surj_primes

# Tests return true if corresponding max sub is found to not contain image of Galois
def is_ired_poly(fmod_factored):
    r"""TODO add description: what is meant by max sub?

    INPUT:

    - ``fmod_factored`` -- TODO type; TODO add description

    OUTPUT: TODO

    EXAMPLES::

        TODO
    """
    return len(fmod_factored) == 1 and fmod_factored[0][1] == 1

def trace_poly(fmod):
    r"""TODO add description

    INPUT:

    - ``fmod`` -- TODO type; TODO add description

    OUTPUT: TODO

    EXAMPLES::

        TODO
    """
    return -fmod[fmod.degree()-1]

def surj_test12(fmod_factored):
    r"""TODO add description

    INPUT:

    - ``fmod_factored`` -- TODO type; TODO add description

    OUTPUT: TODO

    EXAMPLES::

        TODO
    """
    return is_ired_poly(fmod_factored)

def surj_test35(fmod, fmod_factored):
    r"""TODO add description

    INPUT:

    - ``fmod`` -- TODO type; TODO add description

    - ``fmod_factored`` -- TODO type; TODO add description

    OUTPUT: TODO

    EXAMPLES::

        TODO
    """
    return is_ired_poly(fmod_factored) and trace_poly(fmod) != 0

def surj_test4(fmod, fmod_factored):
    r"""TODO add description

    INPUT:

    - ``fmod`` -- TODO type; TODO add description

    - ``fmod_factored`` -- TODO type; TODO add description

    OUTPUT: TODO

    EXAMPLES::

        TODO
    """
    if trace_poly(fmod) != 0:
        for fact in fmod_factored:
            if fact[0].degree() == 1 and fact[1] % 2 != 0: return True
    return False

def surj_tests(C,CHAR,l,p,f,wit):
    r"""TODO add description

    The primes `l` and `p` are expected to be distinct.

    INPUT:

    - ``C`` -- TODO type; TODO add description

    - ``CHAR`` -- TODO type; TODO add description

    - ``l`` -- prime integer; TODO add description

    - ``p`` -- prime integer; TODO add description

    - ``f`` -- TODO type; TODO add description

    - ``wit`` -- TODO type; TODO add description

    OUTPUT: TODO

    EXAMPLES::

        TODO
    """
    fmod = f.change_ring(Zmod(l))
    for i in range(0,len(wit)):
        if wit[i] == 0:
            if l < 7:
                if not fmod in CHAR[l][i]:  wit[i] = p
            if l == 7 and i == 3:
                if not fmod in CHAR[l][0]:  wit[i] = p
            if l >= 7:
                fmod_factored = fmod.factor()
                if surj_test12(fmod_factored): wit[0] = p
                if surj_test35(fmod,fmod_factored): wit[1] = p
                if surj_test4(fmod,fmod_factored): wit[2] = p
    return wit

# Inputs: genus two hyperelliptic curve H, 
# list of primes L, 
# (optionally0) verbose mode, 
# (optionally1) a bound on p to check, 
# (optionally2) a dictionary with key-value pairs (l,[bool_1,bool_2]), 
# and (optionally3) a dictionary with key-value pairs (l,list). 
# For optionally2, bool_1 indicates whether reducible at l is already ruled out (bool_1 == True means ruled out)
# and bool_2 indicates whether irreducible at l is ruled out. 
# For optionally. If verbose mode is on, then return witnesses to non-surjectivity; 
# otherwise just outputs a list of nonsurjective primes
# TODO: what is optionally3? Is it ``ruled_out``? I see only 3 arguments
def is_surj(H,L,verbose=False,bound=10^3,ruled_out={}):
    r"""TODO add description

    INPUT:

    - ``H`` -- HyperellipticCurve ; genus `2` over `\QQ`.

    - ``L`` -- list of prime integers

    - ``verbose`` -- bool (default: ``False``); if ``True``, then return witnesses
      to non-surjectivitiy.

    - ``bound`` -- integer (default: `10^3`); a bound on the primes `p` being checked.

    - ``ruled_out`` -- dict; The key-value pairs are of the form 
      (`l`,[``bool_1``,``bool_2``]) where `l` is a prime integer. ``bool_1`` indicates whether reducible (TODO: the reducible what?)
      at `l` is already ruled out. ``bool_2`` indicates whether irreducible (TODO: the irreducible what?)
      at `l` is ruled out.

    - TODO: what about optionally3?

    OUTPUT: 
    
    Returns ``True`` if TODO. ``False`` otherwise.
    If ``verbose`` is ``True``, then also return a list of primes `p` such that ...(TODO: is this correct?)

    EXAMPLES::

        TODO
    """
    C = poor_mans_conductor(H)
    L = clean_list(L)
    witnesses = initialize_witnesses(L,ruled_out)
    CHAR = initialize_char(L)
    if 2 in L and inA6at2(H) == True: witnesses[2] = [-1]*len(sub_list(2))
    for p in primes(3,bound):
        if C % p != 0:
            Hp = H.change_ring(GF(p))
            f = Hp.frobenius_polynomial()
            for l in L:
                if p !=l and 0 in witnesses[l]:
                    #print(l,p,surj_tests(C,CHAR,l,p,f,witnesses[l]))
                    witnesses[l] = surj_tests(C,CHAR,l,p,f,witnesses[l])
        if chk_brk(witnesses) == True: break
    return return_data(witnesses,verbose)

# TODO: move this to the top of document as per PEP 8.
from tabulate import tabulate

def results(H,L):
    r"""TODO add description

    INPUT:

    - ``H`` -- HyperellipticCurve ; genus `2` over `\QQ`.

    - ``L`` -- list of prime integers

    EXAMPLES::

        TODO
    """
    conclusions= {}
    witnesses = is_surj(H,L,verbose=True)
    for l in L:
        if -2 in witnesses[l] or -1 in witnesses[l] or 0 in witnesses[l]:            
            conclusions[l] = "Not surjective at "+str(l)
        else:            
            conclusions[l] = "Surjective at "+str(l)
    resultstable = [(conclusions[l].strip(), witnesses[l]) for l in L]
    print(tabulate(resultstable, headers=["Conclusions", "Frobenius witnesses for each maximal subgroup"]))
    print("")



︡65552326-83a7-4c44-bc9f-cb5f97470054︡{"done":true}
︠350731ff-ea24-49b9-807f-c85a058beccfsw︠



R.<x> = PolynomialRing(ZZ)
L = list(primes(100))

#Noam's other example
H = HyperellipticCurve(-4843877212*x^6 + 933119476*x^5 - 471005881*x^4 - 28035676*x^3 - 6086587*x^2 - 671923*x - 18584,0); H
results(H,L)

︡e2a4d565-a64d-42e7-8ecd-316ea758af91︡{"stdout":"Hyperelliptic Curve over Integer Ring defined by y^2 = -4843877212*x^6 + 933119476*x^5 - 471005881*x^4 - 28035676*x^3 - 6086587*x^2 - 671923*x - 18584\n"}︡{"stdout":"conclusions          Frobenius witnesses for each maximal subgroup\n-------------------  -----------------------------------------------\nSurjective at 2      [3, 3, 3, 5, 19]\nNot surjective at 3  [17, 13, 0, 17, 17, 17]\nSurjective at 5      [3, 3, 3, 3, 3, 7, 3, 7, 3]\nSurjective at 7      [23, 23, 17, 3]\nSurjective at 11     [3, 3, 13]\nSurjective at 13     [23, 23, 19]\nSurjective at 17     [19, 19, 41]\nSurjective at 19     [13, 13, 23]\nSurjective at 23     [31, 31, 29]\nSurjective at 29     [19, 19, 23]\nSurjective at 31     [3, 3, 7]\nSurjective at 37     [19, 19, 29]\nSurjective at 41     [3, 3, 19]\nSurjective at 43     [29, 29, 31]\nSurjective at 47     [3, 3, 13]\nSurjective at 53     [13, 13, 17]\nSurjective at 59     [37, 37, 29]\nSurjective at 61     [17, 17, 13]\nSurjective at 67     [13, 13, 3]\nSurjective at 71     [43, 43, 41]\nSurjective at 73     [3, 3, 7]\nSurjective at 79     [13, 13, 7]\nSurjective at 83     [61, 61, 59]\nSurjective at 89     [3, 3, 19]\nSurjective at 97     [3, 3, 7]"}︡{"stdout":"\n\n"}︡{"done":true}
︠5577232e-a05b-40b9-afc4-ed6d029e48d8r︠


H = HyperellipticCurve(3628260*x^6 - 1222632*x^5 - 3709872*x^4 + 2955424*x^3 + 2006931*x^2 - 314944*x + 143566,0); H
results(H,L)

H = HyperellipticCurve(58428*x^6 + 894708*x^5 + 3976245*x^4 + 2374954*x^3 - 12089658*x^2 - 319990*x - 7081 ,0); H
results(H,L)

#Noam's Example
H = HyperellipticCurve(16568*x^6 - 91931*x^5 - 1154002*x^4 + 5931677*x^3 - 476629*x^2 - 5645488*x - 1898052,0); H
results(H,L)

#CM curve
H = HyperellipticCurve(R([1, 0, 0, 0, 0, 0, 1])); H
results(H,L)

#?
H = HyperellipticCurve(R([1, -2, -1, 4, 3, 2, 1])); H
results(H,L)

#conductor 249
H = HyperellipticCurve(R([1, 4, 4, 2, 0, 0, 1])); H
results(H,L)

#Drew first curve on zulip
H = HyperellipticCurve( -x^6+6*x^5+3*x^4+5*x^3+23*x^2-3*x+5,x); H
results(H,L)

#Drew second curve on zulip
H=HyperellipticCurve(3*x^5+9*x^4+14*x^3+39*x^2+16,x^3); H
results(H,L)

#Curve from Calegari table
H=HyperellipticCurve(7*x^6-22*x^5-7*x^4 + 61*x^3 -3*x^2-54*x-12,x);H
results(H,L)

#Random curve from LMFDB
H = HyperellipticCurve(R([0, 1, 16, 72, 33, 4]), R([0, 1])); H
results(H,L)
︡bba3f295-acff-4378-ba6c-c429075d4410︡{"stdout":"Hyperelliptic Curve over Integer Ring defined by y^2 = 3628260*x^6 - 1222632*x^5 - 3709872*x^4 + 2955424*x^3 + 2006931*x^2 - 314944*x + 143566\nHyperelliptic Curve over Integer Ring defined by y^2 = 3628260*x^6 - 1222632*x^5 - 3709872*x^4 + 2955424*x^3 + 2006931*x^2 - 314944*x + 143566\n"}︡{"stdout":"conclusions          Frobenius witnesses for each maximal subgroup\n-------------------  -----------------------------------------------\nSurjective at 2      [5, 5, 5, 11, 17]\nNot surjective at 3  [7, 5, 0, 7, 89, 23]\nSurjective at 5      [7, 7, 7, 7, 17, 7, 7, 7, 7]\nSurjective at 7      [13, 13, 5, 5]\nSurjective at 11     [43, 43, 41]\nSurjective at 13     [29, 29, 23]\nSurjective at 17     [23, 23, 29]\nSurjective at 19     [29, 29, 13]\nSurjective at 23     [13, 13, 7]\nSurjective at 29     [23, 23, 13]\nSurjective at 31     [7, 7, 13]\nSurjective at 37     [5, 5, 7]\nSurjective at 41     [23, 23, 13]\nSurjective at 43     [5, 5, 17]\nSurjective at 47     [13, 13, 23]\nSurjective at 53     [13, 13, 7]\nSurjective at 59     [29, 29, 13]\nSurjective at 61     [29, 29, 23]\nSurjective at 67     [43, 43, 7]\nSurjective at 71     [29, 29, 13]\nSurjective at 73     [5, 5, 7]\nSurjective at 79     [7, 7, 13]\nSurjective at 83     [31, 31, 29]\nSurjective at 89     [71, 71, 47]\nSurjective at 97     [5, 5, 23]"}︡{"stdout":"\n\n"}︡{"stdout":"Hyperelliptic Curve over Integer Ring defined by y^2 = 58428*x^6 + 894708*x^5 + 3976245*x^4 + 2374954*x^3 - 12089658*x^2 - 319990*x - 7081\n"}︡{"stdout":"conclusions          Frobenius witnesses for each maximal subgroup\n-------------------  -----------------------------------------------\nSurjective at 2      [7, 5, 11, 5, 7]\nNot surjective at 3  [19, 7, 0, 19, 23, 17]\nSurjective at 5      [7, 37, 37, 17, 37, 7, 37, 7, 7]\nSurjective at 7      [17, 17, 13, 5]\nSurjective at 11     [13, 13, 17]\nSurjective at 13     [31, 31, 37]\nSurjective at 17     [23, 23, 31]\nSurjective at 19     [71, 71, 61]\nSurjective at 23     [13, 13, 11]\nSurjective at 29     [11, 11, 13]\nSurjective at 31     [13, 13, 17]\nSurjective at 37     [17, 17, 13]\nSurjective at 41     [11, 11, 17]\nSurjective at 43     [13, 13, 7]\nSurjective at 47     [17, 17, 29]\nSurjective at 53     [31, 31, 41]\nSurjective at 59     [13, 13, 11]\nSurjective at 61     [41, 41, 29]\nSurjective at 67     [11, 11, 13]\nSurjective at 71     [13, 13, 17]\nSurjective at 73     [53, 53, 47]\nSurjective at 79     [11, 11, 13]\nSurjective at 83     [17, 17, 13]\nSurjective at 89     [13, 13, 11]\nSurjective at 97     [17, 17, 11]"}︡{"stdout":"\n\n"}︡{"stdout":"Hyperelliptic Curve over Integer Ring defined by y^2 = 16568*x^6 - 91931*x^5 - 1154002*x^4 + 5931677*x^3 - 476629*x^2 - 5645488*x - 1898052\n"}︡{"stdout":"conclusions          Frobenius witnesses for each maximal subgroup\n-------------------  -----------------------------------------------\nSurjective at 2      [3, 3, 3, 7, 11]\nNot surjective at 3  [7, 5, 0, 7, 71, 11]\nSurjective at 5      [3, 3, 3, 3, 3, 17, 3, 43, 3]\nSurjective at 7      [43, 43, 37, 3]\nSurjective at 11     [3, 3, 5]\nSurjective at 13     [7, 7, 3]\nSurjective at 17     [5, 5, 11]\nSurjective at 19     [3, 3, 5]\nSurjective at 23     [7, 7, 3]\nSurjective at 29     [19, 19, 11]\nSurjective at 31     [3, 3, 5]\nSurjective at 37     [7, 7, 11]\nSurjective at 41     [3, 3, 5]\nSurjective at 43     [5, 5, 11]\nSurjective at 47     [7, 7, 11]\nSurjective at 53     [13, 13, 11]\nSurjective at 59     [13, 13, 5]\nSurjective at 61     [41, 41, 17]\nSurjective at 67     [7, 7, 3]\nSurjective at 71     [61, 61, 59]\nSurjective at 73     [7, 7, 11]\nSurjective at 79     [13, 13, 11]\nSurjective at 83     [7, 7, 3]\nSurjective at 89     [3, 3, 5]\nSurjective at 97     [13, 13, 19]"}︡{"stdout":"\n\n"}︡{"stdout":"Hyperelliptic Curve over Integer Ring defined by y^2 = x^6 + 1\n"}
︠e8988320-f2a4-40d2-aaa0-f70520472d98︠











