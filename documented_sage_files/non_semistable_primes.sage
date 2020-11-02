r"""
Return the non semistable primes of a genus 2 curve.

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


def non_semistable_primes(f):
    r"""
    Return list of primes of non-semistable reduction

    INPUT:
    - ``f`` -- univariate polynomial over `\\ZZ`; must be of degree `5`
      or `6`.

    OUTPUT:

    A list of primes `p` at which the curve `y^2 = f(x)` has non-semistable
    reduction.

    EXAMPLES:
    TODO

    .. NOTE::

        The list returned is probably larger than the list that we really want
        most of the time; we are just taking the primes which divide the
        conductor with exponent at least `2`.

    .. TODO::

        Implement this function properly.
    """
    reduction_data_C = genus2reduction(0, f)
    conductor_C = reduction_data_C.conductor_C
    return [p[0] for p in conductor_C if p[1] > 1]
