r"""

TODO one-line description.

TODO longer description.

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
# TODO I believe that I've seen this code from somewhere else,
# so this code should be deleted, and the function imported
def sub_list(l):
    if not l in [2,3,5,7]: raise Exception("l must be 2,3,5 or 7")
    S.<x> = PolynomialRing(Zmod(l))
    if l == 2:
        #CHAR2 is a list of characteristic polynomials of each maximal subgroup of GSp(4,2), except for the maximal subgroup that is isomorphic to A_6 (since that subgroup has all characteristic polynomials so must be dealt with differently)
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
        #CHAR3 is a list of characteristic polynomials of each maximal subgroup of GSp(4,3)
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
        #CHAR5 is a list of characteristic polynomials of each maximal subgroup of GSp(4,3)
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

# TODO I believe that I've seen this code in ``prelimarysurj```
# so this code should be deleted, and the function imported
def initialize_witnesses(L,ruled_out):
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

# TODO I believe that I've seen this code in ``prelimarysurj```
# so this code should be deleted, and the function imported
def initialize_char(L):
    CHAR = {}
    for l in L:
        if l in [2,3,5,7]:
            CHAR[l] = sub_list(l)
    return CHAR


# TODO I believe that I've seen this code from somewhere else,
# so this code should be deleted, and the function imported
def inA6at2(H):
    Q,P = H.hyperelliptic_polynomials()
    curve = genus2reduction(P,Q)
    disc = curve.minimal_disc
    if disc.is_square(): return True
    return False


# TODO I believe that I've seen this code from somewhere else,
# so this code should be deleted, and the function imported
def poor_mans_conductor(C):
    f,h = C.hyperelliptic_polynomials()
    red_data = genus2reduction(h,f)
    N = red_data.conductor
    if red_data.prime_to_2_conductor_only:
        N = 2*N
    return N

# TODO I believe that I've seen this code in ``prelimarysurj```
# so this code should be deleted, and the function imported
def chk_brk(witnesses):
    for wit in witnesses:
        if 0 in witnesses[wit]: return False
    return True

# TODO I believe that I've seen this code in ``prelimarysurj```
# so this code should be deleted, and the function imported
def clean_list(L):
    L = list(set(L))
    L.sort()
    return L

# TODO I believe that I've seen this code in ``prelimarysurj```
# so this code should be deleted, and the function imported
def return_data(L, witnesses,verbose):
    if verbose == True: return witnesses
    non_surj_primes = []
    for l in L:
        if 0 in witnesses[l]: non_surj_primes.append(l)
    return non_surj_primes

# Tests return true if corresponding max sub is found to not contain image of Galois
# TODO I believe that I've seen this code in ``prelimarysurj```
# so this code should be deleted, and the function imported
def is_ired_poly(fmod_factored):
    return len(fmod_factored) == 1 and fmod_factored[0][1] == 1

# TODO I believe that I've seen this code in ``prelimarysurj```
# so this code should be deleted, and the function imported
def trace_poly(fmod):
    return -fmod[fmod.degree()-1]


# TODO I believe that I've seen this code in ``prelimarysurj```
# so this code should be deleted, and the function imported
def surj_test12(fmod_factored):
    return is_ired_poly(fmod_factored)

# TODO I believe that I've seen this code in ``prelimarysurj```
# so this code should be deleted, and the function imported
def surj_test35(fmod, fmod_factored):
    return is_ired_poly(fmod_factored) and trace_poly(fmod) != 0


# TODO I believe that I've seen this code in ``prelimarysurj```
# so this code should be deleted, and the function imported
def surj_test4(fmod, fmod_factored):
    if trace_poly(fmod) != 0:
        for fact in fmod_factored:
            if fact[0].degree() == 1 and fact[1] % 2 != 0: return True
    return False

# TODO I believe that I've seen this code in ``prelimarysurj```
# so this code should be deleted, and the function imported
def surj_tests(C,CHAR,l,p,f,wit):
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

# TODO I believe that I've seen this code in ``prelimarysurj```
# so this code should be deleted, and the function imported
# Inputs: genus two hyperelliptic curve H, list of primes L, (optionally0) verbose mode, (optionally1) a bound on p to check, (optionally2) a dictionary with key-value pairs (l,[bool_1,bool_2]), and (optionally3) a dictionary with key-value pairs (l,list). For optionally2, bool_1 indicates whether reducible at l is already ruled out (bool_1 == True means ruled out) and bool_2 indicates whether irreducible at l is ruled out. For optionally. If verbose mode is on, then return witnesses to non-surjectivity; otherwise just outputs a list of nonsurjective primes
def is_surj(H,L,verbose=False,bound=10^3,ruled_out={}):
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
    #print witnesses
    return return_data(L,witnesses,verbose)

#from tabulate import tabulate

#def results(H,L):
#    conclusions= {}
#    witnesses = is_surj(H,L,verbose=True)
#    for l in L:
#        if -2 in witnesses[l] or -1 in witnesses[l] or 0 in witnesses[l]:            
#            conclusions[l] = "Not surjective at "+str(l)
#        else:            
#            conclusions[l] = "Surjective at "+str(l)
#    resultstable = [(conclusions[l].strip(), witnesses[l]) for l in L]
#    print(tabulate(resultstable, headers=["Conclusions", "Frobenius witnesses for each maximal subgroup"]))
#    print("")
