r"""
This is Zev's suggestion of verifying polys with the LMFDB;
Use with caution.

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

# Set up some poly rings
R.<x> = PolynomialRing(ComplexField())
S.<y> = PolynomialRing(RealField())
T.<z> = PolynomialRing(IntegerRing())


def hack_poly_together(roots, p):
    r"""
    Return TODO

    INPUT:

    - ``roots`` -- TODO

    - ``p`` -- a prime number.

    OUTPUT:

    TODO

    EXAMPLES:

    TODO
    """

    Answer = 1
    for root, mul in roots:
        Answer = Answer * (x^2-root*x+p)^mul
    Answer = S(Answer)

    # At this point you'd think that coercing Answer into T would be
    # good. Think again! That don't work. So we need a hack of a hack.

    degree_of_poly = Answer.degree()
    final_answer = 0
    for i in range(degree_of_poly+1):
        final_answer += round(Answer[i]) * z^i

    return final_answer


# Toy example
f = CuspForms(389).hecke_polynomial(5)
the_roots = f.roots(ComplexField())
answer_hopefully = hack_poly_together(the_roots, 5).factor()

# You'd hope that this would be the poly listed at the bottom of:
# https://www.lmfdb.org/ModularForm/GL2/Q/holomorphic/389/2/a/#moreep
# but it ain't :(
