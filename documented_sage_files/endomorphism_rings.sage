r"""
Checks that the endomorphism ring for a genus `2` curve is `\\ZZ`

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
from neron_severi_bound import rank_disc


def can_conclude_trivial(running_triples, this_triple):
    """
    Return true if TODO

    INPUT:

    - ``running_triples`` - TODO

    - ``this_triple`` - TODO

    OUTPUT:
    <TODO required if the one-sentence description of the function needs more
        explanation.>

    EXAMPLES:

        TODO

    ALGORITHM:
    TODO
    Implemented based on private message suggestions from Edgar Costa.

    """
    # This should implement Edgar Costa's suggestion from the Zulip chat.
    # Basically, if you find two primes with rank(NS) = 2 and different
    # squarefree part, then return True
    # TODO
    return False


def is_abs_endo_ring_trivial(f):
    r"""
    Returns true if the absolute endomorphism ring of `C` is `\\ZZ`,
    where `C` is the hyperelliptic curve `y^2 = f(x)`. False otherwise.

    INPUT:

    - ``f`` - A univariate polynomial over `\\ZZ` of degree 5 or 6.

    EXAMPLES:

        TODO

    """
    C = HyperellipticCurve(f)
    reduction_data = genus2reduction(0, f)
    the_conductor = reduction_data.conductor

    running_triples = []

    for p in primes(100):
        if the_conductor % p != 0:  # i.e. if p is a good prime
            C_p = C.base_extend(GF(p))
            P_p_dual = C_p.zeta_function().numerator()
            coeffs_P_p_dual = [P_p_dual[i] for i in range(5)]
            this_triple = rank_disc(coeffs_P_p_dual)  # a tuple, not a list
            if can_conclude_trivial(running_triples, this_triple):
                return True
            else:
                running_triples.append(this_triple)
    # if we haven't returned True by now, probably it's False
    return False
